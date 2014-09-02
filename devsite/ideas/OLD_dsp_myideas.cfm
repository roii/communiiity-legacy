<cfoutput>


<cfif IsDefined("AddDraft")>

	<cfinclude template="dsp_add_draft.cfm">

<cfelseif IsDefined("EditDraft")>

	<cfinclude template="dsp_edit_draft.cfm">

<cfelseif IsDefined("EditIdea")>

	<cfinclude template="dsp_edit_idea.cfm">
	
<cfelse>

	<cfquery name="Category" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugCategory
	WHERE Active = 1
	ORDER BY DisplayOrder
	</cfquery>


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
	</script>
	
	
	<!--- GET IDEAfunL SETTINGS --->
	<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM IdeaFunl_Settings
	</cfquery>
	
	
	<!--- GET UNAUTHORISED SUGGESTIONS --->
	<cfquery name="AllUnAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID, WhenSugMade, suggestion, SugStage, Archived, CategoryID
	FROM suggestion
	WHERE ContactID=#session.UserID#
	AND Authorise LIKE '%no%'
	
	<cfif session.srch_category NEQ 'ALL'>
		AND categoryID=#session.srch_category#						
	</cfif>
	
	<cfif session.srch_keywords NEQ ''>
		AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
		OR suggestion.Details LIKE '%#session.srch_keywords#%')	
	</cfif>
	
	ORDER BY WhenSugMade DESC
	</cfquery>	
	
	
	<!--- GET AUTHORISED SUGGESTIONS --->
	<cfquery name="AllAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID, WhenSugMade, suggestion, SugStage
	FROM suggestion
	WHERE ContactID=#session.UserID#
	AND Authorise LIKE '%yes%'
	AND Archived=0
	
	<cfif session.srch_category NEQ 'ALL'>
		AND categoryID=#session.srch_category#						
	</cfif>
	
	<cfif session.srch_keywords NEQ ''>
		AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
		OR suggestion.Details LIKE '%#session.srch_keywords#%')	
	</cfif>
	
	ORDER BY WhenSugMade DESC
	</cfquery>
	
	<!--- GET RETURNED SUGGESTIONS --->
	<cfquery name="BungIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID, WhenSugMade, suggestion
	FROM suggestion
	WHERE ContactID=#session.UserID#
	AND Archived=1
	ORDER BY WhenSugMade DESC
	</cfquery>
	
	
	
	<table width="100%" cellspacing="1" cellspacing="1">
	
	<tr>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ideafunl_mode=MyIdeas&AddDraft=1&documentID=77" style="color:###TRIM(session.AllSettings_BoxColour)#;text-decoration:none;"><strong>ADD A DRAFT IDEA &raquo;</strong></a><br><br>

		<table width="100%" border="0">
		<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
		<input type="hidden" name="fuseaction" value="#fuseaction#">
		<input type="hidden" name="fusesubaction" value="#fusesubaction#">
		<input type="hidden" name="documentID" value="#documentID#">
		<tr>
		<td><select name="srch_category" style="font-size:11px;color:###TRIM(session.AllSettings_BoxColour)#;width:290px;">
		<option value="ALL"<cfif session.srch_category EQ 'ALL'> selected</cfif>>ALL TOPICS
		<cfloop query="Category">
		<option value="#Category.categoryID#"<cfif session.srch_category EQ Category.categoryID> selected</cfif>>#TRIM(Category.Name)#
		</cfloop>
		</select> <!--- <select name="srch_period" style="font-size:11px;color:###TRIM(session.AllSettings_BoxColour)#;">
		<option value="ALL"<cfif session.srch_period EQ 'ALL'> selected</cfif>>ANY TIME
		<option value="1"<cfif session.srch_period EQ '1'> selected</cfif>>Last 24hrs
		<option value="7"<cfif session.srch_period EQ '7'> selected</cfif>>Last Week
		<option value="30"<cfif session.srch_period EQ '30'> selected</cfif>>Last Month
		</select>  ---><select name="srch_stage" style="font-size:11px;color:###TRIM(session.AllSettings_BoxColour)#;">
		<option value="ALL"<cfif session.srch_stage EQ 'ALL'> selected</cfif>>ANY STAGE
		<option value="Draft"<cfif session.srch_stage EQ 'Draft'> selected</cfif>>Draft
		<option value="Pending"<cfif session.srch_stage EQ 'Pending'> selected</cfif>>Pending
		<option value="Stage 1"<cfif session.srch_stage EQ 'Stage 1'> selected</cfif>>Stage 1
		<option value="Stage 2"<cfif session.srch_stage EQ 'Stage 2'> selected</cfif>>Stage 2
		<option value="Stage 3"<cfif session.srch_stage EQ 'Stage 3'> selected</cfif>>Stage 3
		<option value="Returned"<cfif session.srch_stage EQ 'Returned'> selected</cfif>>Returned (voted no)
		</select> <input type="text" style="font-size:11px;color:###TRIM(session.AllSettings_BoxColour)#;width:100px;" name="srch_keywords" onfocus="javascript:document.ideasearch.srch_keywords.value='';" value="<cfif session.srch_keywords NEQ ''>#session.srch_keywords#<cfelse>Keywords...</cfif>"> <input type="submit" value="SEARCH" style="font-size:11px;color:###TRIM(session.AllSettings_BoxColour)#;"></td>
		</tr>
		
		</form>
		</table><br>
		
		<cfif session.srch_stage EQ 'ALL' OR session.srch_stage EQ 'Draft'>
	
			<!--- GET DRAFT SUGGESTIONS --->
			<cfquery name="DraftIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT SugID, WhenSugMade, suggestion, CategoryID
			FROM Suggestion
			WHERE SugStage='Draft'
			AND ContactID=#session.UserID#
			ORDER BY WhenSugMade DESC
			</cfquery>
		
			<table width="100%" cellpadding="1" cellspacing="1" border="0">
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20">
			<td colspan="4" style="color:###TRIM(session.AllSettings_BoxTextColour)#;padding-left:5px;font-size:12px;"><strong>DRAFT IDEAS</strong> - Spend time getting your ideas just right!</td>
			</tr>
			
			<cfif DraftIdeas.RecordCount>
			
				<tr bgcolor="##e2e2e2">
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Date</strong></td>
				<td width="100%" style="color:###TRIM(session.AllSettings_DkTextColor)#;font-size:11px;padding-left:5px;"><strong>Idea</strong></td>
				<td colspan="2"></td>
				</tr>
				
				
				<cfloop query="DraftIdeas">
						
				<tr>
				<td align="center" style="padding-left:10px;padding-right:10px" nowrap>#DateFormat(DraftIdeas.WhenSugMade, "d-mmm-yy")#</td>
				<td style="padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#DraftIdeas.SugID#">#TRIM(DraftIdeas.Suggestion)#</a></td>
				<td style="padding-left:10px;padding-right:10px" nowrap><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=76&ideafunl_mode=add&SugID=#DraftIdeas.SugID#&CategoryID=#DraftIdeas.CategoryID#">SUBMIT</a></td>
				<td align="right" nowrap><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&ideafunl_mode=MyIdeas&EditDraft=1&SugID=#DraftIdeas.SugID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaDelete('#request.webroot#/ideas/act_delete_draft.cfm?SugID=#DraftIdeas.SugID#');"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Idea" border="0"></a></td>
				</tr>
				</cfloop>
			
			
			
			
			<cfelse>
				
				<tr>
				<td colspan="4">You currently have no Draft Ideas</td>
				</tr>
			
			
			</cfif>
			
			</table><br><br>
		
		</cfif>
	
	
		<cfif session.srch_stage EQ 'ALL' OR session.srch_stage EQ 'Pending'>
		
			<!--- GET PENDING SUGGESTIONS --->
			<cfquery name="PendingIdeas" dbtype="query">
			SELECT SugID, WhenSugMade, suggestion
			FROM AllUnAuthorisedIdeas
			WHERE SugStage LIKE '%Pending%'
			AND Archived=0
			ORDER BY WhenSugMade DESC
			</cfquery>
	
	
			<table width="100%" cellpadding="1" cellspacing="1" border="0">
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20">
			<td colspan="5" style="color:###TRIM(session.AllSettings_BoxTextColour)#;padding-left:5px;font-size:12px;"><strong>PENDING IDEAS</strong> - #IdeaSettings.Required_Pending# out of #IdeaSettings.Total_Pending# "Yes" votes required to progress to Stage 1</td>
			</tr>
			
			<cfif PendingIdeas.RecordCount>
			
				<tr bgcolor="##e2e2e2">
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Date</strong></td>
				<td width="100%" style="color:###TRIM(session.AllSettings_DkTextColor)#;font-size:11px;padding-left:5px;"><strong>Idea</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Votes</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>% Yes</strong></td>
				<td></td>
				</tr>
				
				
				<cfloop query="PendingIdeas">
				
				<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #PendingIdeas.sugID#
				</cfquery>
				
				<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #PendingIdeas.sugID#
				AND vote > 3
				</cfquery>
				
				<cfif AllVotes.RecordCount>
				
					<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
				
				<cfelse>
					
					<cfset PercentYes = 0>
					
				</cfif>
				
				
				<tr>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center">#DateFormat(PendingIdeas.WhenSugMade, "d-mmm-yy")#</td>
				<td style="padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#PendingIdeas.SugID#">#TRIM(PendingIdeas.Suggestion)#</a></td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center">#AllVotes.RecordCount#</td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center"><span title="Total Votes:#AllVotes.RecordCount# - Yes Votes: #YesVotes.RecordCount#">#INT(PercentYes)#%</span></td>
				<td nowrap><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#PendingIdeas.SugID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaRemove('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#PendingIdeas.SugID#');"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="REMOVE YOUR IDEA#chr(10)#Your idea will be moved#chr(10)#to your Returned Ideas list" border="0"></a></td>
				</tr>
				</cfloop>
			
			
			
			
			<cfelse>
				
				<tr>
				<td colspan="5">You currently have no Pending Ideas</td>
				</tr>
			
			
			</cfif>
			
			</table><br><br>
		
		</cfif>
		
		
		<cfif session.srch_stage EQ 'ALL' OR session.srch_stage EQ 'Stage 1'>
		
			<!--- GET STAGE 1 SUGGESTIONS --->
			<cfquery name="Stage1Ideas" dbtype="query">
			SELECT SugID, WhenSugMade, suggestion
			FROM AllAuthorisedIdeas
			WHERE SugStage LIKE '%Stage 1%'
			ORDER BY WhenSugMade DESC
			</cfquery>
		
			<table width="100%" cellpadding="1" cellspacing="1" border="0">
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20">
			<td colspan="5" style="color:###TRIM(session.AllSettings_BoxTextColour)#;padding-left:5px;font-size:12px;"><strong>STAGE 1 IDEAS</strong> - #IdeaSettings.Required_Stage_1# out of #IdeaSettings.Total_Stage_1# "Yes" votes required to progress to Stage 2</td>
			</tr>
			
			<cfif Stage1Ideas.RecordCount>
			
				<tr bgcolor="##e2e2e2">
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Date</strong></td>
				<td width="100%" style="color:###TRIM(session.AllSettings_DkTextColor)#;font-size:11px;padding-left:5px;"><strong>Idea</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Votes</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>% Yes</strong></td>
				<td></td>
				</tr>
				
				
				<cfloop query="Stage1Ideas">
				
				<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #Stage1Ideas.sugID#
				</cfquery>
				
				<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #Stage1Ideas.sugID#
				AND vote > 3
				</cfquery>
				
				<cfif AllVotes.RecordCount>
				
					<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
				
				<cfelse>
					
					<cfset PercentYes = 0>
					
				</cfif>
				
				
				
				<tr>
				<td align="center" style="padding-left:10px;padding-right:10px;" nowrap>#DateFormat(Stage1Ideas.WhenSugMade, "d-mmm-yy")#</td>
				<td style="padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#Stage1Ideas.SugID#">#TRIM(Stage1Ideas.Suggestion)#</a></td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center">#AllVotes.RecordCount#</td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center"><span title="Total Votes:#AllVotes.RecordCount# - Yes Votes: #YesVotes.RecordCount#">#INT(PercentYes)#%</span></td>
				<td nowrap><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#Stage1Ideas.SugID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaRemove('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#Stage1Ideas.SugID#');"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="REMOVE YOUR IDEA#chr(10)#Your idea will be moved#chr(10)#to your Returned Ideas list" border="0"></a></td>
				</tr>
				</cfloop>
			
			
			
			
			<cfelse>
				
				<tr>
				<td colspan="5">You currently have no Stage 1 Ideas</td>
				</tr>
			
			
			</cfif>
			
			</table><br><br>
		
		</cfif>
		
	
		<cfif session.srch_stage EQ 'ALL' OR session.srch_stage EQ 'Stage 2'>
		
			<!--- GET STAGE 2 SUGGESTIONS --->
			<cfquery name="Stage2Ideas" dbtype="query">
			SELECT SugID, WhenSugMade, suggestion
			FROM AllAuthorisedIdeas
			WHERE SugStage LIKE '%Stage 2%'
			ORDER BY WhenSugMade DESC
			</cfquery>
		
			<table width="100%" cellpadding="1" cellspacing="1" border="0">
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20">
			<td colspan="5" style="color:###TRIM(session.AllSettings_BoxTextColour)#;padding-left:5px;font-size:12px;"><strong>STAGE 2 IDEAS</strong> - #IdeaSettings.Required_Stage_2# out of #IdeaSettings.Total_Stage_2# "Yes" votes required to progress to Stage 3</td>
			</tr>
			
			<cfif Stage2Ideas.RecordCount>
			
				<tr bgcolor="##e2e2e2">
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Date</strong></td>
				<td width="100%" style="color:###TRIM(session.AllSettings_DkTextColor)#;font-size:11px;padding-left:5px;"><strong>Idea</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Votes</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>% Yes</strong></td>
				<td></td>
				</tr>
				
				
				<cfloop query="Stage2Ideas">
				
				<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #Stage2Ideas.sugID#
				</cfquery>
				
				<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #Stage2Ideas.sugID#
				AND vote > 3
				</cfquery>
				
				<cfif AllVotes.RecordCount>
				
					<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
				
				<cfelse>
					
					<cfset PercentYes = 0>
					
				</cfif>
				
				
				
				<tr>
				<td align="center" style="padding-left:10px;padding-right:10px;" nowrap>#DateFormat(Stage2Ideas.WhenSugMade, "d-mmm-yy")#</td>
				<td style="padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#Stage2Ideas.SugID#">#TRIM(Stage2Ideas.Suggestion)#</a></td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center">#AllVotes.RecordCount#</td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center"><span title="Total Votes:#AllVotes.RecordCount# - Yes Votes: #YesVotes.RecordCount#">#INT(PercentYes)#%</span></td>
				<td nowrap><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#Stage2Ideas.SugID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaRemove('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#Stage2Ideas.SugID#');"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="REMOVE YOUR IDEA#chr(10)#Your idea will be moved#chr(10)#to your Returned Ideas list" border="0"></a></td>
				</tr>
				</cfloop>
			
			
			
			
			<cfelse>
				
				<tr>
				<td colspan="5">You currently have no Stage 2 Ideas</td>
				</tr>
			
			
			</cfif>
			
			</table><br><br>
		
		</cfif>
	
	
		<cfif session.srch_stage EQ 'ALL' OR session.srch_stage EQ 'Stage 3'>
		
			<!--- GET STAGE 3 SUGGESTIONS --->
			<cfquery name="Stage3Ideas" dbtype="query">
			SELECT SugID, WhenSugMade, suggestion
			FROM AllAuthorisedIdeas
			WHERE SugStage LIKE '%Stage 3%'
			ORDER BY WhenSugMade DESC
			</cfquery>
		
			<table width="100%" cellpadding="1" cellspacing="1" border="0">
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20">
			<td colspan="5" style="color:###TRIM(session.AllSettings_BoxTextColour)#;padding-left:5px;font-size:12px;"><strong>STAGE 3 IDEAS</strong> - #IdeaSettings.Required_Stage_3# out of #IdeaSettings.Total_Stage_3# "Yes" votes required to START THIS IDEA!</td>
			</tr>
			
			<cfif Stage3Ideas.RecordCount>
			
				<tr bgcolor="##e2e2e2">
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Date</strong></td>
				<td width="100%" style="color:###TRIM(session.AllSettings_DkTextColor)#;font-size:11px;padding-left:5px;"><strong>Idea</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Votes</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>% Yes</strong></td>
				<td></td>
				</tr>
				
				
				<cfloop query="Stage3Ideas">
				
				<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #Stage3Ideas.sugID#
				</cfquery>
				
				<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #Stage3Ideas.sugID#
				AND vote > 3
				</cfquery>
				
				<cfif AllVotes.RecordCount>
				
					<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
				
				<cfelse>
					
					<cfset PercentYes = 0>
					
				</cfif>
				
				
				
				<tr>
				<td align="center" style="padding-left:10px;padding-right:10px;" nowrap>#DateFormat(Stage3Ideas.WhenSugMade, "d-mmm-yy")#</td>
				<td style="padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#Stage3Ideas.SugID#">#TRIM(Stage3Ideas.Suggestion)#</a></td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center">#AllVotes.RecordCount#</td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center"><span title="Total Votes:#AllVotes.RecordCount# - Yes Votes: #YesVotes.RecordCount#">#INT(PercentYes)#%</span></td>
				<td nowrap><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#Stage3Ideas.SugID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaRemove('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#Stage3Ideas.SugID#');"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="REMOVE YOUR IDEA#chr(10)#Your idea will be moved#chr(10)#to your Returned Ideas list" border="0"></a></td>
				</tr>
				</cfloop>
			
			
			
			
			<cfelse>
				
				<tr>
				<td colspan="5">You currently have no Stage 3 Ideas</td>
				</tr>
			
			
			</cfif>
			
			</table><br><br>
			
		</cfif>
	
	
		<cfif session.srch_stage EQ 'ALL' OR session.srch_stage EQ 'Returned'>
		
			
		
			<table width="100%" cellpadding="1" cellspacing="1" border="0">
			
			<tr bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="20">
			<td colspan="4" style="color:###TRIM(session.AllSettings_BoxTextColour)#;padding-left:5px;font-size:12px;"><strong>RETURNED IDEAS</strong> - Ideas which didn't make it.</td>
			</tr>
			
			<cfif BungIdeas.RecordCount>
			
				<tr bgcolor="##e2e2e2">
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Date</strong></td>
				<td width="100%" style="color:###TRIM(session.AllSettings_DkTextColor)#;font-size:11px;padding-left:5px;"><strong>Idea</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>Votes</strong></td>
				<td style="color:###TRIM(session.AllSettings_DkTextColor)#;padding-left:10px;padding-right:10px;font-size:11px;" align="center" nowrap><strong>% Yes</strong></td>
				</tr>
				
				
				<cfloop query="BungIdeas">
				
				<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #BungIdeas.sugID#
				</cfquery>
				
				<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
				SELECT *
				FROM SugVote
				WHERE sugID = #BungIdeas.sugID#
				AND vote > 3
				</cfquery>
				
				<cfif AllVotes.RecordCount>
				
					<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
				
				<cfelse>
					
					<cfset PercentYes = 0>
					
				</cfif>
				
				
				
				<tr>
				<td align="center" style="padding-left:10px;padding-right:10px;" nowrap>#DateFormat(BungIdeas.WhenSugMade, "d-mmm-yy")#</td>
				<td style="padding-left:5px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&MyIdeasMode=Details&SugID=#BungIdeas.SugID#">#TRIM(BungIdeas.Suggestion)#</a></td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center">#AllVotes.RecordCount#</td>
				<td style="padding-left:10px;padding-right:10px;" nowrap align="center"><span title="Total Votes:#AllVotes.RecordCount# - Yes Votes: #YesVotes.RecordCount#">#INT(PercentYes)#%</span></td>
				</tr>
				</cfloop>
			
			
			
			
			<cfelse>
				
				<tr>
				<td colspan="4">You currently have no Returned Ideas</td>
				</tr>
			
			
			</cfif>
			
			</table>
			
		</cfif>
		
		
	
	</td>
	</tr>
	
	</table>

	
</cfif>


</cfoutput>
		