<cfparam name="StartRow" default="1">
	<cfif isdefined("StartRow")>	
		<cfset StartRow = #StartRow#>
	</cfif>
	
	
<cfif #GroupMode# EQ 'On'>	
	<cfparam name="MaxRows" default="10">	
<cfelse>
	<cfparam name="MaxRows" default="100">	
</cfif>



<cfif #GroupMode# EQ 'On'>	
	<cfparam name="numberofrecords" default="0">
	<cfoutput query="LogResults" group="sessionID">	
	<cfset numberofrecords = (#numberofrecords#+1)>
	</cfoutput>
		
<cfelse>
	<cfset numberofrecords = #LogResults.RecordCount#>	
</cfif>



	<cfif isdefined("MaxRows")>	
		<cfset MaxRows = #MaxRows#>
	</cfif>
	
	
	
	<cfif #numberofrecords# GT (#StartRow#+#MaxRows#)-1>
		<cfset endrow = #StartRow#+#MaxRows#-1>
	<cfelse>
		<cfset endrow = #numberofrecords#>
	</cfif>







<!--- SET THE PREV VALUE --->
	<cfif #Startrow# GT #Maxrows#>
		<cfset prev = #Startrow#-#Maxrows#>
	
	<cfelse>
		<cfset prev = #StartRow#>
	
	</cfif>
	
	
	
	<cfif #endrow# LT #numberofrecords#>
		<cfset next = (#endrow#+1)>
	
	<cfelse>
		<cfset next = #StartRow#>
	
	</cfif>	


	

<cfoutput>

<span class="normal">Click here to <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&GroupMode=On&LogPeriod=#LogPeriod#&SiteArea=#SiteArea#&Status=#Status#&logmode=results" class="noline">IDENTIFY UNIQUE VISITOR SESSIONS</a></span><br><br>

Displaying: <strong>#startrow# - #endrow#</strong>

</cfoutput> 



<cfoutput>of <strong>#numberofrecords#</strong> <cfif #GroupMode# EQ 'On'>unique visitor sessions<cfelse>unique page hits</cfif></cfoutput><br><br><br>

<cfoutput>
	<table cellpadding="0" cellspacing="1" width="200">
	
	<tr>
	<!--- IF THE CURRENT DISPLAY COUNT IS GREATER THAN THE START ROW PLUE THE MAX ROWS THEN SHOW THE PREVIOUS BUTTON--->

	<cfif #Startrow# GT #Maxrows#>
	<FORM action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&logmode=results" method="post">
	<td width="40">
			
	<INPUT type="hidden" name="Maxrows" value="#Maxrows#">
	<INPUT type="hidden" name="Startrow" value="#Evaluate(startrow - maxrows)#">
	<INPUT type="hidden" name="GroupMode" value="#GroupMode#">
	<INPUT type="hidden" name="SiteArea" value="#SiteArea#">
	<INPUT type="hidden" name="Status" value="#Status#">
	<INPUT type="hidden" name="LogPeriod" value="#LogPeriod#">
	
	
	
	<cfif #GroupMode# EQ 'On'>
	<INPUT type="submit" value="< Prev. 10 Results" class="whitefield">
	<cfelse>
	<INPUT type="submit" value="< Prev. 100 Results" class="whitefield">
	</cfif>
	
	</td>
	</FORM>
	<td width="10">&nbsp;</td>
	</cfif>

	<!--- IF THE RECORD COUNT IS GREATER THAN THE MAX ROWS THEN SHOW THE NEXT BUTTON--->

	<cfif #endrow# LT #numberofrecords#>
	<FORM action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&logmode=results" method="post">
	<td width="40">
	<INPUT type="hidden" name="Maxrows" value="#Maxrows#">
	<INPUT type="hidden" name="Startrow" value="#Evaluate(startrow + maxrows)#">
	<INPUT type="hidden" name="GroupMode" value="#GroupMode#">
	<INPUT type="hidden" name="SiteArea" value="#SiteArea#">
	<INPUT type="hidden" name="Status" value="#Status#">
	<INPUT type="hidden" name="LogPeriod" value="#LogPeriod#">
	
	
	<cfif #GroupMode# EQ 'On'>
	<INPUT type="submit" value="Next 10 Results >" class="whitefield">
	<cfelse>
	<INPUT type="submit" value="Next. 100 Results >" class="whitefield">
	</cfif>
	</td>
	</FORM>
	</CFIF>
	
	</tr>	
	
	</table>


<br><br>

</cfoutput>


<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr>
<td colspan="5"><hr width="100%" size="1" color="Silver"></td>
</tr>

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

	<cfoutput query="LogResults" group="sessionID"  startrow="#StartRow#" maxrows="#maxrows#">
	
	
	
	<tr bgcolor="f2f2f2" height="20">
	<td width="5"><span class="small">&nbsp;</span></td>
	<td colspan="4" class="normal"><b>#SessionID#</b></td>
	</tr>
	
	<tr height="6">
	<td colspan="5"><span class="small"> </span></td>
	</tr>
	<cfoutput>
	
	<cfset thismemberid=#LogResults.MembershipID#>
	
	<cfquery name="PageStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title AS PageTitle
	FROM Sections
	WHERE Fuseaction='#TRIM(LogResults.fuseaction)#'
	</cfquery>
	
	
	
		<cfset UserFirstName=''>
		<cfset UserLastName=''>
		<cfset UserOrg=''>
		
	

	
	
	<tr>
	<td width="5"><span class="small">&nbsp;</span></td>
	<td><span class="small">#DateFormat(DateOfAccess, "dd/mm/yy")#<br>
	#TimeFormat(DateOfAccess, "HH:mm.ss")#</span></td>
	<td><span class="small">#UserFirstName# #UserLastName#<cfif #UserOrg# NEQ ''><br>#UserOrg#</cfif></span></td>
	<td><span class="small">#SessionID#</span></td>
	<td><span class="small">#PageStuff.PageTitle#</span></td>
	</tr>
	
	<tr>
	<td colspan="5"><hr width="100%" size="1" color="Silver"></td>
	</tr>
	</cfoutput>
	
	</cfoutput>
	
	


<cfelse>

	<cfoutput query="LogResults" startrow="#StartRow#" maxrows="#maxrows#">
	
	<cfset thismemberid=#LogResults.MembershipID#>
	
	<cfquery name="PageStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title AS PageTitle
	FROM Sections
	WHERE Fuseaction='#TRIM(LogResults.fuseaction)#'
	</cfquery>
	
	
	
	
		<cfset UserFirstName=''>
		<cfset UserLastName=''>
		<cfset UserOrg=''>
				
	
	<tr<cfif #Evaluate(currentrow MOD 2)# EQ 0> bgcolor="f2f2f2"</cfif>>
	<td width="5"><span class="small">&nbsp;</span></td>
	<td><span class="small">#DateFormat(DateOfAccess, "dd/mm/yy")#<br>
	#TimeFormat(DateOfAccess, "HH:mm.ss")#</span></td>
	<td><span class="small">#UserFirstName# #UserLastName#<cfif #UserOrg# NEQ ''><br>#UserOrg#</cfif></span></td>
	<td><span class="small">#SessionID#</span></td>
	<td><span class="small">#PageStuff.PageTitle#</span></td>
	</tr>
	</cfoutput>
	
</cfif>

<tr>
<td colspan="5"><hr width="100%" size="1" color="Silver"></td>
</tr>

</table><br>

<cfoutput>

<table cellpadding="0" cellspacing="1" width="200">
	
<tr>
<!--- IF THE CURRENT DISPLAY COUNT IS GREATER THAN THE START ROW PLUE THE MAX ROWS THEN SHOW THE PREVIOUS BUTTON--->

<cfif #Startrow# GT #Maxrows#>
<FORM action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&logmode=results" method="post">
<td width="40">
		
<INPUT type="hidden" name="Maxrows" value="#Maxrows#">
<INPUT type="hidden" name="Startrow" value="#Evaluate(startrow - maxrows)#">
<INPUT type="hidden" name="GroupMode" value="#GroupMode#">
<INPUT type="hidden" name="SiteArea" value="#SiteArea#">
<INPUT type="hidden" name="Status" value="#Status#">
<INPUT type="hidden" name="LogPeriod" value="#LogPeriod#">



<cfif #GroupMode# EQ 'On'>
<INPUT type="submit" value="< Prev. 10 Results" class="whitefield">
<cfelse>
<INPUT type="submit" value="< Prev. 100 Results" class="whitefield">
</cfif>

</td>
</FORM>
<td width="10">&nbsp;</td>
</cfif>

<!--- IF THE RECORD COUNT IS GREATER THAN THE MAX ROWS THEN SHOW THE NEXT BUTTON--->

<cfif #endrow# LT #numberofrecords#>
<FORM action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&logmode=results" method="post">
<td width="40">
<INPUT type="hidden" name="Maxrows" value="#Maxrows#">
<INPUT type="hidden" name="Startrow" value="#Evaluate(startrow + maxrows)#">
<INPUT type="hidden" name="GroupMode" value="#GroupMode#">
<INPUT type="hidden" name="SiteArea" value="#SiteArea#">
<INPUT type="hidden" name="Status" value="#Status#">
<INPUT type="hidden" name="LogPeriod" value="#LogPeriod#">


<cfif #GroupMode# EQ 'On'>
<INPUT type="submit" value="Next 10 Results >" class="whitefield">
<cfelse>
<INPUT type="submit" value="Next. 100 Results >" class="whitefield">
</cfif>
</td>
</FORM>
</CFIF>

</tr>	

</table>

</cfoutput>



