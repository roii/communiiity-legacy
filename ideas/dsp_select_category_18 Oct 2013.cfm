<cfoutput>

<cfparam name="session.MainCatID" default="">
<cfif IsDefined("MainCatID")>
	<cfset session.MainCatID = MainCatID>
</cfif>

<!--- GET ALL MAIN CATEGORIES FOR DROP DOWN --->
<cfinclude template="qry_all_maincats.cfm">

<table width="100%" cellspacing="0" cellpadding="0" border="0">

<tr>
<td valign="top">
	
<cfif session.MainCatID EQ ''>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
	
	<tr>
	<td width="100%"><img src="#request.imageroot#/ideaFunL/01_select_cattopic.gif" width="162" height="52" alt="1. SELECT A CATEGORY &amp; TOPIC" border="0"></td>
	</tr>
	
	</table><br>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="100%">
	
		<hr width="100%" size="1" color="##999999">
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">	
		
		<tr>
		<td style="color:##333333;" colspan="2"><strong>Please select an Idea Category...</strong></td>
		</tr>
		
		
		<tr>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		</tr>
		
		<tr>
		<td colspan="2"><strong><li style="color:###TRIM(AllSettings.BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&MainCatID=All" style="color:###TRIM(AllSettings.BoxColour)#;">All Categories</a></li></strong></td>		
		</tr>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		</tr>
		
		<cfloop query="qry_all_maincats">
		
		<cfset this_maincatID = qry_all_maincats.maincatID>
		<cfset this_title = qry_all_maincats.MainCatTitle>
		
		<tr>
		<td colspan="2"><li style="color:###TRIM(AllSettings.BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&MainCatID=#this_maincatID#"><strong>#TRIM(this_title)#</strong></a></li></td>		
		</tr>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>		
		</tr>
		
		<cfquery name="Category" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM SugCategory
		WHERE MainCatID=#this_mainCatID# 
		AND Active = 1
		ORDER BY DisplayOrder
		</cfquery>
		
		<cfloop query="Category">
        
    		<tr>
    		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>		
    		<td><li style="color:###TRIM(AllSettings.BoxColour)#;" type="square"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&MainCatID=#this_maincatID#&currentcategory=#Category.categoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" style="font-size:11px;">#TRIM(Category.Name)#</a></li></td>
    		</tr>
    		
    		<tr>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>		
    		</tr>
    		
    		<tr>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
    		<td height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>		
    		</tr>
    		
    		<tr>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
    		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>		
    		</tr>
		
		</cfloop>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>		
		</tr>
		
		</cfloop>	
		
		</table><br>
		
		
	</td>
	</tr>
	
	</table>	
	
