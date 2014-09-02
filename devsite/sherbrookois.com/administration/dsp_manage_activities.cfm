<cfoutput>

<cfquery name="AllActivities" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Activity
ORDER BY DisplayOrder
</cfquery>
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE ACTIVITY REWARDS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>
<a href="#request.webroot#/administration/dsp_add_activity.cfm" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;" target="addActivity" onclick="fdbackwindow=window.open ('','addActivity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=360,top=10,left=10')">
<strong>ADD AN ACTIVITY &raquo;</strong></a>

	<hr width="100%" size="1" color="e2e2e2">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
	<td width="*"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
	<td width="60"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
	<td width="60"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
	<td width="60"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
	<td width="60"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td><b>Name</b></td>
	<td><b>Description</b></td>
	<td align="center"><b>Prize Entries</b></td>
	<td align="center"><b>Points</b></td>
	<td align="center"><b>Cash</b></td>
	<td align="center"><b>Education</b></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="AllActivities">
	
	<tr>
	<td valign="top">#TRIM(AllActivities.Name)#</td>
	<td valign="top">#TRIM(AllActivities.Description)#</td>
	<td align="center" valign="top">#AllActivities.Entries#</td>
	<td align="center" valign="top">#AllActivities.Points#</td>
	<td align="center" valign="top">#AllActivities.Cash#</td>
	<td align="center" valign="top">#AllActivities.Education#</td>
	<td align="right" valign="top"><a href="#request.webroot#/administration/dsp_edit_activity.cfm?ActivityID=#AllActivities.ActivityID#" target="EditActivity" onclick="fdbackwindow=window.open ('','EditActivity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=360,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Activity" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>	
	
	
	</table>


</td>
</tr>

</table>

</cfoutput>