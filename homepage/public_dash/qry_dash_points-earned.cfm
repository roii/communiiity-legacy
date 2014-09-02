<cfquery name="toppointsearned" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT top 3 sum(Contact_transactions.Transaction_amount) AS totalpoints, Contacts.FirstName, Contacts.ScreenName
FROM Contact_transactions, Contacts
WHERE Contact_transactions.Transaction_Account LIKE '%Points%'
AND Contact_transactions.Transaction_Type LIKE '%Credit%'
AND Contact_transactions.ContactID=Contacts.ContactID
GROUP BY Contacts.FirstName, Contacts.ScreenName
ORDER BY totalpoints DESC
</cfquery>
