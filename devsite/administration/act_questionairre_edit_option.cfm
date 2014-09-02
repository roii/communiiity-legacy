<cfquery name="qry_questionairre_option_edit" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE NewQuestionOptions
SET Option_Name='#form.Option_Name#',

<cfif IsNumeric("#form.Option_order#")>
	Option_order=#form.Option_order#,
<cfelse>
	Option_order=0,
</cfif>

<cfif IsDefined("form.textarea")>
	Textarea=#form.Textarea#
<cfelse>
	Textarea=0
</cfif>

WHERE QuestionOptionID=#form.QuestionOptionID#
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&questionID=#form.questionID#">		