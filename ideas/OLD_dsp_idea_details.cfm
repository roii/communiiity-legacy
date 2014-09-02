<cfoutput>

<cfquery name="selected_maincat" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT MainCatID, MainCatTitle
FROM SugMainCategory
WHERE MainCatID=#session.MainCatID#
</cfquery>
		
<script language="JavaScript">

function ValidateVoteIdea(frmSuggestionInputForm){

if (frmSuggestionInputForm.rate.selectedIndex == "0") {
	alert("You must select your vote.");
	document.frmSuggestionInputForm.rate.focus();
	return;
	}

else if (document.frmSuggestionInputForm.comments.value == "Comments..." || document.frmSuggestionInputForm.comments.value == "") {
	
	if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
		document.frmSuggestionInputForm.submit();
		}
		return;
	}
	
else {
	document.frmSuggestionInputForm.submit(); //submit form
}
}
</script>

<cfquery name="IdeaDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.WhenSugMade, suggestion.suggestion, suggestion.details, suggestion.totalVote, suggestion.voteNumReceived, suggestion.WhenSugEnded, suggestion.WhenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.comments, suggestion.SugStage, suggestion.Reward, suggestion.categoryID, SugCategory.Name, SugCategory.PointsAllocated, SugCategory.WhenCategoryEnded, SugCategory.PointsCutOff, Contacts.FirstName, Contacts.ScreenName
FROM suggestion, SugCategory, Contacts
WHERE suggestion.SugID=#SugID#
AND suggestion.CategoryID=SugCategory.CategoryID
AND suggestion.ContactID=Contacts.ContactID
</cfquery>

<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID = #sugID#
</cfquery>

<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID = #sugID#
AND vote > 3
</cfquery>

<cfif AllVotes.RecordCount>

	<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>

<cfelse>
	
	<cfset PercentYes = 0>
	
</cfif>


<cfif session.UserIsAuthenticated EQ 'Yes'>

<!--- check if user has been vote for this current suggestion --->
<cfquery datasource="#dsn#"  name="isUserVote" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID = #sugID#
AND ContactID=#session.UserID#
</cfquery>


<!--- check if user is watching this idea --->
<cfquery datasource="#dsn#"  name="IsWatched" username="#request.username#" password="#request.password#">
SELECT *
FROM SugWatchList
WHERE sugID = #sugID#
AND ContactID=#session.UserID#
</cfquery>

</cfif>


<cfset this_categoryID = IdeaDetails.categoryID>
	
<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#this_categoryID#
AND Authorise LIKE '%Yes%'
GROUP BY SugID
</cfquery>

<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#this_categoryID#
AND Authorise LIKE '%No%'
AND Archived = 0
GROUP BY SugID
</cfquery>


<cfif AllCat_ActiveIdeas.RecordCount>
	<cfset ThisCatideas = valueList(AllCat_ActiveIdeas.SugID)>
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

<cfset this_pointsremaining = INT(IdeaDetails.PointsAllocated - AllPointsEarned.TotalPointsEarned)>


<cfset add_idea = 1>
<cfset vote_idea = 1>

<cfif this_pointsremaining EQ 0>

	<cfset add_idea = 0>
	<cfset vote_idea = 0>
	
<cfelseif IsDate("#IdeaDetails.WhenCategoryEnded#") AND dateCompare(localdatetime, IdeaDetails.WhenCategoryEnded) EQ 1>

	<cfset add_idea = 0>
	<cfset vote_idea = 0>

<cfelseif this_pointsremaining LTE IdeaDetails.PointsCutOff>
	
	<cfset add_idea = 0>
	
