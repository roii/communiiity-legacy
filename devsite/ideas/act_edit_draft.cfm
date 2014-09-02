

<cfquery name="EditDraftSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Suggestion
SET categoryID=#Trim(Form.selCategory)#, 
suggestion='#Form.txtareaSuggestion#',
details='#Form.txtareaDetails#'
WHERE SugID=#form.SugID#
</cfquery>


<cfoutput>

<script>
alert('Your draft idea has been updated!');
self.location="#request.webroot#/index.cfm?fuseaction=ideas&ideafunl_mode=MyIdeas&fusesubaction=docs&documentID=77";
</script>

</cfoutput>
