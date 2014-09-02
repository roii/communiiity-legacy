<cfoutput>

<!--- SET MONTH START DATE --->
<cfset points_month_start = CreateDate(Dateformat(localdatetime, "yyyy"),  Dateformat(localdatetime, "mm"),  1)>
<cfset points_month_end = CreateDate(Dateformat(localdatetime, "yyyy"),  Dateformat(localdatetime, "mm"),  DaysInMonth(localdatetime))>

<!--- SET YEAR START DATE --->
<cfset points_year_start = CreateDate(Dateformat(localdatetime, "yyyy"),  1,  1)>
<cfset points_year_end = CreateDate(Dateformat(localdatetime, "yyyy"),  12,  31)>




<!--- SPONSORED THIS MONTH --->
<cfquery name="total_thismonth" dbtype="query">
SELECT SUM(Transaction_Amount) AS TotalMonthsPoints
FROM qry_all_sponsored_points
WHERE Transaction_Date >= #points_month_start#
AND Transaction_Date <= #points_month_end#
</cfquery> 


<!--- SPONSORED THIS YEAR --->
<cfquery name="total_thisyear" dbtype="query">
SELECT SUM(Transaction_Amount) AS TotalYearPoints
FROM qry_all_sponsored_points
WHERE Transaction_Date >= #points_year_start#
AND Transaction_Date <= #points_year_end#
</cfquery> 


<cfquery name="total_todate" dbtype="query">
SELECT SUM(Transaction_Amount) AS TotalToDatePoints
FROM qry_all_sponsored_points
</cfquery> 


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Points sponsored</strong></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">This month:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><a href="#request.webroot#/partner_dash/dsp_points_history_popup.cfm?this_organisationID=#this_organisationID#&DateRange_StartDate=#CreateDate(dateFormat(localdatetime, "yyyy"), dateFormat(localdatetime, "mm"), 1)#&DateRange_EndDate=#CreateDate(dateFormat(localdatetime, "yyyy"), dateFormat(localdatetime, "mm"), DaysInMonth(localdatetime))#" target="pointsdetails" onclick="fdbackwindow=window.open ('','pointsdetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=900,height=750,top=10,left=10')">#total_thismonth.TotalMonthsPoints#</a></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">This year:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><a href="#request.webroot#/partner_dash/dsp_points_history_popup.cfm?this_organisationID=#this_organisationID#&DateRange_StartDate=#CreateDate(dateFormat(localdatetime, "yyyy"), 1, 1)#&DateRange_EndDate=#CreateDate(dateFormat(localdatetime, "yyyy"), 12, 31)#" target="pointsdetails" onclick="fdbackwindow=window.open ('','pointsdetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=900,height=750,top=10,left=10')">#total_thisyear.TotalYearPoints#</a></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">To date:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><a href="#request.webroot#/partner_dash/dsp_points_history_popup.cfm?this_organisationID=#this_organisationID#&DateRange_StartDate=#CreateDate(2006, 1, 1)#&DateRange_EndDate=#CreateDate(dateFormat(localdatetime, "yyyy"), 12, 31)#" target="pointsdetails" onclick="fdbackwindow=window.open ('','pointsdetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=900,height=750,top=10,left=10')">#total_todate.TotalToDatePoints#</a></td>
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