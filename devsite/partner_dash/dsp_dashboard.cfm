<cfoutput>

<cfif IsDefined("admin_OrganisationID")>
	<cfset this_organisationID = admin_OrganisationID>
<cfelseif IsDefined("session.User_OrganisationID")>
	<cfset this_organisationID = session.User_OrganisationID>
<cfelse>
	<cfset this_organisationID = 0>
</cfif>

<cfquery name="partnerStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Organisations
WHERE OrganisationID=#this_organisationID#
</cfquery>


<!--- GET ALL POINTS TRANSACTIONS FOR THIS PARTNER SPONSORED POINTS --->
<cfquery name="qry_all_sponsored_points" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, Transaction_Date, Transaction_Amount, Related_Description
FROM contact_transactions
WHERE Transaction_SponsorID=#this_organisationID#
AND Transaction_Account LIKE '%Points%'
AND Transaction_Type LIKE '%Credit%'
AND Related_Description <> ''
AND Related_Description <> ' '
ORDER BY Related_Description, Transaction_Date
</cfquery>


<!--- GET ALL ACTIVE --->
<cfquery name="Active" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ContactTypeID, ContactStatus, DateJoined
FROM Contacts
WHERE ContactStatus LIKE '%Active%'
AND ContactTypeID IN (1,2)
</cfquery>


<!--- GET ALL EARNED POINTS --->
<cfquery name="AllEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalEarned
FROM contact_transactions
WHERE Transaction_Account LIKE '%Points%'
AND Transaction_Type LIKE '%Credit%'
</cfquery>

<table width="100%" cellpadding="0" cellspacing="10" border="0">


<cfif fileExists("#request.fileroot#\images\partners\#TRIM(partnerStuff.LogoFile)#")>
<tr>
<td colspan="2" align="center"><img src="#request.imageroot#/partners/#TRIM(partnerStuff.LogoFile)#" border="0"><br></td>
</tr>
</cfif>

<tr>
<td colspan="2" style="font-size:14px;color:black;" align="center">
<hr width="100%" size="1" color="b4b4b4">
<cfif isdefined('session.User_Organisation_Name') and allsettings.recordcount>
<strong>#TRIM(session.User_Organisation_Name)# #TRIM(allsettings.SiteName)# Dashboard</strong>
</cfif>
<hr width="100%" size="1" color="b4b4b4"></td>
</tr>


<tr>
<td width="50%" valign="top">
	<cfinclude template="dsp_dash_pointsto.cfm"><br>
	<cfinclude template="dsp_dash_points_activity.cfm"><br>
	<cfinclude template="dsp_dash_points_history.cfm">
	<br>
</td>
<td width="50%" valign="top">
	<cfinclude template="dsp_dash_rewards.cfm"><br>
	<cfinclude template="dsp_dash_surveys.cfm"><br>
	<cfinclude template="dsp_dash_ideas.cfm">
	<br>
</td>
</tr>


<tr>
<td colspan="2" style="font-size:14px;color:black;" align="center"><br>
<hr width="100%" size="1" color="b4b4b4">
<strong>Community Statistics</strong>
<hr width="100%" size="1" color="b4b4b4">
</td>
</tr>

<tr>
<td width="50%" valign="top">
	<cfinclude template="dsp_dashboard_schools.cfm"><br>
	<cfinclude template="dsp_dashboard_charities.cfm"><br>	
	<cfinclude template="dsp_dashboard_ideas.cfm">
</td>
<td width="50%" valign="top">
	<cfinclude template="dsp_dashboard_businesses.cfm"><br>
	<cfinclude template="dsp_dashboard_goals.cfm"><br>
	<cfinclude template="dsp_dashboard_feedback.cfm">
	<br>
</td>
</tr>



</table>


</cfoutput>