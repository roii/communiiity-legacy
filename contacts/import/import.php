<?php
include_once("settings.php");

if (!$_POST)
{
  include("form.php");
}
else if(!$_POST['formname'] || $_POST['formname'] != "invite")
{
  include_once($scripts[$iscript]['filename']);
  $login = $_POST['username'];
  $password = $_POST['password'];
  
  $resultarray = get_contacts($login, $password);
	
	
	#if contacts were retreived successfully:
  if(is_array($resultarray))
	{
    #the first array_shift of the result will give you the names in an array
		$names = array_shift($resultarray);
		#the second array_shift of the result will give you the emails
		$emails = array_shift($resultarray);
		
				   if (!eregi("@", $login))
				   {
				   		$login = $login . "@" . strtolower($iscript) . ".com";
				   }

                echo '<style>td {font-family:Arial;font-size:11px;} input {font-family:Arial;font-size:11px;border:solid 1px #b4b4b4;}</style>';
				echo '<table cellpadding="5" bgcolor="#EEEEEE" width="98%" align="center">';
				echo '<form name="inviteform" id="inviteform" method="post" action="http://www.my3p.com/contacts/import/act_import_contacts.cfm">';
				echo '<tr>' . "\n"
				.'<td align="center">' ."\n"
				.'<table width="100%" border="0" cellspacing="0" cellpadding="10" border="0" style="border:solid 1px black;" bgcolor="#ffffff">' ."\n"
				.'<tr>' . "\n"
				.'<td align=\"center\">' ."\n"
				.'<table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">' ."\n"
				.'<tr>' . "\n"
				."<td colspan=\"5\" align=\"center\" style=\"padding-top:10px;padding-bottom:10px;\">$logo</td>" . "\n"
				.'</tr>' . "\n"				
				.'<tr>' . "\n"
				."<td colspan=\"5\" align=\"center\" style=\"padding-top:10px;padding-bottom:15px;\"><div style=\"padding:10px;border:dashed 1px #444444; width:460px;font-size:12px;\" align=\"left\">Tick the contacts you want to import to my3P. Once they have been imported you will be able to select who to send an invitation to.</div></td>" . "\n"
				.'</tr>';
				
		
				echo '<SCRIPT LANGUAGE="JavaScript">' ."\n"
			   	.'    function togglechecked(){ ' . "\n"
			   	.'      for (var i = 0; i < document.inviteform.elements.length; i++) {' . "\n"
			   	.'        var e = document.inviteform.elements[i];' . "\n"
			   	."        if ((e.disabled == false) && (e.name != 'allbox') && (e.type == 'checkbox')) {" ."\n"
			   	.'    e.checked = document.inviteform.allbox.checked;' . "\n"
			   	.'        }' . "\n"
			   	.'      }' . "\n"
			  	.'    }' . "\n"
			   	.'    function toggleselect(){ ' . "\n"
			   	.'      document.inviteform.allbox.checked = !document.inviteform.allbox.checked;' . "\n"
			   	.'        togglechecked();}' . "\n"
			  	.'    </SCRIPT>'  . "\n";
				echo '<tr bgcolor="#CCCCCC">' ."\n"
				.'<td width="30" align="center">' . '<input type="checkbox" name="allbox" id="allbox" value="nothing" style="border:0px;" onClick="togglechecked()" checked>' .'</td>' . "\n"
				.'<td width="110" style="padding-left:5px;"><b>Name</b></td>' . "\n"
				.'<td width="170" style="padding-left:5px;"><b>Email</b></td>' . "\n"
				.'<td width="95" style="padding-left:5px;"><b>Mobile No.</b></td>' . "\n"
				.'<td width="260" style="padding-left:5px;"><b>Categories</b></td>' . "\n"
				.'</tr>';
		
				$maxin = count($names);
				
				echo "<input type=\"hidden\" name=\"TotalContacts\" value=\"$maxin\">";

                   for ($i=0; $i<$maxin; ++$i)
                   {
                     $emails[$i] = trim($emails[$i]);
					 
					 $UseContact = "UseContact_" . $i;
					 $ContactName = "ContactName_" . $i;
					 $ContactEmail = "ContactEmail_" . $i;
					 $ContactPhone = "ContactPhone_" . $i;
					 $Cats = "Categories_" . $i;
					 
                     if ($emails[$i]!="" && eregi("@", $emails[$i]))
                     {
          					   $emails[$i] = strtolower($emails[$i]);
                       echo "<tr><td width=30 align=center valign=top>" . "<input type=\"checkbox\" name=\"$UseContact\" style=\"border:0px;\" value=\"$emails[$i]\" checked>" . "</td><td width=\"110\" style=\"padding-left:5px;\" valign=top><input type=\"text\" name=\"$ContactName\" value=\"$names[$i]\" style=\"width:105px;\"></td><td width=\"170\" style=\"padding-left:5px;\" valign=top><input type=\"text\" name=\"$ContactEmail\" value=\"$emails[$i]\" style=\"width:165px;\"></td><td width=\"95\" style=\"padding-left:5px;\" valign=top><input type=\"text\" name=\"$ContactPhone\" value=\"\" style=\"width:90px;\"></td><td width=\"260\" style=\"padding-left:5px;\" valign=top><input type=\"checkbox\" style=\"border:0px;\" name=\"$Cats\" value=\"2\"> Family &nbsp;&nbsp; <input type=\"checkbox\" style=\"border:0px;\" name=\"$Cats\" value=\"3\"> Friends &nbsp;&nbsp; <input type=\"checkbox\" style=\"border:0px;\" name=\"$Cats\" value=\"4\"> Clients</td></tr>";
                     }
                   }
                   echo <<< _end_this
				   
		
		<tr>
		<td align="center"><input type="checkbox" name="allbox2" value="nothing" onClick="toggleselect()" checked></td>
		<td colspan=4><a href="javascript:toggleselect();">Select / Deselect All</a></td>
		</tr>
		
		<tr>
		<td colspan="5" style="padding:4;" align="center"><input name="submit" type="submit" value="IMPORT SELECTED &raquo;" style="width:300px;background-color:#444444;color:#ffffff;font-weight:bold;border:0px;font-size:11px;padding-top:3px;padding-bottom:3px;"></td>
		</tr>	
		</table>

		</td>
		</tr>
		</table>
		
		</td>
		</tr>		
		</form>
		</table>
		
		<div style="color:#b4b4b4; font-size:11px; font-family:Arial, sans-serif;padding-top:10px;" align="center">&copy; 2006 Address Book Import Scripts Developed by <a href="http://svetlozar.net" target="_blank" style="color:#b4b4b4;">Svetlozar Petrov</a></div>
_end_this;
	}
  else #else print out the form with the error message
  {
    switch ($resultarray)
    {
      case 1: #invalid login
        $formdisclaimer = "<br><span style=\"color:red;font-size:13px;font-weight:bold;\">!! - Invalid Login - !!</span><br>";
        break;
      case 2: #empty username or password
        $formdisclaimer = "<br><b style=\"color:red\">Enter Your Username and Password</b><br>";
        break;
    }
  	include("form.php");
  }
}
else if ($_POST['formname'] == "invite")
{
  $message = file_get_contents($basedir . $slash . "email.html");
  $subject = file_get_contents($basedir . $slash . "emailsubject.txt");


  $addressesStr = implode(",", $_POST['addresses']);

  $headers = "";
  
  if ($fromfield && $fromfield!="")
  {
    $from = $fromfield;
  }
  else
  {
  	$from = trim($_POST['sender']);
  	$headers .= "From: $from\r\n";
  }
  
  $headers .= "Bcc: $addressesStr" . "\r\n";

  $message = str_replace("[[[sender]]]", $_POST['sender'], $message);
  $subject = str_replace("[[[sender]]]", $_POST['sender'], $subject);

  $headers .= "MIME-Version: 1.0\r\n" .
         "Content-Type: text/html;\r\n";
  
 	if(mail ($tofield, $subject, "\r\n". $message, $headers))
 	  $msg = "Invites Sent";
 	else
 	  $msg = "Error occured";
 	
echo <<< _end_sent
<style type="text/css">
<!--
.formheading
{
	color:black;
	font-size:24px;
	font-family:Arial, sans-serif;
	font-weight:bolder;
}
.scriptlinks a
{
	color:blue;
  text-decoration:none;
}

-->
</style> 
  <div style="padding:5; background-color: #EEEEEE; width:350;">
  <div style="width:340; border: black thin solid; background-color:white;" align="center"><h1>$msg</h1>
  <p class="scriptlinks">Invite more from $selects</p><br><br><br></div>
  <div align="center" style="color:#444444; font-size:11.5px; font-family:Arial, sans-serif; align:center;">&copy; 
    2006 Address Book Import Scripts Developed by <a href="http://svetlozar.net" target="_blank" style="color:#333333;">Svetlozar 
    Petrov</a></div> 
</div> 	
_end_sent;

}

?>
