<cfoutput>

	<!--- GET REFERRAL PRIZES THAT HAVE NOT BEEN DRAWN --->
	<cfquery name="AllReferralPrizeDraws" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM InviteFriendPrizes
	WHERE type LIKE 'Week'
	AND Status=0
	</cfquery>	
	
	<!--- LOOP EACH DRAW --->
	<cfloop query="AllReferralPrizeDraws">
		
		<cfset this_DrawID = AllReferralPrizeDraws.DrawID>
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
				Winner=#ValidContact.ContactID#
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



	

<!--- CREATE NEW PRIZE ID --->

	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT PrizePoolID
	FROM Prize_pool
	ORDER BY PrizePoolID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.PrizePoolID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT NEW DAILY PRIZE --->		
	
	<cfquery name="Addprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Prize_pool(PrizePoolID, Name, Country, start_date, draw_date, pointsvalue, PrizeDraw, Reward, DisplayOrder, InviteFriend, Deleted, PromoteOnSide, Daily500, ShowWinner, Image, Status)
	VALUES(#newid#, 'Daily Invite-a-Friend Prize', 0, #CreateODBCDate(localdatetime)#, #CreateODBCDate(DateAdd('d', 1, localdatetime))#, 2000, 1, 0, 0, 1, 0, 0, 0, 0, 'thumb_pre-pay-cards.jpg', 0)
	 </cfquery>
	 
	 
</cfoutput>