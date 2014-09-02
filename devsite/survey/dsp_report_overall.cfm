<cfoutput>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><strong>Total Questionnaires Completed:</strong>&nbsp; #TotalResponders#</td>
<td align="right" style="padding-right:10px;"><a href="#request.webroot#/survey/act_export_overall.cfm?QuestionaireID=#QuestionaireID#">Export to XML</a></td>
</tr>

</table>

	
<hr width="100%" size="1" color="##e2e2e2"><br>
	
	
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
<td><span style="font-size:12px; font-family:Arial;"><strong>#UCASE(qry_QuestionaireSections.QuestionaireSection_Name)#</strong><br>#qry_QuestionaireSections.QuestionaireSection_Details#</span>

<hr width="100%" size="1" color="##e2e2e2">
</td>
</tr>
	
<tr>
<td>


	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	
	<tr>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	<td width="260"><img src="#request.imageroot#/transparent_spc.gif" width="260" height="1" border="0"></td>
	<td width="100%"></td>
	</tr>
	
	
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
	
	
	
	
	<tr>
	<td valign="top" class="small_report"><strong>#qry_sectionQuestions.Question_number#.</strong></td>
	<td valign="top" class="small_report"><strong>#TRIM(qry_sectionQuestions.Question_Name)#</strong></td>
	<td valign="top">
	
	<cfif TRIM(qry_sectionQuestions.Question_Type) EQ 'YesNo'>
	
		
		
	
		<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
		
		<cfloop from="0" to="1" index="loopcount">
		
			<cfquery name="UserAnswerDetails_#loopcount#" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND AnswerDetails = '#loopcount#'
			</cfquery>
			
			<tr>
			<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;">

				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td class="small_report">#YesNoFormat(loopcount)#</td>
				<td class="small_report" align="right" style="padding-right:4px;"><cfif qry_sectionQuestions.Textarea EQ 1> [<a href="#request.webroot#/survey/dsp_report_comments.cfm?QuestionaireID=#QuestionaireID#&questionID=#this_QuestionID#" target="comments" onclick="fdbackwindow=window.open ('','comments','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=20,left=20')">comments</a>]</cfif></td>
				</tr>
				
				</table>
				
			</td>
			<td width="50" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report"><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>(#thisvalue#)<cfcatch>&ndash;</cfcatch></cftry></td>
			<td align="right" valign="top" width="70" style="padding-right:4px;padding-top:1px;padding-bottom:3px;" class="small_report"><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>#NumberFormat(Evaluate(thisvalue/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></td>
			</tr>
		
		</cfloop>
		
		</table>
	
	<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Multichoice'>
		
		
		<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT *
		FROM NewQuestionOptions
		WHERE QuestionID=#this_QuestionID#
		</cfquery>
		
		<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
		
		<cfloop query="qry_QuestionOptions">
		
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_QuestionID#
			AND AnswerDetails LIKE '#qry_QuestionOptions.Option_Value#'
			</cfquery>
			
			<tr>
			<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report">#TRIM(qry_QuestionOptions.Option_Name)#<cfif qry_QuestionOptions.Textarea EQ 1><br>[<a href="#request.webroot#/survey/dsp_report_comments.cfm?QuestionaireID=#QuestionaireID#&questionID=#this_QuestionID#&option=#qry_QuestionOptions.currentrow#" target="comments" onclick="fdbackwindow=window.open ('','comments','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=20,left=20')">comments</a>]</cfif></td>
			<td width="50" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report"><cftry>(#UserAnswerDetails.RecordCount#)<cfcatch>&ndash;</cfcatch></cftry></td>
			<td align="right" valign="top" style="padding-right:4px;padding-top:1px;padding-bottom:3px;" width="70" class="small_report"><cftry>#NumberFormat(Evaluate(UserAnswerDetails.RecordCount/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></td>
			</tr>
		
		</cfloop>
		
		</table>
		
		
	
	<cfelseif qry_sectionQuestions.Question_Type EQ 'Textarea'>
		
		<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT AnswerDetails
		FROM NewSurvey_Answers
		WHERE QuestionaireID=#QuestionaireID#
		AND QuestionID=#this_QuestionID#
		</cfquery>
			
			
		<table cellpadding="0" cellspacing="0" border="1" width="350" bordercolor="##e2e2e2">
		
		<cfloop query="UserAnswerDetails">
		<tr>
		<td class="small_report">#TRIM(UserAnswerDetails.AnswerDetails)#</td>
		</tr>
		</cfloop>
		
		</table>
	
	</cfif>
	
	</td>
	</tr>
		
	
	
	
	<cfif qry_secondaryQuestions.recordcount>
	
	
	<cfloop query="qry_secondaryQuestions">
	<cfset thisquestionnumber=thisquestionnumber+1>
	<cfset this_secondaryQuestionID=qry_secondaryQuestions.QuestionID>
	
	
	<cfquery name="TotalQAnswers" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT AnswerDetails
	FROM NewSurvey_Answers
	WHERE QuestionaireID=#QuestionaireID#
	AND QuestionID=#this_secondaryQuestionID#
	</cfquery>
	
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	
	<tr>
	<td valign="top"><strong></strong></td>
	<td valign="top" class="small_report">#TRIM(qry_secondaryQuestions.Question_Name)#</td>
	<td valign="top">
	
	<cfif TRIM(qry_secondaryQuestions.Question_Type) EQ 'YesNo'>
	
		
		
	
		<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
		
		<cfloop from="0" to="1" index="loopcount">
		
			<cfquery name="UserAnswerDetails_#loopcount#" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND AnswerDetails LIKE '%#loopcount#%'
			</cfquery>
			
			<tr>
			<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report">

				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td class="small_report">#YesNoFormat(loopcount)#</td>
				<td class="small_report" align="right" style="padding-right:4px;"><cfif qry_secondaryQuestions.Textarea EQ 1> [<a href="#request.webroot#/survey/dsp_report_comments.cfm?QuestionaireID=#QuestionaireID#&questionID=#this_QuestionID#" target="comments" onclick="fdbackwindow=window.open ('','comments','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=20,left=20')">comments</a>]</cfif></td>
				</tr>
				
				</table>

			</td>
			<td width="50" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report"><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>(#thisvalue#)<cfcatch>&ndash;</cfcatch></cftry></td>
			<td align="right" valign="top" width="70" style="padding-right:4px;padding-top:1px;padding-bottom:3px;" class="small_report"><cftry><cfset thisvalue = #Evaluate("UserAnswerDetails_" & loopcount & ".RecordCount")#>#NumberFormat(Evaluate(thisvalue/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></td>
			</tr>
		
		</cfloop>
		
		</table>
	
	<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice'>
		
		
		<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT *
		FROM NewQuestionOptions
		WHERE QuestionID=#this_secondaryQuestionID#
		</cfquery>
		
		<table width="350" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
		
		<cfloop query="qry_QuestionOptions">
		
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails
			FROM NewSurvey_Answers
			WHERE QuestionaireID=#QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			AND AnswerDetails LIKE '%#qry_QuestionOptions.Option_Value#%'
			</cfquery>
			
			<tr>
			<td width="230" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report">#TRIM(qry_QuestionOptions.Option_Name)#<cfif qry_QuestionOptions.textarea EQ 1><br>[<a href="#request.webroot#/survey/dsp_report_comments.cfm?QuestionaireID=#QuestionaireID#&questionID=#this_secondaryQuestionID#&option=#qry_QuestionOptions.currentrow#" target="comments" onclick="fdbackwindow=window.open ('','comments','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=20,left=20')">comments</a>]</cfif></td>
			<td width="50" valign="top" style="padding-left:4px;padding-top:1px;padding-bottom:3px;" class="small_report"><cftry>(#UserAnswerDetails.RecordCount#)<cfcatch>&ndash;</cfcatch></cftry></td>
			<td align="right" valign="top" style="padding-right:4px;padding-top:1px;padding-bottom:3px;" width="70" class="small_report"><cftry>#NumberFormat(Evaluate(UserAnswerDetails.RecordCount/TotalQAnswers.RecordCount*100), "0.00")#%<cfcatch>&ndash;</cfcatch></cftry></td>
			</tr>
		
		</cfloop>
		
		</table>
		
		
	
	<cfelseif qry_secondaryQuestions.Question_Type EQ 'Textarea'>
		
		<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT AnswerDetails
		FROM NewSurvey_Answers
		WHERE QuestionaireID=#QuestionaireID#
		AND QuestionID=#this_secondaryQuestionID#
		</cfquery>
			
			
		<table cellpadding="0" cellspacing="0" width="350" border="1" bordercolor="##e2e2e2">
		
		<cfloop query="UserAnswerDetails">
		<tr>
		<td class="small_report">#TRIM(UserAnswerDetails.AnswerDetails)#</td>
		</tr>
		</cfloop>
		
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

</cfoutput>