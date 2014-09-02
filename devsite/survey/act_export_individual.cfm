<cfoutput>


<cfquery name="SurveyDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#QuestionaireID#
</cfquery>

<!--- GET QUESTIONAIRE SECTIONS --->
<cfquery name="qry_QuestionaireSections" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaireSections
WHERE QuestionaireID=#QuestionaireID#
AND Deleted=0
ORDER BY QuestionaireSection_number
</cfquery>

<cfquery name="ResponderDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM Contacts
WHERE ContactID =#UserID#
</cfquery>


<cfquery name="DateStarted" datasource="#dsn#" maxrows="1" username="mykidsbiznew" password="u+67eNfJ">
SELECT AnswerDate
FROM NewSurvey_Answers
WHERE QuestionaireID=#QuestionaireID#
AND UserID=#UserID#
</cfquery>



<cfset export_StartDate = DateFormat(SurveyDetails.Questionaire_startdate, "d mmmm yyyy")>
<cfset export_EndDate = DateFormat(SurveyDetails.Questionaire_enddate, "d mmmm yyyy")>

<cfset export_RegDate = DateFormat(ResponderDetails.TimeOfSurveyCompletion, "d mmmm yyyy")>

<cfxml variable="Individual_Questionnaire_Response">


<QUESTIONNAIRE_RESPONSE>


	<QUESTIONNAIRE_DETAILS>
	
		<Name>#XMLFORMAT(SurveyDetails.Questionaire_Name)#</Name>
		<Introduction_Text>#XMLFORMAT(SurveyDetails.Questionaire_details)#</Introduction_Text>
		<End_Text>#XMLFORMAT(SurveyDetails.Questionaire_endDetails)#</End_Text>
		<Start_Date>#XMLFORMAT(export_StartDate)#</Start_Date>
		<End_Date>#XMLFORMAT(export_EndDate)#</End_Date>
		<Status>#XMLFORMAT(SurveyDetails.Questionaire_status)#</Status>
	
	</QUESTIONNAIRE_DETAILS>	
	
	
	<RESPONDER_DETAILS>
		
		<FirstName>#XMLFORMAT(ResponderDetails.FirstName)#</FirstName>
		<Lastname>#XMLFORMAT(ResponderDetails.LastName)#</Lastname>
		<Email>#XMLFORMAT(ResponderDetails.EmailAddress)#</Email>
		
	</RESPONDER_DETAILS>
	
	
	<ANSWER_DETAILS>
	<Date_Completed>#DateFormat(DateStarted.AnswerDate)#</Date_Completed>	

			
	<cfset thisquestionnumber=0>
	
	<cfloop query="qry_QuestionaireSections">
	
	<QUESTIONNAIRE_SECTION>
	
	<cfset this_QuestionaireSectionID = qry_QuestionaireSections.QuestionaireSectionID>
	
	<cfquery name="qry_sectionQuestions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT *
	FROM NewQuestions
	WHERE QuestionaireSectionID=#this_QuestionaireSectionID#
	AND QuestionLevel='primary'
	AND Deleted=0
	ORDER BY Question_number
	</cfquery>
	
	
	<Section_Name>#XMLFormat(qry_QuestionaireSections.QuestionaireSection_Name)#</Section_Name>
	<Section_Description>#XMLFormat(qry_QuestionaireSections.QuestionaireSection_Details)#</Section_Description>
	
	<SECTION_QUESTIONS>
		
	
		
		
		<cfloop query="qry_sectionQuestions">
		
		<cfset thisquestionnumber=thisquestionnumber+1>
		
		<cfset this_QuestionID = qry_sectionQuestions.QuestionID>
		<cfset this_Access_QuestionID = qry_sectionQuestions.Access_QuestionID>
				
		<!--- CHECK FOR SUB QUESTIONS --->
		<cfquery name="qry_secondaryQuestions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT *
		FROM NewQuestions
		WHERE QuestionLevel LIKE '%secondary%'
		AND PrimaryQuestionID=#this_QuestionID#
		AND Deleted=0
		ORDER BY Question_number
		</cfquery>
		
		
		<question>
		<question_number>#XMLFormat(thisquestionnumber)#</question_number>
		<question_name>#XMLFormat(qry_sectionQuestions.Question_Name)#</question_name>
		
		
		<cfif TRIM(qry_sectionQuestions.Question_Type) EQ 'YesNo'>
		
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_other
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND UserID=#UserID#
			</cfquery>
			<answer>
			<answer_details>#YesNoFormat(UserAnswerDetails.AnswerDetails)#</answer_details>
			
			<cfif (qry_sectionQuestions.Textarea EQ 1) AND (TRIM(UserAnswerDetails.Answer_other) NEQ '') AND (TRIM(UserAnswerDetails.Answer_other) NEQ '-')>
				<other_details>#TRIM(UserAnswerDetails.Answer_other)#</other_details>
			</cfif>
			</answer>
		
		<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Multichoice'>
			
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_other
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND UserID=#UserID#
			</cfquery>
			
			<cfset other_list=valueList(UserAnswerDetails.Answer_other)>
			
			
			<cfset rowcount=0>
			
			<cfloop list="#UserAnswerDetails.AnswerDetails#" delimiters="," index="loopitem">
			<cfset rowcount=rowcount+1>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_QuestionID#
				AND Option_Value='#loopitem#'
				</cfquery>
				<answer>
				<answer_details>#TRIM(qry_QuestionOptions.Option_Name)#</answer_details>
				
				<cfif (qry_QuestionOptions.Textarea EQ 1) AND (ListGetAt(other_list, rowcount, ",") NEQ '-') AND (ListGetAt(other_list, rowcount, ",") NEQ '')>
					<other_details>#ListGetAt(other_list, rowcount, ",")#</other_details>				
				</cfif>
				</answer>
			
			</cfloop>			
			
		
		<cfelseif qry_sectionQuestions.Question_Type EQ 'Textarea'>
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND UserID=#UserID#
			</cfquery>
				
			<answer>
			<answer_details>#TRIM(UserAnswerDetails.AnswerDetails)#</answer_details>
			</answer>
			
		</cfif>
		
		
		</question>
		
		<cfif qry_secondaryQuestions.recordcount>
		
		
		<SECONDARY_QUESTIONS>
		
		
		<cfloop query="qry_secondaryQuestions">
		<cfset thisquestionnumber=thisquestionnumber+1>
		<cfset this_secondaryQuestionID=qry_secondaryQuestions.QuestionID>
		<question>
		<question_name>#XMLFormat(qry_secondaryQuestions.Question_Name)#</question_name>
		
		
		<cfif TRIM(qry_secondaryQuestions.Question_Type) EQ 'YesNo'>
		
				
				<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT AnswerDetails, Answer_other
				FROM NewSurvey_Answers
				WHERE QuestionaireID=#QuestionaireID#
				AND QuestionID=#this_secondaryQuestionID#
				AND UserID=#UserID#
				</cfquery>
				<answer>
				<answer_details>#YesNoFormat(UserAnswerDetails.AnswerDetails)#</answer_details>
				
				<cfif (qry_secondaryQuestions.Textarea EQ 1) AND (TRIM(UserAnswerDetails.Answer_other) NEQ '-') AND (TRIM(UserAnswerDetails.Answer_other) NEQ '')>
					<other_details>#TRIM(UserAnswerDetails.Answer_other)#</other_details>
				</cfif>
				</answer>
		
		<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice'>
			
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_other
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND UserID=#UserID#
			</cfquery>
			
			<cfset other_list=valueList(UserAnswerDetails.Answer_other)>
			
			<cfset rowcount=0>
			
			<cfloop list="#UserAnswerDetails.AnswerDetails#" delimiters="," index="loopitem">
			<cfset rowcount=rowcount+1>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_secondaryQuestionID#
				AND Option_Value='#loopitem#'
				</cfquery>
			
				<answer>
				<answer_details>#TRIM(qry_QuestionOptions.Option_Name)#</answer_details>
				
				<cfif (qry_QuestionOptions.Textarea EQ 1) AND (ListGetAt(other_list, rowcount, ",") NEQ '-') AND (ListGetAt(other_list, rowcount, ",") NEQ '')>
					<other_details>#ListGetAt(other_list, rowcount, ",")#</other_details>
				</cfif>
				</answer>
				
			</cfloop>
			
			
			
			
		
		<cfelseif qry_secondaryQuestions.Question_Type EQ 'Textarea'>
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND UserID=#UserID#
			</cfquery>
				
			<answer>
			<answer_details>#TRIM(UserAnswerDetails.AnswerDetails)#</answer_details>
			</answer>
			
		</cfif>
		
		</question>
		</cfloop>
		
		</SECONDARY_QUESTIONS>
		
		</cfif>
		
		
		
		

		
		</cfloop>
		
	</SECTION_QUESTIONS>
	
	</QUESTIONNAIRE_SECTION>
	
	</cfloop>

</ANSWER_DETAILS>

</QUESTIONNAIRE_RESPONSE>

</cfxml>


<cffile action="write" file="#ExpandPath('Individual_Questionnaire_Response.xml')#" output="#ToString(Individual_Questionnaire_Response)#">



<cfheader name="content-disposition" value="attachment;filename=Individual_Questionnaire_Response.xml">
<cfcontent type="text/xml" file="#ExpandPath('Individual_Questionnaire_Response.xml')#" deletefile="yes">


</cfoutput>