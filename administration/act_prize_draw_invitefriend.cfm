<!--- GET PRIZE DETAILS --->
<cfquery name="PrizeDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool
WHERE PrizePoolID=#PrizePoolID#
</cfquery>

<cfset this_PrizePoolID = PrizeDetails.PrizePoolID>
<cfset this_Country = INT(PrizeDetails.Country)>
<cfset this_start = PrizeDetails.start_date>
<cfset this_end = PrizeDetails.draw_date>




<!--- GET ALL MEMBERS WHO HAVE SUCCESSFULLY INVITED FRIENDS DURING PRIZE PERIOD --->

<cfquery name="PrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT Count(InvitationID) AS TotalInvites, InvitationFrom
FROM Invitations
WHERE InvitationStatus LIKE '%Successful%'
AND DateResponded >= #CreateODBCDate(this_start)#
AND DateResponded <= #CreateODBCDate(this_end)#
GROUP BY InvitationFrom
ORDER BY TotalInvites
</cfquery>


<!--- INSERT THE WINNER DETAILS --->


<cfquery name="UpdateWinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE prize_pool
SET Status=1,
winner=#PrizeEntries.InvitationFrom#
WHERE PrizePoolID=#PrizePoolID#
</cfquery>




<cfoutput>

<script language="JavaScript">
alert("A winner has been drawn!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes";
</script>

</cfoutput>