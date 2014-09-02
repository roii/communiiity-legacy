<!--- MARK QUESTION AS DELETED --->
<cfquery name="deleteQuestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE NewQuestions
SET Deleted=1
WHERE QuestionID=#QuestionID#
</cfquery>
	


<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?color=#color#">		