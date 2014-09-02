<CFQUERY NAME="SurveyDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#QuestionaireID#
</CFQUERY>

<cfset export_StartDate = DateFormat(SurveyDetails.Questionaire_startdate, "d mmmm yyyy")>
<cfset export_EndDate = DateFormat(SurveyDetails.Questionaire_enddate, "d mmmm yyyy")>


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



<cfquery name="AllResponders" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM Contacts
WHERE ContactID IN (#all_users#)
ORDER BY FirstName
</cfquery>
	

<cfoutput>	
	
	
<cfxml variable="Questionnaire_Responders">


<QUESTIONNAIRE_RESPONDERS>


	<QUESTIONNAIRE_DETAILS>
	
		<Name>#XMLFORMAT(SurveyDetails.Questionaire_Name)#</Name>
		<Introduction_Text>#XMLFORMAT(SurveyDetails.Questionaire_details)#</Introduction_Text>
		<End_Text>#XMLFORMAT(SurveyDetails.Questionaire_endDetails)#</End_Text>
		<Start_Date>#XMLFORMAT(export_StartDate)#</Start_Date>
		<End_Date>#XMLFORMAT(export_EndDate)#</End_Date>
		<Status>#XMLFORMAT(SurveyDetails.Questionaire_status)#</Status>
	
	</QUESTIONNAIRE_DETAILS>	
	
	<cfloop query="AllResponders">
	
	<cfset export_RegDate = DateFormat(AllResponders.TimeOfSurveyCompletion, "d mmmm yyyy")>
	
	<RESPONDER>
		<Title>#XMLFORMAT(AllResponders.Title)#</Title>
		<FirstName>#XMLFORMAT(AllResponders.FirstName)#</FirstName>
		<Lastname>#XMLFORMAT(AllResponders.Lastname)#</Lastname>
		<Email>#XMLFORMAT(AllResponders.EmailAddress)#</Email>
	</RESPONDER>
	
	</cfloop>
	
	
</QUESTIONNAIRE_RESPONDERS>

</cfxml>


<cffile action="write" file="#ExpandPath('Questionnaire_Responders.xml')#" output="#ToString(Questionnaire_Responders)#">



<cfheader name="content-disposition" value="attachment;filename=Questionnaire_Responders.xml">
<cfcontent type="text/xml" file="#ExpandPath('Questionnaire_Responders.xml')#" deletefile="yes">


</cfoutput>