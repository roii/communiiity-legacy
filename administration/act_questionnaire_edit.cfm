
<cfquery name="UpdateRepsonder" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Questionnaires_responders
SET Responder_name='#form.Responder_name#',
Responder_title='#form.Responder_title#',
Responder_organisation='#form.Responder_organisation#',
Responder_email='#form.Responder_email#'
WHERE ResponderID=#form.ResponderID#
</cfquery>



<!--- INSERT ANSWERS --->
<cfloop from="1" to="#form.NumberOfQuestions#" index="loopcount">


	<cfset thisanswerdetail = #Evaluate("Answer_" & loopcount)#>
	
	
	<cfquery name="AddAnswer" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Questionnaires_Answers
	SET Answer_details='#thisanswerdetail#',
	DateAnswered=#CreateODBCDateTime(localDateTime)#
	WHERE AnswerID=#Evaluate("AnswerID_" & loopcount)#
	</cfquery>


</cfloop>




<cfoutput>

<script>
alert("Your responses have been submitted.\nThank you for completing the questionnaire.");
self.location="#request.webroot#/templates/dsp_questionaire_report.cfm?questionnaireID=1";
</script>

</cfoutput>