<cfoutput>

<table width="170" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="170" height="8" border="0"></td>
</tr>

<tr>
<td align="center">
	
	<cfif fusesubaction NEQ 'step2'>	
	
		<cfif session.UserIsAuthenticated EQ 'No'>
			<!---<cfinclude template="../templates/dsp_sidebar_login.cfm">--->
		</cfif>	
		
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType NEQ 'Administrator'>
			<cfinclude template="../templates/dsp_sidebar_profile.cfm">
		</cfif>	
		
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
			<cfinclude template="../templates/dsp_sidebar_menu_admin.cfm"><br>
		</cfif>
			
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>	
			<!---<cfinclude template="../templates/dsp_sidebar_sms.cfm"><br>	--->
		<cfelse>
			<!--- <br><cfinclude template="../templates/dsp_sidebar_flash_promo.cfm">
			<cfinclude template="../templates/dsp_sidebar_rewards.cfm"><br>
			<cfinclude template="../templates/dsp_positive_quotes.cfm"><br> --->
		</cfif>
		
		<cfif session.UserIsAuthenticated EQ 'No'>
			<!---<cfinclude template="../templates/dsp_sidebar_sms.cfm"><br>--->
		</cfif>
		
		
	</cfif>

</td>
</tr>

</table>


</cfoutput>