<cfquery name="qry_invitefriend_draws" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM InviteFriendPrizes 
WHERE draw_date <= #localDateTime#
OR status=1
ORDER BY draw_date DESC
</cfquery>


<cfquery name="qry_active_invitefriend_draws" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM InviteFriendPrizes 
WHERE status=0
ORDER BY draw_date DESC
</cfquery>