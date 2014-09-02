<cfquery name="UniqueMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contact_transactions
WHERE Related_Description LIKE '%Survey%'
AND Related_Identifier = 3
GROUP BY ContactID
ORDER BY ContactID
</cfquery>

<cfoutput>#valueList(UniqueMembers.ContactID)#</cfoutput>