</cfif>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75"><cfif IsDefined("ideafunl_mode") AND ideafunl_mode EQ 'WinningDetails'><img src="#request.imageroot#/ideaFunL/new_details.gif" width="116" height="39" alt="Idea Details" border="0"><cfelse><cfif vote_idea EQ 1><cfif IsDefined("isUserVote") AND isUserVote.RecordCount><img src="#request.imageroot#/ideaFunL/new_details.gif" width="116" height="39" alt="Idea Details" border="0"><cfelse><img src="#request.imageroot#/ideaFunL/new_3_1_vote.gif" width="35" height="52" alt="1. Select a topic" border="0"></a><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#currentcategory#"><img src="#request.imageroot#/ideaFunL/new_3_2_vote.gif" width="47" height="52" alt="2. View ideas" border="0"></a><img src="#request.imageroot#/ideaFunL/new_3_3_vote.gif" width="80" height="52" alt="3. VOTE ON AN IDEA" border="0"></cfif><cfelse><img src="#request.imageroot#/ideaFunL/new_3_1_vote.gif" width="35" height="52" alt="1. Select a topic" border="0"></a><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#currentcategory#"><img src="#request.imageroot#/ideaFunL/new_3_2_vote.gif" width="47" height="52" alt="2. View ideas" border="0"></a><img src="#request.imageroot#/ideaFunL/new_3_3_vote.gif" width="80" height="52" alt="3. VOTE ON AN IDEA" border="0"></cfif></cfif><br>
<img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="20"><br></td>
</tr>

<tr>
<td valign="top"><span style="font-size:14px;color:###TRIM(session.AllSettings_DkTextColor)#"><b>&ldquo;#TRIM(IdeaDetails.suggestion)#&rdquo;</b></span><br><br></td>
</tr>

<cfif TRIM(IdeaDetails.Details) NEQ ''>

<tr>
<td valign="top"><span style="color:###TRIM(session.AllSettings_DkTextColor)#"><b>&ldquo;#TRIM(IdeaDetails.Details)#&rdquo;</b></span><br><br></td>
</tr>

</cfif>

