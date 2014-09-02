<cfoutput>

<cfparam name="LogAdmin" default="ALL">
<cfparam name="LogPeriod" default="1">

<cfset datestring = DateAdd('D',  -#LogPeriod#,  localDateTime)>


<cfquery name="AdminLog" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM AdminLog
WHERE LogDate > #datestring#

<cfif LogAdmin NEQ 'ALL'>
AND Administrator=#LogAdmin#
</cfif>

ORDER BY LogID DESC
</cfquery>



</cfoutput>