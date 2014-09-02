<cfoutput>


<cfparam name="LogPeriod" default="1">

<cfif #LogPeriod# GT 0>
	<cfset datestring = DateAdd('M',  -#LogPeriod#,  localDateTime)>
<cfelse>
	<cfset datestring = DateAdd('D',  -7,  localDateTime)>
</cfif>


<cfquery name="AdminLog" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM AdminLog
WHERE LogDate > #datestring#
ORDER BY LogID DESC
</cfquery>



</cfoutput>