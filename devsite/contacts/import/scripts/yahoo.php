<?php
#Copyright 2006 Svetlozar Petrov
#All Rights Reserved
#svetlozar@svetlozar.net
#http://svetlozar.net

#Script to import the names and emails from yahoo contact list

#Globals Section, $location and $cookiearr should be used in any script that uses
#                                     get_contacts function
$location = "";
$cookiearr = array();

#$addopt specifies whether you want to assume that yahoo id's without email addresses
# have @yahoo email. Most do. Leave true if you want to have those emails returned.
# Change to false if you don't want @yahoo.com to be added to yahoo id's
# In that case you'll only get the id's instead of email address for those.
$addopt = true;


#function get_contacts, accepts as arguments $login (the username) and $password
#returns array of: array of the names and array of the emails if login successful
#otherwise returns 1 if login is invalid and 2 if username or password was not specified
function get_contacts($login, $password)
{
  #the globals will be updated/used in the read_header function
  #read the notes above about $addopt
  global $location;
  global $cookiearr;
  global $ch;
  global $addopt;

  #check if username and password was given:
	if ((isset($login) && trim($login)=="") || (isset($password) && trim($password)==""))
	{
	  #return error code if they weren't
		return 2;
	}
	
	#initialize the curl session
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,"http://address.yahoo.com");
	curl_setopt($ch, CURLOPT_REFERER, "");
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);

	$html = curl_exec($ch);
	$matches = array();
	
	#parse the hidden fields from the login form:
	preg_match_all('/<input type\="hidden" name\="([^"]+)" value\="([^"]*)">/', $html, $matches);
	$values = $matches[2];
	$params = "";
	
	$i=0;
	foreach ($matches[1] as $name)
	{
	  $params .= "$name=$values[$i]&";
	  ++$i;
	}
	
	$login = urlencode($login);
	$password = urlencode($password);
	#attempt login:
	curl_setopt($ch, CURLOPT_URL,"http://login.yahoo.com/config/login?");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $params . "login=$login&passwd=$password");
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	
	
	$html = curl_exec($ch);

	#$loginarr = explode("?", $location);
	
  #test if login was successful:
	if (!is_array($cookiearr) || !isset($cookiearr['F']))
	{
		return 1;
	}
	
	preg_match('/\.rand=([^"]*)"/si', $html, $matches);
	$value = $matches[1];
  
  #go to the address book page
	curl_setopt($ch, CURLOPT_POST, 0);
	curl_setopt($ch, CURLOPT_URL,"http://address.mail.yahoo.com/?1&VPC=import_export&A=B&.rand=$value");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	
	$html = curl_exec($ch);
  
  #parse the yahoo.csv form and submit it:
	$matches = array();
	preg_match('/name="\.crumb".*?id="crumb2".*?value="([^"]*)"/si', $html, $matches);
	$crumb = $matches[1];

	preg_match('/\.rand=([^"]*)"/si', $html, $matches);
	$rand = $matches[1];

	
	$action = "http://address.yahoo.com/?1&VPC=import_export&A=B&.rand=$rand";
	curl_setopt($ch, CURLOPT_URL, $action);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, ".crumb=$crumb&VPC=import_export&A=B&submit%5Baction_export_yahoo%5D=Export+Now");
	$html = curl_exec($ch);

	curl_close ($ch);
	
	#parse the csv file:
	$table = explode("\n", $html);
  
	array_shift($table);
	$maxi = count($table);
	
	$names = array();
	$emails = array();
	
  #parse emails and names:
	for($i=0; $i<$maxi; ++$i)
	{
	  $table[$i]=explode(',"',$table[$i]);
	  $table[$i]=array_map("trimvals", $table[$i]);
	  $names[$i]=trim("{$table[$i][0]} {$table[$i][1]} {$table[$i][2]}");
	  if($names[$i]=="")
	  {
		$names[$i]=trim($table[$i][3]); //if no name set to nickname
	  }
	  if($names[$i]=="")
	  {
		$names[$i]=trim($table[$i][7]); //if no name set to yahooid
	  }
	
	  $emails[$i]=trim($table[$i][4]);
	  if($emails[$i]=="" && trim($table[$i][7])!="")
	  {
	
	  	if ($addopt && !eregi("@", $table[$i][7]) && (trim($table[$i][7])!=""))
			$emails[$i]=trim($table[$i][7]) . "@yahoo.com"; //if no email set to yahooid + @yahoo.com
		else
			$emails[$i]=trim($table[$i][7]);	
	  }
	}

  #return the result:
	return array($names, $emails);
}

#function to trim the whitespace around names and email addresses
#used by get_contacts when parsing the csv file
function trimvals($val)
{
  return trim ($val, '" ');
}

#read_header is essential as it processes all cookies and keeps track of the current location url
#leave unchanged, include it with get_contacts
function read_header($ch, $string)
{
    global $location;
    global $cookiearr;
    global $ch;
    
    $length = strlen($string);
    if(!strncmp($string, "Location:", 9))
    {
      $location = trim(substr($string, 9, -1));
    }
    if(!strncmp($string, "Set-Cookie:", 11))
    {
      $cookiestr = trim(substr($string, 11, -1));
      $cookie = explode(';', $cookiestr);
      $cookie = explode('=', $cookie[0]);
      $cookiename = trim(array_shift($cookie)); 
      $cookiearr[$cookiename] = trim(implode('=', $cookie));
    }
    $cookie = "";
    if(trim($string) == "") 
    {
      foreach ($cookiearr as $key=>$value)
      {
        $cookie .= "$key=$value; ";
      }
      curl_setopt($ch, CURLOPT_COOKIE, $cookie);
    }

    return $length;
}
?>






