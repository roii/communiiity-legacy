<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Activity
WHERE ActivityID=#this_activity#
</cfquery>


<cfif this_activity EQ 13>

    <cfif IsDefined("this_VotePoints")>
        <cfset this_points = this_VotePoints>
    <cfelse>
        <cfset this_points = RewardDetails.points>
    </cfif>
    
    <cfif IsDefined("this_VotePrizes")>
        <cfset this_prizes = this_VotePrizes>
    <cfelse>
        <cfset this_prizes = RewardDetails.Entries>
    </cfif>
    
 <cfelseif this_activity EQ 14>   
    
    <cfif IsDefined("this_FeedbackPoints")>
        <cfset this_points = this_FeedbackPoints>
    <cfelse>
        <cfset this_points = RewardDetails.points>
    </cfif>
    
    <cfif IsDefined("this_FeedbackPrizes")>
        <cfset this_prizes = this_FeedbackPrizes>
    <cfelse>
        <cfset this_prizes = RewardDetails.Entries>
    </cfif>
    
<cfelseif this_activity EQ 15 OR this_activity EQ 16 OR this_activity EQ 17 OR this_activity EQ 18>

    <cfif IsDefined("this_IdeaStagePoints")>
        <cfset this_points = this_IdeaStagePoints>
    <cfelse>
        <cfset this_points = RewardDetails.points>
    </cfif>
    
    <cfif IsDefined("this_IdeaStagePrizes")>
        <cfset this_prizes = this_IdeaStagePrizes>
    <cfelse>
        <cfset this_prizes = RewardDetails.Entries>
    </cfif>

<cfelse>

    <cfset this_points = RewardDetails.points>
    <cfset this_prizes = RewardDetails.Entries>
    
</cfif>

<cfset this_description = TRIM(rewarddetails.Name)>

<cfif IsDefined("ExtraDescription")>
	<cfset this_description = this_description & "<i>#ExtraDescription#</i>">
</cfif>

<cfif this_activity EQ 19 OR this_activity EQ 22>

	<cfquery name="CheckReward" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT TransactionID
	FROM contact_transactions
	WHERE Transaction_Description LIKE '%#this_description#%'
	AND ContactID=#this_contactID#
	</cfquery>
	
<cfelseif this_activity EQ 7>

	<cfquery name="CheckReward" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT TransactionID
	FROM contact_transactions
	WHERE Related_Description LIKE '%#this_relatedDescription#%'
	AND Related_Identifier=#this_relatedID#
	</cfquery>
	
<cfelseif this_activity EQ 4>

	<cfquery name="CheckReward" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT TransactionID
	FROM contact_transactions
	WHERE Related_Description LIKE '%#this_relatedDescription#%'
	AND Related_Identifier=#this_relatedID#
	AND Transaction_Date < #DateAdd('h', 24, localdatetime)#
	</cfquery>

</cfif>

