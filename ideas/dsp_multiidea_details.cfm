<cfoutput>

<!--- GET ALL MAIN CATEGORIES FOR DROP DOWN --->
<cfinclude template="qry_all_maincats.cfm">

<!--- CAPTURE WHETHER DIRECTED FROM MULTIVOTE FORM OR SINGLE IDEA --->
<cfif IsDefined("returnIdeas")>
	<cfset returnIdeas = returnIdeas & "0">
<cfelseif IsDefined("SingleIdea")>
	<cfset returnIdeas = SingleIdea>	
</cfif>

<cfif IsDefined("url.Pending")>

	<!--- GET SUGGESTION DETAILS FOR SUGGESTIONS IN LIST ABOVE --->
	<cfquery name="qry_display_suggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, suggestion.Reward
	FROM suggestion
	WHERE suggestion.SugID IN (#returnIdeas#)
	</cfquery>
	
<cfelseif IsDefined("returnIdeas")>	
	
	<!--- GET SUGGESTION DETAILS FOR SUGGESTIONS IN LIST ABOVE --->
	<cfquery name="qry_display_suggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.SugStage, suggestion.Reward
	FROM suggestion
	WHERE suggestion.SugID IN (#returnIdeas#)
	ORDER BY SugStage DESC
	</cfquery>
	
<cfelse>

	<cflocation url="#request.webroot#/index.cfm?fuseaction=ideas">

</cfif>

<cfif IsDefined("currentcategory")>
	<cfset currentcategory = currentcategory>
<cfelse>
	<cfset currentcategory = qry_display_suggestions.CategoryID>
</cfif>

<!--- GET THE SELECTED TOPIC DETAILS --->
<cfinclude template="qry_current_topic.cfm">

<cfset this_categoryID = qry_current_topic.CategoryID>

<!--- GET THE STAGE DETAILS --->
<cfinclude template="act_topic_stages.cfm">

<!--- GET THE SELECTED TOPIC SPONSOR --->
<cfinclude template="qry_topic_sponsor.cfm">

<!--- FIND OUT HOW MANY POINTS HAVE BEEN EARNED AGAINST THIS TOPIC --->
<cfinclude template="qry_category_points_calculation.cfm">


<script type="text/javascript">
<!--
function toggleContent(which) {
	if(document.getElementById("idea"+which).style.display=="block") {
		document.getElementById("idea"+which).style.display="none";
	} else {
		document.getElementById("idea"+which).style.display="block";
	}
}
//-->
</script>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td valign="middle"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75"><img src="#request.imageroot#/ideaFunL/new_02_1.gif" width="35" height="52" alt="1. Select a topic" border="0"></a><img src="#request.imageroot#/ideaFunL/new_02_2.gif" width="59" height="52" alt="2. VIEW IDEAS" border="0"><img src="#request.imageroot#/ideaFunL/new_02_3.gif" width="36" height="52" alt="3. Vote on an idea" border="0"><br>
<img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="8"><br></td>
<td align="right" valign="middle">
	
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	
	<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
	<input type="hidden" name="fuseaction" value="ideas">
	<input type="hidden" name="fusesubaction" value="docs">
	<input type="hidden" name="documentID" value="75">
	<input type="hidden" name="IdeaFunL_Startrow" value="1">
	
	<tr>
	<td align="right"><select name="currentcategory" class="whitefield" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#; width:300px;" onchange="document.ideasearch.submit();">
	<optgroup label="">
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
	<option value="#Category.categoryID#"<cfif currentcategory EQ Category.categoryID> selected</cfif>>- #TRIM(Category.Name)#
	</cfloop>
	<option value="">
	</cfloop>
	</select></td>
	</tr>
	
	</form>
	</table>
	
</td>
</tr>

</table><br>


<table width="100%" cellpadding="8" cellspacing="0" style="border:solid 1px b4b4b4;">

<tr>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<td width="40" align="left" valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"><br><cfif FileExists("#request.fileroot#\images\partners\#TRIM(qry_topic_sponsor.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(qry_topic_sponsor.LogoFile)#" border="0" title="#TRIM(qry_topic_sponsor.Organisation_Name)#"></cfif></td>
	<td valign="top" align="right" width="100%">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td colspan="3"><span style="font-size:14px;color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(qry_current_topic.Name)#</strong></span><br>
		#TRIM(qry_current_topic.description)#
		<hr size=1 color=e2e2e2>
		</td>
		</tr>
		
		<tr>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Sponsor:</strong> #TRIM(qry_topic_sponsor.Organisation_Name)#</td>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Points Available:</strong> #this_pointsremaining#</td>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;" align="right"><strong>Finishes:</strong> <cfif this_pointsremaining EQ 0>Finished<cfelseif IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>Finished<cfelse>#DateFormat(qry_current_topic.WhenCategoryEnded)#</cfif></td>
		</tr>
		
		<cfif add_idea EQ 0>
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;padding-top:4px;font-size:11px;" colspan="3"><hr width="100%" size="1" color="e2e2e2"><strong>NOTE:</strong> <cfif vote_idea EQ 1>The "add-idea" cut-off has been reached. You cannot add new ideas but you can review and vote on submitted ideas.<cfelse>This topic has finished. You can review the submitted ideas but cannot add new ideas or vote.</cfif></td>
			</tr>		
		</cfif>
		
		</table>
	
	
	</td>
	</tr>
	
	</table>
	<hr width="100%" size="1" color="b4b4b4">
	
	
	<table width="100%" cellspacing="1" cellspacing="1">
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="3"><br>
	
		<table width="100%" cellpadding="1" cellspacing="1" border="0">		
			
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"><br>

			<table width="100%" border="0" cellpadding="0" cellspacing="0">
			
			<form method="post" action="#request.webroot#/index.cfm" name="ideasearch2">
			<input type="hidden" name="fuseaction" value="#fuseaction#">
			<input type="hidden" name="fusesubaction" value="#fusesubaction#">
			<input type="hidden" name="documentID" value="#documentID#">
			<input type="hidden" name="IdeaFunL_StartRow" value="1">
			<input type="hidden" name="currentcategory" value="#currentcategory#">
			
			<tr>
			<td><select name="srch_stage" class="whitefield" style="height:20px; width: 300px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
			<option value="ALL"<cfif session.srch_stage EQ 'ALL'> selected</cfif>>ANY STAGE
			<option value="Stage 1"<cfif session.srch_stage EQ 'Stage 1'> selected</cfif>>Stage 1
			<option value="Stage 2"<cfif session.srch_stage EQ 'Stage 2'> selected</cfif>>Stage 2
			<option value="Stage 3"<cfif session.srch_stage EQ 'Stage 3'> selected</cfif>>Stage 3
			</select> <input type="text" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;" name="srch_keywords" onfocus="javascript:document.ideasearch.srch_keywords.value='';" value="<cfif session.srch_keywords NEQ ''>#session.srch_keywords#<cfelse>Keywords...</cfif>"> <input type="submit" value="SEARCH" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;"></td>
			<td align="right"><cfif add_idea EQ 1><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=76&categoryID=#currentcategory#"><img src="#request.imageroot#/ideaFunL/new_add_idea.gif" width="101" height="23" alt="Add New Idea" border="0"></a></cfif></td>
			</tr>
			
			</form>
			</table>			
			
			<script type="text/javascript">
			<!--
			function OpenAllIdeas() {
			<cfloop query="qry_display_suggestions" startrow="1" endrow="#qry_display_suggestions.RecordCount#">
			<cfset this_sugID = qry_display_suggestions.SugID>
			document.getElementById("idea"+#this_sugID#).style.display="block";
			</cfloop>
			}
			//-->			
			<!--
			function CloseAllIdeas() {
			<cfloop query="qry_display_suggestions" startrow="1" endrow="#qry_display_suggestions.RecordCount#">
			<cfset this_sugID = qry_display_suggestions.SugID>
			document.getElementById("idea"+#this_sugID#).style.display="none";
			</cfloop>
			}
			//-->
			</script>

			<hr width="100%" size="1" color="e2e2e2">
			
						
		</td>
		</tr>
			
		<tr>
		<td>
				
			<table width="100%" cellpadding="0" cellspacing="1" border="0">
			
			<tr>
			<td width="100%">
				
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td height="1" colspan="5" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
				</tr>
				
				<tr>
				<td height="2" colspan="5"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="2"></td>
				</tr>
				
				<tr>
				<td width="23"><img src="#request.imageroot#/ideaFunL/new_vote_yes.gif" width="23" height="17" alt="YES" border="0"></td>
				<td width="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="17"></td>
				<td width="23"><img src="#request.imageroot#/ideaFunL/new_vote_no.gif" width="23" height="17" alt="NO" border="0"></td>
				<td width="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="17"></td>
				<td bgcolor="##e2e2e2" style="font-size:11px;color:##444444;padding-left:4px;" valign="middle"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="17" align="absmiddle"><strong>Click idea title for more details and to view feedback...</strong></td>
				</tr>
				
				<tr>
				<td height="2" colspan="5"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="2"></td>
				</tr>
				
				<tr>
				<td height="1" colspan="5" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
				</tr>
				
				</table>
			
			</td>
			</tr>
			
			</table>
			
		</td>			
		</tr>
		
		<tr>
		<td style="padding-top:5px;padding-bottom:10px;">
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td style="color:##444444; font-size:11px;" width="140"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="140" height="1"><br>	All Ideas:&nbsp; <strong><a href="##" onClick="OpenAllIdeas(); return false;" style="color:##444444;">OPEN</a> | <a href="##" onClick="CloseAllIdeas(); return false;" style="color:##444444;">CLOSE</a></strong></td>
			<td align="right"><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75" style="color:##000000;font-size:11px;"><strong>TAKE ME TO MORE IDEAS NEEDING MY VOTE</strong></a></td>
			</tr>
			
			</table>
		
		</td>
		</tr>		
		
		<tr>
		<td><table cellpadding="0" cellspacing="0" border="0" width="100%"><tr><td height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td></tr></table></td>
		</tr>
		
		<!--- loop to display the suggestion  --->
		<cfloop query="qry_display_suggestions">
			
		<cfset this_sugID = qry_display_suggestions.SugID>
		<cfset this_ContactID = qry_display_suggestions.ContactID>
		<cfset this_idea = TRIM(qry_display_suggestions.Suggestion)>
		<cfset this_details = TRIM(qry_display_suggestions.Details)>
		<cfset this_suggested = TRIM(qry_display_suggestions.WhenSugMade)>
		<cfset this_stage = TRIM(qry_display_suggestions.SugStage)>
		<cfset this_archived = qry_display_suggestions.archived>
		<cfset this_reward = qry_display_suggestions.reward>
		<cfset this_category = qry_display_suggestions.CategoryID>
		
		<cfquery datasource="#dsn#"  name="ContactStuff" username="#request.username#" password="#request.password#">
		SELECT FirstName, ScreenName, ContactID
		FROM Contacts
		WHERE ContactID=#this_ContactID#
		</cfquery>	
	
	
		<cfif session.UserIsAuthenticated EQ 'yes' AND IsDefined("session.UserID")>
			
			<!--- check if user has voted for this current suggestion --->
			<cfquery datasource="#dsn#"  name="qry_user_vote" username="#request.username#" password="#request.password#">
			SELECT vote
			FROM SugVote
			WHERE sugID = #this_sugID#
			AND ContactID=#session.UserID#
			</cfquery>
							
			<!--- check if user is watching this idea --->
			<cfquery datasource="#dsn#"  name="qry_user_watch" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugWatchList
			WHERE sugID = #this_sugID#
			AND ContactID=#session.UserID#
			</cfquery>
			
		</cfif>
					
		<cfinclude template="qry_idea_votes.cfm">
		
		<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
		SELECT *
		FROM SugVote
		WHERE sugID = #this_sugID#
		AND vote > 3
		</cfquery>
		
		<cfif qry_idea_votes.RecordCount>			
			<cfset PercentYes = (YesVotes.RecordCount / qry_idea_votes.RecordCount * 100)>			
		<cfelse>				
			<cfset PercentYes = 0>				
		</cfif>		
			
		<!--- MODERATOR COMMENTS --->
		<cfquery name="qry_sug_comments" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SugComments.CommentDate, SugComments.Comment, SugComments.PublicView, Contacts.ScreenName
		FROM SugComments, Contacts
		WHERE SugComments.sugID = #this_sugID#
		AND SugComments.ModeratorID=Contacts.ContactID
		<cfif session.UserIsAuthenticated AND session.UserID NEQ this_contactID>
			AND SugComments.PublicView=1
		</cfif>
		ORDER BY SugComments.CommentDate DESC
		</cfquery>		
			
		<tr>
		<td>			
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
			<tr>
			<td width="50"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="50" height="1"><br><a name="IDEA_#this_SugID#" href="##IDEA_#this_SugID#" onClick="toggleContent(#this_SugID#); return false;" style="text-decoration:none;"><strong>#NumberFormat(this_SugID, "000000")#</strong> - </a></td>
			<td width="100%" style="padding-left:3px;"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"><br>
			<a name="IDEA_#this_SugID#" href="##IDEA_#this_SugID#" onClick="toggleContent(#this_SugID#); return false;"><strong>#this_idea#</strong></a></td>
			</tr>
			
			</table>
				
		</td>
		</tr>
		
		<cfif (session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator') OR ((session.UserIsAuthenticated EQ 'Yes' AND qry_user_vote.RecordCount) OR (session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.UserID) OR (this_stage CONTAINS 'Stage 4') OR (this_stage CONTAINS 'Stage 5'))>
		
			<tr>
			<td style="padding-top:3px;">			
				
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					
				<tr>
				<td width="50"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="50" height="1"></td>
				<td width="100%" style="padding-left:10px;">
	
					<table cellpadding="0" cellspacing="0" border="0" width="490">
					
					<tr>
					<td style="font-size:11px;color:##444444;" width="170"><strong>By:&nbsp;</strong> <cfif TRIM(ContactStuff.ScreenName) NEQ ''><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(ContactStuff.ScreenName)#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(ContactStuff.ScreenName)#" style="color:###TRIM(Allsettings.BoxColour)#;" title="View Profile"><strong>#TRIM(ContactStuff.ScreenName)#</strong><cfelse><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(ContactStuff.ContactID)#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(ContactStuff.ContactID)#" style="color:###TRIM(Allsettings.BoxColour)#;" title="View Profile"><strong>#TRIM(ContactStuff.FirstName)#</strong></cfif></a></td>
				
					<cfif this_stage DOES NOT CONTAIN 'Draft'>
						<td style="font-size:11px;color:##444444;" width="100"><strong>Votes:&nbsp;</strong> #qry_idea_votes.RecordCount#</td>
						<td style="font-size:11px;color:##444444;" width="120"><strong>% Yes:&nbsp;</strong> #NumberFormat(PercentYes, "0.0")#%</td>
						<cfif session.UserIsAuthenticated EQ 'yes'>
						<td style="font-size:11px;color:##444444;" width="150"><strong>Your Vote:&nbsp;</strong> <cfif qry_user_vote.Vote GT 1>YES<cfelseif session.userID EQ this_contactID>Your Idea!<cfelse>NO</cfif></td></cfif>
					</cfif>
				
					</tr>
					
					</table>
				
				</td>
				</tr>
				
				</table>
					
			</td>
			</tr>
			
			
		
		</cfif>
		
		<tr>
		<td style="display:block;" id="idea#this_SugID#">			
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
			<tr>
			<td width="50"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="50" height="4"></td>
			<td width="100%" style="padding-left:3px;"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="50" height="4"><br>

				<table width="100%" cellpadding="4" cellspacing="0" style="border:dashed 1px ##b4b4b4;">
					
                    <cfif this_details NEQ ''>
						<tr>
						<td colspan="3"><strong>Details:&nbsp;</strong> #this_details#</td>
						</tr>
					</cfif>		
                    			
					 <cfif (session.UserIsAuthenticated EQ 'Yes') AND ((qry_user_vote.RecordCount) OR (this_ContactID EQ session.UserID) OR (session.UserType EQ 'Administrator'))>
					<tr>
					<td style="border-top:dashed 1px ##b4b4b4;font-size:11px;color:##444444;width:164px;" width="164"><strong>Suggested:&nbsp;</strong> #DateFormat(this_suggested)#</td>
					<td style="border-top:dashed 1px ##b4b4b4;font-size:11px;color:##444444;width:100px;" width="100"><strong>Stage:&nbsp;</strong> #TRIM(this_stage)#</td>
					<td style="border-top:dashed 1px ##b4b4b4;font-size:11px;color:##444444;" align="right"><!--- <strong>Report:&nbsp;</strong> <a href="##" style="color:###TRIM(AllSettings.BoxColour)#">Duplicate</a> | <a href="##" style="color:###TRIM(AllSettings.BoxColour)#">Wrong Category</a> | <a href="##" style="color:###TRIM(AllSettings.BoxColour)#">Offensive</a> --->&nbsp;</td>
					</tr>
					</cfif>
					</table><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="4"><br>
				
				<!--- IF THEY HAVE IDEA MODERATOR (MOVE IDEA) RIGHTS --->
				<cfif session.UserIsAuthenticated EQ 'Yes' AND session.Permission3_View EQ 1 AND session.UserID NEQ this_ContactID AND ListFind(qry_current_topic.Moderators, session.UserID, ",") AND this_stage DOES NOT CONTAIN 'Stage 4' AND this_stage DOES NOT CONTAIN 'Stage 5'>

					<table cellpadding="0" cellspacing="0" border="0">
					
					<tr>
					<td valign="top"><input type="button" class="whitefield"  onclick="window.open('#request.webroot#/ideas/dsp_moderator_action.cfm?sugID=#this_sugID#&currentcategory=#currentcategory#','moveIdea','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10');" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Move Idea &raquo;"> <input type="button" class="whitefield"  onclick="window.open('#request.webroot#/ideas/dsp_moderator_comments.cfm?sugID=#this_sugID#&currentcategory=#currentcategory#','Modcomment','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10');" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Moderator Comments &raquo;"></td>
					</tr>
						
					<tr>
					<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
					</tr>
					
					</table>
				
				</cfif>
				
				<cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID>
					<table cellpadding="0" cellspacing="0" border="0">
					
					
					<tr>
					<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><cfif this_stage DOES NOT CONTAIN 'Stage 4' AND this_stage DOES NOT CONTAIN 'Stage 5' AND this_stage DOES NOT CONTAIN 'Draft' AND this_archived NEQ 1><input type="button" class="whitefield" onclick="javascript:self.location='#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#this_SugID#';"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Edit Idea &raquo;">&nbsp;&nbsp;<input type="button" class="whitefield" onclick="javascript:confirmIdeaRemove('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#this_SugID#');"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Remove Idea &raquo;"><cfelseif this_stage CONTAINS 'Draft'><input type="button" class="whitefield" onclick="javascript:self.location='#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#this_SugID#&MainCatID=#this_MainCatID#';"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Edit Draft &raquo;">&nbsp;&nbsp;<input type="button" class="whitefield" onclick="javascript:self.location='#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=76&ideafunl_mode=add&SugID=#this_SugID#&CategoryID=#this_category#';"style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Submit Idea &raquo;"></cfif></td>
					</tr>
					</table>
				</cfif>
				
				<cfif qry_sug_comments.recordcount>				
					<cfinclude template="dsp_idea_mod_comments.cfm">				
				</cfif>
								
								
				<cfif this_stage DOES NOT CONTAIN 'Draft'>
				<cfif (session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator') OR ((session.UserIsAuthenticated EQ 'Yes' AND qry_user_vote.RecordCount) OR (session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.UserID) OR (this_stage CONTAINS 'Stage 4') OR (this_stage CONTAINS 'Stage 5'))>
 				
					<cfinclude template="dsp_idea_feedback.cfm">
				
				</cfif>
				</cfif>

			</td>
			</tr>
			
			</table>			
			
		</td>
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="2"><table cellpadding="0" cellspacing="0" border="0" width="100%"><tr><td height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td></tr></table></td>
		</tr>
		
		</cfloop>
		 
		</table>				
					
	</td>
	</tr>
	
	</table>
	
</td>
</tr>

</table>

</cfoutput>
		