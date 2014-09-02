<cfoutput>

<cfquery name="total_user_points" dbtype="query">
SELECT SUM(Transaction_Amount) AS TotalEarnedPoints
FROM qry_all_sponsored_points
</cfquery>


<!--- GET ALL POINTS TRANSACTIONS FOR THIS PARTNER SPONSORED POINTS --->
<cfquery name="qry_all_sponsored_schools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Schools.SchoolName, SUM(contact_transactions.Transaction_Amount) AS TotalSchoolsEarned
FROM contact_transactions, contacts, Schools
WHERE contact_transactions.Transaction_SponsorID=#this_organisationID#
AND contact_transactions.Transaction_Account LIKE '%Points%'
AND contact_transactions.Transaction_Type LIKE '%Credit%'
AND contact_transactions.Related_Description <> ''
AND contact_transactions.contactID = contacts.ContactID
AND contacts.SchoolID=Schools.SchoolID
GROUP BY Schools.SchoolName
</cfquery>

<cfset total_school_points = 0>

<cfloop query="qry_all_sponsored_schools">
<cfif IsNumeric("#qry_all_sponsored_schools.TotalSchoolsEarned#") AND qry_all_sponsored_schools.TotalSchoolsEarned GT 0>
	<cfset total_school_points = (total_school_points + qry_all_sponsored_schools.TotalSchoolsEarned)>
</cfif>
</cfloop>


<!--- GET ALL POINTS TRANSACTIONS FOR THIS PARTNER SPONSORED POINTS --->
<cfquery name="qry_all_sponsored_charities" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Organisations.Organisation_Name, SUM(contact_transactions.Transaction_Amount) AS TotalCharitiesEarned
FROM contact_transactions, contacts, Organisations
WHERE contact_transactions.Transaction_SponsorID=#this_organisationID#
AND contact_transactions.Transaction_Account LIKE '%Points%'
AND contact_transactions.Transaction_Type LIKE '%Credit%'
AND contact_transactions.Related_Description <> ''
AND contact_transactions.contactID = contacts.ContactID
AND contacts.Charity=Organisations.OrganisationID
GROUP BY Organisations.Organisation_Name
</cfquery>


<cfset total_charity_points = 0>

<cfloop query="qry_all_sponsored_charities">
<cfif IsNumeric("#qry_all_sponsored_charities.TotalCharitiesEarned#") AND qry_all_sponsored_charities.TotalCharitiesEarned GT 0>
	<cfset total_charity_points = (total_charity_points + qry_all_sponsored_charities.TotalCharitiesEarned)>
</cfif>
</cfloop>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Points went to</strong></td>
	<td align="right" valign="bottom"><!--- <img src="#request.imageroot#/SiteIcons/Community_sml.jpg" alt="Community" border="0"> ---></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Users:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><a href="#request.webroot#/partner_dash/dsp_points_user_popup.cfm?this_organisationID=#this_organisationID#" target="pointsdetails" onclick="fdbackwindow=window.open ('','pointsdetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')">#total_user_points.TotalEarnedPoints#</a></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Schools:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><a href="#request.webroot#/partner_dash/dsp_points_schools_popup.cfm?this_organisationID=#this_organisationID#" target="pointsdetails" onclick="fdbackwindow=window.open ('','pointsdetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')">#ROUND(total_school_points/10)#</a></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Charities:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><a href="#request.webroot#/partner_dash/dsp_points_charities_popup.cfm?this_organisationID=#this_organisationID#" target="pointsdetails" onclick="fdbackwindow=window.open ('','pointsdetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')">#ROUND(total_charity_points/10)#</a></td>
	</tr>
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>