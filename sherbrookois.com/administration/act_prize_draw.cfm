<!--- GET PRIZE DETAILS --->
<cfquery name="PrizeDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool
WHERE PrizePoolID=#PrizePoolID#
</cfquery>

<cfset this_PrizePoolID = PrizePoolID>
<cfset this_Country = INT(PrizeDetails.Country)>
<cfset this_start = PrizeDetails.start_date>
<cfset this_end = PrizeDetails.draw_date>




<!--- GET ALL ENTRIES FROM APPLICABLE COUNTRIES --->

<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
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

	<!--- Winner Entry ID:#PrizeEntries.Prize_EntryID#<br>
	Winner ContactID: #PrizeEntries.contactID# --->

	<cfquery name="UpdateWinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE prize_pool
	SET Status=1,
	winner=#PrizeEntries.ContactID#,
	PointsPaid=0
	WHERE PrizePoolID=#PrizePoolID#
	</cfquery>

</cfoutput>

<!--- <cfabort> --->
<cfoutput>

<script language="JavaScript">
alert("A winner has been drawn!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes";
</script>

</cfoutput>