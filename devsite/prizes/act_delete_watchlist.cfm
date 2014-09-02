	<!--- INSERT WATCH RECORD --->
	<cfquery name="DeleteWatch" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Prize_Watchlist
	WHERE PrizeID=#PrizePoolID#
	AND ContactID=#session.UserID#
	</cfquery>


<cfoutput>

<script language="JavaScript">
alert("You have removed the prize from your Prize Watchlist");
self.location="#request.webroot#/index.cfm?fuseaction=prizes&fusesubaction=docs&documentid=51";
</script>

</cfoutput>
