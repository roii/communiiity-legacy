<!--- GET LINKED QUESTIONS --->
<cfquery name="qry_sectionQuestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestions
WHERE QuestionaireSectionID=#QuestionaireSectionID#
AND QuestionLevel='primary'
ORDER BY Question_number
</cfquery>

<!--- LOOP LINKED QUESTIONS --->
<cfloop query="qry_sectionQuestions">
<cfset this_QuestionID = qry_sectionQuestions.QuestionID>

	
	<!--- GET LINKED SUB-QUESTIONS --->
	<cfquery name="qry_secondaryQuestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM NewQuestions
	WHERE QuestionLevel LIKE '%secondary%'
	AND PrimaryQuestionID=#this_QuestionID#
	ORDER BY Question_number
	</cfquery>
	
	
	<!--- LOOP SUB-QUESTIONS --->
	<cfloop query="qry_secondaryQuestions">
	<cfset this_SubQuestionID=qry_secondaryQuestions.QuestionID>
		
		<!--- MARK SUB-QUESTIONS AS DELETED --->
		<cfquery name="deleteQuestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE NewQuestions
		SET Deleted=1
		WHERE QuestionID=#this_SubQuestionID#
		</cfquery>
		
	</cfloop>
		
		
	<!--- MARK QUESTION AS DELETED --->
	<cfquery name="deleteQuestion" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE NewQuestions
	SET Deleted=1
	WHERE QuestionID=#this_QuestionID#
	</cfquery>
	
	
</cfloop>


	
<!--- MARK SECTION AS DELETED --->
<cfquery name="deleteSection" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE NewQuestionaireSections
SET Deleted=1
WHERE QuestionaireSectionID=#QuestionaireSectionID#
</cfquery>



<!--- RELOCATE --->
<cflocation url="#request.webroot#/administration/dsp_questionairre_edit.cfm?color=#color#">		