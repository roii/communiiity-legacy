<cfquery name="DeleteMainCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM SugMainCategory
WHERE MainCatID = #MainCatID#	
</cfquery>


<cfoutput>

<script>
alert("The category has been deleted!");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_Sug_mainCats";
</script>

</cfoutput>
