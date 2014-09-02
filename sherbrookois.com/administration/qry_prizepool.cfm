<cfquery name="AllPrize" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE prizedraw=1
AND draw_date > #localDateTime#
AND deleted=0
AND InviteFriend=0
ORDER BY displayOrder
</cfquery>

<cfquery name="ArchivedPrizes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE prizedraw=1
AND draw_date <= #localDateTime#
AND deleted=0
AND InviteFriend=0
ORDER BY draw_date desc, displayOrder
</cfquery>