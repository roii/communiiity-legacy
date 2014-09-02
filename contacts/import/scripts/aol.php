<?php
#Copyright 2006 Svetlozar Petrov
#All Rights Reserved
#svetlozar@svetlozar.net
#http://svetlozar.net

#Script to import the names and emails from aol contact list

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
  
  $login = explode("@", $login);
  $login = $login[0];

  #check if username and password was given:
	if ((isset($login) && trim($login)=="") || (isset($passwd) && trim($passwd)==""))
	{
	  #return error code if they weren't
		return 2;
	}

	#initialize the curl session
	$ch = curl_init();
	
  #get the login form:

	curl_setopt($ch, CURLOPT_URL,"http://webmail.aol.com");
	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_REFERER, "");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	$html = curl_exec($ch);
	
  #follow javascript redirection:	
	$matches = array();
	preg_match('/replace\("([^"]*)"/i', $html, $matches);
	$opturl = $matches[1];
	$location = $opturl;
	curl_setopt($ch, CURLOPT_URL, $opturl);
	$html = curl_exec($ch);

	curl_setopt($ch, CURLOPT_URL, "https://my.screenname.aol.com/_cqr/login/login.psp?mcState=initialized&uitype=mini&sitedomain=registration.aol.com&authLev=1&seamless=y&lang=en&locale=us&siteState=OrigUrl%3dhttp%253a%252f%252fregistration%252eaol%252ecom%252fmail%253fs%255furl%253dhttp%25253a%25252f%25252fwebmail%25252eaol%25252ecom%25252f%25255fcqr%25252fLoginSuccess%25252easpx%25253fsitedomain%25253dsns%25252ewebmail%25252eaol%25252ecom%252526siteState%25253dver%2525253a1%252525252c0%25252526ld%2525253awebmail%25252eaol%25252ecom%25252526pv%2525253aAOL%25252526lc%2525253aen%25252dus%25252526ud%2525253aaol%25252ecom&loginId=&_sns_width_=174&_sns_height_=196&_sns_fg_color_=000000&_sns_err_color_=FF0000&_sns_link_color_=000000&_sns_bg_color_=b8d2e5");
	$html = curl_exec($ch);

  #parse the login form:
	preg_match('/<form name="loginform".*?action="([^"]*).*?<\/form>/si', $html, $matches);
	$opturl = "https://my.screenname.aol.com" .$matches[1];
	
	#get the hidden fields:
	$hiddens = array();
	preg_match_all('/<input type="hidden" name="([^"]*)" value="([^"]*)".*?>/si', $matches[0], $hiddens);
	$hiddennames = $hiddens[1];
	$hiddenvalues = $hiddens[2];
	
	
	$hcount = count($hiddennames);
	$params = "";
	for($i=0; $i<$hcount; $i++)
	{
		$params .= $hiddennames[$i] . "=" . urlencode($hiddenvalues[$i]) . "&";
	}
	
	
	
  $login = urlencode($login);
	$passwd = urlencode($passwd);
	
  #attempt login:
	curl_setopt($ch, CURLOPT_URL, $opturl);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_POST, 1);
	curl_setopt($ch, CURLOPT_POSTFIELDS, $params . "loginId=$login&password=$passwd");
	$html = curl_exec($ch);

  #check if login successful:
	if(!preg_match("/'loginForm', 'false', '([^']*)'/si", $html, $matches))
  {
    #return error if it's not
    return 1;
  }
  
  
  
	$opturl = $matches[1];
	curl_close ($ch);
	$ch = curl_init();
  foreach ($cookiearr as $key=>$value)
  {
    $cookie .= "$key=$value; ";
  }
  curl_setopt($ch, CURLOPT_COOKIE, $cookie);

	curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
	curl_setopt($ch, CURLOPT_REFERER, "");
	curl_setopt($ch, CURLOPT_RETURNTRANSFER,1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, 1);
	curl_setopt($ch, CURLOPT_HEADERFUNCTION, 'read_header');
	curl_setopt($ch, CURLOPT_URL, $opturl);
	$html = curl_exec($ch);

  preg_match('/gPreferredHost = "([^"]*)".*?gSuccessPath = "([^"]*)"/si', $html, $matches);
  $opturl = $matches[1];
  $opturl .= $matches[2];
  $opturl = "http://" . $opturl;

  $opturl = explode("/", $opturl);
  $opturl[count($opturl)-1]="AB";
  $opturl = implode("/", $opturl);

  preg_match('/\&uid:([^\&]*)\&/si', $cookiearr['Auth'], $matches);
  $usr = $matches[1];

  #get the address book:
	$opturl .= "/addresslist-print.aspx?command=all&undefined&sort=LastFirstNick&sortDir=Ascending&nameFormat=FirstLastNick&version=$cookiearr[Version]&user=$usr";
	curl_setopt($ch, CURLOPT_POST, 0);
	curl_setopt($ch, CURLOPT_URL, $opturl);
	$html = curl_exec($ch);
	curl_close ($ch);


  #parse the emails and names:
	preg_match_all('/<span class="fullName">(.*?)<\/span>(.*?)<hr class="contactSeparator">/si', $html, $matches);
	$names = $matches[1];
	$emails = array_map("parse_emails", $matches[2]);

  #return the result:
  return array($names, $emails);
}

#parse_emails needs to be included to be able to get the emails
function parse_emails($str)
{
  $matches = array();
	preg_match('/<span>Email 1:<\/span> <span>([^<]*)<\/span>/si', $str, $matches);
  return $matches[1];
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

