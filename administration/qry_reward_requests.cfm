<cfquery name="qry_reward_requests" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT RewardTransactions.*, Prize_Pool.description, Prize_Pool.pointsvalue, prize_Pool.quantity, Contacts.FirstName, Contacts.LastName
FROM RewardTransactions, Prize_Pool, Contacts
WHERE RewardTransactions.RewardID=Prize_Pool.PrizePoolID
AND RewardTransactions.ContactID=Contacts.ContactID
<cfif session.Requests_DisplayOnly NEQ 'ALL'>
	AND RewardTransactions.RewardTrans_Status LIKE '%#session.Requests_DisplayOnly#%'
</cfif>
ORDER BY #session.RequestSortBy# #session.RequestSortMode#
</cfquery>