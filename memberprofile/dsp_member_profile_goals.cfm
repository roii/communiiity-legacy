<cfoutput>


<!--- GET ALL GOALS FOR THIS MEMBER --->
<cfquery name="AllGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Goals.GoalID, GoalKidsLink.bywhen, GoalKidsLink.archived
FROM Goals, GoalKidsLink
WHERE Goals.GoalID=GoalKidsLink.GoalID
AND GoalKidsLink.KidsID = #ContactDetails.contactID#
</cfquery>


<!--- GET ALL ACTIVE GOALS --->
<cfquery name="ActiveGoals" dbtype="query">
SELECT GoalID, bywhen
FROM AllGoals
WHERE Archived=0
</cfquery>

<!--- GET ALL COMPLETED GOALS --->
<cfquery name="CompleteGoals" dbtype="query">
SELECT GoalID
FROM AllGoals
WHERE Archived=1
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Goals</strong></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="2" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">Number of Active Goals:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"><strong>#ActiveGoals.RecordCount#</strong></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">Number of Completed Goals:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"><strong>#CompleteGoals.RecordCount#</strong></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	
	</table>


</td>
</tr>

</table><br>



</cfoutput>