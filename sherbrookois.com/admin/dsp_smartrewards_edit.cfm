<cfoutput>

<cfquery name="rewardstuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SmartRewards
WHERE SmartRewardID=#SmartRewardID#
</cfquery>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Edit a Kids Smart Reward</title>
<cfinclude template="../templates/styles.cfm">
	
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(AdministratorAddForm) {    

if (AdministratorAddForm.BusinessName.value == "") {
	alert("You must enter a Business Name.");
	AdministratorAddForm.BusinessName.focus();
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
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit a Kids Smart Reward</strong></span></td>
</tr>



<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	<form method="post" action="#request.webroot#/admin/act_smartreward_edit.cfm" name="AdministratorAddForm">

	<input type="hidden" value="#SmartRewardID#" name="SmartRewardID">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Reward Details</td>
	<td class="normal" valign="top"><textarea name="rewarddetails" class="whitefield" style="width:350px;" rows="6">#TRIM(rewardstuff.rewarddetails)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Increase Period</td>
	<td class="normal" valign="top"><select name="IncreasePeriodType" class="whitefield" style="width:350px;"><option value="Days"<cfif #TRIM(rewardstuff.IncreasePeriodType)# EQ 'Days'> selected</cfif>>Days (select number below)<option value="Each Day"<cfif #TRIM(rewardstuff.IncreasePeriodType)# EQ 'Each Day'> selected</cfif>>Each Day<option value="For ever"<cfif #TRIM(rewardstuff.IncreasePeriodType)# EQ 'For ever'> selected</cfif>>For Ever</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Number of Days</td>
	<td class="normal" valign="top"><input name="IncreasePeriodDays" class="whitefield" style="width:350px;" value="#TRIM(rewardstuff.IncreasePeriodDays)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Increase Amount (percent)</td>
	<td class="normal" valign="top"><input name="IncreasePercentage" class="whitefield" style="width:350px;" value="#TRIM(rewardstuff.IncreasePercentage)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Display Order</td>
	<td class="normal" valign="top"><input name="DisplayOrder" class="whitefield" style="width:350px;" value="#rewardstuff.displayorder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="UPDATE NOW >>>" onclick="validate(AdministratorAddForm); return false;"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	
	</table>
	</form>
		
		
		
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>