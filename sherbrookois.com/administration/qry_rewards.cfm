<cfquery name="qry_rewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE reward=1
AND deleted=0
ORDER BY #session.RewardSortBy# #session.RewardSortmode#
</cfquery>