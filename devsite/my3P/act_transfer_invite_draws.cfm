<cfquery name="AllReferralPrizeDraws" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT * 
FROM prize_pool
WHERE InviteFriend=1
AND Deleted=0
ORDER BY draw_date
</cfquery>

<cfloop query="AllReferralPrizeDraws">

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

	<!--- INSERT --->	
	<cfquery name="AddDraw" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	INSERT INTO InviteFriendPrizes(DrawID, type, start_date, draw_date, Status, winners, pointsvalue, ShowWinner, PointsPaid)
	VALUES(#newid#, 'Day', #CreateODBCDate(AllReferralPrizeDraws.start_date)#, #CreateODBCDate(AllReferralPrizeDraws.draw_date)#, #AllReferralPrizeDraws.status#, '#AllReferralPrizeDraws.Winner#', 2000, #AllReferralPrizeDraws.ShowWinner#, #AllReferralPrizeDraws.PointsPaid#)
	 </cfquery>


</cfloop>

<cfquery name="AllNew" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT * 
FROM InviteFriendPrizes
ORDER BY draw_date
</cfquery>

<cfoutput>
<cfdump var="#AllReferralPrizeDraws#"><br>

<cfdump var="#AllNew#">
</cfoutput>