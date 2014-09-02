<cfoutput>

<cfquery name="qry_QuestionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestions
WHERE QuestionID=#QuestionID#
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
		<td class="small"><strong>EDIT QUESTION</strong></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="##e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="details_form" method="post" action="#request.webroot#/administration/act_questionairre_edit_question.cfm">
	
	<input type="hidden" name="QuestionID" value="#QuestionID#">
	
	<tr>
	<td width="130"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
	<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
	<td width="100%"></td>
	</tr>	
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right"><strong>Question Number:</strong></td>
	<td></td>
	<td class="small"><input name="Question_number" type="text" class="whitefield" style="width:50px;" value="#TRIM(qry_QuestionStuff.Question_number)#"></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Question:</strong></td>
	<td></td>
	<td valign="top" class="small"><textarea name="Question_Name" type="text" class="whitefield" style="width:450px;" rows="4">#TRIM(qry_QuestionStuff.Question_Name)#</textarea></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>	
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right" valign="top"><strong>Question Type:</strong></td>
	<td></td>
	<td class="small" valign="top"><input name="Question_Type" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="YesNo"<cfif TRIM(qry_QuestionStuff.Question_Type) EQ 'YesNo'> checked</cfif>> Yes / No<br>
	<input name="Question_Type" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="Multichoice_single"<cfif TRIM(qry_QuestionStuff.Question_Type) EQ 'Multichoice_single'> checked</cfif>> Multi-choice - Single Answer<br>
	<input name="Question_Type" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="Multichoice"<cfif TRIM(qry_QuestionStuff.Question_Type) EQ 'Multichoice'> checked</cfif>> Multi-choice - Multiple Answer<br>
	<input name="Question_Type" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="Textarea"<cfif TRIM(qry_QuestionStuff.Question_Type) EQ 'Textarea'> checked</cfif>> Text Answer<br>
	<input name="Question_Type" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="NA"<cfif TRIM(qry_QuestionStuff.Question_Type) EQ 'NA'> checked</cfif>> No Answer Required</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right" valign="top"><strong>Include Text Box:</strong></td>
	<td></td>
	<td class="small" valign="top"><input name="Textarea" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="0"<cfif TRIM(qry_QuestionStuff.Textarea) EQ 0> checked</cfif>> No<br>
	<input name="Textarea" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="1"<cfif TRIM(qry_QuestionStuff.Textarea) EQ 1> checked</cfif>> Yes</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right" valign="top"><strong>Answer Required:</strong></td>
	<td></td>
	<td class="small" valign="top"><input name="AnswerRequired" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="0"<cfif TRIM(qry_QuestionStuff.AnswerRequired) EQ 0> checked</cfif>> No<br>
	<input name="AnswerRequired" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="1"<cfif TRIM(qry_QuestionStuff.AnswerRequired) EQ 1> checked</cfif>> Yes</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right"><strong>Matching QuestionID:</strong></td>
	<td></td>
	<td class="small" style="color:##444444;"><input name="Access_QuestionID" type="text" class="whitefield" style="width:50px;" value="#qry_QuestionStuff.Access_QuestionID#"> &nbsp; (Needs to match the QuestionID in the ACCESS database we're exporting to)</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td colspan="3" align="right"><input type="submit" class="whitefield" value="UPDATE NOW >>">&nbsp; &nbsp;<input type="button" class="whitefield" value="CANCEL" onclick="javascript:location='#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=view';"></td>
	</tr>
	
	</form>
	
	</table>
	
	</td>
	</tr>

	
	
	
	</table>



</td>
</tr>
	
</cfoutput>