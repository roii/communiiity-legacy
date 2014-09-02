<cfinclude template="../templates/set_language.cfm">

<cftransaction>

<cfquery name="nextid" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT WatchlistID
FROM SugWatchList
ORDER BY WatchlistID DESC
</cfquery>

<cfif nextid.recordcount>
	<cfset this_nextID = (nextid.WatchlistID+1)>
<cfelse>
	<cfset this_nextID = 1>
</cfif>

<cfquery name="AddWatch" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO SugWatchList(WatchlistID, SugID, ContactID, DateAdded)
VALUES(#this_nextID#, #SugID#, #session.UserID#, #CreateODBCDateTime(localDateTime)#)
</cfquery>

</cftransaction>


<cfoutput>


<cfif IsDefined("returnIdeas")>
<script type="text/javascript">
alert('#addideawatch#');
self.location="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&ideafunl_mode=#ideafunl_mode#&sugID=#sugID#&currentcategory=#currentcategory#&returnIdeas=#returnIdeas#";
</script>
<cfelse>
<script type="text/javascript">
alert('#addideawatch#');
self.location="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&ideafunl_mode=#ideafunl_mode#&sugID=#sugID#&currentcategory=#currentcategory#";
</script>
</cfif>
</cfoutput>