<!--- GET ADVERT URL --->
<cfquery name="AdvertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AdvertURL
FROM Advertising
WHERE AdvertID=#AdvertID#
</cfquery>



<cftransaction action="BEGIN">

<!--- GET NEXT CLICK ID --->
<cfquery name="NextID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT AdClickID
FROM AdvertisingClicks
ORDER BY AdClickID DESC
</cfquery>

<cfif NextID.RecordCount>
	<cfset insert_nextID=(NextID.AdClickID+1)>
<cfelse>
	<cfset insert_nextID=1>
</cfif>


<!--- INSERT CLICK DATA --->
<cfquery name="InsertClickData" datasource="#dsn#">
INSERT INTO AdvertisingClicks(
AdClickID,
AdvertID,
ClickDateTime,
UserIP,
ClickedFrom)
VALUES(
#insert_nextID#,
#AdvertID#,
#createodbcdatetime(localDateTime)#,
'#cgi.remote_addr#',
'#cgi.http_referrer#'
)
</cfquery>


</cftransaction>


<!--- REDIRECT TO URL --->
<cflocation url="#AdvertStuff.AdvertURL#">