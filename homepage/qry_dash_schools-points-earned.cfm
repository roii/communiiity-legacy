<cfquery name="topschoolearners" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
		SELECT top 3 sum(Contact_transactions.Transaction_amount) as totalpoints, schools.schoolname
		FROM Contact_transactions, Contacts, schools
		WHERE Contact_transactions.Transaction_Account = 'Points'
		AND Contact_transactions.ContactID=Contacts.ContactID
		AND contacts.schoolid=schools.schoolid
		AND Transaction_Type = 'Credit'
		AND contacts.contacttype = 'kid'
		group by schools.schoolname
		ORDER BY totalpoints desc
</cfquery>





