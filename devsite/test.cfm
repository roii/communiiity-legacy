<cfquery name="DeleteRoyalties" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM Contact_Transactions
WHERE Related_Description LIKE '%Invitation Royalties%'
</cfquery>

<cfquery name="DeleteRoyalties" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contact_Transactions
SET RoyaltyPaid=0
</cfquery>

<cfquery name="DeleteRoyalties" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Invitations
SET Royalties_Earned=0
</cfquery>