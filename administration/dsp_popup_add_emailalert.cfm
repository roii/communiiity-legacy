<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Add Goal Category</title>
<cfinclude template="../templates/styles.cfm">

<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(AddAlert) {    

if (AddAlert.AlertTitle.value == "") {
alert("You must enter a name for this Alert.");
AddAlert.AlertTitle.focus();
return;
}

else if (AddAlert.AlertSubject.value == "") {
alert("You must enter a Subject for this Alert.");
AddAlert.AlertSubject.focus();
return;
}

else if (AddAlert.AlertDetails.value == "") {
alert("You must enter a Message for this Alert.");
AddAlert.AlertDetails.focus();
return;
}
	
else {
AddAlert.submit(); //submit form
}

}
// -->
</script>

</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add Goal Category</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form method="post" action="#request.webroot#/administration/act_add_emailalert.cfm" name="AddAlert">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Alert Name&nbsp;</td>
	<td><input Type="text" class="whitefield" style="width:300px;" name="AlertTitle"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Email Subject&nbsp;</td>
	<td><input Type="text" class="whitefield" style="width:300px;" name="AlertSubject"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top"><br>Email Message&nbsp;</td>
	<td><textarea class="whitefield" style="width:300px;" rows="6" name="AlertDetails"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top"><br>SMS Message&nbsp;</td>
	<td><textarea class="whitefield" style="width:300px;" rows="6" name="SMSDetails"></textarea></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/spacer.gif" width="1" height="10" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Alert Format&nbsp;</td>
	<td><input Type="radio" name="AlertFormat" class="whitefield" value="HTML"> HTML &nbsp;&nbsp; <input Type="radio" name="AlertFormat" class="whitefield" value="Plain" checked> Plain Text</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Variables Used&nbsp;</td>
	<td><input Type="text" class="whitefield" style="width:300px;" name="VariablesUsed"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" onclick="javascript:validate(AddAlert); return false;" value="ADD ALERT NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>