<tr>
<td>
	
	
	<table cellpadding="0" cellspacing="0" border="0" width="90%">
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(session.AllSettings_DkTextColor)#" align="right"><strong>Idea Code:</strong></td>
	<td>#NumberFormat(sugID, "000000")#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(session.AllSettings_DkTextColor)#" align="right"><strong>Category:</strong></td>
	<td>#TRIM(selected_maincat.MainCatTitle)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(session.AllSettings_DkTextColor)#" align="right"><strong>Topic:</strong></td>
	<td>#TRIM(IdeaDetails.Name)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(session.AllSettings_DkTextColor)#" align="right"><strong>Stage:</strong></td>
	<td><cfif TRIM(IdeaDetails.SugStage) CONTAINS 4>Doing<cfelseif TRIM(IdeaDetails.SugStage) CONTAINS 5>Done!<cfelse>#TRIM(IdeaDetails.SugStage)#</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(session.AllSettings_DkTextColor)#" align="right"><strong>Suggested By:</strong></td>
	<td><cfif (IsDefined("isUserVote") AND isUserVote.RecordCount) OR (IdeaDetails.SugStage CONTAINS '4' OR IdeaDetails.SugStage CONTAINS '5')><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#IdeaDetails.contactID#" title="View Profile"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0" align="absmiddle"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(IdeaDetails.contactID)#" style="color:###TRIM(session.AllSettings_BoxColour)#;" title="View Profile"><strong><cfif TRIM(IdeaDetails.ScreenName) NEQ ''>#TRIM(IdeaDetails.ScreenName)#<cfelse>#TRIM(IdeaDetails.FirstName)#</cfif></strong></a><cfelse><a href="##" title="You must vote before you can see#chr(10)#the author of the idea!">?</a></cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(session.AllSettings_DkTextColor)#" align="right"><strong>Date Suggested:</strong></td>
	<td><cfif IsDate("#TRIM(IdeaDetails.WhenSugMade)#")>#DateFormat(IdeaDetails.WhenSugMade, "d-mmm-yyyy")#<cfelse>&ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<cfif (IdeaDetails.SugStage CONTAINS 'Stage 4' OR IdeaDetails.SugStage CONTAINS 'Stage 5')>
	
		<tr>
		<td width="100" style="padding-right:10px;color:###TRIM(session.AllSettings_DkTextColor)#" align="right"><strong>Reward:</strong></td>
		<td>#IdeaDetails.Reward#</td>
		</tr>
		
		<tr>
		<td colspan="2"><hr size="1" color="##e2e2e2"></td>
		</tr>
	
	
	</cfif>
	
	
	
	<cfif (IsDefined("isUserVote") AND isUserVote.RecordCount) AND (IdeaDetails.SugStage DOES NOT CONTAIN 'Stage 4' AND IdeaDetails.SugStage DOES NOT CONTAIN 'Stage 5') AND (session.UserIsAuthenticated EQ 'Yes')>
	
	<tr>
	<td colspan="2" align="center"><cfif IdeaDetails.ContactID NEQ session.UserID><br><cfif IsWatched.RecordCount><a href="#request.webroot#/ideas/act_watchlist_remove.cfm?SugID=#sugID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ideafunl_mode=#ideafunl_mode#&documentID=#documentID#&currentcategory=#currentcategory#" style="color:###TRIM(session.AllSettings_BoxColour)#;font-size:12px;"><strong><span style="text-decoration:none;">(-) </span>Remove from My Watchlist</strong></a><cfelse><a href="#request.webroot#/ideas/act_watchlist_add.cfm?SugID=#SugID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ideafunl_mode=#ideafunl_mode#&documentID=#documentID#&currentcategory=#currentcategory#" style="color:###TRIM(session.AllSettings_BoxColour)#;font-size:12px;"><strong><span style="text-decoration:none;">(+) </span>Add to My Watchlist</strong></a></cfif></cfif></td>
	</tr>
	
	</cfif>
	
	
	</table><br>
	
	
	
	<cfif (IdeaDetails.SugStage CONTAINS 'Stage 4' OR IdeaDetails.SugStage CONTAINS 'Stage 5') OR (session.UserIsAuthenticated EQ 'Yes' AND isUserVote.RecordCount)>
	
		<table width="90%" cellpadding="0" cellspacing="2" border="0">
		
		<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="25">
		<td width="33%" style="color:###TRIM(session.AllSettings_BoxTextColour)#;" align="center"><strong>Votes</strong></td>
		<td width="33%" style="color:###TRIM(session.AllSettings_BoxTextColour)#;" align="center"><strong>% Yes</strong></td>
		<td width="33%" style="color:###TRIM(session.AllSettings_BoxTextColour)#;" align="center"><strong>Your Vote</strong></td>
		</tr>
		
		<tr>
		<td width="33%" align="center">#AllVotes.recordcount#</td>
		<td width="33%" align="center"><cfif vote_idea EQ 1><cfif (IsDefined("isUserVote") AND isUserVote.RecordCount) OR (IdeaDetails.SugStage CONTAINS '4' OR IdeaDetails.SugStage CONTAINS '5')>#INT(PercentYes)#%<cfelse><a href="##" title="You must vote before you can see#chr(10)#the average vote!">?</a></cfif><cfelse>#INT(PercentYes)#%</cfif></td>
		<td width="33%" align="center"><cfif IsDefined("isUserVote") AND isUserVote.RecordCount><cfif isUserVote.vote LTE 1>NO<cfelse>YES</cfif><cfelse>&ndash;</cfif></td>
		</tr>
		
		<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="2">
		<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		</table><br>

	
	<cfelseif session.UserIsAuthenticated EQ 'Yes'>
	
		
		<cfif IdeaDetails.ContactID NEQ session.UserID AND vote_idea EQ 1>
		
			
			<table cellpadding="5" cellspacing="0" border="0">
			
			<form name="frmSuggestionInputForm" action="#request.webroot#/ideas/act_vote.cfm" method="post" onsubmit="javascript:ValidateVoteIdea(frmSuggestionInputForm); return false;">

			<input type="hidden" name="sugID" value="#sugID#">
			<input type="hidden" name="currentcategory" value="#currentcategory#">
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#">
			<td width="140" style="color:###TRIM(session.AllSettings_BoxTextColour)#;font-size:12px;"><strong>What is your vote?</strong></td>
			<td><select name="rate" style="font-size:10px;color:###TRIM(session.AllSettings_DkTextColor)#;width:220px;" class="whitefield">
			<option value="0">-- Select your vote --</option>
			<option value="5">YES - Good Idea!</option>
			<option value="1">NO - Not ready yet</option>
			</select></td>
			<td width="100"><input type="image" src="#request.imageroot#/ideaFunL/vote_button.gif" align="absmiddle" border="0"></td>
			</tr>
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#">
			<td style="color:###TRIM(session.AllSettings_BoxTextColour)#;font-size:12px;" width="140" valign="top"><strong>Comments</strong></td>
			<td><textarea style="width:220px;font-size:11px;color:###TRIM(session.AllSettings_DkTextColor)#;" rows="4" class="whitefield" name="comments" onfocus="javascript: if (document.frmSuggestionInputForm.comments.value == 'Comments...'){document.frmSuggestionInputForm.comments.value='';};" align="absmiddle">Comments...</textarea></td>
			<td></td>
			</tr>
			
			 </form>
			
			</table><br>
			
		</cfif>
		
		
		
		
	
	<cfelse>
	
		<table width="90%" cellpadding="0" cellspacing="0" border="0">
		<tr>
		<td><span style="color:###TRIM(session.AllSettings_BoxColour)#;font-size:12px;"><strong>To vote on ideas and to add your own ideas - <a href="#request.webroot#/index.cfm?fuseaction=login" style="color:###TRIM(session.AllSettings_DkTextColor)#">Login first  &raquo;</a></strong></span>
		<hr size="1" color="##e2e2e2" width="100%" align="left"></td>
		</tr>
		</table><br><br>
	
	</cfif>

	
	
	<cfif (session.UserIsAuthenticated EQ 'Yes') AND ((isUserVote.RecordCount) OR (IdeaDetails.ContactID EQ session.UserID) OR (session.UserType EQ 'Administrator'))>

		<cfset max_date = localdatetime>
	
		<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
		SELECT *
		FROM SugVote
		WHERE sugID = #sugID#
		ORDER BY whenVoteMade DESC
		</cfquery>
	
		<br>
		<table width="90%" cellpadding="0" cellspacing="0" border="0">
		
		<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="25">
		<td style="color:###TRIM(session.AllSettings_BoxTextColour)#;padding-left:10px;" colspan="4"><strong>Comments &amp; Votes...</strong></td>
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
		
	
		<!--- CHECK FOR REVISIONS --->
		<cfquery name="qry_revision_history" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT RevisionDate
		FROM Sug_Revision
		WHERE SugID=#SugID# 
		AND RevisionDate < #CreateODBCDateTime(max_date)#
		AND RevisionDate > #CreateODBCDateTime(AllVotes.whenVoteMade)#
		ORDER BY RevisionDate DESC
		</cfquery>
		
		<cfif qry_revision_history.RecordCount>
			
			<tr>
			<td valign="top" style="font-size:11px;padding-left:10px;color:###TRIM(session.AllSettings_BoxColour)#;">#DateFormat(qry_revision_history.RevisionDate, "d-mmm-yyyy")#</td>
			<td valign="top" style="font-size:11px;color:###TRIM(session.AllSettings_BoxColour)#;">IDEA UPDATED</td>
			<td valign="top" style="font-size:11px;" align="center"></td>
			<td valign="top" style="font-size:11px;"></td>
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
		
		</cfif>
		
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
	
		<cfset max_date = AllVotes.whenVoteMade>
		
		
		</cfloop>
	
		
		</table><br><br>
	
	</cfif>
	
	<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#currentcategory#&IdeaFunL_StartRow=1" style="text-decoration:none;"><strong>&laquo;</strong></a> <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#currentcategory#&IdeaFunL_StartRow=1">Return to the Ideas Page for this Topic</a><br>
	<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75" style="text-decoration:none;"><strong>&laquo;</strong></a> <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75">Select another Topic</a>
	
	
	
</td>
</tr>

</table>


</cfoutput>
		