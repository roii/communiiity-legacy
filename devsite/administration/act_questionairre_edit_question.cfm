<cfquery name="qry_questionairre_question_edit" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE NewQuestions
SET Question_Name='#form.Question_Name#',
Question_Type='#form.Question_Type#',

<cfif IsNumeric("#form.Question_number#")>
	Question_number=#form.Question_number#,
<cfelse>
	Question_number=0,
</cfif>

<cfif IsDefined("form.textarea")>
	Textarea=#form.Textarea#,
<cfelse>
	Textarea=0,
</cfif>

<cfif IsNumeric("#form.Access_QuestionID#")>
	Access_QuestionID=#form.Access_QuestionID#,
<cfelse>
	Access_QuestionID=0,
</cfif>

<cfif IsDefined("form.AnswerRequired")>
	AnswerRequired=#form.AnswerRequired#
<cfelse>
	AnswerRequired=0
</cfif>

WHERE QuestionID=#form.QuestionID#
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=view">		