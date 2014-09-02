<cfoutput>

<cfquery name="AllActivities" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Activity
ORDER BY DisplayOrder
</cfquery>



<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="font-size:12px;color:###TRIM(AllSettings.TextColour)#;">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="*"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
	<td width="70"><img src="#request.imageroot#/transparent_spc.gif" width="70" height="1" border="0"></td>
	<td width="70"><img src="#request.imageroot#/transparent_spc.gif" width="70" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td align="center"><b>Prize Entries</b></td>
	<td align="center"><b>Points</b></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="AllActivities">
	
	<tr>
	<td valign="top" style="padding-right:5px;">#TRIM(AllActivities.Description)#</td>
	<td align="center" valign="top" style="padding-left:5px;padding-right:5px;">#AllActivities.Entries#</td>
	<td align="center" valign="top" style="padding-left:5px;padding-right:5px;">#AllActivities.Points#</td>
	</tr>
	
	<tr>
	<td colspan="3" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	</tr>
	
	</cfloop>	
	
	
	</table>
	
	
</td>
</tr>

</table>


</cfoutput>