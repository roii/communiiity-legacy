<cfoutput>

<cfparam name="individual_mode" default="select">


<cfif individual_mode EQ 'select'>

	<!--- GET ALL RESPONDERS FOR THIS QUESTIONNAIRE --->
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<tr>
	<td><strong>Select a user from the list below to view their repsonses:</strong></td>
	<td align="right" style="padding-right:15px;"><a href="#request.webroot#/survey/act_export_individual_list.cfm?QuestionaireID=#QuestionaireID#">Export to XML</a></td>
	</tr>
	
	</table>
	
	<hr width="100%" size="1" color="##e2e2e2"><br>

	
	<cfquery name="AllResponders" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName
	FROM Contacts
	WHERE ContactID IN (#all_users#)
	ORDER BY Contacts.FirstName
	</cfquery>
	

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	
	<tr>
	<td class="small_report"><strong>Name</strong></td>
	<td class="small_report"><strong>Organisation</strong></td>
	<td class="small_report"><strong>Business Title</strong></td>
	<td class="small_report"><strong>Email</strong></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="AllResponders">
	
	<tr>
	<td class="small_report"><a href="#request.webroot#/survey/dsp_report.cfm?ReportMode=individual&individual_mode=report&UserID=#AllResponders.ContactID#&QuestionaireID=#QuestionaireID#">#TRIM(AllResponders.FirstName)# #TRIM(AllResponders.LastName)#</a></td>
	<td class="small_report"></td>
	<td class="small_report"></td>
	<td class="small_report"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>



<cfelse>

	
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



	<table width="100%" cellpadding="0" border="0">
	
	<tr>
	<td width="80%" class="small_report" valign="bottom"><strong>This report for:</strong> &nbsp;#TRIM(ResponderDetails.FirstName)# #TRIM(ResponderDetails.LastName)#<br>
	<strong>Date Completed:</strong> &nbsp;#DateFormat(DateStarted.AnswerDate)#</td>
	<td width="20%" class="small_report" align="right" style="padding-right:20px;" valign="bottom"><a href="#request.webroot#/survey/act_export_individual.cfm?QuestionaireID=#QuestionaireID#&UserID=#UserID#">Export to XML</a></td>
	</tr>
	
	</table>
	


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
			
	<cfset thisquestionnumber=0>
	
	<cfloop query="qry_QuestionaireSections">
	
	<cfset this_QuestionaireSectionID = qry_QuestionaireSections.QuestionaireSectionID>
	
	<cfquery name="qry_sectionQuestions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT *
	FROM NewQuestions
	WHERE QuestionaireSectionID=#this_QuestionaireSectionID#
	AND QuestionLevel='primary'
	AND Deleted=0
	ORDER BY Question_number
	</cfquery>
	
	
	<tr>
	<td style="padding-right:20px;">
	
	<hr width="100%" size="1" color="##e2e2e2"><br>
	
	<span style="font-size:12px; font-family:Arial;"><strong>#UCASE(qry_QuestionaireSections.QuestionaireSection_Name)#</strong><br>#qry_QuestionaireSections.QuestionaireSection_Details#</span>
	
	<hr width="100%" size="1" color="##e2e2e2">
	</td>
	</tr>
		
	<tr>
	<td style="padding-right:20px;">
	
	
		<table width="100%" cellpadding="2" cellspacing="0" border="0">
		
		<tr>
		<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
		<td width="260"><img src="#request.imageroot#/transparent_spc.gif" width="260" height="1" border="0"></td>
		<td width="100%"></td>
		</tr>
		
		
		<cfloop query="qry_sectionQuestions">
		
		<cfset thisquestionnumber=thisquestionnumber+1>
		
		<cfset this_QuestionID = qry_sectionQuestions.QuestionID>
		
				
		<!--- CHECK FOR SUB QUESTIONS --->
		<cfquery name="qry_secondaryQuestions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT *
		FROM NewQuestions
		WHERE QuestionLevel LIKE '%secondary%'
		AND PrimaryQuestionID=#this_QuestionID#
		AND Deleted=0
		ORDER BY Question_number
		</cfquery>
		
		
		
		
		<tr>
		<td valign="top" class="small_report"><strong>#qry_sectionQuestions.Question_number#.</strong></td>
		<td valign="top" class="small_report"><strong>#TRIM(qry_sectionQuestions.Question_Name)#</strong></td>
		<td valign="top">
		
		<cfif TRIM(qry_sectionQuestions.Question_Type) EQ 'YesNo'>
		
			
			
		
			<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_other
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND UserID=#UserID#
			</cfquery>
			
			<tr>
			<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report">#YesNoFormat(UserAnswerDetails.AnswerDetails)#<cfif (qry_sectionQuestions.Textarea EQ 1) AND (TRIM(UserAnswerDetails.Answer_other) NEQ '') AND (TRIM(UserAnswerDetails.Answer_other) NEQ '-')><br><span style="color:Gray;">#TRIM(UserAnswerDetails.Answer_other)#</span></cfif></td>
			</tr>
			
			
			</table>
			
		
		<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Multichoice'>
			
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_other
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND UserID=#UserID#
			</cfquery>
			
			<cfset other_list=valueList(UserAnswerDetails.Answer_other)>
			
			<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
			<cfset rowcount=0>
			
			<cfloop list="#UserAnswerDetails.AnswerDetails#" delimiters="," index="loopitem">
			<cfset rowcount=rowcount+1>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_QuestionID#
				AND Option_Value='#loopitem#'
				</cfquery>
			
				
				<tr>
				<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report">#TRIM(qry_QuestionOptions.Option_Name)#<cfif (qry_QuestionOptions.Textarea EQ 1) AND (ListGetAt(other_list, rowcount, ",") NEQ '-') AND (ListGetAt(other_list, rowcount, ",") NEQ '')><br>
<span style="color:Gray;">#ListGetAt(other_list, rowcount, ",")#</span></cfif></td>
				</tr>
			
			</cfloop>
			
			</table>
			
			
		
		<cfelseif qry_sectionQuestions.Question_Type EQ 'Textarea'>
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND UserID=#UserID#
			</cfquery>
				
				
			<table cellpadding="0" cellspacing="0" border="1" width="350" bordercolor="##e2e2e2">
			
			<tr>
			<td class="small_report">#TRIM(UserAnswerDetails.AnswerDetails)#</td>
			</tr>
			
			</table>
		
		</cfif>
		
		</td>
		</tr>
			
		
		
		
		<cfif qry_secondaryQuestions.recordcount>
		
		
		<cfloop query="qry_secondaryQuestions">
		<cfset thisquestionnumber=thisquestionnumber+1>
		<cfset this_secondaryQuestionID=qry_secondaryQuestions.QuestionID>
		
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		
		<tr>
		<td valign="top"><strong></strong></td>
		<td valign="top" class="small_report">#TRIM(qry_secondaryQuestions.Question_Name)#</td>
		<td valign="top">
		
		<cfif TRIM(qry_secondaryQuestions.Question_Type) EQ 'YesNo'>
		
			
			
		
			<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
			
			
			
				<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT AnswerDetails, Answer_other
				FROM NewSurvey_Answers
				WHERE QuestionaireID=#QuestionaireID#
				AND QuestionID=#this_secondaryQuestionID#
				AND UserID=#UserID#
				</cfquery>
				
				<tr>
				<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report">#YesNoFormat(UserAnswerDetails.AnswerDetails)#<cfif (qry_secondaryQuestions.Textarea EQ 1) AND (TRIM(UserAnswerDetails.Answer_other) NEQ '-') AND (TRIM(UserAnswerDetails.Answer_other) NEQ '')><br><span style="color:Gray;">#TRIM(UserAnswerDetails.Answer_other)#</span></cfif></td>
				</tr>
			
			
			</table>
		
		<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice'>
			
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_other
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND UserID=#UserID#
			</cfquery>
			
			<cfset other_list=valueList(UserAnswerDetails.Answer_other)>
			
			<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
			<cfset rowcount=0>
			
			<cfloop list="#UserAnswerDetails.AnswerDetails#" delimiters="," index="loopitem">
			<cfset rowcount=rowcount+1>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_secondaryQuestionID#
				AND Option_Value='#loopitem#'
				</cfquery>
			
				
				<tr>
				<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report">#TRIM(qry_QuestionOptions.Option_Name)#<cfif (qry_QuestionOptions.Textarea EQ 1) AND (ListGetAt(other_list, rowcount, ",") NEQ '-') AND (ListGetAt(other_list, rowcount, ",") NEQ '')><br>
				<span style="color:Gray;">#ListGetAt(other_list, rowcount, ",")#</span></cfif></td>
				</tr>
			
			</cfloop>
			
			</table>
			
			
			
		
		<cfelseif qry_secondaryQuestions.Question_Type EQ 'Textarea'>
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND UserID=#UserID#
			</cfquery>
				
				
			<table cellpadding="0" cellspacing="0" width="350" border="1" bordercolor="##e2e2e2">
			
			
			<tr>
			<td class="small_report">#TRIM(UserAnswerDetails.AnswerDetails)#</td>
			</tr>
			
			
			</table>
		
		</cfif>
		
		</td>
		</tr>
		
		
		</cfloop>
		
		
		</cfif>
		
		
		
		
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		
		</cfloop>
		
		
		</table>
		
		
	</td>
	</tr>
	
	<tr>
	<td><br><br></td>
	</tr>
	
	</cfloop>
	
	</table>


</cfif>

</cfoutput>