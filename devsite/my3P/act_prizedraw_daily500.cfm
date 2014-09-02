<!--- GET CURRENT DAILY PRIZE DRAW DETAILS --->
<cfquery name="PrizeDetails" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r" maxrows="1">
SELECT * 
FROM prize_pool
WHERE Daily500=1
AND Status=0

<cfif IsDefined("prizepoolid")>
AND PrizePoolID=#prizepoolid#
</cfif>

ORDER BY draw_date DESC
</cfquery>

<cfif PrizeDetails.RecordCount>	

	<cfset this_PrizePoolID = PrizeDetails.PrizePoolID>
	<cfset this_Country = INT(PrizeDetails.Country)>
	<cfset this_start = PrizeDetails.start_date>
	<cfset this_end = PrizeDetails.draw_date>	
	
<!--- GET ALL ENTRIES FROM APPLICABLE COUNTRIES --->

	<cfquery name="PrizeEntries" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT prize_entry.* 
	FROM contacts, prize_entry
	WHERE prize_entry.EntryDate >= #CreateODBCDateTime(this_start)#
	AND prize_entry.EntryDate <= #CreateODBCDateTime(this_end)#
	AND prize_entry.contactID=contacts.contactID
	
	<cfif this_Country NEQ 0>
		AND Contacts.CountryID=#this_Country#
	</cfif>
	
	</cfquery>

	
<!--- <cfoutput>
#CreateODBCDateTime(this_start)# - #CreateODBCDateTime(this_end)#<br><br>
<cfdump var="#PrizeEntries#">
</cfoutput> --->

<!--- RANDOMLY SELECT A WINNER --->
	<cfset rangeEnd = PrizeEntries.recordcount>
	<cfset selected_winner = RandRange(1,  rangeEnd)>
	

<!--- INSERT THE WINNER DETAILS --->
	<cfoutput query="PrizeEntries" startrow="#selected_winner#" maxrows="1">
	
		<cfset WinnerStuff = "Winner Entry ID:#PrizeEntries.Prize_EntryID#<br>Winner ContactID: #PrizeEntries.contactID#">
	
		<cfquery name="UpdateWinner" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		UPDATE prize_pool
		SET Status=1,
		Winner=#PrizeEntries.ContactID#,
		PointsPaid=0
		WHERE PrizePoolID=#PrizeDetails.PrizePoolID#
		</cfquery>
	
	</cfoutput>

</cfif>


<!--- CREATE NEW PRIZE ID --->
<cfquery name="LastID" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r" maxrows="1">
SELECT PrizePoolID
FROM Prize_pool
ORDER BY PrizePoolID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.PrizePoolID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
	
<cfset this_start = PrizeDetails.draw_date>
<cfset this_end = DateAdd('d', 1, PrizeDetails.draw_date)>

<!--- INSERT NEW DAILY PRIZE --->	
<cfquery name="Addprize" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
INSERT INTO Prize_pool(PrizePoolID, Name, Country, start_date, draw_date, pointsvalue, PrizeDraw, Reward, DisplayOrder, InviteFriend, Deleted, PromoteOnSide, Daily500, ShowWinner, Image, status, PointsPaid)
VALUES(#newid#, '500 Points', 0, #CreateODBCDate(this_start)#, #CreateODBCDate(this_end)#, 500, 1, 0, 0, 0, 0, 0, 1, 0, 'thumb_Points80x80.jpg', 0, 0)
 </cfquery>
 
 
 <cfquery name="NewDraw" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r" maxrows="1">
SELECT * 
FROM prize_pool
WHERE Daily500=1
AND Status=0
ORDER BY draw_date DESC
</cfquery>
 
 <cfmail server="#application.emailserver#" to="alan@my3p.com" from="prizes@my3p.com" subject="Daily500 Prize Draw" type="HTML">
 PRIZE DETAILS<br>
<cfdump var="#PrizeDetails#"><br><br>

 ENTRIES<br>
<cfdump var="#PrizeEntries#"><br><br>

<cfif IsDefined("WinnerStuff")>
 WINNER<br>
<cfdump var="#WinnerStuff#"><br><br>
</cfif>

 NEW DRAW<br>
<cfdump var="#NewDraw#"><br><br>
 
 
 </cfmail>
 
 
 <cfif IsDefined("prizepoolid")>
 
 <cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes">
 </cfif>