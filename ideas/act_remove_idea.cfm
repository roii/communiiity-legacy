<cfquery name="ReturnToDraft" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Suggestion
SET SugStage='Removed',
Authorise = 'no',
Archived=1
WHERE SugID=#SugID#
</cfquery>


<cfoutput>

<script>
alert('Your idea has been removed from the Voting Area.\nIt can now be found in your \"Returned\" ideas list.');
self.location="#request.webroot#/index.cfm?fuseaction=ideas&ideafunl_mode=MyIdeas&fusesubaction=docs&documentID=77";
</script>

</cfoutput>
