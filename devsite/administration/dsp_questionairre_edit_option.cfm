<cfoutput>

<cfquery name="qry_QuestionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestions
WHERE QuestionID=#QuestionID#
</cfquery>

<cfquery name="qry_OptionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestionOptions
WHERE QuestionOptionID=#QuestionOptionID#
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
		<td class="small"><strong>EDIT MULTI-CHOICE QUESTION OPTION:</strong><br>
		#TRIM(qry_QuestionStuff.Question_Name)#</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td colspan="4"><hr width="100%" size="1" color="##e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="details_form" method="post" action="#request.webroot#/administration/act_questionairre_edit_option.cfm">
	
	<input type="hidden" name="QuestionID" value="#QuestionID#">
	<input type="hidden" name="QuestionOptionID" value="#QuestionOptionID#">
	
	
	<tr>
	<td width="130"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
	<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
	<td width="100%"></td>
	</tr>	
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right"><strong>Option Number:</strong></td>
	<td></td>
	<td class="small"><input name="Option_order" type="text" class="whitefield" style="width:50px;" value="#TRIM(qry_OptionStuff.option_order)#"></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Option:</strong></td>
	<td></td>
	<td valign="top" class="small"><textarea name="Option_Name" type="text" class="whitefield" style="width:450px;" rows="4">#TRIM(qry_OptionStuff.Option_Name)#</textarea></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td class="small" style="padding-left:8px;color:##444444;" align="right" valign="top"><strong>Include Text Box:</strong></td>
	<td></td>
	<td class="small" valign="top"><input name="Textarea" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="0"<cfif qry_OptionStuff.Textarea EQ 0> checked</cfif>> No<br>
	<input name="Textarea" type="radio" class="whitefield" style="border:solid 1px Silver;background-color:##e2e2e2;" value="1"<cfif qry_OptionStuff.Textarea> checked</cfif>> Yes</td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td colspan="3" align="right"><input type="submit" class="whitefield" value="UPDATE NOW >>">&nbsp; &nbsp;<input type="button" class="whitefield" value="CANCEL" onclick="javascript:location='#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=edit_options&questionID=#questionID#';"></td>
	</tr>
	
	</form>
	
	</table>
	
	</td>
	</tr>

	
	
	
	</table>



</td>
</tr>
	
</cfoutput>