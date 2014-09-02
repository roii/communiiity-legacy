<cfquery name="topschoolearners" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT top 3 sum(Contact_transactions.Transaction_amount) as totalpoints, schools.schoolname
FROM Contact_transactions, Contacts, schools
WHERE Contact_transactions.Transaction_Account = 'Points'
AND Contact_transactions.Transaction_Type = 'Credit'
AND Contact_transactions.ContactID=Contacts.ContactID
AND contacts.schoolid=schools.schoolid
group by schools.schoolname
ORDER BY totalpoints desc
</cfquery>





