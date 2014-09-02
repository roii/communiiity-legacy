<cfoutput><!--- GET SCHEDULE --->
<cfquery name="GetPaymentSchedule" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT InviteRoyalties_LastPaid
FROM ScheduledTask_log
</cfquery>


<!--- SET DATE RANGE --->
<cfif IsDate("#GetPaymentSchedule.InviteRoyalties_LastPaid#")>
	
	<cfset StartDate = DateAdd('d', 1, GetPaymentSchedule.InviteRoyalties_LastPaid)>
	<cfset EndDate = DateAdd('m', 1, StartDate)>
	
<cfelse>
	
	<cfset StartDate = CreateDate(2006,  2,  1)>
	<cfset EndDate = CreateDate(2006,  3,  1)>
	
</cfif>


<!--- GET ALL SUCCESSFUL INVITES STILL EARNING ROYALTIES --->
<cfquery name="qry_all_invites" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT InvitationID, InvitationFrom, InvitationTo, Royalties_Earned
FROM Invitations
WHERE InvitationStatus LIKE '%Successful%'
AND Royalties_Earned < 3000
</cfquery>


<!--- LOOP INVITES --->
<cfloop query="qry_all_invites">
	
	<cfset this_InvitationID = qry_all_invites.InvitationID>
	<cfset this_InvitationFrom = qry_all_invites.InvitationFrom>
	<cfset this_InvitationTo = qry_all_invites.InvitationTo>
	<cfset this_Royalties_Earned = qry_all_invites.Royalties_Earned>
	
	<cfset royalties_owing = (3000 - this_Royalties_Earned)>
	
	<!--- GET ALL POINTS EARNED BY INVITEE DURING RANGE --->
	<cfquery name="qry_all_transactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT TransactionID, Transaction_Amount
	FROM contact_transactions
	WHERE RoyaltyPaid=0
	AND ContactID=#this_InvitationTo#
	AND Transaction_Type LIKE '%Credit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	
	<cfset total_amount = 0>
	
	<!--- LOOP TRANSACTIONS --->
	<cfloop query="qry_all_transactions">
		
		<cfset this_transactionID = qry_all_transactions.TransactionID>
		<cfset this_Amount = qry_all_transactions.Transaction_Amount>
		
		<!--- ADD AMOUNTS --->
		<cfset total_amount = (total_amount + this_Amount)>
		
		<cfquery name="Update_Transaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE contact_transactions
		SET RoyaltyPaid=1
		WHERE TransactionID=#this_transactionID#
		</cfquery>
		
		
	</cfloop>	
		
	
	<!--- CALCULATE ONE TENTH --->
	<cfif IsNumeric("#total_amount#") AND total_amount NEQ 0>
		<cfset total_amount_percentage = Round(total_amount \ 10)>	
	<cfelse>
		<cfset total_amount_percentage = 0>
	</cfif>	
		
	<!--- CHECK IF THIS EXCEEDS AMOUNT OF ROYALTY STILL OWING --->
	<!--- IF OVER THE MOUNT OWING WORK OUT HOW MUCH TO PAY --->
	<cfif total_amount_percentage GT royalties_owing>
		<cfset amount_to_pay = royalties_owing>
	<cfelse>
		<cfset amount_to_pay = total_amount_percentage>
	</cfif>	
	
	
	<cfif amount_to_pay GT 0>
	
		<!--- REWARD REFERRER --->
		<cftransaction action="BEGIN">	
		
		
			<!--- GET INVITED MEMBERS DETAILS --->
			<cfquery name="InviteeDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT FirstName, LastName
			FROM Contacts
			WHERE ContactID=#this_InvitationTo#
			</cfquery>
			
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT TransactionID
			FROM contact_transactions
			ORDER BY TransactionID DESC
			</cfquery>
			
			<cfif lastid.recordcount>
				<cfset newid = (lastID.TransactionID + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<!--- INSERT THE TRANSACTION --->
				
				<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO contact_transactions(TransactionID, ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
				VALUES(#newID#, #this_InvitationFrom#, #CreateODBCDateTime(localDateTime)#, 'Credit', #amount_to_pay#, 'Invitation Royalties from <em>#InviteeDetails.FirstName# #InviteeDetails.LastName#</em>', 'Points', 10, #this_InvitationTo#, 'Invitation Royalties', 0, 'Earned')
				</cfquery>
		
			</cftransaction>
		
		
			<!--- UPDATE ROYALY NUMBER --->
			<cfquery name="UpdateRoyaltiesEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Invitations
			SET Royalties_Earned=#INT(this_Royalties_Earned+amount_to_pay)#
			WHERE InvitationID=#this_InvitationID#
			</cfquery>
		
		</cfif>
	
	</cfloop>
	
	
<!--- UPDATE THE SCHEDULE LOG --->
<cfquery name="updateSchedule" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE ScheduledTask_Log
SET InviteRoyalties_LastPaid=#createODBCDateTime(localdatetime)#
</cfquery>

</cfoutput>