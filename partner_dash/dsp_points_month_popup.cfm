<cfoutput>

<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.MonthPoints_StartRow" default="1">
</cflock>

<cfif isdefined("MonthPoints_StartRow")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.MonthPoints_StartRow = MonthPoints_StartRow>
	</cflock>
</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.MonthPoints_Maxrows" default="100">
</cflock>

<cfif isdefined("MonthPoints_Maxrows")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.MonthPoints_Maxrows = MonthPoints_Maxrows>
	</cflock>
</cfif>
	
	
	
<!--- SET MONTH START DATE --->
<cfset points_month_start = CreateDate(Dateformat(localdatetime, "yyyy"),  Dateformat(localdatetime, "mm"),  1)>
<cfset points_month_end = CreateDate(Dateformat(localdatetime, "yyyy"),  Dateformat(localdatetime, "mm"),  DaysInMonth(localdatetime))>


<cfparam name="SortBy" default="Transaction_Date">
<cfparam name="Order" default="DESC">

<!--- GET ALL POINTS TRANSACTIONS FOR THIS PARTNER SPONSORED POINTS --->
<cfquery name="qry_points_month" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT contact_transactions.Transaction_Date, contact_transactions.Transaction_Amount, contact_transactions.Related_Description, Contacts.ScreenName
FROM contact_transactions, contacts
WHERE contact_transactions.Transaction_SponsorID=#this_organisationID#
AND contact_transactions.Transaction_Account LIKE '%Points%'
AND contact_transactions.Transaction_Type LIKE '%Credit%'
AND contact_transactions.Related_Description <> ''
AND contact_transactions.Related_Description <> ' '
AND contact_transactions.Transaction_Date >= #points_month_start#
AND contact_transactions.Transaction_Date <= #points_month_end#
AND contact_transactions.ContactID=Contacts.ContactID
ORDER BY #SortBy# #Order#
</cfquery>

<!--- SET THE MonthPoints_endrow VALUE --->
<cfif session.MonthPoints_Maxrows NEQ 'ALL'>

	<cfif qry_points_month.RecordCount GT (session.MonthPoints_StartRow+session.MonthPoints_Maxrows)-1>
		<cfset MonthPoints_endrow = session.MonthPoints_StartRow+session.MonthPoints_Maxrows-1>
	<cfelse>
		<cfset MonthPoints_endrow = qry_points_month.RecordCount>
	</cfif>

<cfelse>
	<cfset MonthPoints_endrow = qry_points_month.RecordCount>

</cfif>



<!--- SET THE PREV VALUE --->
<cfif session.MonthPoints_StartRow GT session.MonthPoints_Maxrows>
	<cfset prev = session.MonthPoints_StartRow-session.MonthPoints_Maxrows>

<cfelse>
	<cfset prev = session.MonthPoints_StartRow>

</cfif>



<!--- SET THE NEXT VALUE --->
<cfif MonthPoints_endrow LT qry_points_month.RecordCount>
	<cfset next = (MonthPoints_endrow+1)>

<cfelse>
	<cfset next = session.MonthPoints_StartRow>

</cfif>



<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.MonthPoints_Maxrows NEQ 'ALL'>

	<cfset NumberCount=(qry_points_month.RecordCount/session.MonthPoints_Maxrows)>
	<cfset PointsNumberCount=Ceiling(NumberCount)>

<cfelse>

	<cfset PointsNumberCount=1>
	
</cfif>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Sponsored Points - This Month</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Sponsored Points - This Month</strong></span></td>
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
	<td class="small" colspan="2">Found: <strong>#qry_points_month.Recordcount#</strong> transactions. &nbsp; Displaying <strong>#session.MonthPoints_StartRow# - #MonthPoints_endrow#</strong></td>
	<td align="right" colspan="2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&MonthPoints_Maxrows=50&MonthPoints_StartRow=1">50</a> | <a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&MonthPoints_Maxrows=100&MonthPoints_StartRow=1">100</a> | <a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&MonthPoints_Maxrows=200&MonthPoints_StartRow=1">200</a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="4"><br><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&SortBy=Transaction_Date&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Date</a></td>
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&SortBy=ScreenName&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">User</a></td>
	<td style="font-size:11px;color:##444444;"><a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&SortBy=Related_Description&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Activity</a></td>
	<td style="font-size:11px;color:##444444;" align="center"><a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&SortBy=Transaction_Amount&order=<cfif order EQ 'ASC'>DESC<cfelse>ASC</cfif>">Earned</a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="4"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<cfset totalpoints = 0>
	
	<cfloop query="qry_points_month" startrow="#session.MonthPoints_StartRow#" endrow="#MonthPoints_endrow#">
	<cfset this_relateddescription = TRIM(qry_points_month.Related_Description)>
	<cfset totalpoints = totalpoints + qry_points_month.Transaction_Amount>
	
	<cfquery name="DescriptionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Dash_Description
	FROM Activity
	WHERE Related_Description LIKE '%#this_relateddescription#%'
	</cfquery>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;"><strong>#Dateformat(qry_points_month.Transaction_Date)#</strong></td>
	<td style="font-size:11px;color:##444444;">#TRIM(qry_points_month.ScreenName)#</td>
	<td style="font-size:11px;color:##444444;"><cfif DescriptionStuff.RecordCount>#TRIM(DescriptionStuff.Dash_Description)#<cfelseif TRIM(this_relateddescription) CONTAINS 'RegisterPromoCode'>Registered with Promo-code<cfelse>#TRIM(this_relateddescription)#</cfif></td>
	<td style="font-size:11px;color:##444444;" align="center">#INT(qry_points_month.Transaction_Amount)#</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="4"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	<cfflush interval="20">
	</cfloop>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;"></td>
	<td style="font-size:11px;color:##444444;"></td>
	<td style="font-size:11px;color:##444444;" align="right"><strong>TOTAL:</strong></td>
	<td style="font-size:11px;color:##444444;" align="center"><strong>#ROUND(totalpoints)#</strong></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="4"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;color:##444444;" colspan="4"><cfif session.MonthPoints_Startrow GT session.MonthPoints_Maxrows>&lt; <a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&MonthPoints_StartRow=#prev#">Prev Page</a> | </cfif><cfif MonthPoints_endrow LT qry_points_month.RecordCount><a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&MonthPoints_StartRow=#next#">Next Page</a> &gt;</cfif><cfif session.MonthPoints_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#PointsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.MonthPoints_Maxrows*NumberCount-session.MonthPoints_Maxrows+1)><cfif thisStartRow EQ session.MonthPoints_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/partner_dash/dsp_points_month_popup.cfm?this_organisationID=#this_organisationID#&MonthPoints_StartRow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.MonthPoints_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ PointsNumberCount> - </cfif></cfloop></cfif></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	</table><br>
	

	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>