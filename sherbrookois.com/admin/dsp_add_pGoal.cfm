<cfoutput>


<cfinclude template="../administration/qry_pgoals.cfm">


<script>
function validate(AddGoal) {
var GoalTypeID = document.forms["AddGoal"].GoalTypeID.options[document.forms["AddGoal"].GoalTypeID.selectedIndex].value;


if (AddGoal.GoalTitle.value == "") {
	alert("Please enter your goal title first.");
	AddGoal.GoalTitle.focus();
	return;
	} 
	 
else if (AddGoal.goaldetails.value == "") {
	alert("Please enter your goals details.");
	AddGoal.Goaldetails.focus();
	return;
	} 
	
else if (GoalTypeID == "0") {
	alert("You must select the goal type.");
	return;
	}
	 
else {
	AddGoal.submit(); //submit form
	}
	
}
</script>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Add a Public Goal</title>
<cfinclude template="../templates/styles.cfm">
	
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">




<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add a Public Goal</strong></span></td>
</tr>



<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	<cfform name="AddGoal" action="#request.webroot#/admin/act_add_goal.cfm" method="post">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Goal Type</td>
	<td class="normal" valign="top"><select name="GoalTypeID" class="whitefield" size="1" style="width:350px;">
	<option value="0">
	<cfloop query="GoalType">
		<option value="#goaltype.GoalTypeID#">#goaltype.GoalType#
	</cfloop>
	</select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Goal Title</td>
	<td class="normal" valign="top"><cfinput type="text" required="Yes" message="Please enter your goal title first" name="GoalTitle" class="whitefield" style="width:350px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Goal Details<br>
	(The result of achieving this goal)</td>
	<td class="normal" valign="top"><textarea rows="5" style="width:350px;" name="goaldetails"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="ADD NOW >>>" onclick="validate(AddGoal); return false;"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	
	</table>
	</cfform>
		
		
		
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>