<cfinclude template="qry_administrators.cfm">
<cfinclude template="qry_adminLog.cfm">

<br>


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<cfoutput>

<form method="post" action="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=#attributes.fusesubaction#">		
<tr bgcolor="e2e2e2" height="30">
<td colspan="3" valign="middle">&nbsp;<select name="LogPeriod" class="whitefield">
<option value="1"<cfif logperiod EQ 1> selected</cfif>>Last 24 hours</option>
<option value="7"<cfif logperiod EQ 7> selected</cfif>>Last 7 days</option>
<option value="30"<cfif logperiod EQ 30> selected</cfif>>Last 30 days</option>
<option value="60"<cfif logperiod EQ 60> selected</cfif>>Last 2 months</option>
<option value="90"<cfif logperiod EQ 90> selected</cfif>>Last 3 months</option>
<option value="120"<cfif logperiod EQ 120> selected</cfif>>Last 4 months</option>
<option value="150"<cfif logperiod EQ 150> selected</cfif>>Last 5 months</option>
<option value="180"<cfif logperiod EQ 180> selected</cfif>>Last 6 months</option>
<option value="365"<cfif logperiod EQ 365> selected</cfif>>Last 12 months</option>
</select> <select name="LogAdmin" class="whitefield">
<option value="ALL"<cfif LogAdmin EQ 'ALL'> selected</cfif>>ALL Administrators
<cfloop query="alladministrators">
<option value="#alladministrators.AdministratorID#"<cfif LogAdmin EQ alladministrators.AdministratorID> selected</cfif>>#TRIM(alladministrators.FirstName)# #TRIM(alladministrators.LastName)#
</cfloop>
</select> <input type="submit" class="whitefield" value=">>"></td>
</tr>
</form>

</cfoutput>

<tr>
<td colspan="3"><br></td>
</tr>

<tr>
<td class="normal" width="76" valign="top"><b>Date/Time</b></td>
<td class="normal" width="100" valign="top" align="center"><b>Administrator</b></td>
<td class="normal" width="430" valign="top"><b>Details</b></td>
</tr>
		
<tr>
<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>
	
<cfoutput query="adminLog">

<cfquery name="administratordetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Administrator
WHERE AdministratorID = #Administrator#
</cfquery>

<tr>
<td class="small" width="76" valign="top" align="center">#DateFormat(LogDate, "dd/mm/yy")#<br>
#TimeFormat(LogDate, "HH:mm.ss")#</td>
<td class="small" width="100" valign="top" align="center">#administratordetails.LastName#, #administratordetails.firstName#</td>
<td class="small" width="430" valign="top">#Details#</td>
</tr>

<tr>
<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>
</cfoutput>		


	
</table>
