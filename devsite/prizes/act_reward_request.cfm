<!--- GET REWARD DETAILS --->
<cfquery name="rewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE PrizePoolID=#rewardID#
</cfquery>


<!--- GET USER POINTS BALANCE --->
<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contact_transactions.*
FROM Contact_transactions
WHERE Contact_transactions.Transaction_Account = 'Points'
AND Contact_transactions.ContactID=#session.UserID#
</cfquery>

<cfset thistotal=0>

<cfloop query="TransactionHistory">

<cfif IsNumeric("#TransactionHistory.Transaction_amount#")>
	<cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>
		<cfset thistotal=(thisTotal - TransactionHistory.Transaction_amount)>
	<cfelse>
		<cfset thistotal=(thisTotal + TransactionHistory.Transaction_amount)>
	</cfif>
</cfif>

</cfloop>


<!--- CHECK USER HAS ENOUGH POINTS FOR REWARD --->

<cfif thistotal LT rewardDetails.pointsvalue>
	
	<script>
	alert("You don;t have enough points to request this reward!");
	histroy.back(-1);
	</script>
	<cfabort>

</cfif>


<cfif form.DistrictID NEQ 0>
	<cfquery name="GetDistrict" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT District
	FROM District
	WHERE DistrictID=#form.DistrictID#
	</cfquery>
	<cfset insert_city = GetDistrict.District>
<cfelse>
	<cfset insert_city = form.city>
</cfif>

<!--- UPDATE SHIPPING DETAILS --->
<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET Address1='#form.address1#',
Address2='#form.address2#',
Address3='#form.address3#',
City='#TRIM(insert_city)#',
CountryID=#form.countryID#,
RegionID=#form.regionid#,
DistrictID=#form.districtid#,
SuburbID=#form.suburbid#
WHERE ContactID=#session.userID#
</cfquery>



<!--- INSERT REWARD TRANSACTION --->
<cftransaction action="BEGIN">

	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT RewardTransID
	FROM RewardTransactions
	ORDER BY RewardTransID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.RewardTransID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
		
	<cfquery name="AddRewardtrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO RewardTransactions(RewardTransID,
	RewardTrans_Date,
	RewardTrans_Status,
	RewardID,
	ContactID)
	VALUES(#newid#, 
	#CreateODBCDateTime(localDateTime)#, 
	'Pending', 
	#form.RewardID#, 
	#session.UserID#)
	</cfquery>

	<cftransaction action="commit" />
</cftransaction>



<!--- INSERT CONTACT DEBIT TRANSACTION --->
<cftransaction action="BEGIN">

	<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_description, Transaction_SponsorID, RoyaltyPaid)
	VALUES(#session.userID#, #CreateODBCDateTime(localDateTime)#, 'Debit', #rewardDetails.pointsvalue#, 'Purchased Reward - #TRIM(RewardDetails.Description)#', 'Points', #newid#, 'RewardRequest', 0, 0)
	</cfquery>

	<cftransaction action="commit" />
	
</cftransaction>


<!--- EMAIL MEMBER --->


<!--- EMAIL ADMIN --->
<cfmail server="#application.emailserver#" to="roy@my3p.com" from="rewards@my3p.com" subject="REWARD REQUEST - #TRIM(RewardDetails.Description)#">
A NEW REWARD REQUEST HAS BEEN SUBMITTED#chr(10)#
#TRIM(RewardDetails.Description)#
</cfmail>


<!--- RETURN TO REWARDS PAGE --->
<cfoutput>

<script>
alert("Your reward request has been processed.\nWe will either ship your reward or contact you\nwithin the next 48hrs.");
self.location="#request.webroot#/index.cfm?fuseaction=prizes&fusesubaction=docs&documentID=62";
</script>

</cfoutput>

