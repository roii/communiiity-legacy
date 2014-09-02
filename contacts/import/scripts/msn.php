<?php
#Copyright 2006 Svetlozar Petrov
#All Rights Reserved
#svetlozar@svetlozar.net
#http://svetlozar.net

#Script to import the names and emails from msn contact list

#Globals Section, $location and $cookiearr should be used in any script that uses
#                                     get_contacts function

$location = "";
$cookiearr = array();


#function get_contacts, accepts as arguments $login (the username) and $password
#returns array of: array of the names and array of the emails if login successful
#otherwise returns 1 if login is invalid and 2 if username or password was not specified
function get_contacts($login, $passwd)
{
  global $location;
  global $cookiearr;
  global $ch;

  #check if username and password was given:
	if ((isset($login) && trim($login)=="") || (isset($passwd) && trim($passwd)==""))
	{
	  #return error code if they weren't
		return 2;
	}

  #hotmail requires to add @msn.com when you sign in:	
	if (!eregi("@", $login))
		$login .= "@" . "msn.com";

	#initialize the curl session
	$ch = curl_init();
	
  #get the login form from hotmail (the script works a little differently than the hotmail one):
	curl_setopt($ch, CURLOPT_URL,"http://www.hotmail.com");
	curl_setopt($ch, CURLOPT_USERAGENT, "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)");
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_REFERER, "");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	$html = curl_exec($ch);
	

	#this is not the login form yet, some javascript auto submit form, needs to be submitted before login:
	$matches = array();
	preg_match('/<form [^>]+action\="([^"]+)"[^>]*>/', $html, $matches);
	$opturl = $matches[1];
	
	#parse the hidden fields:
	preg_match_all('/<input type\="hidden"[^>]*name\="([^"]+)"[^>]*value\="([^"]*)">/', $html, $matches);
	$values = $matches[2];
	$params = "";
	
	$i=0;
	foreach ($matches[1] as $name)
	{
	  $params .= "$name=" . urlencode($values[$i]);
	  ++$i;
	  if(isset($matches[$i]))
	  {
		$params .= "&";
	  }
	}
	
	#submit the javascript form:
	curl_setopt($ch, CURLOPT_URL, $opturl);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $params);
	$html = curl_exec($ch);

  #parse the login form:
	$matches = array();
	preg_match('/<form [^>]+action\="([^"]+)"[^>]*>/', $html, $matches);
	$opturl = $matches[1];

	#parse the hidden fields:
	preg_match_all('/<input type="hidden"[^>]*name\="([^"]+)"[^>]*value\="([^"]*)"[^>]*>/', $html, $matches);
	$values = $matches[2];
	$params = "";
	
	$i=0;
	foreach ($matches[1] as $name)
	{
	  $paramsin[$name]=$values[$i];
	  ++$i;
	}

  #some form specific javascript stuff before submission, this takes care of that: 
	$sPad="IfYouAreReadingThisYouHaveTooMuchFreeTime";
	$lPad=strlen($sPad)-strlen($passwd);
	$PwPad=substr($sPad, 0,($lPad<0)?0:$lPad);
	
	$paramsin['PwdPad']=urlencode($PwPad);

	foreach ($paramsin as $key=>$value)
	{
	  $params .= "$key=" . urlencode($value) . "&";
	}


	
	curl_setopt($ch, CURLOPT_URL,$opturl);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $params . "login=" . urlencode($login) . "&passwd=" . urlencode($passwd) . "&LoginOptions=3");
	$html = curl_exec($ch);


  #test for valid login:
  if(preg_match("/url=([^\"]*)\"/si", $html, $matches)==0 || !eregi("cgi-bin\/sbox", $html))
  {
		return 1;
  }
  $urlredirect = $matches[1];

  #follow meta refresh tag
	curl_setopt($ch, CURLOPT_URL,$urlredirect);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
  
	$html = curl_exec($ch);

  #passed the login, you need to load this page to get some more cookies to complete the login
	curl_setopt($ch, CURLOPT_URL,"http://cb1.msn.com/hm/header.armx?lid=1033&cbpage=login&lc=1033&x=3.200.4104.0");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	$html = curl_exec($ch);



  #follow the javascript redirection url:
	curl_setopt($ch, CURLOPT_POST, 0);
	curl_setopt($ch, CURLOPT_URL,$matches[1]);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 0);
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	
	$html = curl_exec($ch);
	


  #get the base url and build the url for the page with contacts:
	preg_match("/(http:\/\/[^\/]*\/cgi-bin\/).*?curmbox=([^\& ]*).*?a=([^\& ]*)/i", $location, $baseurl);
	$url = $baseurl[1] . "AddressPicker?a=$baseurl[3]&curmbox=$baseurl[2]&Context=InsertAddress&_HMaction=Edit&qF=to";	
	
	curl_setopt($ch, CURLOPT_URL,$url);
	curl_setopt($ch, CURLOPT_USERAGENT, 0);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	
	$html = curl_exec($ch);

  #parse the emails and names:
	preg_match_all('/<option.*?value="([^"]*)"[^>]*>(.*?)\&lt;/i', $html, $emailarr);
	

  #get rid of duplicates:
	$emailsunique = array_unique($emailarr[1]);

  $i = 0;
	foreach ($emailsunique as $key => $value)
	{
    $emails[$i] = $emailarr[1][$key];
    $names[$i++] = $emailarr[2][$key];
  }

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
    
    #echo $string;
    
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
