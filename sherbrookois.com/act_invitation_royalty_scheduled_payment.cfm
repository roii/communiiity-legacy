<cfoutput>

<!--- GET ALL ACTIVE MEMBERS --->
<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactStatus LIKE '%Active%'
AND ReferralCode <> ''
ORDER BY ContactID
</cfquery>

<cfset GrandTotal = 0>

<cfloop query="AllMembers">

<cfset this_inviteeID = Allmembers.ContactID>
<cfset this_FirstName = AllMembers.FirstName>
<cfset this_LastName = AllMembers.LastName>
<cfset this_ReferralCode = Allmembers.ReferralCode>
<cfset this_emailaddress = AllMembers.EmailAddress>

<cfif TRIM(AllMembers.ReferralCode) NEQ ''>

	<!--- GET REFERRER DETAILS --->
	<cfquery name="ReferDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, FirstName, LastName
	FROM Contacts
	WHERE Screenname LIKE '%#TRIM(this_ReferralCode)#%'
	</cfquery>		
	
	<cfif ReferDetails.RecordCount>	
	
		<!--- CHECK FOR INVITE --->
		<cfquery name="checkinvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT InvitationID, InvitationFrom, InvitationTo, Royalties_Earned
		FROM Invitations
		WHERE InvitationStatus LIKE '%Successful%'
		AND InvitationTo = #this_inviteeID#
		AND InvitationFrom = #ReferDetails.ContactID#
		</cfquery>		
		
		<!--- IF INVITE EXISTS GET DATA --->
		<cfif checkinvite.RecordCount>
	
			<cfset this_InvitationID = checkinvite.InvitationID>
			<cfset this_InvitationFrom = ReferDetails.ContactID>
			<cfset this_InvitationTo = this_inviteeID>
			
			<cfif IsNumeric("#checkinvite.Royalties_Earned#")>
				<cfset this_Royalties_Earned = checkinvite.Royalties_Earned>
			<cfelse>
				<cfset this_Royalties_Earned = 0>
			</cfif>
			
			<cfset royalties_owing = (3000 - this_Royalties_Earned)>			
	
		<cfelse>
	
			<!--- CREATE INVITE --->
			<cfquery name="LastInviteID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT InvitationID
			FROM Invitations
			ORDER BY InvitationID DESC
			</cfquery>
			
			<cfif LastInviteID.recordcount>
				<cfset newInviteid = (LastInviteID.InvitationID + 1)>
			<cfelse>
				<cfset newInviteid = 1>
			</cfif>			
			
			<cfquery name="AddInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO Invitations(
			InvitationID,
			InvitationStatus,
			InvitationFrom,
			InvitationToEmail,
			InvitationTo,
			DateFirstSent,
			DateLastSent,
			Royalties_Earned)
			VALUES(
			#newInviteid#, 
			'Successful',
			#ReferDetails.ContactID#,
			'#TRIM(this_emailaddress)#',
			#this_inviteeID#,
			#CreateODBCDateTime(localDateTime)#,
			#CreateODBCDateTime(localDateTime)#,
			0
			)
			</cfquery>			
			
			<cfset this_InvitationID = newInviteid>
			<cfset this_InvitationFrom = ReferDetails.ContactID>
			<cfset this_InvitationTo = this_inviteeID>
			<cfset this_Royalties_Earned = 0>			
			<cfset royalties_owing = 3000>		
		
		</cfif>
		
		<!--- GET ALL POINTS EARNED BY INVITEE DURING RANGE --->
		<cfquery name="qry_all_transactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT TransactionID, Transaction_Amount
		FROM contact_transactions
		WHERE RoyaltyPaid=0
		AND ContactID=#this_InvitationTo#
		AND Transaction_Type LIKE '%Credit%'
		AND Transaction_Account LIKE '%Points%'
		AND PointsType LIKE 'Earned'
		</cfquery>		
		
		<cfset total_amount = 0>
		
		<!--- LOOP TRANSACTIONS --->
		<cfloop query="qry_all_transactions">
			
			<cfset this_transactionID = qry_all_transactions.TransactionID>

			<cfif IsNumeric("#qry_all_transactions.Transaction_Amount#")>
				<cfset this_Amount = qry_all_transactions.Transaction_Amount>
			<cfelse>
				<cfset this_Amount = 0>
			</cfif>			
			
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
		
		<cfif total_amount_percentage GT 0>
		
			<!--- CHECK IF THIS EXCEEDS AMOUNT OF ROYALTY STILL OWING --->
			<!--- IF OVER THE AMOUNT OWING WORK OUT HOW MUCH TO PAY --->
			<cfif total_amount_percentage GTE royalties_owing>
				<cfset amount_to_pay = royalties_owing>
			<cfelse>
				<cfset amount_to_pay = total_amount_percentage>
			</cfif>	
			
			<cfif amount_to_pay GT 0>
				
				<cfset GrandTotal = (GrandTotal + amount_to_pay)>
				
				<!--- INSERT THE TRANSACTION --->					
				<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
				VALUES(#this_InvitationFrom#, #CreateODBCDateTime(localDateTime)#, 'Credit', #amount_to_pay#, 'Invitation Royalties from <em>#this_FirstName# #this_LastName#</em>', 'Points', 10, #this_InvitationTo#, 'Invitation Royalties', 0, 'Earned')
				</cfquery>			
			
				<!--- UPDATE ROYALY NUMBER --->
				<cfquery name="UpdateRoyaltiesEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Invitations
				SET Royalties_Earned=#INT(this_Royalties_Earned + amount_to_pay)#
				WHERE InvitationID=#this_InvitationID#
				</cfquery>			
	
			</cfif>	
			
		</cfif>
	
	</cfif>
			
<!--- REFERRAL CODE BLANK --->
<cfelse>

	<!--- CHECK FOR VALID EMAIL --->	
	<cfif this_emailaddress NEQ ''>	
		
		<!--- CHECK FOR INVITE --->
		<cfquery name="checkinvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT InvitationID, InvitationFrom, InvitationTo, Royalties_Earned
		FROM Invitations
		WHERE InvitationStatus LIKE '%Successful%'
		AND InvitationToEmail LIKE '%#this_emailaddress#%'
		</cfquery>		
				
		<!--- IF INVITE EXISTS GET DATA --->
		<cfif checkinvite.RecordCount>		
		
			<cfset this_InvitationID = checkinvite.InvitationID>
			<cfset this_InvitationFrom = checkinvite.InvitationFrom>
			<cfset this_InvitationTo = this_inviteeID>
			
			<cfif IsNumeric("#checkinvite.Royalties_Earned#")>
				<cfset this_Royalties_Earned = checkinvite.Royalties_Earned>
			<cfelse>
				<cfset this_Royalties_Earned = 0>
			</cfif>
			
			<cfset royalties_owing = (3000 - this_Royalties_Earned)>
			
			<!--- GET ALL POINTS EARNED BY INVITEE DURING RANGE --->
			<cfquery name="qry_all_transactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT TransactionID, Transaction_Amount
			FROM contact_transactions
			WHERE RoyaltyPaid=0
			AND ContactID=#this_inviteeID#
			AND Transaction_Type LIKE '%Credit%'
			AND Transaction_Account LIKE '%Points%'
			AND PointsType LIKE 'Earned'
			</cfquery>			
			
			<cfset total_amount = 0>
			
			<!--- LOOP TRANSACTIONS --->
			<cfloop query="qry_all_transactions">
				
				<cfset this_transactionID = qry_all_transactions.TransactionID>
				
				<cfif IsNumeric("#qry_all_transactions.Transaction_Amount#")>
					<cfset this_Amount = qry_all_transactions.Transaction_Amount>
				<cfelse>
					<cfset this_Amount = 0>
				</cfif>
				
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
			<!--- IF OVER THE AMOUNT OWING WORK OUT HOW MUCH TO PAY --->
			<cfif total_amount_percentage GTE royalties_owing>
				<cfset amount_to_pay = royalties_owing>
			<cfelse>
				<cfset amount_to_pay = total_amount_percentage>
			</cfif>			
			
			<cfif amount_to_pay GT 0>
				
				<cfset GrandTotal = (GrandTotal + amount_to_pay)>
				
				<!--- REWARD REFERRER --->
				<cftransaction action="BEGIN">				
					
					<!--- INSERT THE TRANSACTION --->						
					<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
					INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
					VALUES(#this_InvitationFrom#, #CreateODBCDateTime(localDateTime)#, 'Credit', #amount_to_pay#, 'Invitation Royalties from <em>#this_FirstName# #this_LastName#</em>', 'Points', 10, #this_InvitationTo#, 'Invitation Royalties', 0, 'Earned')
					</cfquery>
				
				<cftransaction action="commit" />
				</cftransaction>				
				
				<!--- UPDATE ROYALY NUMBER --->
				<cfquery name="UpdateRoyaltiesEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Invitations
				SET Royalties_Earned=#INT(this_Royalties_Earned + amount_to_pay)#
				WHERE InvitationID=#this_InvitationID#
				</cfquery>				
			
			</cfif>		
		
		</cfif>		
	
	</cfif>	
	
</cfif>	
	
</cfloop>


<!--- UPDATE THE SCHEDULE LOG --->
<cfquery name="updateSchedule" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE ScheduledTask_Log
SET InviteRoyalties_LastPaid=#createODBCDateTime(localdatetime)#
</cfquery>

</cfoutput>



<cfmail server="#application.emailserver#" to="alan@my3p.com" cc="roy@my3p.com" subject="Weekly Royalty Referral Payment" from="webserver@my3p.com">
The weekly referral royalty payment schedule has run successfully.#Chr(10)#
Total Points Paid: #GrandTotal#
</cfmail>