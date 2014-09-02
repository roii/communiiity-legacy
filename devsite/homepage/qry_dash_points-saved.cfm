<!--- this is a bit tricky, I think we will leave it the same as points earned for now, since there are no points debit transactions at the moment---->

<cfquery name="toppointssaved" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
	SELECT top 3 sum(Contact_transactions.Transaction_amount) as totalpointssaved, Contacts.FirstName, Contacts.LastName
	FROM Contact_transactions, Contacts
	WHERE Contact_transactions.Transaction_Account = 'Points'
	AND Contact_transactions.ContactID=Contacts.ContactID
	AND Transaction_Type = 'Credit'
	group by Contacts.FirstName, Contacts.LastName
	ORDER BY totalpointssaved desc
</cfquery>
<!---
<cfquery name="toppointsspent" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
	SELECT top 10 sum(Contact_transactions.Transaction_amount) as totalpointsspent, Contacts.FirstName, Contacts.LastName
	FROM Contact_transactions, Contacts
	WHERE Contact_transactions.Transaction_Account = 'Points'
	AND Contact_transactions.ContactID=Contacts.ContactID
	AND Transaction_Type = 'Debit'
	group by Contacts.FirstName, Contacts.LastName
	ORDER BY totalpoints desc
</cfquery>

<cfif toppointsspent.recordcount>
	<cfquery dbtype="query" name="toppointssaved" maxrows="3">

	</cfquery>
</cfif>
--->


