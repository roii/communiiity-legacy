<cfquery name="toprewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT top 3 count(RewardTransactions.RewardID) AS totalPurchased, Prize_Pool.description
FROM RewardTransactions, Prize_Pool
WHERE RewardTransactions.RewardID=Prize_Pool.PrizePoolID
GROUP BY Prize_Pool.description
ORDER BY totalPurchased desc
</cfquery>