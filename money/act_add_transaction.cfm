<!--- INSERT THE TRANSACTION --->
<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, RoyaltyPaid, PointsType)
VALUES(#this_contactID#, #CreateODBCDate(this_Transaction_Date)#, '#this_Transaction_Type#', #this_Transaction_Amount#, '#this_Transaction_Description#', '#this_Transaction_Account#', 0, 0, 'Earned')
</cfquery>
