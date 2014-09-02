<cfquery name="UniqueMembers" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT ContactID
FROM contact_transactions
WHERE Related_Description LIKE '%Survey%'
AND Related_Identifier = 3
GROUP BY ContactID
ORDER BY ContactID
</cfquery>

<cfoutput>#valueList(UniqueMembers.ContactID)#</cfoutput>