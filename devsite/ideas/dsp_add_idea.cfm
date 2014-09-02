<cfoutput>


<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(addform) {    

if (addform.Title.value == "") {
	alert("You must enter a Title for this project.");
	addform.Title.focus();
	return;
	} 
	
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	addform.submit(); //submit form
	}
}
// -->
</script>

<cfparam name="AddIdeaMode" default="1">


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Add an Idea</title>
	
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="##ffffff">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>iDEAfunL - Add an Idea</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
<cfif AddIdeaMode EQ 1>
	
	
<script>
function validate(frmSuggestion) {    

if (frmSuggestion.rate1.selectedIndex == "0") {
	alert("You must vote on Idea 1.");
	frmSuggestion.rate1.focus();
	return;
	}

	
else if (frmSuggestion.rate2.selectedIndex == "0") {
	alert("You must vote on Idea 2.");
	frmSuggestion.rate2.focus();
	return;
	}

	
else if (frmSuggestion.rate3.selectedIndex == "0") {
	alert("You must vote on Idea 3.");
	frmSuggestion.rate3.focus();
	return;
	}

else {
	frmSuggestion.submit(); //submit form
	}
	
	
}
</script>
	
	<!--- QUERY FOR UN-AUTHORISED WITH 1 VOTE --->
	<cfquery name="AllUnauthorised_1" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.SUGID, suggestion.suggestion, count(sugvote.vote) as voteReceived
	FROM suggestion, sugvote
	WHERE suggestion.Authorise='No'
	AND suggestion.Archived=0
	AND suggestion.sugID=sugvote.sugID
	AND count(sugvote.vote) LT 2
	ORDER BY suggestion.WhenSugMade
	</cfquery>
	
	<form name="frmSuggestion" action="#request.webroot#/ideas/act_add_idea_vote.cfm" method="post">
	
	
	<!--- checkbox identify --->
	<cfset selectBoxCount = 0>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2" style="color:###TRIM(AllSettings.BoxColour)#;font-size:12px;"><strong>STEP 1<span style="color:###TRIM(AllSettings.DKTextColor)#;">&nbsp; -&nbsp; Vote on 3 pending Ideas</span></strong></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2">
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
		<tr>
		<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		
		<cfloop query="AllUnauthorised">
		
		
		<!--- check if user has been vote for this current suggestion --->
		<cfquery datasource="#dsn#"  name="isUserVote" username="#request.username#" password="#request.password#">
		SELECT *
		FROM SugVote
		WHERE sugID = #AllUnauthorised.sugID#
		AND ContactID=#session.UserID#
		</cfquery>
		
		<cfif NOT isUserVote.recordCount>
		
		<cfset selectBoxCount = selectBoxCount  + 1>
		<input type="hidden" name="sugID#selectBoxCount#" value="#AllUnauthorised.sugID#">
		
		<tr>
		<td width="20" valign="top"><strong>#selectBoxCount#.</strong></td>
		<td width="*" style="padding-left:5px;padding-right:20px;" valign="top">#suggestion#</td>
		<td nowrap valign="top"><select style="font-size:10px;" name="rate#selectBoxCount#">
		<option value="0">Select</option>
		<option value="1">It stinks</option>
		<option value="2">Not so good</option>
		<option value="3">It's OK</option>
		<option value="4">It's good</option>
		<option value="5">It's a winner!</option>
		</select></td>
		</tr>
		
		<tr>
		<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		</cfif>
		
		<cfif selectBoxCount EQ 3>
			<cfbreak>
		</cfif>
		</cfloop>
		
		</table>
	
	

	</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td class="small"><br><input type="submit" onClick="validate(frmSuggestion); return false;" value="VOTE NOW" style="font-size:10px;"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL" style="font-size:10px;"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>	
	
	</table>
	</form>	



