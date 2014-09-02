<cfquery name="DeleteRoyalties" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
DELETE
FROM Contact_Transactions
WHERE Related_Description LIKE '%Invitation Royalties%'
</cfquery>

<cfquery name="DeleteRoyalties" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
UPDATE Contact_Transactions
SET RoyaltyPaid=0
</cfquery>

<cfquery name="DeleteRoyalties" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
UPDATE Invitations
SET Royalties_Earned=0
</cfquery>