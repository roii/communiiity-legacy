<cfoutput>

<!--- GET REFERRAL PRIZES THAT HAVE NOT BEEN DRAWN --->
<cfquery name="AllReferralPrizeDraws" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT * 
FROM InviteFriendPrizes
WHERE Type LIKE '%Week%'
AND Status=0
</cfquery>

<!--- LOOP EACH DRAW --->	
<cfloop query="AllReferralPrizeDraws">
	
	<cfset this_DrawID = AllReferralPrizeDraws.DrawID>
	<cfset this_start = AllReferralPrizeDraws.start_date>
	<cfset this_end = AllReferralPrizeDraws.draw_date>
	
	<!--- GET ALL MEMBERS WHO HAVE JOINED DURING THE DRAW TIME PERIOD WITH A REFERRAL CODE --->	
	<cfquery name="AllReferrals" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT Count(ContactID) AS TotalInvites, ReferralCode
	FROM Contacts
	WHERE ContactStatus LIKE '%Active%'
	AND DateJoined BETWEEN ('#DateFormat(this_Start, 'mm/dd/yyyy')# 00:00:00')
	AND ('#DateFormat(this_end, 'mm/dd/yyyy')# 23:59:59')
	AND ReferralCode <> ''
	GROUP BY ReferralCode
	ORDER BY TotalInvites DESC
	</cfquery>
	
		
	<!--- INSERT THE WINNER DETAILS --->	
	<cfif AllReferrals.RecordCount>
		
		<cfloop query="AllReferrals">
		
		<!--- CHECK IF VALID CONTACT --->			
		<cfquery name="ValidContact" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT ContactID
		FROM Contacts
		WHERE ScreenName='#TRIM(AllReferrals.ReferralCode)#'
		</cfquery>
		
		<cfif ValidContact.RecordCount>
		
			<!--- SET THE WINNING TOTAL --->
			<cfset winning_total = AllReferrals.TotalInvites>
			
			<!--- GET ALL REFERERS WITH WINNING TOTAL --->
			<cfquery name="AllWinners" dbtype="query">
			SELECT ReferralCode
			FROM AllReferrals
			WHERE TotalInvites=#winning_total#
			</cfquery>
			
			<!--- IF MORE THAN ONE WINNER --->
			<cfif AllWinners.RecordCount GT 1>
				
				<!--- CREATE THE MULTIPLE WINNERS INSERT VALUE --->
				<cfset this_winners = ''>
				
				<cfloop query="AllWinners">
					
					<cfset this_referralcode = TRIM(AllWinners.ReferralCode)>
					
					<!--- CHECK IF VALID CONTACT --->			
					<cfquery name="MultiValidContact" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
					SELECT ContactID
					FROM Contacts
					WHERE ScreenName='#this_referralcode#'
					</cfquery>
					
					<cfif MultiValidContact.RecordCount>
						<cfset this_winners = this_winners & "#MultiValidContact.ContactID#,">
					</cfif>
				
				</cfloop>
				
				<!--- SPLIT THE POINTS PER WINNER --->
				<cfset pointsperwinner = Round(AllReferralPrizeDraws.PointsValue / ListLen(this_winners, ","))>
				
				<!--- INSERT THE MULTIPLE WINNERS --->
				<cfquery name="UpdateWinner" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
				UPDATE InviteFriendPrizes
				SET Status=1,
				Winners='#this_winners#',
				PointsPerWinner=#pointsperwinner#
				WHERE DrawID=#this_DrawID#
				</cfquery>
				
				<cfbreak>				
			
			<cfelse>
			
				<!--- INSERT THE ONE WINNER --->
				<cfquery name="UpdateWinner" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
				UPDATE InviteFriendPrizes
				SET Status=1,
				Winners='#ValidContact.ContactID#',
				PointsPerWinner=#AllReferralPrizeDraws.PointsValue#
				WHERE DrawID=#this_DrawID#
				</cfquery>
				
				<cfbreak>
			
			</cfif>
			
		</cfif>
		
		</cfloop>
		
	<cfelse>
	
		<cfquery name="UpdateWinner" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE InviteFriendPrizes
		SET Status=1,
		Winners='0'
		WHERE DrawID=#this_DrawID#
		</cfquery>
	
	</cfif>

</cfloop>

<!--- CREATE NEW DRAW ID --->
<cfquery name="LastID" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r" maxrows="1">
SELECT DrawID
FROM InviteFriendPrizes
ORDER BY DrawID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.DrawID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>

<!--- INSERT NEW DAILY DRAW --->
<cfquery name="AddDraw" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
INSERT INTO InviteFriendPrizes(DrawID, type, start_date, draw_date, status, winners, pointsvalue, showWinner, PointsPaid)
VALUES(#newid#, 'Week', #CreateODBCDate(localdatetime)#, #CreateODBCDate(DateAdd('d', 6, localdatetime))#, 0, '', 5000, 0, 0)
 </cfquery>
	 
</cfoutput>

<cfquery name="AllReferralPrizeDraws" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r" maxrows="1">
SELECT * 
FROM InviteFriendPrizes
WHERE Type LIKE '%Week%'
AND Status=1
ORDER BY DrawID DESC
</cfquery>

<cfmail server="#application.emailserver#" to="alan@my3p.com" cc="roy@my3p.com" from="website@my3p.com" subject="Invite Friend- Week Draw successful" type="html">
RESULTS<br><br>
<cfdump var="#AllReferralPrizeDraws#">
</cfmail>