<cfelseif session.MainCatID EQ 'ALL'>
	
	<cfquery name="qry_all_maincats" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT MainCatID, MainCatTitle
	FROM SugMainCategory
	WHERE Active=1
	ORDER BY DisplayOrder
	</cfquery>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	

	<form action="#request.webroot#/index.cfm" method="post">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="DocumentID" value="#DocumentID#">	
	<tr>
	<td width="100%"><img src="#request.imageroot#/ideaFunL/01_select_cattopic.gif" width="162" height="52" alt="1. SELECT A CATEGORY &amp; TOPIC" border="0"></td>
	<td nowrap style="color:##444444;padding-right:5px;">Select a Category:</td>
	<td align="right" style="padding-right:8px;" nowrap><select name="MainCatID" class="whitefield" style="width: 300px;">
	<option value="ALL" selected> -- All Categories --
	<cfloop query="qry_all_maincats">
	<option value="#qry_all_maincats.MainCatID#">#TRIM(qry_all_maincats.MainCatTitle)#</option>
	</cfloop>
	</select></td>
	<td><input type="submit" value="Change &raquo;" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:black;font-weight:bold;font-size:11px;border:0px;" class="whitefield"></td>
	</tr>	
	</form>	
	
	</table><br>

		
	<cfloop query="qry_all_maincats">
	
	<cfset this_MainCatID = qry_all_maincats.MainCatID>
	<hr width="100%" size="2" color="##999999">
	<span style="font-size:18px;font-family:Trebuchet,Tahoma,Arial;color:##444444;">#TRIM(qry_all_maincats.MainCatTitle)#</span>	
	<hr width="100%" size="2" color="##999999">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">			
	
	<cfquery name="qry_all_categories" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugCategory
	WHERE Active = 1
	AND MainCatID=#this_MainCatID#
	ORDER BY DisplayOrder
	</cfquery>
	
	<cfif IsDefined("DocumentID")>
	<cfelse>
		<cfset documentID=75>
	</cfif>
	
	<cfloop query="qry_all_categories">
    
    <cfset this_categoryID = qry_all_categories.categoryID>
	<cfset this_SponsorID = qry_all_categories.SponsorID>
	<cfset this_PointsAllocated = qry_all_categories.PointsAllocated>
	<cfset this_WhenCategoryEnded = qry_all_categories.WhenCategoryEnded>
	<cfset this_PointsCutOff = qry_all_categories.PointsCutOff>
    
    <cfinclude template="act_topic_stages.cfm">
    
	<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.sugID
	FROM suggestion, Contacts
	WHERE suggestion.ContactID=Contacts.ContactID
	AND suggestion.Authorise = 'yes'
	AND suggestion.Archived=0
	AND suggestion.categoryID=#this_categoryID#
	AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
	</cfquery>
    
    <cfquery name="AllCat_ToVoteIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.sugID
	FROM suggestion, Contacts
	WHERE suggestion.ContactID=Contacts.ContactID
	<cfif IsDefined("session.UserID")>
    AND Contacts.ContactID <> #session.UserID#
	</cfif>
    AND suggestion.Authorise = 'yes'
	AND suggestion.Archived=0
	AND suggestion.categoryID=#this_categoryID#
	AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
	</cfquery>
	
    <cfif thisTopic_Use_Pending EQ 1>
    	<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
    	SELECT SugID
    	FROM Suggestion
    	WHERE CategoryID=#this_categoryID#
    	AND Authorise LIKE '%No%'
    	AND Archived = 0
    	AND SugStage LIKE '%Pending%'
    	GROUP BY SugID
    	</cfquery>
    </cfif>
	
    <cfif thisTopic_Use_Stage4 EQ 1>
    	<cfquery name="AllCat_WinnerIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
    	SELECT SugID
    	FROM Suggestion
    	WHERE CategoryID=#this_categoryID#
        AND suggestion.DisplayAsWinner=1
    	AND (suggestion.SugStage LIKE '%Stage 4%' OR suggestion.SugStage LIKE '%Stage 5%' OR suggestion.SugStage LIKE '%Stage 6%' OR suggestion.SugStage LIKE '%Stage 7%' OR suggestion.SugStage LIKE '%Stage 8%' OR suggestion.SugStage LIKE '%Stage 9%')
    	GROUP BY SugID
    	</cfquery>
	</cfif>
    		
	<cfquery name="AllCat_ReturnedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID
	FROM Suggestion
	WHERE CategoryID=#this_categoryID#
	AND Archived=1
	GROUP BY SugID
	</cfquery>		
	
	<cfquery name="SponsorStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisation_Name, LogoFile
	FROM Organisations
	WHERE OrganisationID=#this_SponsorID#
	</cfquery>
		
	<cfif IsDefined("AllCat_ActiveIdeas") AND AllCat_ActiveIdeas.RecordCount>
		<cfset ThisCatideas = valueList(AllCat_ActiveIdeas.SugID)>
	<cfelse>
		<cfset ThisCatideas = "0">		
	</cfif>
	
	<cfif IsDefined("AllCat_InActiveIdeas") AND AllCat_InActiveIdeas.RecordCount>
		<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
	</cfif>
	
	<cfif IsDefined("AllCat_ActiveIdeas") AND AllCat_ActiveIdeas.Recordcount>
		<cfset ActiveList = ValueList(AllCat_ActiveIdeas.SugID, ",")>
	<cfelse>
		<cfset ActiveList = 0>
	</cfif>		
	
	<cfif session.UserIsAuthenticated EQ 'yes'>
	
		<!--- HOW MANY IDEAS HAS THIS USER VOTED ON --->
		<cfquery name="IdeasAlreadyVotedFor" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SugID
		FROM SugVote
		WHERE ContactID=#session.UserID#
		AND SugID IN (#ActiveList#)
		GROUP BY SugID
		</cfquery>
	
	</cfif>
	
	<tr>
	<td width="80" align="center" valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><cfif FileExists("#request.fileroot#\images\partners\#TRIM(SponsorStuff.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(SponsorStuff.LogoFile)#" border="0" title="#TRIM(SponsorStuff.Organisation_Name)#"></cfif></td>
	<td valign="top" align="right" width="100%">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td valign="top" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&currentcategory=#qry_all_categories.CategoryID#&IdeaFunL_StartRow=1&srch_stage=ALL" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(qry_all_categories.Name)#</strong></a><br>
        <span style="font-size:11px;">&nbsp;-&nbsp;<a href="#request.webroot#/ideas/dsp_topic_stages.cfm?topicID=#this_categoryID#" target="TopicStages" onclick="fdbackwindow=window.open ('','TopicStages','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=600,height=400,top=10,left=10')">Stages and Rewards</a> for this topic</span><hr size="1" color="e2e2e2">
		#TRIM(qry_all_categories.Description)#</td>
		<td valign="top" width="120" align="right"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"><br><cfif thisTopic_Use_Pending EQ 1><cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_InActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowPending=1" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><strong>#AllCat_InActiveIdeas.RecordCount#</strong> pending ideas<cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")></a></cfif><br></cfif>
		<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#AllCat_ActiveIdeas.RecordCount#</strong> active ideas</a><br>
		<cfif session.UserIsAuthenticated EQ 'Yes'>
		<span style="color:###TRIM(AllSettings.BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=Yes"><strong>#INT(AllCat_ToVoteIdeas.RecordCount - IdeasAlreadyVotedFor.RecordCount)#</strong> need my vote</a><br></span></cfif>				
		<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ReturnedIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowReturned=1"><strong>#AllCat_ReturnedIdeas.RecordCount#</strong> returned ideas</a><br>
		<cfif thisTopic_Use_Stage4 EQ 1><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=78&srch_category=#this_categoryID#&WinIdeas_StartRow=1&returnIdeas=#ValueList(AllCat_WinnerIdeas.SugID)#"><strong>#AllCat_WinnerIdeas.RecordCount#</strong> winner ideas</a><br></cfif>        
        <cfset thisTotalIdeas = AllCat_ActiveIdeas.RecordCount>        
        <cfif thisTopic_Use_Pending EQ 1>
            <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_InActiveIdeas.RecordCount)>
        </cfif>
        <cfif thisTopic_Use_Stage4 EQ 1>
            <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_WinnerIdeas.RecordCount)>
        </cfif>        
        <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_ReturnedIdeas.RecordCount)>
        <strong><span style="color:##444444;">Total: #INT(thisTotalIdeas)# ideas</span></strong><br>
		</td>
		</tr>
				
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td height="10" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><hr width="100%" size="1" color="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
	</tr>
	
	</cfloop>			
	
	</table><br>

	</cfloop>
					
	
