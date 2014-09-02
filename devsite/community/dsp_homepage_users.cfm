<cfoutput>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(session.AllSettings_BoxColour)#;" valign="bottom"><a name="dashBiz"><strong>Users - Top Performers</strong></a></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" alt="" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td>
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="400" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td width="100%" style="padding-left:5px;color:black;">List By: <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ShowUserReport=True&ReportType=points" style="color:Black;font-size:12px;padding-left:5px;">Points</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ShowUserReport=True&ReportType=ideas" style="color:Black;font-size:12px;padding-left:5px;">Ideas</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ShowUserReport=True&ReportType=goals" style="color:Black;font-size:12px;padding-left:5px;">Goals</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ShowUserReport=True&ReportType=Contacts" style="color:Black;font-size:12px;padding-left:5px;">Contacts</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ShowUserReport=True&ReportType=Business" style="color:Black;font-size:12px;padding-left:5px;">Businesses</a></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		</table>
		
		
		
		<cfif isDefined("ShowUserReport") AND ShowUserReport EQ "True">

			<cfif ReportType EQ 'Points'>
				<cfinclude template="dsp_topuser_points.cfm">	
			<cfelseif ReportType EQ 'ideas'>
				<cfinclude template="dsp_topuser_ideas.cfm">		
			<cfelseif ReportType EQ 'goals'>
				<cfinclude template="dsp_topuser_goals.cfm">		
			<cfelseif ReportType EQ 'Contacts'>
				<cfinclude template="dsp_topuser_contacts.cfm">		
			<cfelseif ReportType EQ 'Business'>
				<cfinclude template="dsp_topuser_business.cfm">		
			</cfif>
		
		</cfif>		
		
		

</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>
	


</cfoutput>