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

if (AdministratorAddForm.SkillName.value == "") {
	alert("Please enter the Skill Name.");
	AdministratorAddForm.SkillName.focus();
	return;
	} 
	
else if (AdministratorAddForm.SkillKeyword.value == "") {
	alert("Please enter the Skill Keywords.");
	AdministratorAddForm.SkillKeyword.focus();
	return;
	} 
	 
else {
	AdministratorAddForm.submit(); //submit form
	}
}
// -->
</script>

<cfif IsDefined("URL.dup") and URL.dup eq 1>
      <p style="color: red;">
	        The skill is not available to add and existed already in site. So please choose other skill Name.
	  </p> 
<cfelse> 
</cfif>

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40"> 
   <td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#" colspan="3">
         <span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add Skill</strong></span>
   </td>
</tr>



<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr> 
<td valign="top" colspan="3">
<br>

	<form method="post" action="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=addskillin" name="AdministratorAddForm">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Skill Name</td>
	<td class="normal" valign="top"><input name="SkillName" id="SkillName" class="whitefield" size="85"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Skill Keyword</td>
	<td class="normal" valign="top"><input name="SkillKeyword" id="SkillKeyword" class="whitefield" size="85"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	 
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="#addnow# >>>" onClick="validate(AdministratorAddForm); return false;"> &nbsp; <input type="button" onClick="javascript:window.location = '#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manageskills';" value="Back to Manage Skills >>" class="whitefield"></td>
	</tr>	
	
	
	</table>
	</form>
		
		
		
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>