<cfquery name="NextID" datasource="#DSN#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT QuestionID
FROM NewQuestions
ORDER BY QuestionID DESC
</cfquery>


<cfif NextID.recordcount>
	<cfset newQuestionID = (NextID.QuestionID + 1)>
<cfelse>
	<cfset newQuestionID = 1>
</cfif>


<cfquery name="qry_questionairre_question_add" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO NewQuestions(QuestionID, QuestionaireSectionID, QuestionLevel, PrimaryQuestionID, Question_Type, Question_Name, Question_number, Textarea, Deleted, AnswerRequired, Access_QuestionID)
VALUES(#newQuestionID#, #form.QuestionaireSectionID#, '#form.QuestionLevel#', <cfif IsDefined("form.PrimaryQuestionID")>#form.PrimaryQuestionID#<cfelse>0</cfif>, '#form.Question_Type#', '#form.Question_Name#', <cfif IsNumeric("#form.Question_number#")>#form.Question_number#<cfelse>0</cfif>, <cfif Isdefined("form.textarea")>#form.textarea#<cfelse>0</cfif>, 0, <cfif Isdefined("form.AnswerRequired")>#form.AnswerRequired#<cfelse>0</cfif>, <cfif IsNumeric("#form.Access_QuestionID#")>#form.Access_QuestionID#<cfelse>0</cfif>)
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=view">		