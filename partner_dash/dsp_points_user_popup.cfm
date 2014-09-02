<cfoutput>

<cfparam name="SortBy" default="Contacts.ScreenName">
<cfparam name="Order" default="ASC">




<!--- GET ALL POINTS TRANSACTIONS FOR THIS PARTNER SPONSORED POINTS --->
<cfquery name="qry_all_sponsored_points" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.ScreenName, Contacts.FirstName, Contacts.City, Contacts.DateOfBirth, Countries.Name, SUM(contact_transactions.Transaction_Amount) AS TotalEarned
FROM contact_transactions, contacts, countries
WHERE contact_transactions.Transaction_SponsorID=#this_organisationID#
AND contact_transactions.Transaction_Account LIKE '%Points%'
AND contact_transactions.Transaction_Type LIKE '%Credit%'
AND contact_transactions.Related_Description <> ''
AND contact_transactions.contactID = contacts.ContactID
AND contacts.countryID=countries.CountryID
GROUP BY Contacts.ContactID, Contacts.ScreenName, Contacts.FirstName, Contacts.City, Contacts.DateOfBirth, Countries.Name
ORDER BY #SortBy# #Order#
</cfquery>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Sponsored Points - Users</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Sponsored Points - Users</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>
		
	

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_user_popup.cfm?this_organisationID=#this_organisationID#&SortBy=ScreenName&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Screen-Name</a></td>
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_user_popup.cfm?this_organisationID=#this_organisationID#&SortBy=DateOfBirth&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Age</a></td>
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_user_popup.cfm?this_organisationID=#this_organisationID#&SortBy=City&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">City</a></td>
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_user_popup.cfm?this_organisationID=#this_organisationID#&SortBy=Name&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Country</a></td>
	<td style="font-size:11px;color:##444444;" align="center"><a href="#request.webroot#/partner_dash/dsp_points_user_popup.cfm?this_organisationID=#this_organisationID#&SortBy=TotalEarned&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Earned</a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	<cfloop query="qry_all_sponsored_points">
	<cfset this_contact = qry_all_sponsored_points.contactID>
		

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;"><strong><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_Contact#" title="View Profile" target="mymainwindow"><cfif TRIM(qry_all_sponsored_points.ScreenName) NEQ ''>#TRIM(qry_all_sponsored_points.ScreenName)#<cfelse>#TRIM(qry_all_sponsored_points.FirstName)#</cfif></a></strong></td>
	<td style="font-size:11px;color:##444444;"><cfif IsDate("#qry_all_sponsored_points.dateofbirth#")>#DateDiff('yyyy', qry_all_sponsored_points.dateofbirth, localDateTime)#yrs<cfelse>&ndash;</cfif></td>
	<td style="font-size:11px;color:##444444;">#TRIM(qry_all_sponsored_points.City)#</td>
	<td style="font-size:11px;color:##444444;">#TRIM(qry_all_sponsored_points.Name)#</td>
	<td style="font-size:11px;color:##444444;" align="center">#INT(qry_all_sponsored_points.TotalEarned)#</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>