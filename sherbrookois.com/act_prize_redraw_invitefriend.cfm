<cfoutput>

	<!--- GET REFERRAL PRIZES THAT HAVE NOT BEEN DRAWN --->

	<cfquery name="AllReferralPrizeDraws" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM prize_pool
	WHERE InviteFriend=1
	AND Status=1
	AND Deleted=0
	</cfquery>
	
	
<!--- LOOP EACH DRAW --->	

	<cfloop query="AllReferralPrizeDraws">
	
		
		<cfset this_PrizePoolID = AllReferralPrizeDraws.PrizePoolID>
		<cfset this_Country = INT(AllReferralPrizeDraws.Country)>
		<cfset this_start = AllReferralPrizeDraws.start_date>
		<cfset this_end = AllReferralPrizeDraws.draw_date>	
		
		
<!--- GET ALL MEMBERS WHO HAVE SUCCESSFULLY INVITED FRIENDS DURING PRIZE PERIOD --->
		
		<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Count(ContactID) AS TotalInvites, ReferralCode
		FROM Contacts
		WHERE ContactStatus LIKE '%Active%'
		AND DateJoined >= #CreateODBCDate(this_start)#
		AND DateJoined <= #CreateODBCDate(this_end)#
		AND ReferralCode <> ''
		GROUP BY ReferralCode
		ORDER BY TotalInvites DESC
		</cfquery>	
		
		
		<cfdump var="#PrizeEntries#">
		
<!--- INSERT THE WINNER DETAILS --->	
		<cfif PrizeEntries.RecordCount>
			
			<cfloop query="PrizeEntries">
			<!--- CHECK IF VALID CONTACT --->
			
			<cfquery name="ValidContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Contacts
			WHERE ScreenName='#TRIM(PrizeEntries.ReferralCode)#'
			</cfquery>
			
			<cfif ValidContact.RecordCount>
			
				<cfquery name="UpdateWinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE prize_pool
				SET Status=1,
				Winner=#ValidContact.ContactID#,
				PointsPaid=0
				WHERE PrizePoolID=#this_PrizePoolID#
				</cfquery>
				
				<cfbreak>
						
			</cfif>
			
			</cfloop>
			
		<cfelse>
		
			<cfquery name="UpdateWinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE prize_pool
			SET Status=1,
			Winner=0			
			WHERE PrizePoolID=#this_PrizePoolID#
			</cfquery>
		
		</cfif>
	
	
	</cfloop>

	 
</cfoutput>