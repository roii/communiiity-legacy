<cfoutput>



<!--- MARK THE QUESTIONNAIRE AS DELETED --->
<cfquery name="DeleteQuestionaire" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE NewQuestionaires
SET Deleted=1
WHERE QuestionaireID=#QuestionaireID#
</cfquery>



<script>
alert("You have successfully marked the questionnaire as 'Deleted'.");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_questionairres";
</script>


</cfoutput>