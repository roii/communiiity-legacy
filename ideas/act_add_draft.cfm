<cfquery name="AddDraftSuggestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Suggestion(categoryID, suggestion, details, madeBy, contactID, Authorise, SugStage, WhenSugMade, Archived)
VALUES (#Form.selCategory#, '#Replace(Form.txtareaSuggestion, "'", "'", "ALL")#', '#Replace(Form.txtareaDetails, "'", "'", "ALL")#', '#Trim(session.User_FirstName)# #Trim(session.User_LastName)#', #session.UserID#, 'no', 'Draft', #createODBCDateTime(localDateTime)#, 0)
</cfquery>


<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT SugID
FROM Suggestion
WHERE ContactID=#session.userID#
ORDER BY SugID DESC
</cfquery>


<cfset ExtraDescription = "<BR>Idea: #TRIM(Form.txtareaSuggestion)#">

<!--- PROCESS REWARDS --->
<cfset this_activity = 12>
<cfset this_contactID = session.UserID>
<cfset this_relatedDescription = "AddIdea">
<cfset this_relatedID = "#LastID.SugID#">

<cfinclude template="../templates/act_activity_reward_payment.cfm">


<cfoutput>

<script>
alert('Your draft idea has been saved!');
self.location="#request.webroot#/index.cfm?fuseaction=ideas&ideafunl_mode=MyIdeas&fusesubaction=docs&documentID=77";
</script>

</cfoutput>
