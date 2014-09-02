<cfoutput>


<CFQUERY NAME="SurveyDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#QuestionaireID#
</CFQUERY>

<cfset export_StartDate = DateFormat(SurveyDetails.Questionaire_startdate, "d mmmm yyyy")>
<cfset export_EndDate = DateFormat(SurveyDetails.Questionaire_enddate, "d mmmm yyyy")>

<!--- GET QUESTIONAIRE SECTIONS --->
<cfquery name="qry_QuestionaireSections" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaireSections
WHERE QuestionaireID=#QuestionaireID#
AND Deleted=0
ORDER BY QuestionaireSection_number
</cfquery>


<!--- TOTAL RESPONDERS --->
<cfquery name="TotalAnswers" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT UserID
FROM NewSurvey_Answers
WHERE QuestionaireID=#QuestionaireID#
GROUP BY UserID
ORDER BY UserID
</cfquery>

<cfset all_users = valuelist(TotalAnswers.UserID)>
<cfset TotalResponders = TotalAnswers.RecordCount>





<cfxml variable="QuestionnaireXML">


<QUESTIONNAIRE>


	<QUESTIONNAIRE_DETAILS>
	
		<Name>#XMLFORMAT(SurveyDetails.Questionaire_Name)#</Name>
		<Introduction_Text>#XMLFORMAT(SurveyDetails.Questionaire_details)#</Introduction_Text>
		<End_Text>#XMLFORMAT(SurveyDetails.Questionaire_endDetails)#</End_Text>
		<Start_Date>#XMLFORMAT(export_StartDate)#</Start_Date>
		<End_Date>#XMLFORMAT(export_EndDate)#</End_Date>
		<Status>#XMLFORMAT(SurveyDetails.Questionaire_status)#</Status>
	
	</QUESTIONNAIRE_DETAILS>
	
	<QUESTIONNAIRE_SUMMARY>
		<Total_Responders>#XMLFormat(TotalResponders)#</Total_Responders>
	</QUESTIONNAIRE_SUMMARY>

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
	
	<cfquery name="TotalQAnswers" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT AnswerDetails
	FROM NewSurvey_Answers
	WHERE QuestionaireID=#QuestionaireID#
	AND QuestionID=#this_QuestionID#
	</cfquery>
	
	
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
	<question_type>#XMLFormat(qry_sectionQuestions.Question_Type)#</question_type>
	
	<cfif TRIM(qry_sectionQuestions.Question_Type) EQ 'YesNo'>
	
		<question_results>
	
		<cfloop from="0" to="1" index="loopcount">
		
		<cfquery name="UserAnswerDetails_#loopcount#" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT AnswerDetails
		FROM NewSurvey_Answers
		WHERE QuestionaireID=#QuestionaireID#
		AND QuestionID=#this_QuestionID#
		AND AnswerDetails='#loopcount#'
		</cfquery>
			
		<question_option>
		<option_name>#YesNoFormat(loopcount)#</option_name>
		<total_responses><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>#XMLFormat(thisvalue)#<cfcatch>&ndash;</cfcatch></cftry></total_responses>
		<option_percent><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>#NumberFormat(Evaluate(thisvalue/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></option_percent>
		</question_option>
		
		</cfloop>
	
		</question_results>
	
	
	<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Multichoice'>
	
		<question_results>
		
		<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT *
		FROM NewQuestionOptions
		WHERE QuestionID=#this_QuestionID#
		</cfquery>
		
				
		<cfloop query="qry_QuestionOptions">
		
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND AnswerDetails='#qry_QuestionOptions.Option_Value#'
			</cfquery>
		
		<question_option>
		<option_name>#TRIM(qry_QuestionOptions.Option_Name)#</option_name>
		<total_responses><cftry>#XMLFormat(UserAnswerDetails.RecordCount)#<cfcatch>&ndash;</cfcatch></cftry></total_responses>
		<option_percent><cftry>#NumberFormat(Evaluate(UserAnswerDetails.RecordCount/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></option_percent>
		</question_option>
		
		</cfloop>
		
		</question_results>
	
	<cfelseif qry_sectionQuestions.Question_Type EQ 'Textarea'>
		
		<question_results>
		
		<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT AnswerDetails
		FROM NewSurvey_Answers
		WHERE QuestionaireID=#QuestionaireID#
		AND QuestionID=#this_QuestionID#
		</cfquery>
			
			
		<question_answers>
		
		<cfloop query="UserAnswerDetails">
		
		<answer_details>#XMLFormat(UserAnswerDetails.AnswerDetails)#</answer_details>
		
		</cfloop>
		
		</question_answers>
		</question_results>
	
	</cfif>
	
	
	
	
	<cfif qry_secondaryQuestions.recordcount>
	
		<SECONDARY_QUESTIONS>
		
		
		<cfloop query="qry_secondaryQuestions">
		<cfset thisquestionnumber=thisquestionnumber+1>
		<cfset this_secondaryQuestionID=qry_secondaryQuestions.QuestionID>
		
		
		<cfquery name="TotalQAnswers" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT AnswerDetails
		FROM NewSurvey_Answers
		WHERE QuestionaireID=#QuestionaireID#
		AND QuestionID=#this_secondaryQuestionID#
		</cfquery>
		
		<question_name>#XMLFormat(qry_secondaryQuestions.Question_Name)#</question_name>
		<question_type>#XMLFormat(qry_secondaryQuestions.Question_Type)#</question_type>
		
		
		<cfif TRIM(qry_secondaryQuestions.Question_Type) EQ 'YesNo'>
			
			<question_results>
			
			<cfloop from="0" to="1" index="loopcount">
			
			<cfquery name="UserAnswerDetails_#loopcount#" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND AnswerDetails='#loopcount#'
			</cfquery>
			
			<question_option>
			<option_name>#YesNoFormat(loopcount)#</option_name>
			<total_responses><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>#XMLFormat(thisvalue)#<cfcatch>&ndash;</cfcatch></cftry></total_responses>
			<option_percent><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>#NumberFormat(Evaluate(thisvalue/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></option_percent>
			</question_option>
				
			
			</cfloop>
			
			
			</question_results>
			
		<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice'>
			
			<question_results>
			
			<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT *
			FROM NewQuestionOptions
			WHERE QuestionID=#this_secondaryQuestionID#
			</cfquery>
			
		
			<cfloop query="qry_QuestionOptions">
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND AnswerDetails='#qry_QuestionOptions.Option_Value#'
			</cfquery>
				
			<question_option>
			<option_name>#TRIM(qry_QuestionOptions.Option_Name)#</option_name>
			<total_responses><cftry>#XMLFormat(UserAnswerDetails.RecordCount)#<cfcatch>&ndash;</cfcatch></cftry></total_responses>
			<option_percent><cftry>#NumberFormat(Evaluate(UserAnswerDetails.RecordCount/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></option_percent>
			</question_option>			
			
			
			</cfloop>
			
			</question_results>
			
		
		<cfelseif qry_secondaryQuestions.Question_Type EQ 'Textarea'>
			
			<question_results>
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			</cfquery>
				
				
			<question_answers>
		
			<cfloop query="UserAnswerDetails">
		
			<answer_details>#XMLFormat(UserAnswerDetails.AnswerDetails)#</answer_details>
		
			</cfloop>
		
			</question_answers>
			</question_results>
		
		
		</cfif>
		
		
		</cfloop>
	
		</SECONDARY_QUESTIONS>
	
	</cfif>
	
	
	
	</question>
	
	</cfloop>
	
	</SECTION_QUESTIONS>

	

</QUESTIONNAIRE_SECTION>

</cfloop>


</QUESTIONNAIRE>

</cfxml>


<cffile action="write" file="#ExpandPath('QuestionnaireXML.xml')#" output="#ToString(QuestionnaireXML)#">



<cfheader name="content-disposition" value="attachment;filename=QuestionnaireXML.xml">
<cfcontent type="text/xml" file="#ExpandPath('QuestionnaireXML.xml')#" deletefile="yes">


</cfoutput>