<!--- IF NEW MEMBER REWARD CHECK THEY HAVEN'T GOT IT ALREADY --->
<cfif (this_activity EQ 19 OR this_activity EQ 22 OR this_activity EQ 7 OR this_activity EQ 4) AND CheckReward.RecordCount>
<cfelse>
    
	<cfif this_prizes GT 0>	
	
		<cfloop from="1" to="#this_prizes#" index="loopcount">
			
			<cftransaction action="BEGIN" isolation="read_committed">
			
			<cfquery name="NewEntry" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO Prize_Entry(ContactID, EntryDate)
			VALUES(#this_contactID#, #CreateODBCDateTime(localDateTime)#)
			</cfquery>
			
			<cftransaction action="COMMIT"/>
			</cftransaction>
			
		</cfloop>
		
	</cfif>
	
	
	<cfif this_points GT 0>
			
		<!--- IF A SPONSORID PASSED IN --->
		<cfif IsDefined("this_sponsorID") AND IsNumeric("#this_sponsorID#")>
			
			<cftransaction action="begin" isolation="read_committed">
			
				<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
				VALUES(#this_contactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #this_points#, '#TRIM(this_description)#', 'Points', #this_sponsorID#, #this_relatedID#, '#this_relatedDescription#', 0, 'Earned')
				</cfquery>
			
			<cftransaction action="COMMIT"/>		
			</cftransaction>
			
		<cfelse>
		
			<!--- LOOK FOR SPONSOR --->
			<cfquery name="SponsorCheck" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SponsorPointsID, SponsorID, PointsRemaining
			FROM SponsorPoints
			WHERE PointsRemaining > 0
			AND (Activities LIKE '#this_activity#' OR Activities LIKE '#this_activity#,%' OR Activities LIKE '%,#this_activity#' OR Activities LIKE '%,#this_activity#,%')
			ORDER BY DatePurchased
			</cfquery>
			
			<cfif SponsorCheck.RecordCount>
			
				<!--- DOES THE SPONSOR HAVE ENOUGH POINTS LEFT FOR THIS ACTION --->
				<cfif SponsorCheck.PointsRemaining GTE this_points>
					
					<cftransaction action="begin" isolation="read_committed">
						<!--- INSERT THE TRANSACTION --->						
						<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
						INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
						VALUES(#this_contactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #this_points#, '#TRIM(this_description)#', 'Points', #SponsorCheck.SponsorID#, #this_relatedID#, '#this_relatedDescription#', 0, 'Earned')
						</cfquery>					
					<cftransaction action="COMMIT"/>
					</cftransaction>
					
					<!--- REMOVE POINTS FROM SPONSORS TABLE --->
					<cfquery name="UpdateSponsorPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE SponsorPoints
					SET PointsRemaining=#int(SponsorCheck.PointsRemaining - this_points)#
					WHERE SponsorPointsID=#SponsorCheck.SponsorPointsID#
					</cfquery>					
					
				<cfelse>
				
					<cftransaction action="begin" isolation="read_committed">						
						<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
						INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
						VALUES(#this_contactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #this_points#, '#TRIM(this_description)#', 'Points', #SponsorCheck.SponsorID#, #this_relatedID#, '#this_relatedDescription#', 0, 'Earned')
						</cfquery>				
					<cftransaction action="COMMIT"/>
					</cftransaction>					
					
					<!--- REMOVE POINTS FROM SPONSORS TABLE --->
					<cfquery name="UpdateSponsorPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE SponsorPoints
					SET PointsRemaining=0
					WHERE SponsorPointsID=#SponsorCheck.SponsorPointsID#
					</cfquery>					
					
				</cfif>				
				
			<cfelse>		
				
				<!--- LOOK FOR DEFAULT SPONSOR --->
				<cfquery name="DefaultCheck" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
				SELECT OrganisationID
				FROM Organisations
				WHERE DefaultSponsor=1
				</cfquery>
								
				<cftransaction action="begin" isolation="read_committed">					
					<!--- INSERT THE TRANSACTION --->
					<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
					INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
					VALUES(#this_contactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #this_points#, '#TRIM(this_description)#', 'Points', #DefaultCheck.OrganisationID#, #this_relatedID#, '#this_relatedDescription#', 0, 'Earned')
					</cfquery>				
				<cftransaction action="COMMIT"/>
				</cftransaction>
				
			</cfif>
	
		</cfif>
	
	</cfif>	
	
	<cfif rewarddetails.Cash GT 0>
    	
		<cftransaction action="begin" isolation="read_committed">			
		<!--- INSERT THE TRANSACTION --->			
			<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
			VALUES(#this_contactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #rewarddetails.Cash#, '#TRIM(this_description)#', 'Personal', #this_relatedID#, '#this_relatedDescription#', 0, 'Earned')
			</cfquery>				
		<cftransaction action="COMMIT"/>
		</cftransaction>
	
	</cfif>
		
	<cfif rewarddetails.Education GT 0>
	
		<cftransaction action="begin" isolation="read_committed">		
			
			<!--- INSERT THE TRANSACTION --->				
			<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
			VALUES(#this_contactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #rewarddetails.Education#, '#TRIM(this_description)#', 'Education', #this_relatedID#, '#this_relatedDescription#', 0, 'Earned')
			</cfquery>
		
		<cftransaction action="COMMIT"/>
		</cftransaction>
	
	</cfif>
	
</cfif>