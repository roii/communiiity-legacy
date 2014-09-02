<cfoutput>

<script language="JavaScript">
<!--
function confirmQuestionDelete(aURL) {
    if(confirm('Are you sure you want to delete this question?')) {
      location.href = aURL;
    }
  }
//-->
</script>
	
<cfquery name="qry_sectionQuestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestions
WHERE QuestionaireSectionID=#session.current_section#
AND QuestionLevel='primary'
AND Deleted=0
ORDER BY Question_number
</cfquery>

	

<tr>
<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td></td>
<td></td>
<td colspan="2" bgcolor="silver" style="padding:8px;" class="small">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="4">
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td class="small"><strong>SECTION QUESTIONS</strong></td>
		<td class="small" align="right"><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=add&QuestionaireSectionID=#session.current_section#&questionlevel=primary" style="text-decoration:none;color:##444444;">[ADD QUESTION]</a></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>

	
	<cfloop query="qry_sectionQuestions">
			
	<cfset this_QuestionID = qry_sectionQuestions.QuestionID>
	<cfset this_QuestionNo = qry_sectionQuestions.Question_number>
	
	<!--- CHECK FOR SUB QUESTIONS --->
	<cfquery name="qry_secondaryQuestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM NewQuestions
	WHERE QuestionLevel LIKE '%secondary%'
	AND PrimaryQuestionID=#this_QuestionID#
	AND Deleted=0
	ORDER BY Question_number
	</cfquery>
	
	<tr>
	<td valign="top" class="small" width="40" align="center"><div style="width:22px;height:19px;padding-top:2px;padding-bottom:2px;padding-left:4px;padding-right:4px;background-color:##e2e2e2;color:black;"><strong>#qry_sectionQuestions.Question_number#</strong></span></td>
	<td valign="top" class="small" style="padding-right:20px;"><a name="Q#this_QuestionID#">#TRIM(qry_sectionQuestions.Question_Name)#</a></td>
	<td valign="top" class="small" width="120" style="padding-right:20px;"><cfif TRIM(qry_sectionQuestions.Question_Type) EQ 'YesNo'>Yes / No<cfelseif TRIM(qry_sectionQuestions.Question_Type) EQ 'Multichoice_single'><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&QuestionID=#this_QuestionID#" style="color:##444444;">Multi-choice</a><br><em>(Single answer)</em><cfelseif TRIM(qry_sectionQuestions.Question_Type) EQ 'Multichoice'><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&QuestionID=#this_QuestionID#" style="color:##444444;">Multi-choice</a><br><em>(Multiple answer)</em><cfelseif TRIM(qry_sectionQuestions.Question_Type) EQ 'textarea'>Text Answer<cfelse><em>No answer required</em></cfif></td>
	<td valign="top" align="right" width="60" nowrap><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit&QuestionID=#this_QuestionID#" style="color:##444444;text-decoration:none;">Edit</a> | <a 
	href="javascript:confirmQuestionDelete('#request.webroot#/administration/act_questionairre_question_delete.cfm?QuestionID=#this_QuestionID#')" style="color:##444444;text-decoration:none;">Del.</a> <cfif session.current_question EQ this_QuestionID><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question=0&##Q#this_QuestionID#"><img src="#request.imageroot#/icon_contract.gif" alt="Close Sub-Questions" border="0"></a><cfelse><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question=#this_QuestionID#&##Q#this_QuestionID#"><img src="#request.imageroot#/icon_expand.gif" alt="Display Sub-Questions" border="0"></a></cfif></td>
	</tr>
	
	
	
	
	<cfif session.current_question EQ this_QuestionID>
			
		<tr>
		<td></td>
		<td colspan="3"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr>
		<td></td>
		<td colspan="3" bgcolor="##e2e2e2"><br>
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td class="small" style="padding-left:5px;"><strong>SUB-QUESTIONS</strong></td>
			<td class="small" align="right" style="padding-right:5px;"><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=add&QuestionaireSectionID=#session.current_section#&questionlevel=secondary&PrimaryQuestionID=#this_QuestionID#" style="text-decoration:none;color:##444444;">[ADD SUB-QUESTION]</a></td>
			</tr>
			
			</table>
		
		</td>
		</tr>
		
		<tr>
		<td></td>
		<td colspan="3" bgcolor="##e2e2e2"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		
		<cfloop query="qry_secondaryQuestions">
		<cfset thisSubQuestionID = qry_secondaryQuestions.QuestionID>
		
		<tr>
		<td></td>
		<td class="small" bgcolor="##e2e2e2" style="padding-left:5px;">#TRIM(qry_secondaryQuestions.Question_Name)#</td>
		<td class="small" bgcolor="##e2e2e2" style="padding-left:5px;"><cfif TRIM(qry_secondaryQuestions.Question_Type) EQ 'YesNo'>Yes / No<cfelseif TRIM(qry_secondaryQuestions.Question_Type) EQ 'Multichoice_single'><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&QuestionID=#thisSubQuestionID#" style="color:##444444;">Multi-choice</a><br><em>(Single answer)</em><cfelseif TRIM(qry_secondaryQuestions.Question_Type) EQ 'Multichoice'><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&QuestionID=#thisSubQuestionID#" style="color:##444444;">Multi-choice</a><br><em>(Multiple answer)</em><cfelseif TRIM(qry_secondaryQuestions.Question_Type) EQ 'textarea'>Text Answer<cfelse><em>No answer required</em></cfif></td>
		<td align="right" bgcolor="##e2e2e2" style="padding-right:5px;"><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit&QuestionID=#thisSubQuestionID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Question" border="0"></a> <a 
	href="javascript:confirmQuestionDelete('#request.webroot#/administration/act_questionairre_question_delete.cfm?QuestionID=#thisSubQuestionID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Question" border="0"></a></td>
		</tr>
		
		<cfif qry_secondaryQuestions.currentrow NEQ qry_secondaryQuestions.recordcount>
		
			<tr>
			<td></td>
			<td colspan="3" bgcolor="##e2e2e2"><hr width="100%" size="1" color="silver"></td>
			</tr>
		
		<cfelse>
		
			<tr>
			<td></td>
			<td colspan="3" bgcolor="##e2e2e2"><br></td>
			</tr>
		
		</cfif>
		
		</cfloop>
		<tr>
		<td></td>
		<td colspan="3"><br></td>
		</tr>
	
	</cfif>
	
	
	
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	
	</cfloop>
	
	</table>



</td>
</tr>
	
</cfoutput>