<cfparam name="LogPeriod" default="1">

<cfset datestring = DateAdd('D',  -#LogPeriod#,  localDateTime)>



<cfquery name="LogResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SessionID, DateOfAccess, AccessLogID, MembershipID, AdministratorID, Fuseaction
FROM AccessLog
WHERE DateOfAccess > #datestring#

<cfif #SiteArea# NEQ 'All'>
AND Fuseaction='#SiteArea#'
</cfif>

<cfif #Status# EQ 'Members'>
AND MembershipID <> 0
<cfelseif #Status# EQ 'NonMembers'>
AND MembershipID IS NULL
</cfif>

<cfif #GroupMode# EQ 'On'>
GROUP BY SessionID, DateOfAccess, AccessLogID, MembershipID, AdministratorID, Fuseaction
ORDER BY SessionID, DateOfAccess DESC

<cfelse>
ORDER BY DateOfAccess DESC
</cfif>

</cfquery>