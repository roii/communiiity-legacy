<cfquery name="qry_questionairre_section_edit" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE NewQuestionaireSections
SET QuestionaireSection_Name='#form.QuestionaireSection_Name#',
QuestionaireSection_Details='#form.QuestionaireSection_Details#',

<cfif IsNumeric("#form.QuestionaireSection_number#")>
	QuestionaireSection_number=#form.QuestionaireSection_number#
<cfelse>
	QuestionaireSection_number=0
</cfif>

WHERE QuestionaireSectionID=#form.QuestionaireSectionID#
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section_mode=view">		