<!---<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="170" height="8" border="0"></td>
</tr>

<cfif session.UserIsAuthenticated EQ 'No'>
	
	<tr>
	<td align="center">
	<cfinclude template="../templates/dsp_sidebar_testimonials.cfm"><br>
	</td>
	</tr>
	
	<tr>
	<td align="center">
		<a href="#request.webroot#/index.cfm?fuseaction=prizes&fusesubaction=docs&documentID=113"><img src="#request.imageroot#/banner_school_printer.gif" width="144" height="147" alt="" border="0"></a><br>
		<a href="#request.webroot#/index.cfm?fuseaction=prizes&fusesubaction=docs&documentID=113" style="font-size:14px;font-family:Trebuchet MS, Arial, Verdana, Helvetica;"><strong>Click to find out</strong></a><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
	</td>
	</tr>
	
	
</cfif>


<tr>
<td align="center">
	<cfinclude template="../templates/dsp_invite_friend.cfm"><br>
</td>
</tr>

<cfif session.UserIsAuthenticated EQ 'Yes'>

	<tr>
	<td align="center">
		<a href="#request.webroot#/index.cfm?fuseaction=prizes&fusesubaction=docs&documentID=113"><img src="#request.imageroot#/banner_school_printer.gif" width="144" height="147" alt="" border="0"></a><br>
		<a href="#request.webroot#/index.cfm?fuseaction=prizes&fusesubaction=docs&documentID=113" style="font-size:14px;font-family:Trebuchet MS, Arial, Verdana, Helvetica;"><strong>Click to find out</strong></a><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
	</td>
	</tr>
		
	<tr>
	<td align="center">
		<cfinclude template="../templates/dsp_sidebar_sms.cfm"><br>
	</td>
	</tr>

	<tr>
	<td align="center">
		<cfinclude template="../templates/dsp_sidebar_announcements.cfm"><br>
	</td>
	</tr>
	
</cfif>

</table>


</cfoutput>--->