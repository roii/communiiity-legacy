<cflock Type="exclusive" scope="session" timeout="10">

<cfparam name="session.IdeaFunL_StartRow" default="1">
<cfif isdefined("IdeaFunL_StartRow")>	
	<cfset session.IdeaFunL_StartRow = IdeaFunL_StartRow>
</cfif>	
	
<cfparam name="session.IdeaFunL_MaxRows" default="5">
<cfif isdefined("IdeaFunL_MaxRows")>	
	<cfset session.IdeaFunL_MaxRows = IdeaFunL_MaxRows>
</cfif>
	
<cfparam name="session.IdeaFunL_hideIdeas" default="Yes">
<cfif isdefined("IdeaFunL_hideIdeas")>	
	<cfset session.IdeaFunL_hideIdeas = IdeaFunL_hideIdeas>
</cfif>

</cflock>

<script type="text/javascript">
function validateSelRate(frm){
	if(frm.login.value == 0){
		alert('You must be a member and logged-in to vote.');
		return false;
	}	
}
<!--
function confirmIdeaDelete(aURL) {
    if(confirm('Are you sure you want to remove this idea from the Voting Area?\nIt will be moved to your \"Returned\" ideas list')) {
      location.href = aURL;
    }
  }
//-->
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

<cfoutput>

<!--- GET ALL MAIN CATEGORIES FOR DROP DOWN --->
<cfinclude template="qry_all_maincats.cfm">

<!--- GET THE SELECTED TOPIC DETAILS --->
<cfinclude template="qry_current_topic.cfm">

<cfif qry_current_topic.Active EQ 0>

<script type="text/javascript">
alert("The topic you selected has been archived.\nPlease select an active topic.");
history.back(-1);
</script>
<cfabort>

</cfif>

<cfset this_categoryID = qry_current_topic.CategoryID>

<!--- GET THE STAGE DETAILS --->
<cfinclude template="act_topic_stages.cfm">

<!--- GET THE SELECTED TOPIC SPONSOR --->
<cfinclude template="qry_topic_sponsor.cfm">

<!--- FIND OUT HOW MANY POINTS HAVE BEEN EARNED AGAINST THIS TOPIC --->
<cfinclude template="qry_category_points_calculation.cfm">

<cfif session.UserIsAuthenticated EQ 'Yes' AND IsDefined("session.UserID")>
	<!--- BUILD A LIST OF IDEAS THIS USER ALREADY VOTED FOR --->
	<cfinclude template="qry_user_voted_ideas.cfm">
</cfif>

<!--- GET ALL THE ACTIVE IDEAS TO DISPLAY BELOW --->
<cfinclude template="qry_ideas_pond.cfm">