<cfelseif AddIdeaMode EQ 2>
	
	<script language="JavaScript">

	function ValidateAddIdea(frmSuggestionInputForm){
	var email = frmSuggestionInputForm.txtEmail.value;
	var at = email.indexOf("@");		
	var space = email.indexOf(" ");
	var comma = email.indexOf(",");
	var dot = email.indexOf(".");
	var two_dots = email.indexOf("..");
	var length = email.length -1;
	
	if(email != ""){
		if((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
		alert("Please enter a valid Email Address.");
		frmSuggestionInputForm.txtEmail.value = email;
		frmSuggestionInputForm.txtEmail.focus();
		return false;
		}
	} 
	
	if(trim(frmSuggestionInputForm.selCategory.value) =="0"){
		alert("Please select a suggestion category!");
		frmSuggestionInputForm.selCategory.focus();
		return false;
	}
	
	
	else if(trim(frmSuggestionInputForm.txtareaSuggestion.value) == ""){
		alert("Please enter your suggestion!");
		frmSuggestionInputForm.txtareaSuggestion.focus();
		return false;
	}

	else {
		frmSuggestionInputForm.submit(); //submit form
	}
	</script>


	<cfquery name="selCategory" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
	SELECT CategoryID, Name
	FROM SugCategory
	WHERE whenCategoryEnded IS NULL
    AND Active=1
	ORDER BY Name ASC
	</cfquery>
	
	<form name="frmSuggestionInputForm" action="#request.webroot#/ideas/act_add_idea.cfm" method="post">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2" style="color:###TRIM(AllSettings.BoxColour)#;font-size:12px;"><strong>STEP 2<span style="color:###TRIM(AllSettings.DKTextColor)#;">&nbsp; -&nbsp; Enter your Idea</span></strong></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2">
	
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr> 			
		<td align="right" style="padding-right:10px;"><strong>Email</strong></td>		
		<td><input type="text" name="txtEmail" class="field" style="width:250px;" <cfif session.UserIsAuthenticated EQ "yes">value="#session.user_email#"</cfif>></td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr> 		
		<td align="right" style="padding-right:10px;"><strong>Category</strong></td>
		<td><select name="selCategory" class="field" style="width:250px;">
		<option value="0">Select a Suggestion Category</option>
		<cfloop query="selCategory">
        
        <!--- GET IDEAfunL SETTINGS --->
        <cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
        SELECT *
        FROM IdeaFunl_Settings
        </cfquery>
        
        <cfquery name="qry_current_topic" datasource="#dsn#" username="#request.username#" password="#request.password#">
        SELECT *
        FROM SugCategory
        <cfif IsNumeric("#selCategory.categoryID#")>
        	WHERE CategoryID=#selCategory.categoryID#
       </cfif>
        </cfquery>
        
        <cfquery name="qry_all_category_suggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
        SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
        FROM suggestion, SugVote
        WHERE suggestion.SugID=SugVote.SugID
        AND suggestion.Authorise = 'yes'
        AND suggestion.Archived=0
        AND suggestion.categoryID=#selCategory.categoryID#
        AND (suggestion.SugStage LIKE '%Stage 1%' OR suggestion.SugStage LIKE '%Stage 2%' OR suggestion.SugStage LIKE '%Stage 3%')	
        GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
        ORDER BY voteReceived DESC
        </cfquery>
        
        <cfset activityid = 2>
        
        <cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
        SELECT SugID
        FROM Suggestion
        WHERE CategoryID=#selCategory.categoryID#
        AND Authorise LIKE '%No%'
        AND Archived = 0
        GROUP BY SugID
        </cfquery>
        		
        <cfif qry_all_category_suggestions.RecordCount>
        	<cfset ThisCatideas = valueList(qry_all_category_suggestions.SugID)>
        <cfelse>
        	<cfset ThisCatideas = "0">		
        </cfif>
        
        <cfif AllCat_InActiveIdeas.RecordCount>
        	<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
        </cfif>
        
        <cfquery name="AllPointsEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
        SELECT Count(Transaction_Amount) AS TotalPointsEarned
        FROM contact_transactions
        WHERE (Related_Description LIKE '%AddIdea%'
        OR Related_Description LIKE '%Vote%'
        OR Related_Description LIKE '%VoteComments%'
        OR Related_Description LIKE '%IdeaStage1%'
        OR Related_Description LIKE '%IdeaStage2%'
        OR Related_Description LIKE '%IdeaStage3%'
        OR Related_Description LIKE '%IdeaStage4%'
        OR Related_Description LIKE '%IdeaStage5%')
        AND Related_Identifier IN (#ThisCatideas#)
        AND Transaction_Type LIKE '%Credit%'
        AND Transaction_Account LIKE '%Points%'
        </cfquery>
        
        <cfset this_pointsremaining = INT(qry_current_topic.PointsAllocated - AllPointsEarned.TotalPointsEarned)>
        
        <cfif this_pointsremaining GT 0 AND IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>
		<option value="#selCategory.categoryID#">#TRIM(selCategory.Name)#</option>
        </cfif>
		</cfloop>
		</select></td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr> 		
		<td align="right" style="padding-right:10px;" valign="top"><strong>Suggestion</strong></td>
		<td valign="top"><textarea name="txtareaSuggestion" class="field" style="width:250px;" rows="8"></textarea></td>
		</tr>
		<tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr> 		
		<td align="right"></td>
		<td><input type="submit" onClick="ValidateAddIdea(frmSuggestionInputForm); return false;" value="SUBMIT YOUR IDEA" class="field"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL" class="field"></td>
		</tr>
		<tr>
		
		</table>
		
		
	</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	</table>
	
	</form>
	
</cfif>


</td>
</tr>

</table>

</body>
</html>

</cfoutput>