<cfoutput>



<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Report Bad Content</title>
<cfinclude template="../templates/styles.cfm">

<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(reportform) {    

if (reportform.Name.value == "") {
	alert("You must enter your Name.");
	reportform.Name.focus();
	return;
	} 
	
else if (reportform.Email.value == "") {
	alert("You must enter your Email.");
	reportform.Email.focus();
	return;
	} 
	
else if (reportform.LinkToURL.value == "") {
	alert("You must enter the URL to the bad content.");
	reportform.LinkToURL.focus();
	return;
	} 
	
else {
	reportform.submit(); //submit form
	}
}
// -->
</script><br>


</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Report Bad Content</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<form method="post" action="act_report_profanity.cfm" name="reportform">
	
	<cfif IsDefined("session.UerID")>
		<input type="hidden" name="UserID" value="#session.UserID#">
	</cfif>
	
	<input type="hidden" name="this_query_string" value="#this_query_string#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Your Name</td>
	<td class="normal" valign="top"><input class="whitefield" style="width:400px;" name="Name"<cfif session.UserIsAuthenticated EQ 1> value="#session.User_FirstName# #session.User_LastName#"</cfif>></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Your Email</td>
	<td class="normal" valign="top"><input class="whitefield" style="width:400px;" name="Email"<cfif session.UserIsAuthenticated EQ 1> value="#session.User_Email#"</cfif>></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Link to page containing bad content</td>
	<td class="normal" valign="top"><textarea class="whitefield" name="LinkToURL" rows="4" style="width:400px;">#request.webroot#/index.cfm?#URLDecode(this_query_string)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Details</td>
	<td class="normal" valign="top"><textarea class="whitefield" name="Details" rows="4" style="width:400px;"></textarea></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="SEND NOW >>>" onclick="validate(reportform); return false;"></td>
	</tr>
	
	
	
	</table>
	</form>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


