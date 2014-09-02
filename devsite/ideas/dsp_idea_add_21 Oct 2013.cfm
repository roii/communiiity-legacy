<cfoutput>

<cfquery name="selected_maincat" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT MainCatID, MainCatTitle
FROM SugMainCategory
<cfif IsDefined("session.MainCatID") AND IsNumeric("#session.MainCatID#")>
	WHERE MainCatID=#session.MainCatID#
<cfelseif IsDefined("MainCatID") AND IsNumeric("#MainCatID#")>
	WHERE MainCatID=#MainCatID#
</cfif>
</cfquery>

<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>

<cfif IsDefined("url.CategoryID")>
    
    <cfquery name="qry_current_topic" datasource="#dsn#" username="#request.username#" password="#request.password#">
    SELECT *
    FROM SugCategory
    WHERE CategoryID=#url.CategoryID#
    </cfquery>
    
    <cfset this_categoryID = qry_current_topic.CategoryID>
    <cfinclude template="act_topic_stages.cfm">

    <cfquery name="qry_all_category_suggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
    SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, count(SugVote.vote) as voteReceived
    FROM suggestion, SugVote
    WHERE suggestion.SugID=SugVote.SugID
    AND suggestion.Authorise = 'yes'
    AND suggestion.Archived=0
    AND suggestion.categoryID=#this_categoryID#
    AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)	
    GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage
    ORDER BY voteReceived DESC
    </cfquery>
    
    <cfset activityid = 2>
    
    <cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
    SELECT SugID
    FROM Suggestion
    WHERE CategoryID=#this_categoryID#
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
        
    <cfif this_pointsremaining LTE 0>
    	
        <script type="text/javascript">
        alert("The topic you are trying to add your idea to has been closed.\nYou can only add ideas to open topics.");
        history.back(-1);
        </script>
        <cfabort>	
        
    <cfelseif IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>
    	
        <script type="text/javascript">
        alert("The topic you are trying to add your idea to has been closed.\nYou can only add ideas to open topics.");
        history.back(-1);
        </script>
        <cfabort>
        
    </cfif>
    
<cfelse>

    <script type="text/javascript">
    alert("The topic you are trying to add your idea to has been closed.\nYou can only add ideas to open topics.");
    history.back(-1);
    </script>
    <cfabort>
        
</cfif>

<cfquery name="selCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
WHERE Active=1
AND CategoryID=#url.CategoryID#
ORDER BY DisplayOrder ASC
</cfquery>

<!--- QUERY FOR UN-AUTHORISED --->
<cfquery name="AllUnauthorised" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUGID, suggestion, details
FROM suggestion
WHERE ContactID <> #session.UserID#
AND Authorise LIKE '%No%'
AND SugStage LIKE '%Pending%'
AND Suggestion <> ''
AND Archived = 0
<cfif IsDefined("url.CategoryID")>
	AND CategoryID=#url.CategoryID#
</cfif>
ORDER BY WhenSugMade ASC
</cfquery>


<script language="JavaScript">
function show(targetId){ 
  if (document.getElementById){ 
        target = document.getElementById( targetId ); 
        target.style.display = ""; 
  } 
} 
function hide(targetId){ 
  if (document.getElementById){ 
        target = document.getElementById( targetId ); 
        target.style.display = "none"; 
  } 
}
function ToggleMoreInfo(ThisElement) {
	
	if (document.getElementById( ThisElement ).style.display == "none") {
	show(ThisElement);
	show(ThisElement);
	}
	else {
	hide(ThisElement);
	hide(ThisElement);
	}
}
function ValidateAddIdea(frmSuggestionInputForm) {

	if (document.getElementById("rate1")) {		
		
		if (document.frmSuggestionInputForm.rate1.selectedIndex == "0") {
		alert("Please enter a vote for each idea");
		document.frmSuggestionInputForm.rate1.focus();
		return;		
		}		
		else if (document.frmSuggestionInputForm.comments1.value == "comments..." || document.frmSuggestionInputForm.comments1.value == "") {	
		alert("Please enter your comments to help grow this idea!");
		document.frmSuggestionInputForm.comments1.focus();
		return;
		}			
	} 
	
	if (document.getElementById("rate2")) {
		
		if (document.frmSuggestionInputForm.rate2.selectedIndex == "0") {
		alert("Please enter a vote for each idea");
		document.frmSuggestionInputForm.rate2.focus();
		return;		
		}		
		else if (document.frmSuggestionInputForm.comments2.value == "comments..." || document.frmSuggestionInputForm.comments2.value == "") {	
		alert("Please enter your comments to help grow this idea!");
		document.frmSuggestionInputForm.comments2.focus();
		return;
		}
		
	}
	
	if (document.getElementById("rate3")) {
			
		if (document.frmSuggestionInputForm.rate3.selectedIndex == "0") {
		alert("Please enter a vote for each idea");
		document.frmSuggestionInputForm.rate3.focus();
		return;		
		}		
		else if (document.frmSuggestionInputForm.comments3.value == "comments..." || document.frmSuggestionInputForm.comments3.value == "") {	
		alert("Please enter your comments to help grow this idea!");
		document.frmSuggestionInputForm.comments3.focus();
		return;
		}
		
	}
	
	if (frmSuggestionInputForm.txtareaSuggestion.value == "") {
	alert("Please enter your suggestion!");
	frmSuggestionInputForm.txtareaSuggestion.focus();
	return;
	}	
	else {
	frmSuggestionInputForm.submit();
	}
	
	
}
</script>

