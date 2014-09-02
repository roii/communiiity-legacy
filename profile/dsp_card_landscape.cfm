<cfoutput>

<cfif (session.UserIsAuthenticated EQ 'Yes')>

	<cfquery name="qry_mobile_num" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT MobilePhone
	FROM Contacts
	WHERE ContactID=#session.UserID#
	</cfquery>

</cfif>

<cfset allsettings.logo_file = '3Pv_logo_card.gif'>

<table width="300" cellpadding="5" cellspacing="0" style="border:dotted 0px e2e2e2;" align="center">

<tr>
<td valign="top">
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<tr>
	<td valign="middle" width="40%" align="center" style="padding-right:3px;color:black;"><span style="font-size:13px;"><strong>Help your School<br>and the Planet</strong></span><br>
	<span style="font-size:9px;">while you...<br>
	- make real money<br>
	- win daily prizes<br>
	- earn points to spend<br>
	on computers, prepay phone cards and more!</td>
	<td width="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td valign="top" width="60%" align="center" style="padding-left:4px;color:black;">
	<span style="font-size:9px;">Your community with a purpose</span><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	<img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" alt="#TRIM(AllSettings.SiteName)#" border="0"><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	<span style="font-size:11px;color:Black;"><strong>#TRIM(session.User_FirstName)# #TRIM(session.User_LastName)#</strong></span><br>
	<span style="font-size:9px;color:Black;"><a href="mailto:">#TRIM(session.User_Email)#</a>
	<cfif IsDefined("qry_mobile_num") AND qry_mobile_num.MobilePhone NEQ ''><br>
	#TRIM(qry_mobile_num.MobilePhone)#
	</cfif>	
	</span><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	<span style="font-size:9px;">To earn extra points, use <strong>"<em>#session.User_ScreenName#</em>"</strong> as your invite code when registering on <a href="">www.my3p.com</a></span></td>
	</tr>
	
	</table>


</td>
</tr>	

</table>


</cfoutput>