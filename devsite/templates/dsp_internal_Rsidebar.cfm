<!---<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><cfoutput><img src="#request.imageroot#/transparent_spc.gif" width="170" height="8" border="0"></cfoutput></td>
</tr>

<cfif fusesubaction NEQ 'step2'>

	<tr>
	<td align="center">

	<cfif session.permission1_view EQ 1 OR session.permission46_view EQ 1>
		<cfinclude template="dsp_sidebar_testimonials.cfm"><br>
	</cfif>
	
	<cfinclude template="dsp_sidebar_schoolprinters.cfm">
	
	<cfif session.permission1_view EQ 1 OR session.permission31_view EQ 1>
		<cfinclude template="dsp_invite_friend.cfm">
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission96_view EQ 1>		
		<cfinclude template="dsp_sidebar_sms.cfm"><br>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission41_view EQ 1>		
		<cfinclude template="dsp_sidebar_announcements.cfm"><br>
	</cfif>
	
	</td>
	</tr>
	
</cfif>

</table>


--->