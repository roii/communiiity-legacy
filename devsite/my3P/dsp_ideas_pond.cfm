<script language="javascript">
function validateSelRate(frm){
	if(frm.login.value == 0){
		alert('You must be a member and logged-in to vote.');
		return false;
	}	
}
</script>

<script language="JavaScript">
<!--
function confirmIdeaDelete(aURL) {
    if(confirm('Are you sure you want to remove this idea from the Voting Area?\nIt will be moved to your \"Returned\" ideas list')) {
      location.href = aURL;
    }
  }
//-->
</script>

<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.IdeaFunL_StartRow" default="1">
</cflock>

	<cfif isdefined("IdeaFunL_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.IdeaFunL_StartRow = IdeaFunL_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.IdeaFunL_MaxRows" default="50">
</cflock>

<cfif isdefined("IdeaFunL_MaxRows")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.IdeaFunL_MaxRows = IdeaFunL_MaxRows>
	</cflock>
</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.IdeaFunL_hideIdeas" default="Yes">
</cflock>

<cfif isdefined("IdeaFunL_hideIdeas")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.IdeaFunL_hideIdeas = IdeaFunL_hideIdeas>
	</cflock>
</cfif>

<cfoutput>

<cfquery name="Category" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM SugCategory
WHERE Active = 1
ORDER BY DisplayOrder
</cfquery>

<cfquery name="CurrentStuff" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM SugCategory
WHERE CategoryID=#currentcategory#
</cfquery>

<cfquery name="CurrentSponsor" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT Organisation_Name, LogoFile
FROM Organisations

<cfif IsNumeric("#CurrentStuff.SponsorID#") AND CurrentStuff.SponsorID NEQ 0>
	WHERE OrganisationID=#CurrentStuff.SponsorID#
<cfelse>
	WHERE OrganisationID=10
</cfif>
</cfquery>

<cfinclude template="qry_ideas_pond.cfm">

<cfset activityid = 2>


<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT SugID
FROM Suggestion
WHERE CategoryID=#currentcategory#
AND Authorise LIKE '%No%'
AND Archived = 0
GROUP BY SugID
</cfquery>
		
		
		
<cfif AllSuggestions.RecordCount>
	<cfset ThisCatideas = valueList(AllSuggestions.SugID)>
<cfelse>
	<cfset ThisCatideas = "0">		
</cfif>

<cfif AllCat_InActiveIdeas.RecordCount>
	<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
</cfif>


<cfquery name="AllPointsEarned" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
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



<cfset this_pointsremaining = INT(CurrentStuff.PointsAllocated - AllPointsEarned.TotalPointsEarned)>


<cfset add_idea = 1>
<cfset vote_idea = 1>

<cfif this_pointsremaining EQ 0>

	<cfset add_idea = 0>
	<cfset vote_idea = 0>
	
<cfelseif IsDate("#CurrentStuff.WhenCategoryEnded#") AND dateCompare(localdatetime, CurrentStuff.WhenCategoryEnded) EQ 1>

	<cfset add_idea = 0>
	<cfset vote_idea = 0>

<cfelseif this_pointsremaining LTE CurrentStuff.PointsCutOff>
	
	<cfset add_idea = 0>
	
</cfif>




<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td valign="middle"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75"><img src="#request.imageroot#/ideaFunL/new_02_1.gif" width="35" height="52" alt="1. Select a topic" border="0"></a><img src="#request.imageroot#/ideaFunL/new_02_2.gif" width="59" height="52" alt="2. VIEW IDEAS" border="0"><img src="#request.imageroot#/ideaFunL/new_02_3.gif" width="36" height="52" alt="3. Vote on an idea" border="0"><br>
<img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="8"><br>




</td>
<td align="right" valign="middle">
	
	<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="documentID" value="#documentID#">
	<input type="hidden" name="IdeaFunL_Startrow" value="1">
	
	<tr>
	<td align="right"><select name="currentcategory" class="whitefield" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
	<cfloop query="Category">
	<option value="#Category.categoryID#"<cfif currentcategory EQ Category.categoryID> selected</cfif>>#TRIM(Category.Name)#
	</cfloop>
	</select> <input type="submit" value="CHANGE TOPIC" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;" class="whitefield"></td>
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
	
	<td width="40" align="left" valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"><br><cfif FileExists("#request.fileroot#\images\partners\#TRIM(CurrentSponsor.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(CurrentSponsor.LogoFile)#" border="0" title="#TRIM(CurrentSponsor.Organisation_Name)#"></cfif></td>
	<td valign="top" align="right" width="100%">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td colspan="3"><span style="font-size:14px;color:###TRIM(AllSettings.BoxColour)#;"><strong>#TRIM(CurrentStuff.Name)#</strong></span><br>
		#TRIM(CurrentStuff.description)#
		<hr size=1 color=e2e2e2>
		</td>
		</tr>
		
		<tr>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Sponsor:</strong> #TRIM(CurrentSponsor.Organisation_Name)#</td>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Points Available:</strong> #this_pointsremaining#</td>
		<td width="33%" style="color:###TRIM(AllSettings.DkTextColor)#;" align="right"><strong>Finishes:</strong> <cfif this_pointsremaining EQ 0>Finished<cfelseif IsDate("#CurrentStuff.WhenCategoryEnded#") AND dateCompare(localdatetime, CurrentStuff.WhenCategoryEnded) EQ 1>Finished<cfelse>#DateFormat(CurrentStuff.WhenCategoryEnded)#</cfif></td>
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
		
		
		
		<cfif IsDefined("AllSuggestions")>
			
			
			<!--- SET THE IdeaFunL_endrow VALUE --->
			<cfif session.IdeaFunL_MaxRows NEQ 'ALL'>
			
				<cfif AllSuggestions.RecordCount GT (session.IdeaFunL_StartRow+session.IdeaFunL_MaxRows)-1>
					<cfset IdeaFunL_endrow = session.IdeaFunL_StartRow+session.IdeaFunL_MaxRows-1>
				<cfelse>
					<cfset IdeaFunL_endrow = AllSuggestions.RecordCount>
				</cfif>
			
			<cfelse>
				<cfset IdeaFunL_endrow = AllSuggestions.RecordCount>
			
			</cfif>
			
			
			
			<!--- SET THE PREV VALUE --->
			<cfif session.IdeaFunL_Startrow GT session.IdeaFunL_Maxrows>
				<cfset prev = session.IdeaFunL_Startrow-session.IdeaFunL_Maxrows>
			
			<cfelse>
				<cfset prev = session.IdeaFunL_StartRow>
			
			</cfif>
			
			
			
			<!--- SET THE NEXT VALUE --->
			<cfif IdeaFunL_endrow LT AllSuggestions.RecordCount>
				<cfset next = (IdeaFunL_endrow+1)>
			
			<cfelse>
				<cfset next = session.IdeaFunL_StartRow>
			
			</cfif>
			
			
			
			<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
			<cfif session.IdeaFunL_MaxRows NEQ 'ALL'>
			
				<cfset NumberCount=(AllSuggestions.RecordCount/session.IdeaFunL_Maxrows)>
				<cfset IdeaFunLNumberCount=Ceiling(NumberCount)>
			
			<cfelse>
			
				<cfset IdeaFunLNumberCount=1>
				
			</cfif>
			
			<tr>
			<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"><br>
	
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
				<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
				<input type="hidden" name="fuseaction" value="#fuseaction#">
				<input type="hidden" name="fusesubaction" value="#fusesubaction#">
				<input type="hidden" name="documentID" value="#documentID#">
				<input type="hidden" name="IdeaFunL_StartRow" value="1">
				<input type="hidden" name="currentcategory" value="#currentcategory#">
				
				<tr>
				<td><select name="srch_stage" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">
				<option value="ALL"<cfif session.srch_stage EQ 'ALL'> selected</cfif>>ANY STAGE
				<option value="Stage 1"<cfif session.srch_stage EQ 'Stage 1'> selected</cfif>>Stage 1
				<option value="Stage 2"<cfif session.srch_stage EQ 'Stage 2'> selected</cfif>>Stage 2
				<option value="Stage 3"<cfif session.srch_stage EQ 'Stage 3'> selected</cfif>>Stage 3
				</select> <input type="text" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;" name="srch_keywords" onfocus="javascript:document.ideasearch.srch_keywords.value='';" value="<cfif session.srch_keywords NEQ ''>#session.srch_keywords#<cfelse>Keywords...</cfif>"> <input type="submit" value="SEARCH" class="whitefield" style="height:20px; font-size:11px;color:###TRIM(AllSettings.BoxColour)#;"></td>
				<td align="right"><cfif add_idea EQ 1><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=76&categoryID=#currentcategory#"><img src="#request.imageroot#/addidea_butt.gif" width="108" height="20" alt="Add a new idea" border="0"></a></cfif></td>
				</tr>
				
				</form>
				</table>
			
			<hr width="100%" size="1" color="e2e2e2">
			
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td style="font-size:11px;"><strong>#AllSuggestions.RecordCount#</strong> ideas. <cfif AllSuggestions.RecordCount>&nbsp; Displaying <strong>#session.IdeaFunL_Startrow#</strong> - <strong>#IdeaFunL_Endrow#</strong></cfif></td>
				<td align="center" style="color:###TRIM(AllSettings.DkTextColor)#;padding-top:4px;font-size:11px;">Ideas I've voted on:&nbsp; <cfif session.IdeaFunL_hideIdeas EQ 'Yes'><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75&IdeaFunL_hideIdeas=No"></cfif><strong>SHOW</strong></a> | <cfif session.IdeaFunL_hideIdeas EQ 'No'><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75&IdeaFunL_hideIdeas=Yes"></cfif><strong>HIDE</strong></a></td>
				<td align="right" style="font-size:11px;"><cfif AllSuggestions.RecordCount>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=20&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=50&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=100&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_maxrows=ALL&IdeaFunL_StartRow=1&currentcategory=#currentcategory#&documentID=75" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></cfif></td>
				</tr>
				
				</table>
			
			
			<hr width="100%" size="1" color="e2e2e2">
			 </td>
			</tr>
			
			<cfif AllSuggestions.RecordCount>
				
				<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height="35" class="normal">
				<td style="color:###TRIM(AllSettings.BoxTextColour)#;padding-left:5px;">The suggestions/ideas</td>
				<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">By</td>
				<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">Votes</td>
				<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">%<br>Yes</td>
				<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">Your<br>Vote</td>			
				</tr>
				
				
				<!--- loop to display the suggestion --->
				<cfloop query="AllSuggestions" startrow="#session.IdeaFunL_StartRow#" endrow="#IdeaFunL_endrow#">
					
					<cfset this_sugID = AllSuggestions.SugID>
					<cfset this_ContactID = AllSuggestions.ContactID>
					
					<cfquery datasource="#dsn#"  name="ContactStuff" username="mykidsbizcom" password="w29snfc66r">
					SELECT FirstName, ScreenName
					FROM Contacts
					WHERE ContactID=#this_ContactID#
					</cfquery>
				
				
					<!--- set the background color of the row --->				
					<cfset bgColor="ffffff">
					<cfset vote = 0 >
					
					<cfif session.UserIsAuthenticated EQ 'yes'>
					
							<!--- user has vote if isUserVote recordCount > 0 or the suggestion was made by the user --->
							<cfif ListFind(votedList, this_sugID, ",")>
						
								<cfset bgColor="e2e2e2">
								<cfset vote = 1>
							
							</cfif>
							
							<cfif this_ContactID NEQ '' AND this_ContactID EQ session.UserID>
								<cfset bgColor="e2e2e2">
							</cfif>
						
						
					</cfif>
								
					<cfquery datasource="#dsn#"  name="AllVotes" username="mykidsbizcom" password="w29snfc66r">
					SELECT *
					FROM SugVote
					WHERE sugID = #this_sugID#
					</cfquery>
					
					<cfquery datasource="#dsn#"  name="YesVotes" username="mykidsbizcom" password="w29snfc66r">
					SELECT *
					FROM SugVote
					WHERE sugID = #this_sugID#
					AND vote > 3
					</cfquery>
					
					<cfif AllVotes.RecordCount>
					
						<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
					
					<cfelse>
						
						<cfset PercentYes = 0>
						
					</cfif>
					
					<cfif vote_idea EQ 1>
					
						<tr bgcolor="#bgColor#" height="23">
						<td style="padding-left:5px;"><cfif len(suggestion) GT 50><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75">#mid(suggestion,1,50)#</a> <a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75" style="color:###TRIM(AllSettings.BoxColour)#;">details..</a><cfelse><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75">#suggestion#</a></cfif></td>			
						<td align="center" style="font-size:11px;"><a name="SUG#sugID#"></a><cfif (vote EQ 1) OR (session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID) OR (session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator')><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle"></a> <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><cfif TRIM(ContactStuff.ScreenName) NEQ ''>#TRIM(ContactStuff.ScreenName)#<cfelse>#TRIM(ContactStuff.FirstName)#</cfif></a><cfelse><a href="##" title="You must vote before you can see#chr(10)#the author of this idea!">?</a></cfif></td>				
						<td align="center"><cfif (vote EQ 1) OR (session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID) OR (session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator')>#AllVotes.RecordCount#<cfelse><a href="##" title="You must vote before you can see#chr(10)#the number of votes received!">?</a></cfif></td>
						<td align="center"><cfif (vote EQ 1) OR (session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID) OR (session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator')>#INT(PercentYes)#%<cfelse><a href="##" title="You must vote before you can see#chr(10)#the average vote!">?</a></cfif></td>			
						<td align="center"><cfif IsDefined("isUserVote") AND isUserVote.RecordCount><cfif isUserVote.vote LTE 1>NO<cfelse>YES</cfif><cfelse><cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID NEQ session.userID><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75"><img src="#request.imageroot#/ideaFunL/vote_button.gif" width="66" height="19" alt="Vote Now!" border="0"></a><cfelseif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#SugID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaDelete('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#SugID#');"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="REMOVE YOUR IDEA#chr(10)#Your idea will be moved#chr(10)#to your Returned Ideas list" border="0"></a><cfelse><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75"><img src="#request.imageroot#/ideaFunL/vote_button.gif" width="66" height="19" alt="Vote Now!" border="0"></a></cfif></cfif></td>		
						</tr>					
					
					<cfelse>
					
						<tr bgcolor="#bgColor#" height="23">
						<td style="padding-left:5px;"><cfif len(suggestion) GT 50><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75">#mid(suggestion,1,50)#</a> <a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75" style="color:###TRIM(AllSettings.BoxColour)#;">details..</a><cfelse><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&ideafunl_mode=details&sugID=#sugID#&currentcategory=#currentcategory#&fusesubaction=docs&documentid=75">#suggestion#</a></cfif></td>			
						<td align="center"><a name="SUG#sugID#"></a><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"><cfif TRIM(ContactStuff.ScreenName) NEQ ''>#TRIM(ContactStuff.ScreenName)#<cfelse>#TRIM(ContactStuff.FirstName)#</cfif></a></td>				
						<td align="center">#AllVotes.RecordCount#</td>
						<td align="center">#INT(PercentYes)#%</td>			
						<td align="center"><cfif IsDefined("isUserVote") AND isUserVote.RecordCount><cfif isUserVote.vote LTE 1>NO<cfelse>YES</cfif><cfelse><cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID NEQ session.userID>You did not vote<cfelseif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID>Your Idea!<cfelse>You did not vote</cfif></cfif></td>		
						</tr>
					
					</cfif>
					
					</cfloop>
					
					
					
				
					<tr>
					<td colspan="5" style="font-size:11px;">			
					<hr width="100%" size="1" color="e2e2e2">
					<cfif session.IdeaFunL_Startrow GT session.IdeaFunL_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_Startrow=#prev#&documentID=75&currentcategory=#currentcategory#">Prev Page</a> | </cfif><cfif IdeaFunL_endrow LT AllSuggestions.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_Startrow=#next#&documentID=75&currentcategory=#currentcategory#">Next Page</a> &gt;</cfif><cfif session.IdeaFunL_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#IdeaFunLNumberCount#" index="NumberCount"><cfset thisStartRow=(session.IdeaFunL_Maxrows*NumberCount-session.IdeaFunL_Maxrows+1)><cfif thisStartRow EQ session.IdeaFunL_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&IdeaFunL_Startrow=#thisStartRow#&documentID=75&currentcategory=#currentcategory#"></cfif>#NumberCount#<cfif thisStartRow EQ session.IdeaFunL_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ IdeaFunLNumberCount> - </cfif></cfloop></cfif></td>
					</tr>			
				
			
			
			<cfelse>
			
				<tr>
				<td colspan="5" style="font-size:11px;">There are no authorised ideas for this topic. You could be the first member to <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=76&categoryID=#currentcategory#">ADD AN IDEA!</a>
				</td>
				</tr>
				
			</cfif>
			
					
		</cfif>	
			</table>
	
	</td>
	</tr>
	
	<cfif session.UserIsAuthenticated NEQ 'Yes'>
	<tr class="normal">
	<td>
	
	
	
		<span style="color:###TRIM(AllSettings.BoxColour)#;font-size:12px;"><strong>To vote on ideas and to add your own ideas - <span style="color:###TRIM(AllSettings.DkTextColor)#">Login first  &raquo;</span></strong></span>
	<br><br>
	
	</td>
	</tr>
	</cfif>
	
	</table>

</td>
</tr>

</table>
</cfoutput>
		