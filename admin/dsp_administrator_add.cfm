<cfoutput> 

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head> 
<cfinclude template="../templates/styles.cfm">
	
	<cfinclude template="../templates/set_language.cfm">
<title>communautiii - #addanadminTxt#</title>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(AdministratorAddForm) {    

if (AdministratorAddForm.FirstName.value == "") {
	alert("#firstnamealert#.");
	AdministratorAddForm.FirstName.focus();
	return;
	} 
	
else if (AdministratorAddForm.LastName.value == "") {
	alert("#lastnamealert#.");
	AdministratorAddForm.LastName.focus();
	return;
	} 
	
else if (AdministratorAddForm.EmailAddress.value == "") {
	alert("#emailalert#.");
	AdministratorAddForm.EmailAddress.focus();
	return;
	} 
	
else if (AdministratorAddForm.Password.value == "") {
	alert("#passalert#.");
	AdministratorAddForm.Password.focus();
	return;
	} 
	
else {
	AdministratorAddForm.submit(); //submit form
	}
}
// -->
</script>


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#addanadminTxt#</strong></span></td>
</tr>



<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	<form method="post" action="#request.webroot#/admin/act_administrator_add.cfm" name="AdministratorAddForm">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#firstNameText#</td>
	<td class="normal" valign="top"><input name="FirstName" class="whitefield" size="85"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#lastNameText#</td>
	<td class="normal" valign="top"><input name="LastName" class="whitefield" size="85"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#emailaddress#</td>
	<td class="normal" valign="top"><input name="EmailAddress" class="whitefield" size="85"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#password#</td>
	<td class="normal" valign="top"><input name="Password" class="whitefield" size="85"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="#addnow# >>>" onClick="validate(AdministratorAddForm); return false;"> &nbsp; <input type="button" onClick="javascript:window.close();" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>	
	
	
	</table>
	</form>
		
		
		
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>