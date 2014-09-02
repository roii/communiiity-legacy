<cfoutput>

<table width="170" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="170" height="8" border="0"></td>
</tr>

<tr>
<td>
	<cfif fusesubaction NEQ 'step2'>	
	
		<cfif session.UserIsAuthenticated EQ 'No'>
			<cfinclude template="dsp_sidebar_login.cfm">
		</cfif>	
		
		<cfif session.permission1_view EQ 1 OR session.permission64_view EQ 1>
			<cfinclude template="dsp_sidebar_profile.cfm">
		</cfif>	
		
		<cfif session.permission1_view EQ 1 OR session.permission2_view EQ 1 OR session.permission11_view EQ 1 OR session.permission94_view EQ 1 OR session.permission83_view EQ 1 OR session.permission84_view EQ 1 OR session.permission95_view EQ 1 OR session.permission93_view EQ 1 OR session.permission52_view EQ 1 OR session.permission24_view EQ 1 OR session.permission68_view EQ 1 OR session.permission69_view EQ 1 OR session.permission54_view EQ 1 OR session.permission97_view EQ 1 OR session.permission11_view EQ 1 OR session.permission59_view EQ 1 OR session.permission60_view EQ 1 OR session.permission55_view EQ 1 OR session.permission56_view EQ 1 OR session.permission57_view EQ 1 OR session.permission58_view EQ 1 OR session.permission61_view EQ 1 OR session.permission62_view EQ 1 OR session.permission99_view EQ 1 OR session.permission63_view EQ 1 OR session.permission87_view EQ 1 OR session.permission88_view EQ 1 OR session.permission96_view EQ 1 OR session.permission92_view EQ 1>
			<br><cfinclude template="dsp_sidebar_menu_admin.cfm"><br>
		</cfif>
		
		<br>
		<cfinclude template="dsp_sidebar_flash_promo.cfm">
			
		<!--- <cfif session.permission1_view EQ 1 OR session.permission28_view EQ 1>
			<cfinclude template="dsp_sidebar_rewards.cfm"><br>
		</cfif> --->
			
		<cfif session.permission1_view EQ 1 OR session.permission101_view EQ 1>
			<cfinclude template="dsp_positive_quotes.cfm"><br>
		</cfif>		
		
	</cfif>
</td>
</tr>

</table>

</cfoutput>