<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75"><img src="#request.imageroot#/ideaFunL/new_3_1_add.gif" width="35" height="52" alt="1. Select a topic" border="0"></a><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#CategoryID#"><img src="#request.imageroot#/ideaFunL/new_3_2_add.gif" width="46" height="52" alt="2. View Ideas" border="0"></a><img src="#request.imageroot#/ideaFunL/new_3_3_add.gif" width="67" height="52" alt="3. ADD AN IDEA" border="0"><br>
<img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="8"><br>

<img src="#request.imageroot#/ideaFunl_Process.gif" width="484" height="111" border="0"><br><br>
	
For every idea or suggestion that you submit that gets approved and posted on the site, you get 1 entry into the draw to win great prizes. And every time your ideas moves up a stage - you earn more points. And because ideas get better with your comments, every suggestion you vote &amp; give feedback on also gets you an entry into the prize draw.
<br><br>


<table width="100%" cellspacing="0" cellpadding="0" border="0">

<form name="frmSuggestionInputForm" action="#request.webroot#/ideas/act_add_idea_vote.cfm" method="post" onsubmit="javascript:ValidateAddIdea(frmSuggestionInputForm); return false;">
<input type="hidden" name="JavaCatch" value="0">
<tr>
<td><div style="border:dotted 1px ##b4b4b4;"></div></td>
</tr>

<tr>
<td><br><img src="#request.imageroot#/ideaFunL/a_vote.gif" width="254" height="36" alt="STEP 1 - Vote on new ideas" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<cfset Vote_1 = 0>
	<cfset Vote_2 = 0>
	<cfset Vote_3 = 0>
			
	<cfif AllUnauthorised.recordcount>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="45"></td>
		<td width="100%">		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
					
			<tr>
			<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
			</tr>			
			
			<cfset IdeaCount = 0>	
			
			<cfloop query="AllUnauthorised">
			
			<cfset this_sugID = AllUnauthorised.sugID>			
			
			<!--- check if user has voted for this current suggestion --->
			<cfquery datasource="#dsn#"  name="isUserVote" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE SugID = #this_sugID#
			AND ContactID = #session.UserID#
			</cfquery>			
			
			<cfif isUserVote.recordCount EQ 0>			
				
				<cfquery datasource="#dsn#"  name="Sug_TotalVotes" username="#request.username#" password="#request.password#">
				SELECT contactID
				FROM SugVote
				WHERE sugID = #this_sugID#
				</cfquery>
				
                <cfset IdeaCount = IdeaCount + 1>
                
                <input type="hidden" name="sugID#IdeaCount#" value="#this_sugID#">
                
                <tr>
                <td width="20" valign="top" style="color:###TRIM(AllSettings.DkTextColor)#;"><a title="#IdeaCount#"><strong>#IdeaCount#.</strong></a></td>
                <td width="*" style="padding-left:5px;padding-right:20px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>#suggestion#</strong></td>
                </tr>
                
                <cfif TRIM(details) NEQ ''>
                
                <tr>
                <td></td>
                <td style="font-size:11px;padding-left:5px;color:###TRIM(AllSettings.DKTextColor)#;">#TRIM(details)#</td>
                </tr>
                
                </cfif>
                
                <tr>
                <td colspan="2" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
                </tr>
                
                <tr>
                <td width="20" valign="top"> </td>
                <td width="*" style="padding-left:5px;padding-right:20px;" valign="top"><select style="font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="rate#IdeaCount#" id="rate#IdeaCount#" class="rate">
                <option value="0">Select</option>
                <option value="5">YES - It's a winner!</option>
                <option value="1">NO - Not so good</option>
                </select> <input type="text" style="width:250px;font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="comments#IdeaCount#" onfocus="javascript: if (document.frmSuggestionInputForm.comments#IdeaCount#.value == 'comments...'){document.frmSuggestionInputForm.comments#IdeaCount#.value='';}" value="comments..."></td>
                </tr>
                
                <tr>
                <td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
                </tr>
                
                <tr>
                <td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
                </tr>
                
                <tr>
                <td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
                </tr>
                
			</cfif>
			
			<cfif IdeaCount EQ 3>
				<cfbreak>
			</cfif>
			</cfloop>
			
			</table>
		
			
		</td>
		</tr>
	
		<input type="hidden" name="unauthorised" value="yes">
		
	<cfelse>
		
		<input type="hidden" name="unauthorised" value="no">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="45"></td>
		<td width="100%" style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>There are no pending ideas to authorise.<br>
		Please go ahead and add your own ideas!</strong></td>
		</tr>
		
	</cfif>
	
	</table>


