<cfoutput>

<cfparam name="resource_mode" default="index">

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MY RESOURCES</strong></td>
<td align="right" width="30"></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="400" height="15" border="0"><br>



<cfif resource_mode EQ 'index'>

<ul>
<li><strong><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&resource_mode=create_cards" style="color:###TRIM(AllSettings.BoxColour)#;">Create your own #TRIM(AllSettings.SiteName)# Business Cards</a></strong><br>
<span style="color:###TRIM(AllSettings.DkTextColor)#;">They include your Screen-name which can be used as an <u>invitation code</u> by your friends when they sign-up to earn you both extra points!</span></li>
</ul>


<cfelseif resource_mode EQ 'create_cards'>

	<cfinclude template="dsp_create_cards.cfm">


</cfif>

</td>
</tr>

</table>



</cfoutput>