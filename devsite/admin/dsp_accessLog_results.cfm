<cfparam name="GroupMode" default="off">

<cfoutput>

<span class="normal">Your Search retrieved <b>#LogResults.RecordCount#</b> unique page hits for your specified search criteria.<br><br>

Click here to <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&GroupMode=On&LogPeriod=#LogPeriod#&SiteArea=#SiteArea#&Status=#Status#&logmode=results" class="noline">IDENTIFY UNIQUE VISITORS</a></span>
<br><br><br>

</cfoutput>


<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr>
<td width="5"><span class="normal">&nbsp;</span></td>
<td><span class="normal"><b>ACCESS DATE</b></span></td>
<td><span class="normal"><b>MEMBERSHIP I.D.</b></span></td>
<td><span class="normal"><b>UNIQUE COMPUTER I.D.</b></span></td>
<td><span class="normal"><b>AREA OF SITE</b></span></td>
</tr>

<tr>
<td colspan="5"><hr width="100%" size="1" color="Silver"></td>
</tr>

<cfif #GroupMode# EQ 'On'>

	<cfoutput query="LogResults" group="sessionID">
	<tr bgcolor="f2f2f2" height="20">
	<td width="5"><span class="small">&nbsp;</span></td>
	<td colspan="4" class="normal"><b>#SessionID#</b></td>
	</tr>
	
	<tr height="6">
	<td colspan="5"><span class="small"> </span></td>
	</tr>
	<cfoutput>
	
	
	<cfquery name="PageStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title AS PageTitle
	FROM Sections
	WHERE Fuseaction='#TRIM(LogResults.fuseaction)#'
	</cfquery>
	
	
	<tr>
	<td width="5"><span class="small">&nbsp;</span></td>
	<td><span class="small">#DateFormat(DateOfAccess, "dd/mm/yy")#<br>
	#TimeFormat(DateOfAccess, "HH:mm.ss")#</span></td>
	<td><span class="small">#MembershipID#</span></td>
	<td><span class="small">#SessionID#</span></td>
	<td><span class="small">#PageStuff.PageTitle#</span></td>
	</tr>
	
	<tr>
	<td colspan="5"><hr width="100%" size="1" color="Silver"></td>
	</tr>
	</cfoutput>
	
	</cfoutput>


<cfelse>

	<cfoutput query="LogResults">
	
	<cfquery name="PageStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title AS PageTitle
	FROM Sections
	WHERE Fuseaction='#TRIM(LogResults.fuseaction)#'
	</cfquery>
	
	
	<tr<cfif #Evaluate(currentrow MOD 2)# EQ 0> bgcolor="f2f2f2"</cfif>>
	<td width="5"><span class="small">&nbsp;</span></td>
	<td><span class="small">#DateFormat(DateOfAccess, "dd/mm/yy")#<br>
	#TimeFormat(DateOfAccess, "HH:mm.ss")#</span></td>
	<td><span class="small">#MembershipID#</span></td>
	<td><span class="small">#SessionID#</span></td>
	<td><span class="small">#PageStuff.PageTitle#</span></td>
	</tr>
	</cfoutput>
	
</cfif>

</table>


