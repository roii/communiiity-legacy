<cfoutput>

<script language="JavaScript">
	<!--
	function confirmSectionDelete(aURL) {
	    if(confirm('Deleting this section will also delete\nALL QUESTIONS linked to this section.\n\nAre you sure you want to delete this section?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	

<tr>
<td bgcolor="silver" style="padding:2px;">

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td class="normal"><strong>&nbsp;QUESTIONNAIRE SECTIONS</strong></td>
	<td align="right" style="padding-right:2px;" class="small"><cfif session.current_section_mode NEQ 'add'><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section_mode=add" style="text-decoration:none;color:##444444;">[ADD SECTION]</a></cfif></td>
	</tr>
	
	</table>
	
			
</td>
</tr>


<cfif session.current_section_mode EQ 'add'>

	<!--- CREATE NEXT SECTION NUMBER --->
	<cfquery name="LastNumber" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
	SELECT QuestionaireSection_number
	FROM NewQuestionaireSections
	WHERE QuestionaireID=#session.Edit_QuestionaireID#
	AND Deleted=0
	ORDER BY QuestionaireSection_number DESC
	</cfquery>
	
	<cfif LastNumber.RecordCount>
		<cfset insert_nextnumber=(LastNumber.QuestionaireSection_number+1)>
	<cfelse>
		<cfset insert_nextnumber=1>
	</cfif>
	
	<tr>
	<td><br>
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<form name="details_form" method="post" action="#request.webroot#/administration/act_questionairre_add_section.cfm">
		
		<input type="hidden" name="QuestionaireID" value="#session.Edit_QuestionaireID#">
		
		<tr>
		<td width="130"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
		<td width="100%"></td>
		</tr>
			
		<tr>
		<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Section Name:</strong></td>
		<td></td>
		<td valign="top" class="small"><input name="QuestionaireSection_Name" type="text" class="whitefield" style="width:450px;"></td>
		</tr>
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		<tr>
		<td class="small" align="right" style="padding-left:8px;color:##444444;" valign="top"><strong>Details:</strong></td>
		<td></td>
		<td valign="top"><textarea name="QuestionaireSection_Details" class="whitefield" style="width:450px;" rows="6"></textarea></td>
		</tr>
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		<tr>
		<td class="small" style="padding-left:8px;color:##444444;" align="right"><strong>Section Number:</strong></td>
		<td></td>
		<td class="small"><input name="QuestionaireSection_number" type="text" class="whitefield" style="width:150px;" value="#insert_nextnumber#"></td>
		</tr>
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		<tr>
		<td colspan="3" align="right"><input type="submit" class="whitefield" value="ADD NOW >>">&nbsp; &nbsp;<input type="button" class="whitefield" value="CANCEL" onclick="javascript:location='#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section_mode=view';"></td>
		</tr>
		
		</form>
		
		</table>
	
	
	</td>
	</tr>

<cfelseif session.current_section_mode EQ 'edit' AND IsDefined("QuestionaireSectionID")>


	<!--- GET SECTION DETAILS --->
	<cfquery name="qry_SectionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM NewQuestionaireSections
	WHERE QuestionaireSectionID=#QuestionaireSectionID#
	</cfquery>
	
	
	<tr>
	<td><br>
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<form name="details_form" method="post" action="#request.webroot#/administration/act_questionairre_edit_section.cfm">
		
		<input type="hidden" name="QuestionaireSectionID" value="#QuestionaireSectionID#">
		
		<tr>
		<td width="130"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
		<td width="100%"></td>
		</tr>
			
		<tr>
		<td class="small" style="padding-left:8px;color:##444444;" valign="top" align="right"><strong>Section Name:</strong></td>
		<td></td>
		<td valign="top" class="small"><input name="QuestionaireSection_Name" type="text" class="whitefield" style="width:450px;" value="#TRIM(qry_SectionStuff.QuestionaireSection_Name)#"></td>
		</tr>
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		<tr>
		<td class="small" align="right" style="padding-left:8px;color:##444444;" valign="top"><strong>Details:</strong></td>
		<td></td>
		<td valign="top"><textarea name="QuestionaireSection_Details" class="whitefield" style="width:450px;" rows="6">#TRIM(qry_SectionStuff.QuestionaireSection_Details)#</textarea></td>
		</tr>
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		<tr>
		<td class="small" style="padding-left:8px;color:##444444;" align="right"><strong>Section Number:</strong></td>
		<td></td>
		<td class="small"><input name="QuestionaireSection_number" type="text" class="whitefield" style="width:150px;" value="#TRIM(qry_SectionStuff.QuestionaireSection_number)#"></td>
		</tr>
		
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		<tr>
		<td colspan="3" align="right"><input type="submit" class="whitefield" value="UPDATE NOW >>">&nbsp; &nbsp;<input type="button" class="whitefield" value="CANCEL" onclick="javascript:location='#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section_mode=view';"></td>
		</tr>
		
		</form>
		
		</table>
	
	
	</td>
	</tr>


<cfelse>


	<!--- GET QUESTIONAIRE SECTIONS --->
	<cfquery name="qry_QuestionaireSections" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM NewQuestionaireSections
	WHERE QuestionaireID=#session.Edit_QuestionaireID#
	AND Deleted=0
	ORDER BY QuestionaireSection_number
	</cfquery>
	
	
	<tr>
	<td><br>
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
		<td></td>
		<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
		</tr>
		
		<cfloop query="qry_QuestionaireSections">
		
		<cfset this_QuestionaireSectionID = qry_QuestionaireSections.QuestionaireSectionID>
		
			
		<tr>
		<td width="10"></td>
		<td width="20"><img src="#request.imageroot#/icon_relatedresource_doc.gif" width="8" height="9" border="0"></td>
		<td class="small">#TRIM(qry_QuestionaireSections.QuestionaireSection_Name)#</td>
		<td align="right" style="padding-right:6px;"><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section_mode=edit&QuestionaireSectionID=#this_QuestionaireSectionID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Section" border="0"></a> <a 
		href="javascript:confirmSectionDelete('#request.webroot#/administration/act_questionairre_section_delete.cfm?QuestionaireSectionID=#this_QuestionaireSectionID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Section" border="0"></a> <cfif session.current_section EQ this_QuestionaireSectionID><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section=0"><img src="#request.imageroot#/icon_contract.gif" alt="Close Questions" border="0"></a><cfelse><a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?current_section=#this_QuestionaireSectionID#"><img src="#request.imageroot#/icon_expand.gif" alt="Display Questions" border="0"></a></cfif></td>
		</tr>
		
		
		<cfif session.current_section EQ this_QuestionaireSectionID>
		
			<cfif session.current_question_mode EQ 'view'>
				<cfinclude template="dsp_questionairre_edit_listquestions.cfm">
				
			<cfelseif session.current_question_mode EQ 'add'>
				<cfinclude template="dsp_questionairre_add_question.cfm">
				
			<cfelseif session.current_question_mode EQ 'edit'>
				
				<cfif IsDefined("QuestionID")>
					<cfinclude template="dsp_questionairre_edit_question.cfm">
				<cfelse>
					<cfinclude template="dsp_questionairre_edit_listquestions.cfm">
				</cfif>
				
			<cfelseif session.current_question_mode EQ 'edit_options'>
				
				<cfif IsDefined("QuestionID")>
					<cfinclude template="dsp_questionairre_edit_question_options.cfm">
				<cfelse>
					<cfinclude template="dsp_questionairre_edit_listquestions.cfm">
				</cfif>
				
			<cfelseif session.current_question_mode EQ 'editoption'>
				
				<cfinclude template="dsp_questionairre_edit_option.cfm">
				
			<cfelseif session.current_question_mode EQ 'addoption'>
				
				<cfinclude template="dsp_questionairre_add_option.cfm">
				
			</cfif>
			
			
		</cfif>
		
		
		
		<tr>
		<td colspan="4"><hr width="100%" size="1" color="silver"></td>
		</tr>
		
		</cfloop>
		
		</table>
	
	</td>
	</tr>


</cfif>



</cfoutput>