<cfparam name="session.userID" default="">
<cfoutput>

<cfquery name="qry_all_maincats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT MainCatID, MainCatTitle, DisplayOrder, Active
FROM SugMainCategory
WHERE Active=1
ORDER BY DisplayOrder
</cfquery>



<cfif IsDefined("AddDraft")>

	<cfinclude template="dsp_add_draft.cfm">

<cfelseif IsDefined("EditDraft")>

	<cfinclude template="dsp_edit_draft.cfm">

<cfelseif IsDefined("EditIdea")>

	<cfinclude template="dsp_edit_idea.cfm">
	
<cfelse>


	<script language="JavaScript">	
	function confirmIdeaDelete(aURL) {
	    if(confirm('Are you sure you want to delete this draft idea?')) {
	      location.href = aURL;
	    }
		}
	
	function confirmIdeaRemove(aURL) {
	    if(confirm('Are you sure you want to remove this idea?')) {
	      location.href = aURL;
	    }
		}
	<!--
	function toggleContent(which) {
		if(document.getElementById("kb"+which).style.display=="block") {
			document.getElementById("kb"+which).style.display="none";
			document.getElementById("topcell"+which).style.backgroundColor="##ffffff";
			document.getElementById("imexpandbut_"+which).style.display="block";
			document.getElementById("imclosebut_"+which).style.display="none";
	
		} else {
			document.getElementById("kb"+which).style.display="block";
			document.getElementById("topcell"+which).style.backgroundColor="##eaeaea";
			document.getElementById("imexpandbut_"+which).style.display="none";
			document.getElementById("imclosebut_"+which).style.display="block";
		}
	}
	//-->
	</script>
	
	<!--- GET IDEAfunL SETTINGS --->
	<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM IdeaFunl_Settings
	</cfquery>
	
	<table width="100%" border="0">
	
	<tr>
	<td valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ideafunl_mode=MyIdeas&AddDraft=1&documentID=77" style="color:###TRIM(AllSettings.BoxColour)#;text-decoration:none;"><strong>#addadraftidea# &raquo;</strong></a><br><br></td>
	</tr>
	
	</table>
	
	
	<table width="100%" border="0">
	<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="documentID" value="#documentID#">
	
	<cfif IsDefined("ideafunl_mode")>
	<input type="hidden" name="ideafunl_mode" value="#ideafunl_mode#">
	</cfif>
	
	<tr>
	<td><select name="currentcategory" class="whitefield" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#; width: 300px;">
	<optgroup label="">
	<option value="ALL"<cfif session.srch_category EQ 'ALL'> selected</cfif>>-- #alltopics# --
	<cfloop query="qry_all_maincats">
	<cfset this_maincatID = qry_all_maincats.maincatID>
	<cfset this_title = qry_all_maincats.MainCatTitle>
	<optgroup label="#TRIM(this_title)#">
	<cfquery name="Category" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugCategory
	WHERE MainCatID=#this_mainCatID# 
	AND Active = 1
	ORDER BY DisplayOrder
	</cfquery>
	<cfloop query="Category">
	<option value="#Category.categoryID#"<cfif session.srch_category EQ Category.categoryID> selected</cfif>>- #TRIM(Category.Name)#
	</cfloop>
	<option value="">
	</cfloop>
	</select><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"><br>
	<select name="srch_stage" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
	<option value="ALL"<cfif session.srch_stage EQ 'ALL'> selected</cfif>>#anystage#
	<option value="Draft"<cfif session.srch_stage EQ 'Draft'> selected</cfif>>#draft#
	<option value="Pending"<cfif session.srch_stage EQ 'Pending'> selected</cfif>>#Pending#
	<option value="Stage 1"<cfif session.srch_stage EQ 'Stage 1'> selected</cfif>>#stage1#
	<option value="Stage 2"<cfif session.srch_stage EQ 'Stage 2'> selected</cfif>>#stage2#
	<option value="Stage 3"<cfif session.srch_stage EQ 'Stage 3'> selected</cfif>>#stage3#
	<option value="Stage 4"<cfif session.srch_stage EQ 'Stage 4'> selected</cfif>>#winnerideadoing#
	<option value="Stage 5"<cfif session.srch_stage EQ 'Stage 5'> selected</cfif>>#winnerideadone#
	<option value="Returned"<cfif session.srch_stage EQ 'Returned'> selected</cfif>>#returnedvotedno#
	</select> <input type="text" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;width:130px;" name="srch_keywords" onfocus="javascript:document.ideasearch.srch_keywords.value='';" value="<cfif session.srch_keywords NEQ ''>#session.srch_keywords#<cfelse>#ideacodekeywords#...</cfif>"> <input type="submit" value="#search# &raquo;" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;font-weight:bold;" class="whitefield"></td>
	</tr>
		
	
	
	</form>
	</table><br>
	
	<cfquery name="AllSuggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.WhenSugEnded, suggestion.SugStage, suggestion.reward, SugCategory.Name,  SugCategory.MainCatID, SugMainCategory.MainCatTitle
	FROM suggestion, Contacts, SugCategory, SugMainCategory
	WHERE suggestion.ContactID=Contacts.ContactID
	AND Contacts.ContactID=#session.UserID#
	AND suggestion.CategoryID=SugCategory.CategoryID
	AND SugCategory.MainCatID=SugMainCategory.MainCatID
	
	<cfif session.srch_category NEQ 'ALL'>
		AND suggestion.categoryID=#session.srch_category#						
	</cfif>
	
	<cfif session.srch_stage NEQ 'ALL'>
		
		<cfif session.srch_stage EQ 'Returned'>
			AND Archived=1
		<cfelse>
			AND suggestion.SugStage LIKE '%#session.srch_stage#%'
		</cfif>		
		
	</cfif>
	
	<cfif session.srch_keywords NEQ '' AND session.srch_keywords NEQ 'Idea code or keywords...'>
		AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
		OR suggestion.Details LIKE '%#session.srch_keywords#%'
		
		<cfif IsNumeric("#session.srch_keywords#")>
			OR suggestion.SugID = #session.srch_keywords#
		</cfif>
		)	
	</cfif>
	
	GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.WhenSugEnded, suggestion.SugStage, suggestion.reward, SugCategory.Name,  SugCategory.MainCatID,  SugMainCategory.MainCatTitle
	ORDER BY WhenSugEnded DESC
	</cfquery>
	
	
	<table width="100%" cellspacing="1" cellspacing="1">
	
	<tr>
	<td>
	
	
		<cfif IsDefined("AllSuggestions") AND AllSuggestions.RecordCount GT 0>
						
			
			<!--- loop to display the suggestion --->
			<cfloop query="AllSuggestions">
			
				<cfset this_sugID = AllSuggestions.SugID>
				<cfset this_Idea = AllSuggestions.Suggestion>
				<cfset this_Details = AllSuggestions.Details>
				<cfset this_ContactID = AllSuggestions.ContactID>
				<cfset this_stage = AllSuggestions.SugStage>
				<cfset this_reward = AllSuggestions.reward>
				<cfset this_Topic = AllSuggestions.Name>
				<cfset this_Start = AllSuggestions.WhenSugMade>
				<cfset this_End = AllSuggestions.WhenSugEnded>
				<cfset this_MainCat = AllSuggestions.MainCatTitle>
				<cfset this_MainCatID = AllSuggestions.MainCatID>
				<cfset this_archived = AllSuggestions.archived>
								
				<!--- GET REWARDS --->
				<cfquery name="IdeaRewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT SUM(contact_transactions.Transaction_Amount) AS TotalReward
				FROM contact_transactions
				WHERE ContactID=#this_ContactID#
				AND Transaction_Type LIKE 'Credit%'
				AND Transaction_Account LIKE '%Points%'
				AND Related_Identifier=#this_sugID#
				AND (Related_Description LIKE '%AddIdea%' OR Related_Description LIKE '%IdeaStage1%' OR Related_Description LIKE '%IdeaStage2%' OR Related_Description LIKE '%IdeaStage3%' OR Related_Description LIKE '%IdeaStage4%' OR Related_Description LIKE '%IdeaStage5%' OR Related_Description LIKE '%Bonus Points for your Idea%' OR Related_Description LIKE '%Bonus Points for your Idea%')
				</cfquery>				
				
			<!--- <cfif (session.srch_period NEQ 'ALL') AND (DateCompare(CatSug.WhenSugMade, SearchStart) EQ 1)> --->
				<cfif IdeaRewards.RecordCount AND ISNumeric("#IdeaRewards.TotalReward#")>
					<cfset this_reward = IdeaRewards.TotalReward>
				<cfelse>
					<cfset this_reward = 0>
				</cfif>				
				
				<cfquery datasource="#dsn#" name="ContactStuff" username="#request.username#" password="#request.password#">
				SELECT FirstName, ScreenName
				FROM Contacts
				WHERE ContactID=#this_ContactID#
				</cfquery>			
			
				<!--- set the background color of the row --->				
				<cfset bgColor="ffffff">
				<cfset vote = 0 >
				
				<cfif session.UserIsAuthenticated EQ 'yes'>					
					
						<!--- check if user has voted for this current suggestion --->
						<cfquery datasource="#dsn#"  name="isUserVote" username="#request.username#" password="#request.password#">
						SELECT *
						FROM SugVote
						WHERE sugID = #this_sugID#
						AND ContactID=#session.UserID#
						</cfquery>
				
						<!--- user has vote if isUserVote recordCount > 0 or the suggestion was made by the user --->
						<cfif isUserVote.recordCount OR (this_ContactID NEQ '' AND this_ContactID EQ session.UserID)>					
							<cfset bgColor="ffffff">
							<cfset vote = 1>						
						</cfif>					
					
				</cfif>
				
				<!--- MODERATOR COMMENTS --->
				<cfquery name="qry_sug_comments" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT SugComments.CommentDate, SugComments.Comment, SugComments.PublicView, Contacts.ScreenName
				FROM SugComments, Contacts
				WHERE SugComments.sugID = #this_sugID#
				AND SugComments.ModeratorID=Contacts.ContactID
				<cfif session.UserID NEQ this_contactID>
					AND SugComments.PublicView=1
				</cfif>
				ORDER BY SugComments.CommentDate DESC
				</cfquery>
							
				<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #this_sugID#
				</cfquery>
				
				<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #this_sugID#
				AND vote > 3
				</cfquery>
				
				<cfif AllVotes.RecordCount>
					<cfset TotalVotes=AllVotes.RecordCount>
				<cfelse>
					<cfset TotalVotes=0>
				</cfif>
				
				<cfif YesVotes.RecordCount>
					<cfset TotalYesVotes=YesVotes.RecordCount>
				<cfelse>
					<cfset TotalYesVotes=0>
				</cfif>
				
				<cfif TotalYesVotes GT 0 OR TotalVotes GT 0>
					<cfset PercentYes = (TotalYesVotes / TotalVotes * 100)>
				<cfelse>
					<cfset PercentYes = 0>
				</cfif>
								
				<table cellpadding="0" cellspacing="0">
				
				<tr>
				<cfif this_stage CONTAINS 'Draft'>
					<td>
						<table cellpadding="2" cellspacing="0" border="0" bgcolor="##5a5a5a">						
						<tr>
						<td style="color:white;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;<strong>DRAFT IDEA</strong>&nbsp;</td>
						</tr>						
						</table>
					</td>						
				<cfelseif this_archived EQ 1>
					<td>
						<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">						
						<tr>
						<td style="color:333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;RETURNED IDEA&nbsp;</td>
						</tr>						
						</table>
					</td>
				<cfelseif this_stage CONTAINS 'Pending'>
					<td>
						<table cellpadding="2" cellspacing="0" border="0" bgcolor="##5a5a5a">						
						<tr>
						<td style="color:white;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;PENDING IDEA&nbsp;</td>
						</tr>						
						</table>
					</td>
				<cfelseif this_stage CONTAINS 'Stage 4' OR this_stage CONTAINS 'Stage 5'>
					<td>
						<table cellpadding="2" cellspacing="0" border="0" bgcolor="##99CC00">						
						<tr>
						<td style="color:white;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;<strong>WINNING IDEA!</strong>&nbsp;</td>
						</tr>						
						</table>
					</td>	
				<cfelse>
					<td>
						<table cellpadding="2" cellspacing="0" border="0" bgcolor="###TRIM(Allsettings.BoxColour)#">						
						<tr>
						<td style="color:white;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;<strong>ACTIVE IDEA</strong>&nbsp;</td>
						</tr>						
						</table>
					</td>
				</cfif>				
				<td width="100%" align="right">
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">
					
					<tr>
					<td style="color:##333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>ID: &nbsp;#NumberFormat(this_sugID, "000000")#&nbsp;</td>
					</tr>
					
					</table>
				</td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
				<td>
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">
					
					<tr>
					<td style="color:##333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;#DateFormat(this_Start)#&nbsp;</td>
					</tr>
					
					</table>
				</td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
				<td>
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">
					
					<tr>
					<td style="color:##333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;<cfif this_archived EQ 1>Returned<cfelse>#this_stage#</cfif>&nbsp;</td>
					</tr>
					
					</table>
				</td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
				<td>
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">
					
					<tr>
					<td style="color:##333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;#AllVotes.RecordCount# votes&nbsp;</td>
					</tr>
					
					</table>
				</td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
				<td>
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">
					
					<tr>
					<td style="color:##333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;#INT(PercentYes)#% YES&nbsp;</td>
					</tr>
					
					</table>
				</td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
				<td>
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">
					
					<tr>
					<td style="color:##333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;<cfif IsDefined("isUserVote") AND isUserVote.RecordCount><cfif isUserVote.vote LTE 1>You Voted: NO<cfelse>You Voted: YES</cfif><cfelse><cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID NEQ session.userID>You didn't vote<cfelseif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID>Your Idea!<cfelse>&ndash;</cfif></cfif>&nbsp;</td>
					</tr>
					
					</table>
				</td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
				<td>
					<table cellpadding="2" cellspacing="0" border="0" bgcolor="##dddddd">					
					<tr>
					<td style="color:##333333;font-size:11px;padding-left:5px;padding-right:5px;" align="center" nowrap>&nbsp;#INT(this_reward)#pts earned&nbsp;</td>
					</tr>					
					</table>
				</td>
				</tr>
				
				</table>
				
				<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 1px ##888888;">
				
				<tr>
				<td id="topcell#AllSuggestions.CurrentRow#" style="background-color:##ffffff;">
				
					
					<table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left:4px;padding-right:4px;padding-top:4px;padding-bottom:4px;">
					
					<tr>
					<td valign="top" width="100%" height="100%"><a name="IDEA_#AllSuggestions.CurrentRow#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></a><br>
						
						
						<table cellpadding="0" cellspacing="0" border="0" height="100%" width="100%">
						
						<tr>
						<td valign="top">
						<a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&ideafunl_mode=voteresults&SingleIdea=#sugID#&currentcategory=#AllSuggestions.categoryID#"><strong>#TRIM(this_Idea)#</strong></a><br>
					<span style="font-size:11px;color:###TRIM(AllSettings.DkTextColor)#;">#TRIM(this_Details)#</span></td>
						</tr>
						
						</table>
						
						
					</td>
					<td align="right" valign="top" height="100%" width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"><br>
						
						<table cellpadding="0" cellspacing="0" border="0" height="100%" width="120">
						
						<tr>
						<td nowrap style="padding-right:5px;" align="right" width="100%" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><cfif TRIM(ContactStuff.ScreenName) NEQ ''>#TRIM(ContactStuff.ScreenName)#<cfelse>#TRIM(ContactStuff.FirstName)#</cfif></a></td>
						<td align="right" width="24" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0"></a></td>
						</tr>
						
						<tr>
						<td colspan="2" height="100%" valign="bottom" align="right"><a href="##&##IDEA_#AllSuggestions.CurrentRow#" class="textlinks" onClick="toggleContent(#AllSuggestions.CurrentRow#); return false;"><img src="#request.imageroot#/ideaFunL/expand.gif" border="0" name="imexpandbut_#AllSuggestions.CurrentRow#" style="display:visible;"></a><a href="##&##IDEA_#AllSuggestions.CurrentRow#" class="textlinks" onClick="toggleContent(#AllSuggestions.CurrentRow#); return false;"><img src="#request.imageroot#/ideaFunL/close.gif" border="0" name="imclosebut_#AllSuggestions.CurrentRow#" style="display:none;"></a></td>
						</tr>
						
						</table>
					
					</td>
					</tr>
					
					</table>
					
					
				</td>
				</tr>
				
				
				
				<tr style="display:none;" id="kb#AllSuggestions.CurrentRow#">
				<td>
					
				
					<table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left:4px;padding-right:4px;padding-top:4px;padding-bottom:4px;border-top:solid 1px ##b4b4b4;">
					
					<tr>
					<td valign="top" width="100%">
					
					
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
						
						<tr>
						<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
						<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
						<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
						<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
						<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
						</tr>
						
						<tr>
						<td align="right" style="padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top"><strong>Category:</strong></td>
						<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><strong>#TRIM(this_MainCat)#</strong></td>
						<td></td>
						<td align="right" style="padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top"><strong>Suggested:</strong></td>
						<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><strong>#DateFormat(this_Start)#</strong></td>
						</tr>
						
						<tr>
						<td align="right" style="padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top"><strong>Topic:</strong></td>
						<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><strong>#TRIM(this_Topic)#</strong></td>
						<td></td>
						<td align="right" style="padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top"><strong><cfif this_stage CONTAINS '4' OR this_Stage CONTAINS '5'>Voted Winner:<cfelseif this_stage CONTAINS 'Pending' OR this_Stage CONTAINS 'Stage'>Returned:</cfif></strong></td>
						<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><strong><cfif this_stage CONTAINS 'Pending' OR this_Stage CONTAINS 'Stage'>#DateFormat(this_End)#</cfif></strong></td>
						</tr>			
						
						<cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID>
						
						<tr>
						<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
						</tr>
						
						<tr>
						<td align="right" style="padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top"></td>
						<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><cfif this_stage DOES NOT CONTAIN 'Stage 4' AND this_stage DOES NOT CONTAIN 'Stage 5' AND this_stage DOES NOT CONTAIN 'Draft' AND this_archived NEQ 1><input type="button" class="whitefield" onclick="javascript:self.location='#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#this_SugID#';"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Edit Idea &raquo;">&nbsp;&nbsp;<input type="button" class="whitefield" onclick="javascript:confirmIdeaRemove('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#this_SugID#');"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Remove Idea &raquo;"><cfelseif this_stage CONTAINS 'Draft'><input type="button" class="whitefield" onclick="javascript:self.location='#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#this_SugID#&MainCatID=#this_MainCatID#';"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Edit Draft &raquo;">&nbsp;&nbsp;<input type="button" class="whitefield" onclick="javascript:self.location='#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=76&ideafunl_mode=add&SugID=#this_SugID#&CategoryID=#AllSuggestions.CategoryID#';"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Submit Idea &raquo;"></cfif></td>
						<td colspan="3"></td>
						</tr>
						
						</cfif>
						
						<tr>
						<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
						</tr>
						
						<tr>
						<td></td>
						<td colspan="4"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#AllSuggestions.categoryID#"><img src="#request.imageroot#/ideaFunL/view_feedback.gif" width="167" height="18" alt="View Feedback" border="0"></a></td>
						</tr>
						
						<cfif qry_sug_comments.recordcount>
					
						<tr>
						<td ></td>
						<td colspan="4"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#AllSuggestions.categoryID#"><img src="#request.imageroot#/view_mod_comments_button.gif" width="155" height="15" alt="View Moderator Comments" border="0"></a></td>
						</tr>	
						
						</cfif>	
						
						<tr>
						<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
						</tr>		
						
						</table>
					
					
					</td>				
					</tr>
					
					</table>
					
				
				</td>			
				</tr>			
				
				</table><br>
				
				
				</cfloop>
				
				
			
			<cfelse>
			
				<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 1px ##b4b4b4;">
				
				<tr>
				<td>
				
					
					<table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left:4px;padding-right:4px;padding-top:4px;padding-bottom:4px;">
					
					<tr>
					<td valign="top" width="100%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>#noideasfound#</strong></td>
					</tr>
					
					</table>
					
					
				</td>
				</tr>
					
				</table>
			
			</cfif>
			
			
	
	</td>
	</tr>
	
	
	</table>
		
		
</cfif>


</cfoutput>
		