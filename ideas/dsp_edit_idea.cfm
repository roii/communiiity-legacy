<cfoutput>

<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT categoryID, Suggestion, Details
FROM Suggestion
WHERE SugID=#SugID#
</cfquery>

<cfquery name="selCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryID, Name
FROM SugCategory
WHERE Active = 1
ORDER BY Name ASC
</cfquery>

<script language="JavaScript">
<!--
function ValidateEditIdea(frmSuggestionInputForm){

if  (trim(frmSuggestionInputForm.selCategory.value) =="0"){
	alert("Please select a Topic!");
	frmSuggestionInputForm.selCategory.focus();
	return false;
}


else if(trim(frmSuggestionInputForm.txtareaDetails.value) == ""){
	alert("Please enter some details!");
	frmSuggestionInputForm.txtareaDetails.focus();
	return false;
}

else {
	frmSuggestionInputForm.submit(); //submit form
}
}
//-->
</script>


<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID = #sugID#
ORDER BY whenVoteMade DESC
</cfquery>
	
<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
<form name="frmSuggestionInputForm" action="#request.webroot#/ideas/act_edit_idea.cfm" method="post" onsubmit="ValidateEditIdea(frmSuggestionInputForm); return false;">

<input type="hidden" name="SugID" value="#SugID#">
<input type="hidden" name="Current_categoryID" value="#IdeaStuff.categoryID#">
<input type="hidden" name="Current_Details" value="#TRIM(IdeaStuff.Details)#">


<tr>
<td colspan="2"><span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>UPDATE YOUR IDEA</strong></span><br><br>
Using the feedback and comments you have received for this idea to date you can modify and "grow" it by adjusting the details below.<br><br>

<span style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><strong>PLEASE NOTE: &nbsp;You cannot change the "Summary" as this is how your idea is recognised by other members.</strong></span><br><br></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" width="125"><strong>Topic</strong></td>
<td><select name="selCategory" style="font-size:11px;width:295px;color:###TRIM(AllSettings.BoxColour)#;" class="whitefield">
<option value="0">Select a Topic</option>
<cfloop query="selCategory">
<option value="#selCategory.categoryID#"<cfif IdeaStuff.categoryID EQ selCategory.categoryID> selected</cfif>>#TRIM(selCategory.Name)#</option>
</cfloop>
</select></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" valign="top" width="125"><strong>Summary (120 max)</strong></td>
<td valign="top">#TRIM(IdeaStuff.Suggestion)#</td>
</tr>


<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" valign="top" width="125"><strong>Details</strong></td>
<td valign="top"><textarea name="txtareaDetails" style="font-size:11px;width:295px;color:###TRIM(AllSettings.BoxColour)#;" rows="12" class="whitefield">#TRIM(IdeaStuff.Details)#</textarea></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
</tr>

<tr>
<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr> 		
<td style="padding-right:10px;" valign="top" width="125"> </td>
<td valign="top"><input type="submit" value="Update Idea" class="whitefield"> &nbsp; <input type="button" value="Cancel" class="whitefield" onclick="javascript:history.back(-1);"></td>
</tr>

</form>

</table><br>


<table width="90%" cellpadding="0" cellspacing="0" border="0">
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height="25">
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;padding-left:10px;" colspan="4"><strong>Comments &amp; Votes...</strong></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;" width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="5" border="0"></td>
	<td width="100" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="5" border="0"></td>
	<td width="100" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="5" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="5" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;"><strong>When</strong></td>
	<td><strong>Who</strong></td>
	<td align="center"><strong>Vote</strong></td>
	<td><strong>Comments</strong></td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="AllVotes">
			
	<cfquery name="VoteBy" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, ScreenName
	FROM Contacts
	WHERE ContactID=#AllVotes.ContactID#
	</cfquery>
	
	<tr>
	<td valign="top" style="font-size:11px;padding-left:10px;">#DateFormat(AllVotes.whenVoteMade, "d-mmm-yyyy")#</td>
	<td valign="top" style="font-size:11px;"><cfif TRIM(VoteBy.ScreenName) NEQ ''>#TRIM(VoteBy.ScreenName)#<cfelse>#TRIM(VoteBy.FirstName)#</cfif></td>
	<td valign="top" style="font-size:11px;" align="center"><cfif AllVotes.Vote GTE 3>YES<cfelse>NO</cfif></td>
	<td valign="top" style="font-size:11px;">#TRIM(AllVotes.comments)#</td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	
	</cfloop>

	
	</table><br>


</cfoutput>