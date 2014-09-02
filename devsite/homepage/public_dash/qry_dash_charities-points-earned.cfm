<cfquery name="topcharitiesPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT top 3 sum(Contact_transactions.Transaction_amount) as totalpoints, organisations.organisation_name
FROM Contact_transactions, Contacts, organisations
WHERE Contact_transactions.Transaction_Account = 'Points'
AND Contact_transactions.Transaction_Type = 'Credit'
AND Contact_transactions.ContactID=Contacts.ContactID
AND contacts.charity <> 0
AND contacts.charity=organisations.organisationID
group by organisations.organisation_name
ORDER BY totalpoints desc
</cfquery>





