

<cfquery name="DeleteDraftSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Suggestion
SET archived=1,
SugStage='Deleted'
WHERE SugID=#SugID#
</cfquery>


<cfoutput>

<script>
alert('Your draft idea has been deleted!');
self.location="#request.webroot#/index.cfm?fuseaction=ideas&ideafunl_mode=MyIdeas&fusesubaction=docs&documentID=77";
</script>

</cfoutput>
