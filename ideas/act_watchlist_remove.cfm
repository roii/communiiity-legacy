<cfinclude template="../templates/set_language.cfm">

<cftransaction>


<cfquery name="RemoveWatch" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM SugWatchList
WHERE SugID=#SugID#
AND ContactID=#session.UserID#
</cfquery>

</cftransaction>


<cfoutput>

<cfif IsDefined("returnIdeas")>
<script type="text/javascript">
alert('#remideawatch#');
self.location="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&ideafunl_mode=#ideafunl_mode#&sugID=#sugID#&currentcategory=#currentcategory#&returnIdeas=#returnIdeas#";
</script>
<cfelse>
<script type="text/javascript">
alert('#remideawatch#');
self.location="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&ideafunl_mode=#ideafunl_mode#&sugID=#sugID#&currentcategory=#currentcategory#";
</script>
</cfif>

</cfoutput>