</td>
</tr>


<tr>
<td width="100%"><br><img src="#request.imageroot#/ideaFunL/b_enteridea.gif" width="178" height="36" alt="STEP 2 - Enter Your Idea" border="0"><br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="48"></td>
	<td width="100%">
	
	
		<!--- CHECK IF THIS IS A VALID DRAFT BEING SUBMITTED --->
		
		<cfif IsDefined("SugID")>
			
			<cfquery name="DraftStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT categoryID, Suggestion, Details
			FROM Suggestion
			WHERE SugID=#SugID#
			AND SugStage='Draft'
			</cfquery>			
			
			<!--- IF YES SET DATA INTO DEFAULT PARAMS --->
			<cfif DraftStuff.RecordCount>
			
				<cfset insert_SugID = SugID>
				<cfset insert_categoryID = DraftStuff.categoryID>
				<cfset insert_Suggestion = DraftStuff.Suggestion>
				<cfset insert_Details = DraftStuff.Details>
			
			<cfelse>
				
				<cfset insert_SugID = 0>
				<cfset insert_categoryID = 0>
				<cfset insert_Suggestion = ''>
				<cfset insert_Details = ''>
				
			</cfif>			
		
		<!--- IF IT"S NOT A DRAFT SET THE DEFAULT PARAMS TO NULL --->
		<cfelse>
			
			<cfset insert_SugID = 0>
			<cfset insert_categoryID = 0>
			<cfset insert_Suggestion = ''>
			<cfset insert_Details = ''>		
		
		</cfif>
	
		<input type="hidden" name="DraftID" value="#insert_SugID#">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
		<tr>
		<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2"><span style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><strong>PLEASE NOTE:</strong> &nbsp;Once you have submitted your idea you will no longer be able to edit the "Summary" but you will be able to edit the "Details".</span>
		<hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr>
		<td style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" width="125"><strong>Idea Category:</strong></td>
		<td>#TRIM(selected_maincat.MainCatTitle)#</td>
		</tr>
	
		<tr>
		<td colspan="2"><hr size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr> 		
		<td style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#;" width="125"><strong>Idea Topic</strong></td>
		<td><cfif IsDefined("url.CategoryID")><input type="hidden" name="selCategory" value="#url.categoryID#">#TRIM(selCategory.Name)#<cfelse><select name="selCategory" style="font-size:10px;width:295px;color:###TRIM(AllSettings.BoxColour)#;" class="whitefield">
		<option value="0">Pick an Idea Category</option>
		<cfloop query="selCategory">
		
		<cfif selCategory.PointsUsed LT selCategory.PointsCutOff>
		<option value="#selCategory.categoryID#"<cfif insert_categoryID EQ selCategory.categoryID> selected</cfif>>#TRIM(selCategory.Name)#</option>
		</cfif>
		</cfloop>
		</select></cfif></td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr> 		
		<td style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top" width="125"><strong>Summary (120 max)</strong></td>
		<td valign="top"><input type="text" name="txtareaSuggestion" style="font-size:12px;width:295px;color:Black;" value="#TRIM(insert_Suggestion)#" maxlength="120" class="whitefield"></td>
		</tr>
		
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr> 		
		<td style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top" width="125"><strong>Details</strong></td>
		<td valign="top"><textarea name="txtareaDetails" style="font-size:12px;width:295px;color:Black;" rows="8" class="whitefield">#TRIM(insert_Details)#</textarea></td>
		</tr>
		
		<tr>
		<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr> 		
		<td style="padding-right:10px;" valign="top" width="125"> </td>
		<td valign="top"><input type="submit" value="Cast your votes and add your idea" style="font-size:11px;" class="whitefield"></td>
		</tr>
		
		</table>
		
		
	</td>
	</tr>
	
	
	</table>
	

</td>
</tr>

</form>

</table>
<br><br><br>





</cfoutput>