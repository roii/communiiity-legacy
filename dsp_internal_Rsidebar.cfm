<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="170" height="8" border="0"></td>
</tr>


<tr>
<td align="center">
	<cfinclude template="../templates/dsp_sidebar_quicktour.cfm"><br>
</td>
</tr>

<tr>
<td align="center">
<cfif fusesubaction NEQ 'step2'>
	<cfinclude template="../templates/dsp_sidebar_rewards.cfm"><br>
</cfif>
</td>
</tr>


</table>


</cfoutput>