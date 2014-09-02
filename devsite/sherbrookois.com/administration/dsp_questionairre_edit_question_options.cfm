<cfoutput>

<script language="JavaScript">
<!--
function confirmQuestionOptionDelete(aURL) {
    if(confirm('Are you sure you want to delete this option?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<cfquery name="qry_QuestionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestions
WHERE QuestionID=#QuestionID#
</cfquery>

<cfquery name="qry_QuestionOptions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestionOptions
WHERE QuestionID=#QuestionID#
ORDER BY Option_Order
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
	<td>
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td class="small" valign="top"><strong>QUESTION OPTIONS &nbsp; &ndash; &nbsp; <span style="color:##444444;">"#TRIM(qry_QuestionStuff.Question_Name)#"</span></strong></td>
		<td class="small" align="right" width="100" valign="top"><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=addoption&QuestionID=#questionID#" style="text-decoration:none;color:##444444;">[ADD OPTION]</a></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td><hr width="100%" size="1" color="##e2e2e2">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
		<tr>
		<td class="small" valign="top">
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<cfif qry_QuestionOptions.RecordCount>
				
				<tr>
				<td width="25"><img src="#request.imageroot#/transparent_spc.gif" width="25" height="1" border="0"></td>
				<td width="100%"> </td>
				<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
				<td width="60"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"></td>
				</tr>
				
				<cfloop query="qry_QuestionOptions">
				<cfset this_QuestionOptionID=qry_QuestionOptions.QuestionOptionID>
				<tr>
				<td width="25" class="small">#qry_QuestionOptions.Option_Order#</td>
				<td class="small">#qry_QuestionOptions.Option_Name#</td>
				<td class="small"><cfif qry_QuestionOptions.Textarea><em>text</em><cfelse>&ndash;</cfif></td>
				<td align="right" style="color:##444444;text-decoration:none;" nowrap><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=editoption&QuestionID=#QuestionID#&QuestionOptionID=#this_QuestionOptionID#" style="color:##444444;text-decoration:none;">Edit</a> | <a 
	href="javascript:confirmQuestionOptionDelete('#request.webroot#/administration/act_questionairre_delete_option.cfm?QuestionID=#QuestionID#&QuestionOptionID=#this_QuestionOptionID#')" style="color:##444444;text-decoration:none;">Del.</a></td>
				</tr>
				
				<tr>
				<td colspan="4"><hr width="100%" size="1" color="##e2e2e2"></td>
				</tr>
			
				</cfloop>
			
			
			</cfif>
			
			
			
			</table>

		
			<a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_question_mode=view" style="color:##444444;">< return to question list</a>
		
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>



</td>
</tr>
	
</cfoutput>