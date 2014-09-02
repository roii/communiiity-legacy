<cfoutput>

<!--- GET DATE COMPLETED --->
<cfquery name="DateSubmittedDetails" datasource="#dsn#" maxrows="1" username="mykidsbiznew" password="u+67eNfJ">
SELECT AnswerDate
FROM NewSurvey_Answers
WHERE UserID=#Session.UserID#
AND QuestionaireID=#this_QuestionaireID#
ORDER BY AnswerDate DESC
</cfquery>
			
			
<!--- GET QUESTIONAIRE SECTIONS --->
<cfquery name="qry_QuestionaireSections" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaireSections
WHERE QuestionaireID=#this_QuestionaireID#
AND Deleted=0
ORDER BY QuestionaireSection_number
</cfquery>

			

<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="e2e2e2">

<tr>
<td>


	<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="white">

	<tr>
	<td>
	
		
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td><span style="font-size:12px;"><strong>DATE COMPLETED:</strong> #DateFormat(DateSubmittedDetails.AnswerDate, "d-mmm-yyyy")#</span><br><br>
		
		<hr width="100%" size="1" color="e2e2e2">
		</td>
		</tr>
		
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
		<td><span style="font-size:12px;"><strong>#UCASE(qry_QuestionaireSections.QuestionaireSection_Name)#</strong><br></span>
		
		<hr width="100%" size="1" color="e2e2e2">
		</td>
		</tr>
			
		<tr>
		<td>
		
		
			<table width="100%" cellpadding="2" cellspacing="0" border="0">
			
			<tr>
			<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
			<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
			<td width="100%"></td>
			</tr>
			
			
			<cfloop query="qry_sectionQuestions">
			
			<cfset thisquestionnumber=thisquestionnumber+1>
			
			<cfset this_QuestionID = qry_sectionQuestions.QuestionID>
			
			
			<cfquery name="UserAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_Other
			FROM NewSurvey_Answers
			WHERE UserID=#Session.UserID#
			AND QuestionaireID=#this_QuestionaireID#
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
			<td valign="top"><span style="padding-top:2px;padding-bottom:2px;padding-left:4px;padding-right:4px;background-color:black;color:white;"><strong>#qry_sectionQuestions.Question_number#</strong></span></td>
			<td valign="top">#TRIM(qry_sectionQuestions.Question_Name)#</td>
			<td valign="top" width="100%">
			
			<cfif qry_sectionQuestions.Question_Type CONTAINS 'YesNo'>
			
				<table cellpadding="0" cellspacing="0" border="1" bordercolor="e2e2e2">
				<tr>
				<td width="50"><input style="border:solid 1px Silver;" disabled type="radio" name="answer_#thisquestionnumber#" value="1"<cfif (UserAnswerDetails.recordcount) AND UserAnswerDetails.AnswerDetails EQ 1> checked</cfif>> Yes</td>
				<td width="50"><input style="border:solid 1px Silver;" disabled type="radio" name="answer_#thisquestionnumber#" value="0"<cfif (UserAnswerDetails.recordcount) AND UserAnswerDetails.AnswerDetails EQ 0> checked</cfif>> No</td>
				</tr>
				</table>
				
				<!--- <cfdump var="#qry_secondaryQuestions#"> --->
			
			<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Multichoice_single'>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_QuestionID#
				ORDER BY Option_Order
				</cfquery>
			
				<table cellpadding="0" cellspacing="2" border="0">
				
				<cfset thisOptionCount=0>
				<cfloop query="qry_QuestionOptions">
				
				
				<tr>
				<td width="25"><input style="border:solid 1px Silver;" disabled type="radio" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"<cfif (UserAnswerDetails.recordcount) AND (TRIM(UserAnswerDetails.AnswerDetails) NEQ '') AND (ListFind(UserAnswerDetails.AnswerDetails, "#TRIM(qry_QuestionOptions.Option_Value)#"))> checked</cfif>></td>
				<td width="100%"> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<cfset thisOptionCount=(thisOptionCount+1)>
				<tr>
				<td colspan="2"><textarea disabled name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5" style="border:solid 1px Silver;"><cfif (UserAnswerDetails.recordcount) AND (TRIM(UserAnswerDetails.AnswerDetails) NEQ '')><cftry>#ListGetAt(UserAnswerDetails.Answer_other,  thisOptionCount,  ",")#<cfcatch></cfcatch></cftry></cfif></textarea><br><br></td>
				</tr>
				
				
				</cfif>
				
				
				</cfloop>
				
				</table>
			
			
			<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Multichoice'>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_QuestionID#
				ORDER BY Option_Order
				</cfquery>
			
				<table cellpadding="0" cellspacing="2" border="0">
				
				<cfset thisOptionCount=0>
				<cfloop query="qry_QuestionOptions">
				<tr>
				<td width="25"><input style="border:solid 1px Silver;" disabled type="checkbox" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"<cfif (UserAnswerDetails.recordcount) AND (TRIM(UserAnswerDetails.AnswerDetails) NEQ '') AND (ListFind(UserAnswerDetails.AnswerDetails, "#TRIM(qry_QuestionOptions.Option_Value)#"))> checked</cfif>></td>
				<td width="100%"> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<cfset thisOptionCount=(thisOptionCount+1)>
				<tr>
				<td colspan="2"><textarea style="border:solid 1px Silver;" disabled name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"><cfif (UserAnswerDetails.recordcount) AND (TRIM(UserAnswerDetails.AnswerDetails) NEQ '') AND (ListLen(UserAnswerDetails.Answer_other) GTE thisOptionCount)>#ListGetAt(UserAnswerDetails.Answer_other,  thisOptionCount,  ",")#</cfif></textarea><br><br></td>
				</tr>			
				</cfif>
				
				
				</cfloop>
				
				</table>
				
				
			
			
			<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Textarea'>
				<textarea style="border:solid 1px Silver;" disabled name="answer_#thisquestionnumber#" style="width:250px;" class="whitefield" rows="5"><cfif IsDefined("UserAnswerDetails.recordcount")>#TRIM(UserAnswerDetails.AnswerDetails)#</cfif></textarea>
			
			</cfif>
			
			</td>
			</tr>
			
			
			<cfif qry_sectionQuestions.Textarea>
			
			<tr>
			<td></td>
			<td></td>
			<td width="100%"><textarea style="border:solid 1px Silver;" disabled name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"><cfif IsDefined("UserAnswerDetails.recordcount")>#TRIM(UserAnswerDetails.Answer_Other)#</cfif></textarea></td>
			</tr>				
				
			</cfif>
			
			<cfif qry_secondaryQuestions.recordcount>
			
			
			<cfloop query="qry_secondaryQuestions">
			
			<tr>
			<td></td>
			<td colspan="2"><br><div style="border-top:dashed 1px Silver;">&nbsp;</div></td>
			</tr>
			
			<cfset thisquestionnumber=thisquestionnumber+1>			
			<cfset this_secondaryQuestionID=qry_secondaryQuestions.QuestionID>
			
			<cfquery name="SecondaryAnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT AnswerDetails, Answer_Other
			FROM NewSurvey_Answers
			WHERE UserID=#Session.UserID#
			AND QuestionaireID=#this_QuestionaireID#
			AND QuestionID=#this_secondaryQuestionID#
			</cfquery>
			
			<tr>
			<td valign="top"> </td>
			<td valign="top">#TRIM(qry_secondaryQuestions.Question_Name)#</td>
			<td valign="top" width="100%">
			
			<cfif qry_secondaryQuestions.Question_Type CONTAINS 'YesNo'>
			
				<table cellpadding="0" cellspacing="0" border="1" bordercolor="e2e2e2">
				<tr>
				<td width="50"><input style="border:solid 1px Silver;" disabled type="radio" name="answer_#thisquestionnumber#" value="1"<cfif (SecondaryAnswerDetails.recordcount) AND SecondaryAnswerDetails.AnswerDetails EQ 1> checked</cfif>> Yes</td>
				<td width="50"><input style="border:solid 1px Silver;" disabled type="radio" name="answer_#thisquestionnumber#" value="0"<cfif (SecondaryAnswerDetails.recordcount) AND SecondaryAnswerDetails.AnswerDetails EQ 0> checked</cfif>> No</td>
				</tr>
				</table>
			
			<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice_single'>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_secondaryQuestionID#
				ORDER BY Option_Order
				</cfquery>
			
				
				<table cellpadding="0" cellspacing="2" border="0">
				
				<cfset thisOptionCount=0>
				<cfloop query="qry_QuestionOptions">
				<tr>
				<td width="25"><input style="border:solid 1px Silver;" disabled type="radio" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"<cfif (SecondaryAnswerDetails.recordcount) AND (TRIM(SecondaryAnswerDetails.AnswerDetails) NEQ '') AND (ListFind(SecondaryAnswerDetails.AnswerDetails, "#TRIM(qry_QuestionOptions.Option_Value)#"))> checked</cfif>></td>
				<td width="100%"> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<cfset thisOptionCount=(thisOptionCount+1)>
				<tr>
				<td colspan="2"><textarea style="border:solid 1px Silver;" disabled name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"><cfif (SecondaryAnswerDetails.recordcount) AND (TRIM(SecondaryAnswerDetails.AnswerDetails) NEQ '') AND (ListLen(SecondaryAnswerDetails.Answer_other) GTE thisOptionCount)>#ListGetAt(SecondaryAnswerDetails.Answer_other,  thisOptionCount,  ",")#</cfif></textarea></td>
				</tr>				
				</cfif>
							
				</cfloop>
				
				</table>
				
				
			<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice'>
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_secondaryQuestionID#
				ORDER BY Option_Order
				</cfquery>
			
				
				<table cellpadding="0" cellspacing="2" border="0">
				
				<cfset thisOptionCount=0>
				<cfloop query="qry_QuestionOptions">
				<tr>
				<td width="25"><input style="border:solid 1px Silver;" disabled type="checkbox" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"<cfif (SecondaryAnswerDetails.recordcount) AND (TRIM(SecondaryAnswerDetails.AnswerDetails) NEQ '') AND (ListFind(SecondaryAnswerDetails.AnswerDetails, "#TRIM(qry_QuestionOptions.Option_Value)#"))> checked</cfif>></td>
				<td width="100%"> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<cfset thisOptionCount=(thisOptionCount+1)>
				<tr>
				<td colspan="2"><textarea style="border:solid 1px Silver;" disabled name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"><cfif (SecondaryAnswerDetails.recordcount) AND (TRIM(SecondaryAnswerDetails.AnswerDetails) NEQ '') AND (ListLen(SecondaryAnswerDetails.Answer_other) GTE thisOptionCount)>#ListGetAt(SecondaryAnswerDetails.Answer_other,  thisOptionCount,  ",")#</cfif></textarea></td>
				</tr>
				
				
				</cfif>
				
				
				</cfloop>
				
				</table>
				
			
			
			<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Textarea'>
				<textarea style="border:solid 1px Silver;" disabled name="answer_#thisquestionnumber#" style="width:250px;" class="whitefield" rows="5"><cfif IsDefined("SecondaryAnswerDetails.recordcount")>#TRIM(SecondaryAnswerDetails.AnswerDetails)#</cfif></textarea><br><br>
			
			</cfif>
			
			</td>
			</tr>
			
			<cfif qry_secondaryQuestions.Textarea>
			<tr>
			<td></td>
			<td></td>
			<td width="100%"><textarea style="border:solid 1px Silver;" disabled name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"><cfif IsDefined("SecondaryAnswerDetails.recordcount")>#TRIM(SecondaryAnswerDetails.Answer_other)#</cfif></textarea><br><br></td>
			</tr>			
			</cfif>
		
		
			</cfloop>
			
			
			</cfif>
			
			
					
			
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
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
		
	
	
	

	</td>
	</tr>
	
	</table>



</td>
</tr>
</form>
</table>
</cfoutput>