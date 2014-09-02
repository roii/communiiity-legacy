<cfquery name="topcharitiesSupporters" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT top 3 count(Contacts.contactID) as totalsupporters, organisations.organisation_name
FROM Contacts, organisations
WHERE contacts.charity <> 0 
AND contacts.charity=organisations.organisationID
group by organisations.organisation_name
ORDER BY totalsupporters desc
</cfquery>





