<cfoutput>

<cfparam name="SortBy" default="Organisation_Name">
<cfparam name="Order" default="ASC">




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
ORDER BY #SortBy# #Order#
</cfquery>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Sponsored Points - Charities</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Sponsored Points - Charities</strong></span></td>
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
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_charities_popup.cfm?this_organisationID=#this_organisationID#&SortBy=Organisation_Name&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Charity</a></td>
	<td style="font-size:11px;color:##444444;"></td>
	<td style="font-size:11px;color:##444444;" align="center"><a href="#request.webroot#/partner_dash/dsp_points_charities_popup.cfm?this_organisationID=#this_organisationID#&SortBy=TotalCharitiesEarned&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Earned</a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<cfset total_charity_points = 0>
	
	<cfloop query="qry_all_sponsored_charities">	
	<cfset total_charity_points = total_charity_points + qry_all_sponsored_charities.TotalCharitiesEarned>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;"><strong>#TRIM(qry_all_sponsored_charities.Organisation_Name)#</strong></td>
	<td style="font-size:11px;color:##444444;"></td>
	<td style="font-size:11px;color:##444444;" align="center">#ROUND(qry_all_sponsored_charities.TotalCharitiesEarned/10)#</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;"></td>
	<td style="font-size:11px;color:##444444;" align="right"><strong>TOTAL:</strong></td>
	<td style="font-size:11px;color:##444444;" align="center"><strong>#ROUND(total_charity_points/10)#</strong></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>