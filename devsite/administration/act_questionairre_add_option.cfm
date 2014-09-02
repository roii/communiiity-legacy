<!--- CHECK FOR VALUE --->
<cfquery name="Alloptions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT QuestionOptionID
FROM NewQuestionOptions
WHERE QuestionID=#form.QuestionID#
</cfquery>

<cfif Alloptions.RecordCount>
	<cfset newvalue=AllOptions.RecordCount+1>
<cfelse>
	<cfset newvalue=1>
</cfif>


<cfquery name="NextID" datasource="#DSN#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT QuestionOptionID
FROM NewQuestionOptions
ORDER BY QuestionOptionID DESC
</cfquery>


<cfif NextID.recordcount>
	<cfset newOptionID = (NextID.QuestionOptionID + 1)>
<cfelse>
	<cfset newOptionID = 1>
</cfif>


<cfquery name="qry_questionairre_questionoption_add" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO NewQuestionOptions(
QuestionOptionID, 
QuestionID,
Option_Name,
Option_Value,
Option_order,
Textarea)

VALUES(
#newOptionID#, 
#form.QuestionID#, 
'#form.Option_Name#',
'#newvalue#',
<cfif IsNumeric("#form.Option_order#")>
#form.Option_order#
<cfelse>
0
</cfif>,
<cfif Isdefined("form.Textarea")>
#form.Textarea#
<cfelse>
0
</cfif>)
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&QuestionID=#form.QuestionID#">		