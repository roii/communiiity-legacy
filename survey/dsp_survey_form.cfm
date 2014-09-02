<cfoutput>


<!--- GET QUESTIONAIRE SECTIONS --->
<cfquery name="qry_QuestionaireSections" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaireSections
WHERE QuestionaireID=#this_QuestionaireID#
AND Deleted=0
ORDER BY QuestionaireSection_number
</cfquery>

<cfset totalQuestions=0>

<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(QuestionForm) {    

if (QuestionForm.UserID.value == "") {
	alert("You must be logged-in to access this survey.");
	return;
	} 
	

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

	<cfloop query="qry_sectionQuestions">
			
		<cfset totalquestions=totalquestions+1>
		<cfset this_QuestionID = qry_sectionQuestions.QuestionID>
		<cfset this_QuestionNo = qry_sectionQuestions.Question_number>
		
		
		<cfif (qry_sectionQuestions.AnswerRequired EQ 1) AND (qry_sectionQuestions.Question_Type CONTAINS 'YesNo')>
		
			
			else if ((QuestionForm.answer_#totalquestions#[0].checked == false) && (QuestionForm.answer_#totalquestions#[1].checked == false)) {
			alert("You must select an answer for Question #this_QuestionNo#.");
			QuestionForm.answer_#totalquestions#[1].focus();
			return;
			}
		
		
		<cfelseif (qry_sectionQuestions.AnswerRequired EQ 1) AND (qry_sectionQuestions.Question_Type CONTAINS 'Multichoice')>
		
			<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT *
			FROM NewQuestionOptions
			WHERE QuestionID=#this_QuestionID#
			ORDER BY Option_Order
			</cfquery>
			
			else if (<cfloop query="qry_QuestionOptions"><cfset thisoption=(qry_QuestionOptions.currentrow-1)>(QuestionForm.answer_#totalquestions#[#thisoption#].checked == false)<cfif qry_QuestionOptions.currentrow NEQ qry_QuestionOptions.recordcount> && </cfif></cfloop>) {
			alert("You must select an answer for Question #this_QuestionNo#.");
			QuestionForm.answer_#totalquestions#[1].focus();
			return;
			}
		
		
		<cfelseif (qry_sectionQuestions.AnswerRequired EQ 1) AND (qry_sectionQuestions.Question_Type CONTAINS 'Multichoice_single')>
		
		
			<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT *
			FROM NewQuestionOptions
			WHERE QuestionID=#this_QuestionID#
			ORDER BY Option_Order
			</cfquery>
			
			else if (<cfloop query="qry_QuestionOptions"><cfset thisoption=(qry_QuestionOptions.currentrow-1)>(QuestionForm.answer_#totalquestions#[#thisoption#].checked == false)<cfif qry_QuestionOptions.currentrow NEQ qry_QuestionOptions.recordcount> && </cfif></cfloop>) {
			alert("You must select an answer for Question #this_QuestionNo#.");
			QuestionForm.answer_#totalquestions#[1].focus();
			return;
			}
		
		</cfif>
		
		
		
		<!--- CHECK FOR SUB QUESTIONS --->
		<cfquery name="qry_secondaryQuestions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT *
		FROM NewQuestions
		WHERE QuestionLevel LIKE '%secondary%'
		AND PrimaryQuestionID=#this_QuestionID#
		AND Deleted=0
		ORDER BY Question_number
		</cfquery>
		
		
		<cfif qry_secondaryQuestions.recordcount>
			
			
			<cfloop query="qry_secondaryQuestions">
		
			<cfset totalquestions=totalquestions+1>
			<cfset this_SubQuestionID=qry_secondaryQuestions.QuestionID>
		
			
			<cfif (qry_secondaryQuestions.AnswerRequired EQ 1) AND (qry_secondaryQuestions.Question_Type CONTAINS 'YesNo')>
		
				
				else if ((QuestionForm.answer_#totalquestions#[0].checked == false) && (QuestionForm.answer_#totalquestions#[1].checked == false)) {
				alert("You must select an answer for Question #this_QuestionNo#.");
				QuestionForm.answer_#totalquestions#[1].focus();
				return;
				}
		
			
			<cfelseif (qry_secondaryQuestions.AnswerRequired EQ 1) AND (qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice')>
			
				
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_SubQuestionID#
				ORDER BY Option_Order
				</cfquery>
				
				else if (<cfloop query="qry_QuestionOptions"><cfset thisoption=(qry_QuestionOptions.currentrow-1)>(QuestionForm.answer_#totalquestions#[#thisoption#].checked == false)<cfif qry_QuestionOptions.currentrow NEQ qry_QuestionOptions.recordcount> && </cfif></cfloop>) {
				alert("You must select an answer for Question #this_QuestionNo#.");
				QuestionForm.answer_#totalquestions#[1].focus();
				return;
				}
			
			
			<cfelseif (qry_secondaryQuestions.AnswerRequired EQ 1) AND (qry_secondaryQuestions.Question_Type CONTAINS 'Multichoice_single')>
			
			
				<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				SELECT *
				FROM NewQuestionOptions
				WHERE QuestionID=#this_SubQuestionID#
				ORDER BY Option_Order
				</cfquery>
				
				else if (<cfloop query="qry_QuestionOptions"><cfset thisoption=(qry_QuestionOptions.currentrow-1)>(QuestionForm.answer_#totalquestions#[#thisoption#].checked == false)<cfif qry_QuestionOptions.currentrow NEQ qry_QuestionOptions.recordcount> && </cfif></cfloop>) {
				alert("You must select an answer for Question #this_QuestionNo#.");
				QuestionForm.answer_#totalquestions#[1].focus();
				return;
				}
			
			</cfif>
		
			</cfloop>
		
		</cfif>
		
		
	</cfloop>
	
		
</cfloop>

else {
	QuestionForm.submit(); //submit form
	}
}
// -->
</script>
	
<span style="font-size:12px;color:444444;">		

<span style="font-size:14px;color:444444;"><strong>#TRIM(SurveyCheck.Questionaire_Name)#</strong></span><br><br>
<cfif TRIM(SurveyCheck.Questionaire_details) NEQ ''>#TRIM(SurveyCheck.Questionaire_details)#<br><br></cfif>



<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="e2e2e2">

<form method="post" action="#request.webroot#/survey/act_survey_form.cfm" name="QuestionForm"> 
<input type="hidden" name="QuestionaireID" value="#this_QuestionaireID#">
<input type="hidden" name="UserID" value="#Session.UserID#">
<input type="hidden" name="TotalSurveyQuestions" value="#totalquestions#">
<tr>
<td>


	<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="white">

	<tr>
	<td>
	
	
	
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
		<td><span style="font-size:12px;color:444444;"><strong>#qry_QuestionaireSections.QuestionaireSection_Name#</strong><br>
		#qry_QuestionaireSections.QuestionaireSection_Details#</span>
		
		<hr width="100%" size="1" color="e2e2e2">
		</td>
		</tr>
			
		<tr>
		<td>
		
		
			<table width="100%" cellpadding="2" cellspacing="0" border="0">
			
			<tr>
			<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
			<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
			<td width="100%"></td>
			</tr>
			
			
			<cfloop query="qry_sectionQuestions">
			
			<cfset thisquestionnumber=thisquestionnumber+1>
			
			<cfset this_QuestionID = qry_sectionQuestions.QuestionID>
			<cfset this_AccessQuestionID = qry_sectionQuestions.Access_QuestionID>
			
			<!--- CHECK FOR SUB QUESTIONS --->
			<cfquery name="qry_secondaryQuestions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
			SELECT *
			FROM NewQuestions
			WHERE QuestionLevel LIKE '%secondary%'
			AND PrimaryQuestionID=#this_QuestionID#
			AND Deleted=0
			ORDER BY Question_number
			</cfquery>
			
			
			<input type="hidden" name="questionID_#thisquestionnumber#" value="#this_QuestionID#">
			<input type="hidden" name="Access_QuestionID_#thisquestionnumber#" value="#this_AccessQuestionID#">
			<tr>
			<td valign="top"><span style="padding-top:2px;padding-bottom:2px;padding-left:4px;padding-right:4px;background-color:black;color:white;"><strong>#qry_sectionQuestions.Question_number#</strong></span></td>
			<td valign="top" style="color:##444444;">#TRIM(qry_sectionQuestions.Question_Name)#</td>
			<td valign="top">
			
			<cfif qry_sectionQuestions.Question_Type CONTAINS 'YesNo'>
			
				<table cellpadding="0" cellspacing="0" border="1" bordercolor="e2e2e2">
				<tr>
				<td width="50"><input type="radio" name="answer_#thisquestionnumber#" value="1"> Yes</td>
				<td width="50"><input type="radio" name="answer_#thisquestionnumber#" value="0"> No</td>
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
				
				<cfloop query="qry_QuestionOptions">
				<tr>
				<td width="25"><input type="radio" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"></td>
				<td width="100%"> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<tr>
				<td colspan="2"><textarea name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"> </textarea><br><br></td>
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
				
				<cfloop query="qry_QuestionOptions">
				<tr>
				<td width="25"><input type="checkbox" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"></td>
				<td> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<tr>
				<td colspan="2"><textarea name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"> </textarea><br><br></td>
				</tr>			
				</cfif>
				
				
				</cfloop>
				
				</table>
				
				
			
			
			<cfelseif qry_sectionQuestions.Question_Type CONTAINS 'Textarea'>
				<textarea name="answer_#thisquestionnumber#" style="width:250px;" class="whitefield" rows="5"> </textarea>
			
			</cfif>
			
			</td>
			</tr>
			
			
			<cfif qry_sectionQuestions.Textarea>
			
			<tr>
			<td></td>
			<td></td>
			<td><textarea name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"> </textarea></td>
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
			
			<input type="hidden" name="questionID_#thisquestionnumber#" value="#this_secondaryQuestionID#">
			<tr>
			<td valign="top"> </td>
			<td valign="top" style="color:444444;">#TRIM(qry_secondaryQuestions.Question_Name)#</td>
			<td valign="top">
			
			<cfif qry_secondaryQuestions.Question_Type CONTAINS 'YesNo'>
			
				<table cellpadding="0" cellspacing="0" border="1" bordercolor="e2e2e2">
				<tr>
				<td width="50"><input type="radio" name="answer_#thisquestionnumber#" value="1"> Yes</td>
				<td width="50"><input type="radio" name="answer_#thisquestionnumber#" value="0"> No</td>
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
				
				<cfloop query="qry_QuestionOptions">
				<tr>
				<td width="25"><input type="radio" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"></td>
				<td width="100%"> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<tr>
				<td colspan="2"><textarea name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"> </textarea></td>
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
				
				<cfloop query="qry_QuestionOptions">
				<tr>
				<td width="25"><input type="checkbox" name="answer_#thisquestionnumber#" class="whitefield" value="#TRIM(qry_QuestionOptions.Option_Value)#"></td>
				<td width="100%"> #TRIM(qry_QuestionOptions.Option_Name)#</td>
				</tr>
				
				<cfif qry_QuestionOptions.Textarea>
				<tr>
				<td colspan="2"><textarea name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"> </textarea></td>
				</tr>
				
				
				</cfif>
				
				
				</cfloop>
				
				</table>
				
			
			
			<cfelseif qry_secondaryQuestions.Question_Type CONTAINS 'Textarea'>
				<textarea name="answer_#thisquestionnumber#" style="width:250px;" class="whitefield" rows="5"> </textarea><br><br>
			
			</cfif>
			
			</td>
			</tr>
			
			<cfif qry_secondaryQuestions.Textarea>
			<tr>
			<td></td>
			<td></td>
			<td><textarea name="answer_#thisquestionnumber#_other" style="width:250px;" class="whitefield" rows="5"> </textarea><br><br></td>
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
		
		
		
		<tr>
		<td><div align="center"><input type="submit" class="whitefield" value="Submit Your Answers" onclick="validate(QuestionForm); return false;"><cfif TRIM(SurveyCheck.Questionaire_enddetails) NEQ ''><br><br><br>
#TRIM(SurveyCheck.Questionaire_enddetails)#</cfif></div></td>
		</tr>
		
		
		</table><br>
	
	
	

	</td>
	</tr>
	
	</table>



</td>
</tr>
</form>
</table>
</cfoutput>