<cfelseif IsNumeric("#session.MainCatID#")>				
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
	
	<form action="#request.webroot#/index.cfm" method="post">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="DocumentID" value="#DocumentID#">	
	<tr>
	<td width="100%"><img src="#request.imageroot#/ideaFunL/01_select_cattopic.gif" width="162" height="52" alt="1. SELECT A CATEGORY &amp; TOPIC" border="0"></td>
	<td nowrap style="color:##444444;padding-right:5px;">Select a Category:</td>
	<td align="right" style="padding-right:8px;" nowrap><select name="MainCatID" class="whitefield" style="width: 300px;">
	<option value="ALL"> -- All Categories --
	<cfloop query="qry_all_maincats">
	<option value="#qry_all_maincats.MainCatID#"<cfif qry_all_maincats.MainCatID EQ session.MainCatID> selected</cfif>>#TRIM(qry_all_maincats.MainCatTitle)#</option>
	</cfloop>
	</select></td>
	<td><input type="submit" value="Change &raquo;" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:black;font-weight:bold;font-size:11px;border:0px;" class="whitefield"></td>
	</tr>	
	</form>	
	
	</table><br>
			
	<cfquery name="selected_maincat" dbtype="query">
	SELECT MainCatID, MainCatTitle
	FROM qry_all_maincats
	WHERE MainCatID=#session.MainCatID#
	</cfquery>

	<cfquery name="qry_all_categories" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM SugCategory
	WHERE Active = 1
	AND MainCatID=#session.MainCatID#
	ORDER BY DisplayOrder
	</cfquery>
	
	<cfif IsDefined("DocumentID")>
	<cfelse>
		<cfset documentID=75>
	</cfif>		
	
	<hr width="100%" size="2" color="##999999">		
	<span style="font-size:18px;font-family:Trebuchet,Tahoma,Arial;color:##444444;">#TRIM(selected_maincat.MainCatTitle)#</span>
	<hr width="100%" size="2" color="##999999">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<cfloop query="qry_all_categories">
	
	<cfset this_categoryID = qry_all_categories.categoryID>
	<cfset this_SponsorID = qry_all_categories.SponsorID>
	<cfset this_PointsAllocated = qry_all_categories.PointsAllocated>
	<cfset this_WhenCategoryEnded = qry_all_categories.WhenCategoryEnded>
	<cfset this_PointsCutOff = qry_all_categories.PointsCutOff>		
	
	<cfinclude template="act_topic_stages.cfm">
    
	<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT suggestion.sugID
	FROM suggestion, Contacts
	WHERE suggestion.ContactID=Contacts.ContactID
	
	<cfif session.UserIsAuthenticated EQ 'Yes'>
		AND Contacts.ContactID <> #session.UserID#
	</cfif>
	
	AND suggestion.Authorise = 'yes'
	AND suggestion.Archived=0
	AND suggestion.categoryID=#this_categoryID#
	AND (<cfset thisLoop = 0><cfloop list="#thisTopic_ActiveStageList#" index="LoopStage" delimiters=","><cfset thisLoop = thisLoop+1>suggestion.SugStage LIKE '%#LoopStage#%'<cfif thisLoop NEQ ListLen(thisTopic_ActiveStageList, ",")> OR </cfif></cfloop>)
	</cfquery>
	
    <cfif thisTopic_Use_Pending EQ 1>
    	<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
    	SELECT SugID
    	FROM Suggestion
    	WHERE CategoryID=#this_categoryID#
    	AND Authorise LIKE '%No%'
    	AND Archived = 0
    	AND SugStage LIKE '%Pending%'
    	GROUP BY SugID
    	</cfquery>
    </cfif>
	
    <cfif thisTopic_Use_Stage4 EQ 1>
    	<cfquery name="AllCat_WinnerIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
    	SELECT SugID
    	FROM Suggestion
    	WHERE CategoryID=#this_categoryID#
    	AND (suggestion.SugStage LIKE '%Stage 4%' OR suggestion.SugStage LIKE '%Stage 5%' OR suggestion.SugStage LIKE '%Stage 6%' OR suggestion.SugStage LIKE '%Stage 7%' OR suggestion.SugStage LIKE '%Stage 8%' OR suggestion.SugStage LIKE '%Stage 9%')
    	GROUP BY SugID
    	</cfquery>
	</cfif>
    		
	<cfquery name="AllCat_ReturnedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID
	FROM Suggestion
	WHERE CategoryID=#this_categoryID#
	AND Archived=1
	GROUP BY SugID
	</cfquery>		
	
	<cfquery name="SponsorStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisation_Name, LogoFile
	FROM Organisations
	WHERE OrganisationID=#this_SponsorID#
	</cfquery>
		
	<cfif AllCat_ActiveIdeas.RecordCount>
		<cfset ThisCatideas = valueList(AllCat_ActiveIdeas.SugID)>
	<cfelse>
		<cfset ThisCatideas = "0">		
	</cfif>
	
	<cfif AllCat_InActiveIdeas.RecordCount>
		<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
	</cfif>
	
	<cfif AllCat_ActiveIdeas.Recordcount>
		<cfset ActiveList = ValueList(AllCat_ActiveIdeas.SugID, ",")>
	<cfelse>
		<cfset ActiveList = 0>
	</cfif>		
	
	<cfif session.UserIsAuthenticated EQ 'yes'>
	
		<!--- HOW MANY IDEAS HAS THIS USER VOTED ON --->
		<cfquery name="IdeasAlreadyVotedFor" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SugID
		FROM SugVote
		WHERE ContactID=#session.UserID#
		AND SugID IN (#ActiveList#)
		GROUP BY SugID
		</cfquery>
	
	</cfif>
	
	<tr>
	<td width="80" align="center" valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"><br><cfif FileExists("#request.fileroot#\images\partners\#TRIM(SponsorStuff.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(SponsorStuff.LogoFile)#" border="0" title="#TRIM(SponsorStuff.Organisation_Name)#"></cfif></td>
	<td valign="top" align="right" width="100%">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td valign="top" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="1" border="0"><br><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(qry_all_categories.Name)#</strong></a><br>
        <span style="font-size:11px;">&nbsp;-&nbsp;<a href="#request.webroot#/ideas/dsp_topic_stages.cfm?topicID=#this_categoryID#" target="TopicStages" onclick="fdbackwindow=window.open ('','TopicStages','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=600,height=400,top=10,left=10')">Stages and Rewards</a> for this topic</span><hr size="1" color="e2e2e2">
		#TRIM(qry_all_categories.Description)#</td>
		<td valign="top" width="120" align="right"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"><br><cfif thisTopic_Use_Pending EQ 1><cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_InActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowPending=1" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><strong>#AllCat_InActiveIdeas.RecordCount#</strong> pending ideas<cfif session.UserIsAuthenticated AND ListFind(qry_all_categories.Moderators, session.UserID, ",")></a></cfif><br></cfif>
		<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=No" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>#AllCat_ActiveIdeas.RecordCount#</strong> active ideas</a><br>
		<cfif session.UserIsAuthenticated EQ 'Yes'>
		<span style="color:###TRIM(AllSettings.BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ActiveIdeas.SugID)#&IdeaFunL_hideIdeas=Yes"><strong>#INT(AllCat_ActiveIdeas.RecordCount - IdeasAlreadyVotedFor.RecordCount)#</strong> need my vote</a><br></span></cfif>				
		<a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1&returnIdeas=#ValueList(AllCat_ReturnedIdeas.SugID)#&IdeaFunL_hideIdeas=No&ShowReturned=1"><strong>#AllCat_ReturnedIdeas.RecordCount#</strong> returned ideas</a><br>
		<cfif thisTopic_Use_Stage4 EQ 1><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=78&srch_category=#this_categoryID#&WinIdeas_StartRow=1&returnIdeas=#ValueList(AllCat_WinnerIdeas.SugID)#"><strong>#AllCat_WinnerIdeas.RecordCount#</strong> winner ideas</a><br></cfif>
		 <cfset thisTotalIdeas = AllCat_ActiveIdeas.RecordCount>        
        <cfif thisTopic_Use_Pending EQ 1>
            <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_InActiveIdeas.RecordCount)>
        </cfif>
        <cfif thisTopic_Use_Stage4 EQ 1>
            <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_WinnerIdeas.RecordCount)>
        </cfif>        
        <cfset thisTotalIdeas = (thisTotalIdeas + AllCat_ReturnedIdeas.RecordCount)>
        <strong><span style="color:##444444;">Total: #INT(thisTotalIdeas)# ideas</span></strong><br>
		</td>
		</tr>
				
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td height="10" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><hr width="100%" size="1" color="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	
</cfif>

</td>
</tr>

</table>

</cfoutput>