<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfinclude template="/templates/set_language.cfm">
	<title>#TRIM(AllSettings.SiteName)# - Forgot your Password?</title>
<cfinclude template="templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<form method="post" action="#request.webroot#/act_forgot_password.cfm" name="PasswordForm">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#forgotPassHeading#</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
	<table border="0" cellpadding="0" cellspacing="0" width="97%">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/spacer.gif" width="10" height="1" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/spacer.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/spacer.gif" width="10" height="1" border="0"></td>
	<td><br>
	
		
		<table cellspacing="0" cellpadding="2" border="0">
		
		<tr>
		<td class="objectcopyblack" width="100" align="right"><b>#emailaddress#</b></td>
	  	<td><input Type="text" size="40" class="whitefield" name="emailaddress"></td>
		</tr>
		
		<tr>
		<td width="100"></td>
		<td class="objectcopy">#forgotPassNote#</td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="white"></td>
		</tr>
		
		<tr>
		<td align="left" colspan="2"><input Type="submit" class="whitefield" value="#sendPassText#" border="0">&nbsp;&nbsp;<input type="button" class="whitefield" value="#cancelbttn#" onClick="javascript:window.close();" border="0"></a></td>
		</tr>
		
		
		</table><br>
		
		
	</td>
	</tr>
	</table>
	
	
	



</td>
</tr>
</form>

</table>

</body>
</html>


</cfoutput>