<cfoutput>
<table width="100%" border="0">
<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
<input type="hidden" name="fuseaction" value="#fuseaction#">
<input type="hidden" name="fusesubaction" value="#fusesubaction#">
<tr>
<td style="font-size:11px;">Filter By:</td>
<td style="font-size:11px;"><select name="srch_category" class="whitefield" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;width:280px;">
	<optgroup label="">
	<option value="ALL"<cfif session.srch_category EQ "ALL"> selected</cfif>>- ALL Categories
	<cfloop query="qry_all_maincats">
	<cfset this_maincatID = qry_all_maincats.maincatID>
	<cfset this_title = qry_all_maincats.MainCatTitle>
	<optgroup label="#TRIM(this_title)#">
	<cfquery name="Category" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugCategory
	WHERE MainCatID=#this_mainCatID#
	ORDER BY DisplayOrder
	</cfquery>
	<cfloop query="Category">
	<option value="#Category.categoryID#"<cfif session.srch_category EQ Category.categoryID> selected</cfif>>- #TRIM(Category.Name)#
	</cfloop>
	<option value="">
	</cfloop>
	</select> <select name="srch_archive" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
<option value="ALL"<cfif session.srch_archive EQ 'ALL'> selected</cfif>>ANY STATUS
<option value="0"<cfif session.srch_archive EQ '0'> selected</cfif>>Active Ideas
<option value="1"<cfif session.srch_archive EQ '1'> selected</cfif>>Archived Ideas
</select> <select name="srch_stage" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
<option value="ALL"<cfif session.srch_stage EQ 'ALL'> selected</cfif>>ANY STAGE
<option value="Pending"<cfif session.srch_stage EQ 'Pending'> selected</cfif>>Pending
<option value="Stage 1"<cfif session.srch_stage EQ 'Stage 1'> selected</cfif>>Stage 1
<option value="Stage 2"<cfif session.srch_stage EQ 'Stage 2'> selected</cfif>>Stage 2
<option value="Stage 3"<cfif session.srch_stage EQ 'Stage 3'> selected</cfif>>Stage 3
<option value="Stage 4"<cfif session.srch_stage EQ 'Stage 4'> selected</cfif>>Holding Stage
<option value="Stage 5"<cfif session.srch_stage EQ 'Stage 5'> selected</cfif>>Will Not Be Doing
<option value="Stage 6"<cfif session.srch_stage EQ 'Stage 6'> selected</cfif>>Might Do It
<option value="Stage 7"<cfif session.srch_stage EQ 'Stage 7'> selected</cfif>>Will Do It
<option value="Stage 8"<cfif session.srch_stage EQ 'Stage 8'> selected</cfif>>In Progress
<option value="Stage 9"<cfif session.srch_stage EQ 'Stage 9'> selected</cfif>>Done It!
</select></td>
</tr>

<tr>
<td style="font-size:11px;">Order By:</td>
<td style="font-size:11px;"><select name="IdeaSortBy" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
<option value="suggestion.WhenSugMade"<cfif session.IdeaSortBy EQ 'suggestion.WhenSugMade'> selected</cfif>>Date Submitted
<option value="suggestion.WhenSugEnded"<cfif session.IdeaSortBy EQ 'suggestion.WhenSugEnded'> selected</cfif>>Date Finished
<option value="suggestion.SugStage"<cfif session.IdeaSortBy EQ 'suggestion.SugStage'> selected</cfif>>Stage
<option value="suggestion.suggestion"<cfif session.IdeaSortBy EQ 'suggestion.suggestion'> selected</cfif>>Title
<option value="contacts.FirstName"<cfif session.IdeaSortBy EQ 'contacts.FirstName'> selected</cfif>>Made by
<option value="VoteReceived"<cfif session.IdeaSortBy EQ 'VoteReceived'> selected</cfif>>Votes
</select> <select name="IdeaSortOrder" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
<option value="ASC"<cfif session.IdeaSortOrder EQ 'ASC'> selected</cfif>>ASC
<option value="DESC"<cfif session.IdeaSortOrder EQ 'DESC'> selected</cfif>>DESC</select> <input type="text" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;" name="srch_keywords" onfocus="javascript:document.ideasearch.srch_keywords.value='';" value="<cfif session.srch_keywords NEQ ''>#session.srch_keywords#<cfelse>Keywords...</cfif>"> <input type="submit" value="SEARCH" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;"></td>
</tr>
</form>
</table><br>

</cfoutput>