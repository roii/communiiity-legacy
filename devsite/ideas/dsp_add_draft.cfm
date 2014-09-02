<cfoutput>


<cfquery name="selCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryID, Name
FROM SugCategory
WHERE Active=1
ORDER BY Name ASC
</cfquery>

<script language="JavaScript">

function ValidateAddIdea(frmSuggestionInputForm){

if  (trim(frmSuggestionInputForm.selCategory.value) =="0"){
	alert("Please select a Topic!");
	frmSuggestionInputForm.selCategory.focus();
	return false;
}


else if(trim(frmSuggestionInputForm.txtareaSuggestion.value) == ""){
	alert("Please enter your idea!");
	frmSuggestionInputForm.txtareaSuggestion.focus();
	return false;
}

else {
	frmSuggestionInputForm.submit(); //submit form
}
}
</script>
	
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
<form name="frmSuggestionInputForm" action="#request.webroot#/ideas/act_add_draft.cfm" method="post">
	
<tr>
<td colspan="2"><span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>ADD A DRAFT IDEA</strong></span><br><br>
You can spend as much time as you need to get your draft ideas just right and when you're ready to submit them to the IDEAfunL just click the "submit this draft idea" link!<br><br>

<span style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><strong>PLEASE NOTE: &nbsp;Once you have submitted your idea you will no longer be able to edit the "Summary" but you will be able to edit the "Details".</strong></span><br><br></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" width="125"><strong>Topic</strong></td>
<td><select name="selCategory" style="font-size:11px;width:300px;color:###TRIM(AllSettings.BoxColour)#;" class="whitefield">
<option value="0">Select a Topic</option>
<cfloop query="selCategory">
<option value="#selCategory.categoryID#">#TRIM(selCategory.Name)#</option>
</cfloop>
</select></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" valign="top" width="125"><strong>Summary (120 max)</strong></td>
<td valign="top"><input type="text" name="txtareaSuggestion" style="font-size:11px;width:295px;color:###TRIM(AllSettings.BoxColour)#;" maxlength="120" class="whitefield"></td>
</tr>


<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" valign="top" width="125"><strong>Details</strong></td>
<td valign="top"><textarea name="txtareaDetails" style="font-size:11px;width:295px;color:###TRIM(AllSettings.BoxColour)#;" rows="12" class="whitefield"></textarea></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr>
<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" valign="top" width="125"> </td>
<td valign="top"><input type="submit" value="Save Draft Idea" onclick="javascript:ValidateAddIdea(frmSuggestionInputForm); return false;" class="whitefield"> &nbsp; <input type="button" value="Cancel" onclick="javascript:history.back(-1);" class="whitefield"></td>
</tr>

</form>

</table>


</cfoutput>