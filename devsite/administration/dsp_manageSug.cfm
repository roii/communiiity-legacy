<script language="javascript">
 <!--
	function confirmIdeaDelete(aURL) {
	    if(confirm('Are you sure you want to archive this Idea?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>


<cfparam name="session.Ideas_StartRow" default="1">
<cfif isdefined("Ideas_StartRow")>	
	<cfset session.Ideas_StartRow = Ideas_StartRow>
</cfif>	
	
<cfparam name="session.Ideas_MaxRows" default="10">
<cfif isdefined("Ideas_MaxRows")>	
	<cfset session.Ideas_MaxRows = Ideas_MaxRows>
</cfif>

<cfparam name="session.NoVoteIdeas_StartRow" default="1">
<cfif isdefined("NoVoteIdeas_StartRow")>	
	<cfset session.NoVoteIdeas_StartRow = NoVoteIdeas_StartRow>
</cfif>	
	
<cfparam name="session.NoVoteIdeas_MaxRows" default="10">
<cfif isdefined("NoVoteIdeas_MaxRows")>	
	<cfset session.NoVoteIdeas_MaxRows = NoVoteIdeas_MaxRows>
</cfif>
	
	
<!--- GET ALL MAIN CATEGORIES FOR DROP DOWN --->
<cfinclude template="../ideas/qry_all_maincats.cfm">

<cfquery name="qry_all_topics" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryID, MainCatID, Name, Description, Active, DisplayOrder
FROM SugCategory
</cfquery>

<cfparam name="session.IdeaSortBy" default="suggestion.SugStage">
<cfif isDefined("IdeaSortBy")>
	<cfset session.IdeaSortBy = IdeaSortBy>
</cfif>

<cfparam name="session.IdeaSortOrder" default="asc">
<cfif isDefined("IdeaSortOrder")>
	<cfset session.IdeaSortOrder = IdeaSortOrder>
</cfif>


<cfparam name="session.srch_category" default="ALL">
<cfif isDefined("srch_category")>
	<cfset session.srch_category = srch_category>
</cfif>

<cfparam name="session.srch_period" default="ALL">
<cfif isDefined("srch_period")>
	<cfset session.srch_period = srch_period>
</cfif>

<cfparam name="session.srch_stage" default="Pending">
<cfif isDefined("srch_stage")>
	<cfset session.srch_stage = srch_stage>
</cfif>

<cfparam name="session.srch_keywords" default="">
<cfif isDefined("srch_keywords") AND srch_keywords NEQ 'Keywords...'>
	<cfset session.srch_keywords = srch_keywords>
</cfif>

<cfparam name="session.srch_archive" default="0">
<cfif isDefined("srch_archive") AND srch_archive NEQ 'ALL'>
	<cfset session.srch_archive = srch_archive>
</cfif>

<cfquery name="AllSuggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.WhenSugEnded, suggestion.SugStage, count(SugVote.vote) as voteReceived
FROM suggestion, Contacts, SugVote
WHERE suggestion.ContactID=Contacts.ContactID
AND suggestion.SugID=SugVote.SugID
<cfif session.srch_archive EQ 0>
	AND suggestion.Archived=0
<cfelseif session.srch_archive EQ 1>
	AND suggestion.Archived=1
</cfif>
<cfif session.srch_category NEQ 'ALL'>
	AND suggestion.categoryID=#session.srch_category#						
</cfif>
<cfif session.srch_stage NEQ 'ALL'>
	AND suggestion.SugStage LIKE '%#session.srch_stage#%'				
</cfif>
<cfif session.srch_keywords NEQ ''>
	AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
	OR suggestion.Details LIKE '%#session.srch_keywords#%' 
	OR Contacts.FirstName LIKE '%#session.srch_keywords#%' 
	OR contacts.lastName LIKE '%#session.srch_keywords#%')	
</cfif>
GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.WhenSugEnded, suggestion.SugStage
ORDER BY #session.IdeaSortBy# #session.IdeaSortOrder#
</cfquery>

<cfif AllSuggestions.RecordCount>
	<cfset VoteIdeas = ValueList(AllSuggestions.SugID)>
<cfelse>
	<cfset VoteIdeas="0">
</cfif>

<!--- SET THE members_endrow VALUE --->
<cfif session.Ideas_MaxRows NEQ 'ALL'>
	<cfif AllSuggestions.RecordCount GT (session.Ideas_StartRow + session.Ideas_MaxRows) - 1>
		<cfset Ideas_endrow = session.Ideas_StartRow + session.Ideas_MaxRows - 1>
	<cfelse>
		<cfset Ideas_endrow = AllSuggestions.RecordCount>
	</cfif>
<cfelse>
	<cfset Ideas_endrow = AllSuggestions.RecordCount>
</cfif>

<!--- SET THE PREV VALUE --->
<cfif session.Ideas_Startrow GT session.Ideas_Maxrows>
	<cfset prev = session.Ideas_Startrow-session.Ideas_Maxrows>
<cfelse>
	<cfset prev = session.Ideas_StartRow>
</cfif>

<!--- SET THE NEXT VALUE --->
<cfif Ideas_endrow LT AllSuggestions.RecordCount>
	<cfset next = (Ideas_endrow+1)>
<cfelse>
	<cfset next = session.Ideas_StartRow>
</cfif>

<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.Ideas_MaxRows NEQ 'ALL'>
	<cfset NumberCount=(AllSuggestions.RecordCount / session.Ideas_Maxrows)>
	<cfset IdeasNumberCount=Ceiling(NumberCount)>
<cfelse>
	<cfset IdeasNumberCount=1>	
</cfif>


<cfquery name="NoVoteIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.WhenSugEnded, suggestion.SugStage
FROM suggestion, Contacts
WHERE suggestion.SugID NOT IN (#VoteIdeas#)
AND suggestion.ContactID=Contacts.ContactID

<cfif session.srch_archive EQ 0>
	AND suggestion.Archived=0
<cfelseif session.srch_archive EQ 1>
	AND suggestion.Archived=1
</cfif>

<cfif session.srch_category NEQ 'ALL'>
	AND suggestion.categoryID=#session.srch_category#						
</cfif>

<cfif session.srch_stage NEQ 'ALL'>
	AND suggestion.SugStage LIKE '%#session.srch_stage#%'				
</cfif>

<cfif session.srch_keywords NEQ ''>
	AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
	OR suggestion.Details LIKE '%#session.srch_keywords#%' 
	OR Contacts.FirstName LIKE '%#session.srch_keywords#%' 
	OR contacts.lastName LIKE '%#session.srch_keywords#%')	
</cfif>

GROUP BY suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.WhenSugEnded, suggestion.SugStage
ORDER BY #session.IdeaSortBy# #session.IdeaSortOrder#
</cfquery>

<!--- SET THE members_endrow VALUE --->
<cfif session.NoVoteIdeas_MaxRows NEQ 'ALL'>
	<cfif NoVoteIdeas.RecordCount GT (session.NoVoteIdeas_StartRow + session.NoVoteIdeas_MaxRows) - 1>
		<cfset NoVoteIdeas_endrow = session.NoVoteIdeas_StartRow + session.NoVoteIdeas_MaxRows - 1>
	<cfelse>
		<cfset NoVoteIdeas_endrow = NoVoteIdeas.RecordCount>
	</cfif>
<cfelse>
	<cfset NoVoteIdeas_endrow = NoVoteIdeas.RecordCount>
</cfif>

<!--- SET THE PREV VALUE --->
<cfif session.NoVoteIdeas_Startrow GT session.NoVoteIdeas_Maxrows>
	<cfset prev = session.NoVoteIdeas_Startrow-session.NoVoteIdeas_Maxrows>
<cfelse>
	<cfset prev = session.NoVoteIdeas_StartRow>
</cfif>

<!--- SET THE NEXT VALUE --->
<cfif NoVoteIdeas_endrow LT NoVoteIdeas.RecordCount>
	<cfset next = (NoVoteIdeas_endrow+1)>
<cfelse>
	<cfset next = session.NoVoteIdeas_StartRow>
</cfif>

<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.NoVoteIdeas_MaxRows NEQ 'ALL'>
	<cfset NumberCount=(NoVoteIdeas.RecordCount / session.NoVoteIdeas_Maxrows)>
	<cfset NoVoteIdeasNumberCount=Ceiling(NumberCount)>
<cfelse>
	<cfset NoVoteIdeasNumberCount=1>	
</cfif>

<cfoutput>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE IDEAS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<cfinclude template="dsp_manageSug_Filters.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">		

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td colspan="4"><strong>IDEAS WITH VOTES</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>#AllSuggestions.RecordCount#</strong> Ideas. Displaying <strong>#session.Ideas_StartRow# - #Ideas_EndRow#</strong></td>
	<td align="right" style="font-size:11px;" colspan="4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Ideas_maxrows=20&Ideas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Ideas_maxrows=50&Ideas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Ideas_maxrows=100&Ideas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Ideas_maxrows=ALL&Ideas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<!--- display allow sorting column --->
	
	<tr>
	<td style="padding-left:10px;font-size:11px;"></td>
	<td style="padding-left:10px;font-size:11px;" nowrap><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortBy=suggestion.WhenSugMade&IdeaSortOrder=<cfif session.IdeaSortOrder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Start / End</strong></a></td>
	<td style="padding-left:10px;font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortBy=suggestion.suggestion&IdeaSortOrder=<cfif session.IdeaSortOrder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Idea / [Category] [Topic]</strong></a></td>
	<td style="padding-left:10px;font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortBy=suggestion.contactID&IdeaSortOrder=<cfif session.IdeaSortOrder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>By</strong></a></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortBy=suggestion.sugstage&IdeaSortOrder=<cfif session.IdeaSortOrder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Stage</strong></a></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center"><strong>% Yes</strong></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortBy=voteReceived&IdeaSortOrder=<cfif session.IdeaSortOrder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Votes</strong></a></td>
	<td style="padding-left:5px;font-size:11px;"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<form method="post" action="#request.webroot#/administration/act_ideas_multireverse.cfm" name="MultiReverse">
	<input type="hidden" name="TotalRecs" value="#session.Ideas_MaxRows#">
	
	<cfloop query="AllSuggestions" startrow="#session.Ideas_StartRow#" endrow="#Ideas_endrow#">
	
	<cfset this_sugID = AllSuggestions.SugID>
	<cfset this_ContactID = AllSuggestions.ContactID>
	<cfset this_CategoryID = AllSuggestions.CategoryID>
		
	<cfquery datasource="#dsn#"  name="ContactStuff" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName, ScreenName
	FROM Contacts
	WHERE ContactID=#this_ContactID#
	</cfquery>
	
	<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugVote
	WHERE sugID = #this_sugID#
	</cfquery>
	
	<cfquery name="YesVotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugVote
	WHERE sugID = #this_sugID#
	AND vote > 3
	</cfquery>
	
	<cfif IsDefined("this_categoryID") AND IsNumeric("#this_categoryID#")>
	
		<cfquery name="qry_current_topic" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Name, MainCatID
		FROM SugCategory
		WHERE CategoryID=#this_categoryID#
		</cfquery>
		
	</cfif>
	
	<cfif IsDefined("qry_current_topic.MainCatID") AND IsNumeric("#qry_current_topic.MainCatID#")>
		
		<cfquery name="qry_current_cat" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT MainCatTitle
		FROM SugMainCategory
		WHERE MainCatID=#qry_current_topic.MainCatID#
		</cfquery>
		
	</cfif>
	

	<cfif AllVotes.RecordCount>	
		<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>	
	<cfelse>		
		<cfset PercentYes = 0>		
	</cfif>
	
	<input type="hidden" name="SugID_#AllSuggestions.CurrentRow#" value="#this_sugID#">
	
	<tr>
	<td style="padding-left:10px;font-size:11px;" valign="top"><input type="checkbox" class="whitefield" name="Delete_#AllSuggestions.CurrentRow#" value="1" style="border:none;"></td>
	<td style="padding-left:10px;font-size:11px;" nowrap valign="top">#DateFormat(AllSuggestions.WhenSugMade, "d-mmm-yyyy")#<br>#DateFormat(AllSuggestions.WhenSugEnded, "d-mmm-yyyy")#</td>
	<td style="padding-left:10px;font-size:11px;" valign="top"><a title="<cfif IsDefined('qry_current_cat') AND qry_current_cat.recordcount>#TRIM(qry_current_cat.MainCatTitle)# </cfif><cfif IsDefined('qry_current_topic')>#TRIM(qry_current_topic.Name)#</cfif>" href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#this_categoryID#" target="_Blank"><strong>#TRIM(AllSuggestions.suggestion)#</strong></a><cfif AllSuggestions.archived CONTAINS 1>&nbsp;&nbsp;&nbsp;<span style="color:red">[A]</span></cfif><br><span style="font-size:10px;">#TRIM(AllSuggestions.details)#</span></td>
	<td style="padding-left:10px;font-size:11px;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr><td style="padding-right:5px;padding-top:3px;" width="15" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a></td><td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile">#TRIM(ContactStuff.FirstName)# #TRIM(ContactStuff.LastName)#</a><br><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile">[#TRIM(ContactStuff.ScreenName)#]</a></td></tr></table></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center" valign="top">#TRIM(AllSuggestions.SugStage)#</td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center" valign="top">#INT(PercentYes)#%</td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center" valign="top">#AllVotes.RecordCount#</td>
	<td style="padding-left:5px;font-size:11px;" align="right" valign="top"><a href="#request.webroot#/administration/dsp_edit_idea.cfm?sugID=#sugID#" target="editIdea" onclick="fdbackwindow=window.open ('','editIdea','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaDelete('#request.webroot#/administration/act_RemoveSug.cfm?sugID=#sugID#')"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Idea" border="0"></a>&nbsp;<cfif (TRIM(AllSuggestions.SugStage) CONTAINS 'Pending') OR (TRIM(AllSuggestions.SugStage) CONTAINS 'Stage 1') OR (TRIM(AllSuggestions.SugStage) CONTAINS 'Stage 2') OR (TRIM(AllSuggestions.SugStage) CONTAINS 'Stage 3')><a href="#request.webroot#/administration/dsp_move_idea.cfm?sugID=#sugID#" target="moveIdea" onclick="fdbackwindow=window.open ('','moveIdea','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=500,top=10,left=10')"><img src="images/icon_move.gif" width="10" height="10" alt="Move Idea" border="0"></a>&nbsp;</cfif><a href="javascript:confirmReverse('#request.webroot#/administration/act_reverse.cfm?type=idea&SugID=#sugID#');" title="Reverse this Idea">R</a></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	
	<tr>
	<td colspan="2" style="font-size:11px;" valign="top"><a href="javascript:document.MultiReverse.submit();" style="color:###TRIM(AllSettings.BoxColour)#;">Reverse Selected</a></td>
	<td align="right" colspan="6" style="font-size:11px;" valign="top"><cfif session.Ideas_Startrow GT session.Ideas_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Ideas_Startrow=#prev#" style="color:###TRIM(AllSettings.BoxColour)#;">Prev Page</a> | </cfif><cfif Ideas_endrow LT AllSuggestions.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Ideas_Startrow=#next#" style="color:###TRIM(AllSettings.BoxColour)#;">Next Page</a> &gt;</cfif><cfif session.Ideas_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#IdeasNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Ideas_Maxrows*NumberCount-session.Ideas_Maxrows+1)><cfif thisStartRow EQ session.Ideas_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Ideas_Startrow=#thisStartRow#" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif>#NumberCount#<cfif thisStartRow EQ session.Ideas_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ IdeasNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</td>
	</tr>
	
	</form>
	
	
	
	<tr>
	<td colspan="4"><br><br><br><br><strong>IDEAS WITHOUT ANY VOTES</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>#NoVoteIdeas.RecordCount#</strong> Ideas Without Votes. Displaying <strong>#session.NoVoteIdeas_StartRow# - #NoVoteIdeas_EndRow#</strong></td>
	<td align="right" style="font-size:11px;" colspan="4"><br><br><br><br>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&NoVoteIdeas_maxrows=20&NoVoteIdeas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&NoVoteIdeas_maxrows=50&NoVoteIdeas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&NoVoteIdeas_maxrows=100&NoVoteIdeas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&NoVoteIdeas_maxrows=ALL&NoVoteIdeas_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;font-size:11px;"></td>
	<td style="padding-left:10px;font-size:11px;" nowrap><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortby=suggestion.WhenSugMade&IdeaSortorder=<cfif session.IdeaSortorder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Start / End</strong></a></td>
	<td style="padding-left:10px;font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortby=suggestion.suggestion&IdeaSortorder=<cfif session.IdeaSortorder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Idea / [Category] [Topic]</strong></a></td>
	<td style="padding-left:10px;font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortby=suggestion.contactID&IdeaSortorder=<cfif session.IdeaSortorder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>By</strong></a></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortby=suggestion.sugstage&IdeaSortorder=<cfif session.IdeaSortorder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Stage</strong></a></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center"><strong>% Yes</strong></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug&IdeaSortby=voteReceived&IdeaSortorder=<cfif session.IdeaSortorder EQ 'asc'>desc<cfelse>asc</cfif>"><strong>Votes</strong></a></td>
	<td style="padding-left:5px;font-size:11px;"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<form method="post" action="#request.webroot#/administration/act_ideas_multireverse.cfm" name="MultiReverse2">

	<input type="hidden" name="TotalRecs" value="#session.NoVoteIdeas_MaxRows#">
	
	<cfloop query="NoVoteIdeas" startrow="#session.NoVoteIdeas_StartRow#" endrow="#NoVoteIdeas_endrow#">
	
	<cfset this_sugID = NoVoteIdeas.SugID>
	<cfset this_ContactID = NoVoteIdeas.ContactID>
	<cfset this_CategoryID = NoVoteIdeas.CategoryID>
		
	<cfquery datasource="#dsn#"  name="ContactStuff" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName, ScreenName
	FROM Contacts
	WHERE ContactID=#this_ContactID#
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
	
	<cfif IsDefined("this_categoryID") AND IsNumeric("#this_categoryID#")>
	
		<cfquery name="qry_current_topic" dbtype="query">
		SELECT Name, MainCatID
		FROM qry_all_topics
		WHERE CategoryID=#this_categoryID#
		</cfquery>
		
	</cfif>
	
	<cfif IsDefined("qry_current_topic.MainCatID") AND IsNumeric("#qry_current_topic.MainCatID#")>
		
		<cfquery name="qry_current_cat" dbtype="query">
		SELECT MainCatTitle
		FROM qry_all_maincats
		WHERE MainCatID=#qry_current_topic.MainCatID#
		</cfquery>
		
	</cfif>
	

	<cfif AllVotes.RecordCount>	
		<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>	
	<cfelse>		
		<cfset PercentYes = 0>		
	</cfif>
	
	<input type="hidden" name="SugID_#NoVoteIdeas.CurrentRow#" value="#this_sugID#">
	
	<tr>
	<td style="padding-left:10px;font-size:11px;" nowrap><input type="checkbox" class="whitefield" name="Delete_#NoVoteIdeas.CurrentRow#" value="1"></td>
	<td style="padding-left:10px;font-size:11px;">#DateFormat(NoVoteIdeas.WhenSugMade, "d-mmm-yyyy")#<cfif IsDate("#NoVoteIdeas.WhenSugEnded#")><br>#DateFormat(NoVoteIdeas.WhenSugEnded, "d-mmm-yyyy")#</cfif>
	</td>
	<td style="padding-left:10px;font-size:11px;" valign="top"><a title="<cfif IsDefined("qry_current_cat") AND qry_current_cat.recordcount>#TRIM(qry_current_cat.MainCatTitle)# </cfif><cfif IsDefined("qry_current_topic")>#TRIM(qry_current_topic.Name)#</cfif>" href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#this_categoryID#" target="_Blank"><strong>#TRIM(NoVoteIdeas.suggestion)#</strong></a><cfif NoVoteIdeas.archived CONTAINS 1>&nbsp;&nbsp;&nbsp;<span style="color:red">[A]</span></cfif><br><span style="font-size:10px;">#TRIM(NoVoteIdeas.details)#</span></td>
	<td style="padding-left:10px;font-size:11px;" valign="top"><table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr><td style="padding-right:5px;padding-top:3px;" width="15" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a></td><td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile">#TRIM(ContactStuff.FirstName)# #TRIM(ContactStuff.LastName)#</a><br><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile">[#TRIM(ContactStuff.ScreenName)#]</a></td></tr></table></td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center">#TRIM(NoVoteIdeas.SugStage)#</td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center">#INT(PercentYes)#%</td>
	<td style="padding-left:5px;padding-right:5px;font-size:11px;" align="center">#AllVotes.RecordCount#</td>
	<td style="padding-left:5px;font-size:11px;" align="right"><a href="#request.webroot#/administration/dsp_edit_idea.cfm?sugID=#sugID#" target="editIdea" onclick="fdbackwindow=window.open ('','editIdea','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaDelete('#request.webroot#/administration/act_RemoveSug.cfm?sugID=#sugID#')"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Idea" border="0"></a>&nbsp;<cfif (TRIM(AllSuggestions.SugStage) CONTAINS 'Pending') OR (TRIM(AllSuggestions.SugStage) CONTAINS 'Stage 1') OR (TRIM(AllSuggestions.SugStage) CONTAINS 'Stage 2') OR (TRIM(AllSuggestions.SugStage) CONTAINS 'Stage 3')><a href="#request.webroot#/administration/dsp_move_idea.cfm?sugID=#sugID#" target="moveIdea" onclick="fdbackwindow=window.open ('','moveIdea','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=500,top=10,left=10')"><img src="images/icon_move.gif" width="10" height="10" alt="Move Idea" border="0"></a>&nbsp;</cfif><a href="javascript:confirmReverse('#request.webroot#/administration/act_reverse.cfm?type=idea&SugID=#sugID#');" title="Reverse this Idea">R</a></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>	

	<tr>
	<td colspan="2" style="font-size:11px;" valign="top"><a href="javascript:document.MultiReverse2.submit();" style="color:###TRIM(AllSettings.BoxColour)#;">Reverse Selected</a></td>
	<td align="right" colspan="6" style="font-size:11px;" valign="top"><cfif session.NoVoteIdeas_Startrow GT session.NoVoteIdeas_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&NoVoteIdeas_Startrow=#prev#" style="color:###TRIM(AllSettings.BoxColour)#;">Prev Page</a> | </cfif><cfif NoVoteIdeas_endrow LT NoVoteIdeas.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&NoVoteIdeas_Startrow=#next#" style="color:###TRIM(AllSettings.BoxColour)#;">Next Page</a> &gt;</cfif><cfif session.NoVoteIdeas_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#NoVoteIdeasNumberCount#" index="NumberCount"><cfset thisStartRow=(session.NoVoteIdeas_Maxrows*NumberCount-session.NoVoteIdeas_Maxrows+1)><cfif thisStartRow EQ session.NoVoteIdeas_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&NoVoteIdeas_Startrow=#thisStartRow#" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif>#NumberCount#<cfif thisStartRow EQ session.NoVoteIdeas_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ NoVoteIdeasNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</td>
	</tr>
	
	</form>
	
	</table>


	
</td>
</tr>

</table>

</cfoutput>