<cfquery name="DeleteSugCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM sugCategory
WHERE categoryID = #categoryID#	
</cfquery>


<cfoutput>

<script>
alert("The topic has been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat";
</script>

</cfoutput>
