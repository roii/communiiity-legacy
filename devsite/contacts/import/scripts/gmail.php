<?php
#Copyright 2006 Svetlozar Petrov
#All Rights Reserved
#svetlozar@svetlozar.net
#http://svetlozar.net

#Script to import the names and emails from gmail contact list

#Globals Section, $location and $cookiearr should be used in any script that uses
#                                     get_contacts function
$location = "";
$cookiearr = array();

#function get_contacts, accepts as arguments $login (the username) and $password
#returns array of: array of the names and array of the emails if login successful
#otherwise returns 1 if login is invalid and 2 if username or password was not specified
function get_contacts($login, $password)
{
  #the globals will be updated/used in the read_header function
  global $location;
  global $cookiearr;
  global $ch;

  #check if username and password was given:
	if ((isset($login) && trim($login)=="") || (isset($password) && trim($password)==""))
	{
	  #return error code if they weren't
		return 2;
	}
	
	#initialize the curl session
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL,"http://gmail.com");
	curl_setopt($ch, CURLOPT_REFERER, "");
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	
	#get the html from gmail.com
  $html = curl_exec($ch);
	
	$matches = array();
	$actionarr = array();
	
	#parse the login form:
  preg_match('/<form[^>]*action="([^"]*)"/', $html, $actionarr);
	$locationarr = explode('?', $location);
	$locationarr = explode('/', $locationarr[0]);
	
  #get the url where the logon form need to be submitted
	$locationarr[count($locationarr)-1]= $actionarr[1]; 
	$action = implode('/', $locationarr);
	
	#parse all the hidden elements of the form
	preg_match_all('/<input type\="hidden" name\="([^"]+)" value\="([^"]*)"[^>]*>/', $html, $matches);
	$values = $matches[2];
	$params = "";
	
	$i=0;
	foreach ($matches[1] as $name)
	{
	  $params .= "$name=" . urlencode($values[$i]) . "&";
	  ++$i;
	}

  $login = urlencode($login);
  $password = urlencode($password);
  
  #submit the login form:
	curl_setopt($ch, CURLOPT_URL,$action);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $params ."Email=$login&Passwd=$password&PersistentCookie=");

	$html = curl_exec($ch);

  #test if login was successful:
	if (preg_match('/url=([^"]*)/', $html, $actionarr)!=0)
	{
		$location = $actionarr[1];
	}
	else
	{
		return 1;
	}
	$location = str_replace("&quot;", '', $location);
	$location = str_replace("&amp;", '&', $location);
	$location = trim ($location,"'\"");
	

  #follow the location specified after login
	curl_setopt($ch, CURLOPT_POST, 0);
	curl_setopt($ch, CURLOPT_URL, "$location");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	
	$html = curl_exec($ch);
	
	#get the base url for the current web page:
	preg_match('/<base href="([^"]*)"[^>]*>/', $html, $actionarr);
	$location = $actionarr[1];
	
####find the link to contacts and get the url, follow the link:
	$location .= "?pnl=a&v=cl";
	
	curl_setopt($ch, CURLOPT_URL, $location);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	
	$html = curl_exec($ch);
	curl_close ($ch);
	
	#get rid of html &nbsp; in the contacts table
	$html = preg_replace('/<span[^>]*>[^<]*<\/span>/', '&nbsp;', $html);
	
	#parse the email addresses and names:
	preg_match_all('/<input type="?checkbox"?[^>]*>[^<]*<\/td>[^<]*<td[^>]*>[^<]*<b>([^<]*)<\/b>[^<]*<\/td>[^<]*<td[^>]*>([^\&]*)/', $html, $matches);
	$names = $matches[1];
	$emails = array_map("trimvals", $matches[2]);

  #return the result:
	return array($names, $emails);
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

#function to trim the whitespace around names and email addresses
#used by get_contacts when parsing the csv file
function trimvals($val)
{
  return trim ($val, "\" \n");
}
?>






