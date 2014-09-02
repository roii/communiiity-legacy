<cfquery name="NextID" datasource="#DSN#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT QuestionaireSectionID
FROM NewQuestionaireSections
ORDER BY QuestionaireSectionID DESC
</cfquery>


<cfif NextID.recordcount>
	<cfset newQuestionaireSectionID = (NextID.QuestionaireSectionID + 1)>
<cfelse>
	<cfset newQuestionaireSectionID = 1>
</cfif>


<cfquery name="qry_questionairre_section_add" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO NewQuestionaireSections(QuestionaireSectionID, QuestionaireID, QuestionaireSection_Name, QuestionaireSection_Details, QuestionaireSection_number, Deleted)
VALUES(#newQuestionaireSectionID#, #form.QuestionaireID#, '#form.QuestionaireSection_Name#', '#form.QuestionaireSection_Details#', <cfif IsNumeric("#form.QuestionaireSection_number#")>#form.QuestionaireSection_number#<cfelse>0</cfif>, 0)
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section_mode=view">		