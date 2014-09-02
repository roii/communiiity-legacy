<cfoutput>

<cfparam name="session.Dashboard_StartDate" default="#DateAdd('d', -30, localdatetime)#">
<cfif IsDefined("form.Dashboard_StartDate")>
	<cfset session.Dashboard_StartDate = CreateDate(mid(form.Dashboard_StartDate,7,4),mid(form.Dashboard_StartDate,4,2),mid(form.Dashboard_StartDate,1,2))>
</cfif>

<cfparam name="session.Dashboard_EndDate" default="#DateAdd('d', 1, localdatetime)#">
<cfif IsDefined("form.Dashboard_EndDate")>
	<cfset session.Dashboard_EndDate = CreateDate(mid(form.Dashboard_EndDate,7,4),mid(form.Dashboard_EndDate,4,2),mid(form.Dashboard_EndDate,1,2))>
</cfif>

<!--- GET ALL EARNED POINTS --->
<cfquery name="AllEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalEarned
FROM contact_transactions
WHERE Transaction_Account LIKE '%Points%'
AND Transaction_Type LIKE '%Credit%'
AND Transaction_Date BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>

<!--- GET ALL REDEEEMED POINTS--->
<cfquery name="AllSpent" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalSpent
FROM contact_transactions
WHERE Transaction_Account LIKE '%Points%'
AND Transaction_Type LIKE '%Debit%'
AND Transaction_Date BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>

<cfif AllEarned.RecordCount AND IsNumeric("#AllEarned.TotalEarned#")>
	<cfset totalearned_points = AllEarned.TotalEarned>
<cfelse>
	<cfset totalearned_points = 0>
</cfif>

<cfif AllSpent.RecordCount AND IsNumeric("#AllSpent.TotalSpent#")>
	<cfset totalspent_points = AllSpent.TotalSpent>
<cfelse>
	<cfset totalspent_points = 0>
</cfif>


<cfset balance_points = (totalearned_points - totalspent_points)>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#admindash#</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="400" height="15" border="0"></td>
</tr>

<form name="DashForm" action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" method="post">
<tr>
<td colspan="2" style="color:###TRIM(AllSettings.DkTextColor)#"><strong>#reportfrom#:</strong> <input type="text" class="whitefield" name="Dashboard_StartDate" style="width:100px;" value="#DateFormat(session.Dashboard_StartDate, 'dd/mm/yyyy')#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.DashForm.Dashboard_StartDate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a> &nbsp;&nbsp;&nbsp; <strong>#totext#</strong> <input type="text" class="whitefield" name="Dashboard_EndDate" style="width:100px;" value="#DateFormat(session.Dashboard_EndDate, 'dd/mm/yyyy')#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.DashForm.Dashboard_EndDate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0" alt=""></a> &nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" class="whitefield" style="color:###TRIM(AllSettings.DkTextColor)#" value="#dispdash# &raquo;">

<hr width="100%" size="1" color="##b4b4b4">

</td>
</tr>
</form>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="400" height="15" border="0"></td>
</tr>

</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="50%" valign="top">
<!--- <cfinclude template="dsp_dashboard_kpis.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"> --->
<cfinclude template="dsp_dashboard_registrations.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_invitations.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_schools.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_charities.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_feedback.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
</td>
<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
<td width="50%" valign="top"><!--- 
<cfinclude template="dsp_dashboard_points.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_cash.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_education.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_prizes.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_businesses.cfm"> --->
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_goals.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><!--- 
<cfinclude template="dsp_dashboard_ideas.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"> ---></td>
</tr>


</table>


</cfoutput>