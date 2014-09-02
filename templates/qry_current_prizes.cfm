<cfparam name="attributes.prizepoolid" default="">

<cfquery name="prizeQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize 
WHERE prize.status = 1
AND getdate() >= prize.start_date
AND getdate() <=prize.draw_date
AND prize.prizepoolid = #attributes.prizepoolid#
</cfquery>


