<cfoutput>



<!--- GET ALL ACTIVE GOALS --->
<cfquery name="ActiveGoals" dbtype="query">
SELECT GoalID, bywhen
FROM AllGoals
WHERE Archived=0
</cfquery>

<!--- GET ALL OVERDUE GOALS --->
<cfset overdue=0>
<cfloop query="ActiveGoals">
<cfset thisdate = DateFormat(ActiveGoals.bywhen, "yyyymmdd")>
<cfif DateCompare(thisdate, DateFormat(localDateTime, "yyyymmdd")) EQ -1>
	<cfset overdue=overdue+1>
</cfif> 
</cfloop>

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
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/goals_sml.jpg" alt="Goals" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Active Goals:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#ActiveGoals.recordcount#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Overdue Goals:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#OverDue#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Completed Goals:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#CompleteGoals.recordcount#</td>
	</tr>
	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>