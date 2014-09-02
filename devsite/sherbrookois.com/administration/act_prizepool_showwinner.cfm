<cfquery name="ShowWinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE prize_pool
SET ShowWinner=1
WHERE PrizePoolID=#PrizePoolID#
</cfquery>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes">