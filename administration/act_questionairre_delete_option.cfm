<cfquery name="qry_questionairre_option_delete" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM NewQuestionOptions
WHERE QuestionOptionID=#QuestionOptionID#
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&questionID=#questionID#">		