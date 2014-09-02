<?php

if ($_POST['username'])
  $username = $_POST['username'];

$logonform = <<< _end_lform
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
font-family:Arial, sans-serif;
font-size:12px;
text-decoration:none;
}

td {
font-family:Arial, sans-serif;
font-size:12px;
}

-->
</style> 

<table cellpadding="5" bgcolor="#EEEEEE" width="450" align="center">

<form name="form1" method="post" action="">

<tr>
<td align="center">

	
	<table width="440" border="0" cellspacing="0" cellpadding="0" style="border:solid 1px black; background-color: #FFFFFF" align="center">
	
	<tr> 
	<td colspan="2" style="padding:10px;"><div align="right" class="scriptlinks"><font color="#333333"><strong>SELECT:&nbsp; </strong></font>$selects</div>
	<hr width="100%" size="1" color="#444444"></td>
	</tr>
	
	<tr> 
	<td colspan="2" align="center">$logo</td>
	</tr>
	
	<tr> 
	<td colspan="2" align="center" style="padding-top:20px;padding-bottom:10px;"><div style="padding:10px;border:dashed 1px #444444; width:400px;" align="center">
	
	
		<table cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr> 
		<td style="padding-right:15px;" align="right"><strong>$formname Username:</strong></td>
		<td><input name="username" value="$username" type="text" class="text" id="username" style="width:180px;"></td>
		</tr>
		
		<tr> 
		<td style="padding-right:15px;" align="right"><strong>$formname Password:</strong></td>
		<td><input name="password" type="password" class="text" id="password" style="width:180px;"></td>
		</tr>
		
		</table>
	
	
	</div></td>
	</tr>
		
	
	<tr> 
	<td colspan="2" align="center">$formdisclaimer<br>
	<hr width="420" size="1" color="#444444" align="center"></td>
	</tr>
	
	<tr> 
	<td colspan="2" align="center" style="padding-bottom:10px;padding-top:3px;"><input type="submit" name="Submit" value="GET MY CONTACTS &raquo;" style="width:300px;background-color:#444444;color:#ffffff;font-weight:bold;border:0px;font-size:11px;padding-top:3px;padding-bottom:3px;"></td>
	</tr>
	
	</table>

</td>
</tr>

</form>
</table>

<div style="color:#b4b4b4; font-size:11px; font-family:Arial, sans-serif;padding-top:10px;" align="center">&copy; 2006 Address Book Import Scripts Developed by <a href="http://svetlozar.net" target="_blank" style="color:#b4b4b4;">Svetlozar Petrov</a></div>

_end_lform;
echo $logonform;

?>