<cfset activityid = 2>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td valign="middle"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75"><img src="#request.imageroot#/ideaFunL/new_02_1.gif" width="35" height="52" alt="1. Select a topic" border="0"></a><img src="#request.imageroot#/ideaFunL/new_02_2.gif" width="59" height="52" alt="2. VIEW IDEAS" border="0"><img src="#request.imageroot#/ideaFunL/new_02_3.gif" width="36" height="52" alt="3. Vote on an idea" border="0"><br>
<img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="8"><br></td>
<td align="right" valign="middle">
	
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	
	<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="documentID" value="#documentID#">
	<input type="hidden" name="IdeaFunL_Startrow" value="1">
	
	<tr>
	<td align="right"><select name="currentcategory" class="whitefield" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;width:300px;" onchange="javascript:ideasearch.submit();">
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
		<td colspan="2" valign="top"><span style="font-size:14px;color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(qry_current_topic.Name)#</strong></span><br>#TRIM(qry_current_topic.description)#</td>
        <td align="right" style="font-size:11px;" valign="top"><a href="#request.webroot#/ideas/dsp_topic_stages.cfm?topicID=#this_categoryID#" target="TopicStages" onclick="fdbackwindow=window.open ('','TopicStages','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=0,resizable=0,width=600,height=400,top=10,left=10')">Stages and Rewards</a></td>
		</tr>
        
        <tr>
        <td colspan="3"><hr size="1" color="e2e2e2"></td>
        </tr>
		
		<tr>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Sponsor:</strong> #TRIM(qry_topic_sponsor.Organisation_Name)#</td>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Points Available:</strong> #this_pointsremaining#</td>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;" align="right"><strong>Finishes:</strong> <cfif this_pointsremaining EQ 0>Finished<cfelseif IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>Finished<cfelse>#DateFormat(qry_current_topic.WhenCategoryEnded)#</cfif></td>
		</tr>
		
		<cfif add_idea EQ 0 OR this_pointsremaining EQ 0 OR IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1>
			<tr>
			<td style="color:##333333;padding-top:4px;font-size:12px;" colspan="3"><hr width="100%" size="1" color="e2e2e2"><strong>NOTE: <cfif vote_idea EQ 1>The "add-idea" cut-off has been reached. You cannot add new ideas but you can review and vote on submitted ideas.<cfelse>This topic has finished. You can review the submitted ideas but cannot add new ideas or vote.</cfif></strong></td>
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
			
		<!--- SET THE IdeaFunL_endrow VALUE --->
		<cfif session.IdeaFunL_MaxRows NEQ 'ALL'>
		
			<cfif qry_ideas_pond.RecordCount GT (session.IdeaFunL_StartRow + session.IdeaFunL_MaxRows)-1>
				<cfset IdeaFunL_endrow = session.IdeaFunL_StartRow + session.IdeaFunL_MaxRows-1>
			<cfelse>
				<cfset IdeaFunL_endrow = qry_ideas_pond.RecordCount>
			</cfif>
		
		<cfelse>
			<cfset IdeaFunL_endrow = qry_ideas_pond.RecordCount>			
		</cfif>			
		
		<!--- SET THE PREV VALUE --->
		<cfif session.IdeaFunL_Startrow GT session.IdeaFunL_Maxrows>
			<cfset prev = session.IdeaFunL_Startrow-session.IdeaFunL_Maxrows>			
		<cfelse>
			<cfset prev = session.IdeaFunL_StartRow>			
		</cfif>				
		
		<!--- SET THE NEXT VALUE --->
		<cfif IdeaFunL_endrow LT qry_ideas_pond.RecordCount>
			<cfset next = (IdeaFunL_endrow + 1)>			
		<cfelse>
			<cfset next = session.IdeaFunL_StartRow>			
		</cfif>		
		
		<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
		<cfif session.IdeaFunL_MaxRows NEQ 'ALL'>			
			<cfset NumberCount = (qry_ideas_pond.RecordCount / session.IdeaFunL_Maxrows)>
			<cfset IdeaFunLNumberCount = Ceiling(NumberCount)>			
		<cfelse>			
			<cfset IdeaFunLNumberCount=1>				
		</cfif>
			
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
			<td><select name="srch_stage" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
			<option value="ALL"<cfif session.srch_stage EQ 'ALL'> selected</cfif>>ANY STAGE
			<cfif thisTopic_Use_Stage1 EQ 1>
                <option value="Stage 1"<cfif session.srch_stage EQ 'Stage 1'> selected</cfif>>Stage 1
			</cfif>
            <cfif thisTopic_Use_Stage2 EQ 1>
                <option value="Stage 2"<cfif session.srch_stage EQ 'Stage 2'> selected</cfif>>Stage 2
			</cfif>
            <cfif thisTopic_Use_Stage3 EQ 1>
                <option value="Stage 3"<cfif session.srch_stage EQ 'Stage 3'> selected</cfif>>Stage 3
			</cfif>
            </select> <input type="text" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;" name="srch_keywords" onfocus="javascript:document.ideasearch.srch_keywords.value='';" value="<cfif session.srch_keywords NEQ ''>#session.srch_keywords#<cfelse>Keywords...</cfif>"> <input type="submit" value="SEARCH" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;"></td>
			<td align="right"><cfif add_idea EQ 0 OR this_pointsremaining EQ 0 OR IsDate("#qry_current_topic.WhenCategoryEnded#") AND dateCompare(localdatetime, qry_current_topic.WhenCategoryEnded) EQ 1><cfelse><cfif session.UserIsAuthenticated EQ 'Yes'><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=76&categoryID=#currentcategory#"><cfelse><a href="javascript:alert('Please login to add your idea.');"></cfif><img src="#request.imageroot#/ideaFunL/new_add_idea.gif" width="101" height="23" alt="Add New Idea" border="0"></a></cfif></td>
			</tr>
			
			</form>
			</table>			
			
			<script type="text/javascript">
			<!--
			function OpenAllIdeas() {
			<cfloop query="qry_ideas_pond" startrow="#session.IdeaFunL_StartRow#" endrow="#IdeaFunL_endrow#">
			<cfset this_sugID = qry_ideas_pond.SugID>
			document.getElementById("idea"+#this_sugID#).style.display="block";
			</cfloop>
			}
			//-->			
			<!--
			function CloseAllIdeas() {
			<cfloop query="qry_ideas_pond" startrow="#session.IdeaFunL_StartRow#" endrow="#IdeaFunL_endrow#">
			<cfset this_sugID = qry_ideas_pond.SugID>
			document.getElementById("idea"+#this_sugID#).style.display="none";
			</cfloop>
			}
			//-->
			</script>

			<hr width="100%" size="1" color="e2e2e2">
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td style="font-size:11px;"><strong>#qry_ideas_pond.RecordCount#</strong> ideas. <cfif qry_ideas_pond.RecordCount>&nbsp; Displaying <strong>#session.IdeaFunL_Startrow#</strong> - <strong>#IdeaFunL_Endrow#</strong></cfif></td>
			<td align="right" style="font-size:11px;"><cfif qry_ideas_pond.RecordCount>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=3&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">3</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=5&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">5</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=10&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=ALL&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></cfif></td>
			</tr>
			
			</table><br>
						
		</td>
		</tr>
		
		<cfif qry_ideas_pond.RecordCount>
			
			<form name="voteform" method="Post" action="#request.webroot#/ideas/act_multivote.cfm">
			
			<cfif session.IdeaFunL_Maxrows NEQ 'ALL'>		
				<input type="hidden" name="TotalIdeas" value="#session.IdeaFunL_Maxrows#">
			<cfelse>
				<input type="hidden" name="TotalIdeas" value="#qry_ideas_pond.recordcount#">
			</cfif>
			
			<input type="hidden" name="currentcategory" value="#currentcategory#">
			
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
					<td bgcolor="##e2e2e2" style="font-size:11px;color:##444444;padding-left:4px;" valign="middle"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="17" align="absmiddle"><strong><cfif session.UserIsAuthenticated EQ 'Yes'>Click the idea title for more details and to vote and enter feedback...<cfelse>Click the idea title for details. Login to vote and give feedback...</cfif></strong></td>
					</tr>
					
					<tr>
					<td height="2" colspan="5"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="2"></td>
					</tr>
					
					<tr>
					<td height="1" colspan="5" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
					</tr>
					
					</table>
				
				</td>
				<cfif session.UserIsAuthenticated EQ 'Yes' AND NOT IsDefined("ShowReturned") AND vote_idea EQ 1 AND this_pointsremaining GT 0><td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
				<td align="right"><input type="image" src="#request.imageroot#/ideaFunL/new_process_votes.gif" width="101" height="23" alt="Process your votes" border="0"></td>
				</cfif>
				</tr>
				
				</table>
				
			</td>			
			</tr>
			
			<tr>
			<td style="padding-top:5px;padding-bottom:10px;">
			
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td style="color:##444444; font-size:11px;">All Ideas:&nbsp; <strong><a href="##" onClick="OpenAllIdeas(); return false;" style="color:##444444;">OPEN</a> | <a href="##" onClick="CloseAllIdeas(); return false;" style="color:##444444;">CLOSE</a></strong></td>
				<td align="right" style="color:##444444; font-size:11px;"><cfif session.UserIsAuthenticated EQ 'Yes'>Ideas I've voted on:&nbsp; <cfif session.IdeaFunL_hideIdeas EQ 'Yes'><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75&IdeaFunL_hideIdeas=No<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:##444444;"><strong>SHOW</strong></a></cfif><cfif session.IdeaFunL_hideIdeas EQ 'No'><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75&IdeaFunL_hideIdeas=Yes<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:##444444;"><strong>HIDE</strong></a></cfif></cfif></td>
				</tr>
				
				</table>
			
			</td>
			</tr>		
			
			<tr>
			<td><table cellpadding="0" cellspacing="0" border="0" width="100%"><tr><td height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td></tr></table></td>
			</tr>
			
			<!--- loop to display the suggestion  --->
			<cfloop query="qry_ideas_pond" startrow="#session.IdeaFunL_StartRow#" endrow="#IdeaFunL_endrow#">
				
			<cfset this_sugID = qry_ideas_pond.SugID>
			<cfset this_ContactID = qry_ideas_pond.ContactID>
			<cfset this_idea = TRIM(qry_ideas_pond.Suggestion)>
			<cfset this_details = TRIM(qry_ideas_pond.Details)>
			<cfset this_suggested = TRIM(qry_ideas_pond.WhenSugMade)>
			<cfset this_stage = TRIM(qry_ideas_pond.SugStage)>
			
			<cfquery datasource="#dsn#"  name="ContactStuff" username="#request.username#" password="#request.password#">
			SELECT FirstName, ScreenName
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
			
			<cfquery datasource="#dsn#" name="YesVotes" username="#request.username#" password="#request.password#">
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
				<td width="20" align="right"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="20" height="1"><cfif  session.UserIsAuthenticated EQ 'yes' AND IsDefined("session.UserID")><br><cfif qry_user_watch.RecordCount><a href="#request.webroot#/ideas/act_watchlist_remove.cfm?SugID=#this_SugID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ideafunl_mode=#ideafunl_mode#&documentID=#documentID#&currentcategory=#currentcategory#"><img src="#request.imageroot#/ideaFunL/icon_watchlist_remove.gif" width="15" height="16" alt="Stop watching this idea" border="0"><cfelse><a href="#request.webroot#/ideas/act_watchlist_add.cfm?SugID=#this_SugID#&fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ideafunl_mode=#ideafunl_mode#&documentID=#documentID#&currentcategory=#currentcategory#"><img src="#request.imageroot#/ideaFunL/icon_watchlist_add.gif" width="15" height="16" alt="Add this idea to your 'Watch-List'" border="0"></cfif></a></cfif></td>
				</tr>
				
				</table>
					
			</td>
			</tr>
			
			<cfif (session.UserIsAuthenticated EQ 'Yes') AND ((qry_user_vote.RecordCount) OR (this_ContactID EQ session.UserID) OR (session.UserType EQ 'Administrator'))>
			
				<tr>
				<td style="padding-top:3px;">			
					
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
						
					<tr>
					<td width="50"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="50" height="1"></td>
					<td width="100%" style="padding-left:10px;">
	
						<table cellpadding="0" cellspacing="0" border="0" width="490">
						
						<tr>
						<td style="font-size:11px;color:##444444;" width="170"><strong>By:&nbsp;</strong> <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(this_ContactID)#" style="color:###TRIM(Allsettings.BoxColour)#;" title="View Profile"><strong><cfif TRIM(ContactStuff.ScreenName) NEQ ''>#TRIM(ContactStuff.ScreenName)#<cfelse>#TRIM(ContactStuff.FirstName)#</cfif></a></td>
						<td style="font-size:11px;color:##444444;" width="100"><strong>Votes:&nbsp;</strong> #qry_idea_votes.RecordCount#</td>
						<td style="font-size:11px;color:##444444;" width="120"><strong>% Yes:&nbsp;</strong> #NumberFormat(PercentYes, "0.0")#%</td>
						<cfif session.userID NEQ this_contactID><td style="font-size:11px;color:##444444;" width="100"><strong>Your Vote:&nbsp;</strong> <cfif qry_user_vote.Vote GT 1>YES<cfelse>NO</cfif></td></cfif>
						</tr>
						
						</table>
					
					</td>
					</tr>
					
					</table>
						
				</td>
				</tr>
			
			</cfif>
			
			<tr>
			<td style="display:none;" id="idea#this_SugID#">
				
				
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
				
				</td>
				</tr>				
				
				<!--- IF THEY HAVE IDEA MODERATOR (MOVE IDEA) RIGHTS --->
				<cfif (session.UserIsAuthenticated EQ 'Yes' AND session.Permission3_View EQ 1 AND session.UserID NEQ this_ContactID AND ListFind(qry_current_topic.Moderators, session.UserID, ",") AND NOT IsDefined("ShowReturned") AND NOT IsDefined("ShowPending"))>
				
					<tr>
					<td width="50"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="50" height="4"></td>
					<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
					</tr>
					
					<tr>
					<td width="50"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="50" height="4"></td>
					<td valign="top"><input type="button" class="whitefield"  onclick="window.open('#request.webroot#/ideas/dsp_moderator_action.cfm?sugID=#this_sugID#&currentcategory=#currentcategory#','moveIdea','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10');" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Move Idea &raquo;"> <input type="button" class="whitefield"  onclick="window.open('#request.webroot#/ideas/dsp_moderator_comments.cfm?sugID=#this_sugID#&currentcategory=#currentcategory#','Modcomment','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10');" style="cursor:hand;background-color:###TRIM(AllSettings.BoxColour)#;color:white;font-weight:bold;font-size:11px;border:0px;" value="Moderator Comments &raquo;"></td>
					</tr>
				
				</cfif>
				
				</table>				
				
				<cfif (session.UserIsAuthenticated EQ 'no') OR ((IsDefined("qry_user_vote") AND qry_user_vote.RecordCount LT 1 AND this_ContactID NEQ session.UserID)) AND NOT IsDefined("ShowReturned") AND NOT IsDefined("ShowPending") AND vote_idea EQ 1 AND this_pointsremaining GT 0>

					<cfif qry_sug_comments.recordcount>
					
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
										
						<tr>
						<td width="50"></td>
						<td style="padding-left:10px;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#currentcategory#"><img src="#request.imageroot#/view_mod_comments_button.gif" width="155" height="15" alt="View Feedback" border="0"></a></td>
						</tr>	
						
						</table>
						
					</cfif>					
				
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
					<tr>
					<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="10"></td>
					</tr>
					
					<input type="hidden" name="SugID_#qry_ideas_pond.CurrentRow#" value="#this_sugID#">
					<input type="hidden" name="votevalue_#qry_ideas_pond.CurrentRow#" value="Z">	
					<tr>
					<td width="23" align="center" style="font-size:11px;color:##666666;">Yes</td>
					<td width="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
					<td width="23" align="center" style="font-size:11px;color:##666666;">No</td>
					<td width="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
					<td style="padding-left:4px;"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
					</tr>	
						
					<tr>
					<td width="23"><cfif session.UserIsAuthenticated EQ 'Yes' AND NOT IsDefined("ShowReturned")><a onclick='javascript:if(document.getElementById("voteyes_#qry_ideas_pond.CurrentRow#").src=="#request.imageroot#/ideaFunL/new_vote_yes_off.gif") {document.getElementById("voteyes_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_yes_on.gif"; document.getElementById("voteno_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_no_off.gif"; document.voteform.votevalue_#qry_ideas_pond.CurrentRow#.value="5";} else {document.getElementById("voteyes_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_yes_off.gif"; document.getElementById("voteno_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_no_on.gif";  document.voteform.votevalue_#qry_ideas_pond.CurrentRow#.value="1";}'><cfelse><a href="javascript:alert('Please login to vote');"></cfif><img src="#request.imageroot#/ideaFunL/new_vote_yes_off.gif" width="23" height="22" alt="YES" border="0" id="voteyes_#qry_ideas_pond.CurrentRow#"></a></td>
					<td width="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="22"></td>
					<td width="23"><cfif session.UserIsAuthenticated EQ 'Yes' AND NOT IsDefined("ShowReturned")><a onclick='javascript:if(document.getElementById("voteno_#qry_ideas_pond.CurrentRow#").src=="#request.imageroot#/ideaFunL/new_vote_no_off.gif") {document.getElementById("voteno_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_no_on.gif"; document.getElementById("voteyes_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_yes_off.gif";  document.voteform.votevalue_#qry_ideas_pond.CurrentRow#.value="1";} else {document.getElementById("voteno_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_no_off.gif"; document.getElementById("voteyes_#qry_ideas_pond.CurrentRow#").src="#request.imageroot#/ideaFunL/new_vote_yes_on.gif";  document.voteform.votevalue_#qry_ideas_pond.CurrentRow#.value="5";}'><cfelse><a href="javascript:alert('Please login to vote');"></cfif><img src="#request.imageroot#/ideaFunL/new_vote_no_off.gif" width="23" height="22" alt="NO" border="0" id="voteno_#qry_ideas_pond.CurrentRow#"></a></td>
					<td width="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="22"></td>
					<td style="padding-left:4px;"><input type="text" style="border:solid 1px ##b4b4b4; background-color:white; height:22px; width:490px; font-size:12px; font-family:Arial; color:###TRIM(AllSettings.BoxColour)#; line-height:18px;" value="Add your feedback to help grow this idea..." onfocus="if(this.value=='' || this.value=='Add your feedback to help grow this idea...'){this.value=''};" name="comments_#qry_ideas_pond.CurrentRow#"></td>
					</tr>				
					
					</table>
						
				<cfelse>
				
					<table width="100%" cellpadding="0" cellspacing="0" border="0">
					
					<tr>
					<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="6"></td>
					</tr>			
				
					<tr>
					<td width="50"></td>
					<td style="padding-left:10px;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#currentcategory#"><img src="#request.imageroot#/ideaFunL/view_feedback.gif" width="167" height="18" alt="View Feedback" border="0"></a></td>
					</tr>				
					
					<cfif qry_sug_comments.recordcount>
					
					<tr>
					<td width="50"></td>
					<td style="padding-left:10px;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#currentcategory#"><img src="#request.imageroot#/view_mod_comments_button.gif" width="155" height="15" alt="View Moderator Comments" border="0"></a></td>
					</tr>	
					
					</cfif>		
					
					</table>
				</cfif>				
				
			</td>
			</tr>
			
			<tr>
			<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="2"><table cellpadding="0" cellspacing="0" border="0" width="100%"><tr><td height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td></tr></table></td>
			</tr>
			
			</cfloop>
			 
			</table>					
						
		</td>
		</tr>
		
		<tr>
		<td style="padding-top:10px;">
				
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
				<td bgcolor="##e2e2e2" style="font-size:11px;color:##444444;padding-left:4px;" valign="middle"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="17" align="absmiddle"><strong><cfif session.UserIsAuthenticated EQ 'Yes'>Click idea title for more details and to vote and enter feedback...<cfelse>Click idea title for details. Login to vote and give feedback...</cfif></strong></td>
				</tr>
				
				<tr>
				<td height="2" colspan="5"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="2"></td>
				</tr>
				
				<tr>
				<td height="1" colspan="5" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
				</tr>
				
				</table>
			
			</td>
			<cfif session.UserIsAuthenticated EQ 'Yes' AND NOT IsDefined("ShowReturned") AND vote_idea EQ 1 AND this_pointsremaining GT 0><td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="1"></td>
			<td align="right"><input type="image" src="#request.imageroot#/ideaFunL/new_process_votes.gif" width="101" height="23" alt="Process your votes" border="0"></td>
			</cfif>
			</tr>
	
	<cfelse>
		
		<tr>
		<td><strong>No ideas were found for using the search criteria specified above.</strong></td>
		</tr>
		
	</cfif>
			
			</table>
			
		</td>			
		</tr>
		
		</form>
	
	<tr>
	<td align="right" style="padding-top:10px;">
	
		<table cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td align="right" style="font-size:11px;"><cfif session.IdeaFunL_Startrow GT session.IdeaFunL_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&currentcategory=#currentcategory#&documentID=75&IdeaFunL_Startrow=#prev#<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">Prev Page</a> | </cfif><cfif IdeaFunL_endrow LT qry_ideas_pond.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&currentcategory=#currentcategory#&documentID=75&IdeaFunL_Startrow=#next#<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">Next Page</a> &gt;</cfif><cfif session.IdeaFunL_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#IdeaFunLNumberCount#" index="NumberCount"><cfset thisStartRow=(session.IdeaFunL_Maxrows * NumberCount - session.IdeaFunL_Maxrows + 1)><cfif thisStartRow EQ session.IdeaFunL_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&currentcategory=#currentcategory#&documentID=75&IdeaFunL_Startrow=#thisStartRow#<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif><cfif IsDefined("ShowReturned")>&ShowReturned=1</cfif><cfif IsDefined("ShowPending")>&ShowPending=1</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><cfif session.IdeaFunL_StartRow EQ NumberCount><strong></cfif>#NumberCount#<cfif session.IdeaFunL_StartRow EQ NumberCount></strong></cfif><cfif thisStartRow EQ session.IdeaFunL_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ IdeaFunLNumberCount> - </cfif></cfloop></cfif></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>	
	
</td>
</tr>

</table>

</cfoutput>
		