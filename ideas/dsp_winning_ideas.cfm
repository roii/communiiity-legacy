<cfoutput>

<cflock Type="exclusive" scope="session" timeout="10">

<cfparam name="session.WinIdeas_StartRow" default="1">
<cfif isdefined("WinIdeas_StartRow")>	
	<cfset session.WinIdeas_StartRow = WinIdeas_StartRow>
</cfif>	
	
<cfparam name="session.WinIdeas_MaxRows" default="5">
<cfif isdefined("WinIdeas_MaxRows")>	
	<cfset session.WinIdeas_MaxRows = WinIdeas_MaxRows>
</cfif>

</cflock>


<!--- GET ALL MAIN CATEGORIES FOR DROP DOWN --->
<cfinclude template="qry_all_maincats.cfm">

<script type="text/javascript">
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

<table width="100%" border="0">

<tr>
<td valign="top">#ideawinheading1# #ideawinheading2# #ideawinheading3#<br><br></td>
</tr>

</table>

<table width="100%" border="0">
<form method="post" action="#request.webroot#/index.cfm" name="ideasearch">
<input type="hidden" name="fuseaction" value="#fuseaction#">
<input type="hidden" name="fusesubaction" value="#fusesubaction#">
<input type="hidden" name="documentID" value="#documentID#">
<input type="hidden" name="WinIdeas_StartRow" value="1">

<cfif IsDefined("ideafunl_mode")>
<input type="hidden" name="ideafunl_mode" value="#ideafunl_mode#">
</cfif>

<tr>
<td><select name="srch_category" class="whitefield" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#; width: 300px;">
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
<option value="ALL"<cfif session.srch_stage EQ 'ALL'> selected</cfif>>#allwinningideas#
<option value="Stage 8"<cfif session.srch_stage EQ 'Stage 8'> selected</cfif>>#Doing#
<option value="Stage 9"<cfif session.srch_stage EQ 'Stage 9'> selected</cfif>>#Done#
</select> <input type="text" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;width:130px;" name="srch_keywords" onfocus="javascript:document.ideasearch.srch_keywords.value='';" value="<cfif session.srch_keywords NEQ ''>#session.srch_keywords#<cfelse>#ideacodekeywords#...</cfif>"> <input type="submit" value="#search# &raquo;" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;font-weight:bold;" class="whitefield"></td>
</tr>

</form>
</table><br>

<cfquery name="WinningSuggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.sugID, suggestion.suggestion, suggestion.details, suggestion.whenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.categoryID, suggestion.archived, suggestion.authorise, suggestion.WhenSugMade, suggestion.WhenSugEnded, suggestion.SugStage, suggestion.reward, suggestion.DisplayAsWinner, SugCategory.Name,  SugMainCategory.MainCatTitle
FROM suggestion, Contacts, SugCategory, SugMainCategory
WHERE suggestion.ContactID=Contacts.ContactID

<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
<cfelse>
	AND suggestion.DisplayAsWinner=1
</cfif>

AND suggestion.CategoryID=SugCategory.CategoryID
AND SugCategory.MainCatID=SugMainCategory.MainCatID

<cfif IsDefined("returnIdeas") AND returnIdeas NEQ ''>
	AND Suggestion.SugID IN (#returnideas#)
</cfif>

<cfif session.srch_category NEQ 'ALL'>
	AND suggestion.categoryID=#session.srch_category#
</cfif>
	
<cfif session.srch_keywords NEQ '' AND session.srch_keywords NEQ 'Idea code or keywords...'>
	AND (suggestion.Suggestion LIKE '%#session.srch_keywords#%' 
	OR suggestion.Details LIKE '%#session.srch_keywords#%'
	
	<cfif IsNumeric("#session.srch_keywords#")>
		OR suggestion.SugID = #session.srch_keywords#
	</cfif>
	
	OR Contacts.FirstName LIKE '%#session.srch_keywords#%' 
	OR contacts.lastName LIKE '%#session.srch_keywords#%')
</cfif>

<cfif session.srch_stage CONTAINS 'Stage 8'>
	AND suggestion.SugStage LIKE '%Stage 8%'
<cfelseif session.srch_stage CONTAINS 'Stage 9'>
	AND suggestion.SugStage LIKE '%Stage 9%'
<cfelse>
	AND (suggestion.SugStage LIKE '%Stage 4%' OR suggestion.SugStage LIKE '%Stage 5%' OR suggestion.SugStage LIKE '%Stage 6%' OR suggestion.SugStage LIKE '%Stage 7%' OR suggestion.SugStage LIKE '%Stage 8%' OR suggestion.SugStage LIKE '%Stage 9%')
</cfif>
	
ORDER BY suggestion.WhenSugEnded DESC
</cfquery>

<!--- SET THE IdeaFunL_endrow VALUE --->
<cfif session.WinIdeas_MaxRows NEQ 'ALL'>

	<cfif WinningSuggestions.RecordCount GT (session.WinIdeas_StartRow + session.WinIdeas_MaxRows) - 1>
		<cfset WinIdeas_endrow = session.WinIdeas_StartRow + session.WinIdeas_MaxRows - 1>
	<cfelse>
		<cfset WinIdeas_endrow = WinningSuggestions.RecordCount>
	</cfif>

<cfelse>
	<cfset WinIdeas_endrow = WinningSuggestions.RecordCount>			
</cfif>			

<!--- SET THE PREV VALUE --->
<cfif session.WinIdeas_Startrow GT session.WinIdeas_Maxrows>
	<cfset prev = session.WinIdeas_Startrow - session.WinIdeas_Maxrows>			
<cfelse>
	<cfset prev = session.WinIdeas_StartRow>			
</cfif>				

<!--- SET THE NEXT VALUE --->
<cfif WinIdeas_endrow LT WinningSuggestions.RecordCount>
	<cfset next = (WinIdeas_endrow + 1)>			
<cfelse>
	<cfset next = session.WinIdeas_StartRow>			
</cfif>		

<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
<cfif session.WinIdeas_MaxRows NEQ 'ALL'>			
	<cfset NumberCount = (WinningSuggestions.RecordCount / session.WinIdeas_Maxrows)>
	<cfset WinIdeasNumberCount = Ceiling(NumberCount)>			
<cfelse>			
	<cfset WinIdeasNumberCount=1>				
</cfif>

<table width="100%" cellspacing="1" cellspacing="1">
		
<tr>
<td colspan="2">
	
	<hr width="100%" size="1" color="e2e2e2">
	<table width="100%" cellspacing="0" cellspacing="0">
	
	<tr>
	<td style="font-size:11px;"><strong>#WinningSuggestions.RecordCount#</strong> winning ideas. <cfif WinningSuggestions.RecordCount>&nbsp; Displaying <strong>#session.WinIdeas_Startrow#</strong> - <strong>#WinIdeas_Endrow#</strong></cfif></td>
	<td align="right" style="font-size:11px;"><cfif WinningSuggestions.RecordCount>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&WinIdeas_maxrows=3&WinIdeas_StartRow=1&srch_category=#session.srch_category#&documentID=78<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">3</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&WinIdeas_maxrows=5&WinIdeas_StartRow=1&srch_category=#session.srch_category#&documentID=78<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">5</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&WinIdeas_maxrows=10&WinIdeas_StartRow=1&srch_category=#session.srch_category#&documentID=78<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&WinIdeas_maxrows=ALL&WinIdeas_StartRow=1&srch_category=#session.srch_category#&documentID=78<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></cfif></td>
	</tr>
	
	</table>
	<hr width="100%" size="1" color="e2e2e2"><br>
	<cfif IsDefined("WinningSuggestions") AND WinningSuggestions.RecordCount GT 0>
		
		
		<table cellpadding="0" cellspacing="0">			
		<tr>
		<td>
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="##e2e2e2" style="width:85px;">			
			<tr>
			<td style="color:##666666;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>IDEA ID</td>
			</tr>			
			</table>
		</td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
		<td>
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="##e2e2e2" style="width:85px;">			
			<tr>
			<td style="color:##666666;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>DATE WON</td>
			</tr>			
			</table>
		</td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
		<td>
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="##e2e2e2" style="width:95px;">			
			<tr>
			<td style="color:##666666;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>TOTAL VOTES</td>
			</tr>			
			</table>
		</td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
		<td>
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="##e2e2e2" style="width:80px;">			
			<tr>
			<td style="color:##666666;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>% YES</td>
			</tr>			
			</table>
		</td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
		<td>
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="##e2e2e2" style="width:95px;">			
			<tr>
			<td style="color:##666666;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>YOUR VOTE</td>
			</tr>			
			</table>
		</td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
		<td>
			<table cellpadding="2" cellspacing="0" border="0" bgcolor="##e2e2e2" style="width:95px;">			
			<tr>
			<td style="color:##666666;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>REWARD</td>
			</tr>			
			</table>
		</td>
		</tr>		
		</table><br>
		
		<!--- loop to display the suggestion --->
		<cfloop query="WinningSuggestions" startrow="#session.WinIdeas_StartRow#" endrow="#WinIdeas_endrow#">
		
			<cfset this_sugID = WinningSuggestions.SugID>
			<cfset this_Idea = WinningSuggestions.Suggestion>
			<cfset this_Details = WinningSuggestions.Details>
			<cfset this_ContactID = WinningSuggestions.ContactID>
			<cfset this_stage = WinningSuggestions.SugStage>
			<cfset this_reward = WinningSuggestions.reward>
			<cfset this_Topic = WinningSuggestions.Name>
			<cfset this_Start = WinningSuggestions.WhenSugMade>
			<cfset this_End = WinningSuggestions.WhenSugEnded>
			<cfset this_MainCat = WinningSuggestions.MainCatTitle>
			<cfset this_DisplayAsWinner = WinningSuggestions.DisplayAsWinner>
			
			<!--- GET REWARDS --->
			<cfquery name="IdeaRewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT SUM(contact_transactions.Transaction_Amount) AS TotalReward
			FROM contact_transactions
			WHERE ContactID=#this_ContactID#
			AND Transaction_Type LIKE 'Credit%'
			AND Transaction_Account LIKE '%Points%'
			AND Related_Identifier=#this_sugID#
			AND (Related_Description LIKE '%AddIdea%' OR Related_Description LIKE '%IdeaStage1%' OR Related_Description LIKE '%IdeaStage2%' OR Related_Description LIKE '%IdeaStage3%' OR Related_Description LIKE '%IdeaStage4%' OR Related_Description LIKE '%IdeaStage5%' OR Related_Description LIKE '%IdeaStage6%' OR Related_Description LIKE '%IdeaStage7%' OR Related_Description LIKE '%IdeaStage8%' OR Related_Description LIKE '%IdeaStage9%' OR Related_Description LIKE '%Bonus Points for your Idea%' OR Related_Description LIKE '%Bonus Points for your Idea%')
			</cfquery>		
			
			<cfif IdeaRewards.RecordCount AND IsNumeric("#IdeaRewards.TotalReward#")>
				<cfset this_reward = IdeaRewards.TotalReward>
			<cfelse>
				<cfset this_reward = 2111>
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
						
			</cfif>
						
			<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE sugID = #this_sugID#
			ORDER BY WhenVoteMade
			</cfquery>
			
			<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE sugID = #this_sugID#
			AND vote > 3
			</cfquery>
			
			<cfif AllVotes.RecordCount AND YesVotes.RecordCount>			
				<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>			
			<cfelse>				
				<cfset PercentYes = 0>
			</cfif>
			
			<cfif this_DisplayAsWinner EQ 1>
				<cfset headerBG = "##dddddd">
			<cfelse>
				<cfset headerBG = "##ffba75">
			</cfif>
			
			<table cellpadding="0" cellspacing="0">
			
			<tr>
			<td>
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#headerBG#" style="width:85px;">
				
				<tr>
				<td style="color:##333333;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>ID: #NumberFormat(this_sugID, "000000")#</td>
				</tr>
				
				</table>
			</td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
			<td>
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#headerBG#" style="width:85px;">
				
				<tr>
				<td style="color:##333333;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>#DateFormat(this_End)#</td>
				</tr>
				
				</table>
			</td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
			<td>
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#headerBG#" style="width:95px;">
				
				<tr>
				<td style="color:##333333;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>#AllVotes.RecordCount# votes</td>
				</tr>
				
				</table>
			</td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
			<td>
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#headerBG#" style="width:80px;">
				
				<tr>
				<td style="color:##333333;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>#INT(PercentYes)#%</td>
				</tr>
				
				</table>
			</td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
			<td>
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#headerBG#" style="width:95px;">
				
				<tr>
				<td style="color:##333333;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap><cfif IsDefined("isUserVote") AND isUserVote.RecordCount><cfif isUserVote.vote LTE 1>You Voted: NO<cfelse>You Voted: YES</cfif><cfelse><cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID NEQ session.userID>You didn't vote<cfelseif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID>Your Idea!<cfelse>&ndash;</cfif></cfif></td>
				</tr>
				
				</table>
			</td>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="2" height="1" border="0"></td>
			<td>
				<table cellpadding="2" cellspacing="0" border="0" bgcolor="#headerBG#" style="width:95px;">
				
				<tr>
				<td style="color:##333333;font-size:11px;padding-left:10px;padding-right:10px;" align="center" nowrap>#INT(this_reward)#pts earned</td>
				</tr>
				
				</table>
			</td>
			</tr>
			
			</table>
			
			<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 1px ##888888;">
			
			<tr>
			<td id="topcell#WinningSuggestions.CurrentRow#" style="background-color:##ffffff;">
			
				
				<table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left:4px;padding-right:4px;padding-top:4px;padding-bottom:4px;">
				
				<tr>
				<td valign="top" width="100%" height="100%"><a name="IDEA_#WinningSuggestions.CurrentRow#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></a><br>
					
					
					<table cellpadding="0" cellspacing="0" border="0" height="100%" width="100%">
					
					<tr>
					<td valign="top">
					<a title="View Details" href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&ideafunl_mode=voteresults&SingleIdea=#this_sugID#&currentcategory=#WinningSuggestions.categoryID#"><strong>#TRIM(this_Idea)#</strong></a><br>
				<span style="font-size:11px;color:###TRIM(AllSettings.DkTextColor)#;">#TRIM(this_Details)#</span></td>
					</tr>
					
					</table>
					
					
				</td>
				<td align="right" valign="top" height="100%" width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"><br>
					
					<table cellpadding="0" cellspacing="0" border="0" height="100%" width="120">
					
					<tr>
					<td nowrap style="padding-right:5px;" align="right" width="100%" valign="top"><cfif TRIM(ContactStuff.ScreenName) NEQ ''><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(ContactStuff.ScreenName)#" title="View Profile">#TRIM(ContactStuff.ScreenName)#</a><cfelse><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile">#TRIM(ContactStuff.FirstName)#</a></cfif></td>
					<td align="right" width="24" valign="top"><cfif TRIM(ContactStuff.ScreenName) NEQ ''><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(ContactStuff.ScreenName)#" title="View Profile"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile"></cfif><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" border="0"></a></td>
					</tr>
					
					<tr>
					<td colspan="2" height="100%" valign="bottom" align="right"><a href="##&##IDEA_#WinningSuggestions.CurrentRow#" class="textlinks" onClick="toggleContent(#WinningSuggestions.CurrentRow#); return false;"><img src="#request.imageroot#/ideaFunL/expand.gif" border="0" name="imexpandbut_#WinningSuggestions.CurrentRow#" style="display:visible;"></a><a href="##&##IDEA_#WinningSuggestions.CurrentRow#" class="textlinks" onClick="toggleContent(#WinningSuggestions.CurrentRow#); return false;"><img src="#request.imageroot#/ideaFunL/close.gif" border="0" name="imclosebut_#WinningSuggestions.CurrentRow#" style="display:none;"></a></td>
					</tr>
					
					</table>
				
				</td>
				</tr>
				
				</table>				
				
			</td>
			</tr>		
			
			<tr style="display:none;" id="kb#WinningSuggestions.CurrentRow#">
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
					<td align="right" style="padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top"><strong>Voted Winner:</strong></td>
					<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><strong>#DateFormat(this_End)#</strong></td>
					</tr>
					
					<cfif IsDefined("session.UserIsAuthenticated") AND session.UserIsAuthenticated EQ 'yes' AND session.UserType EQ 'Administrator'>
						<tr>
						<td align="right" style="padding-top:10px;padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top"><strong>Admin:</strong></td>
						<td style="padding-top:10px;color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top"><a href="#request.webroot#/administration/dsp_edit_idea.cfm?sugID=#this_sugID#&winnerIdeas=1" target="editIdea" onclick="fdbackwindow=window.open ('','editIdea','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaDelete('#request.webroot#/administration/act_RemoveSug.cfm?sugID=#this_sugID#')"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Idea" border="0"></a>&nbsp;<a href="#request.webroot#/audit.cfm?IdeaList=#this_SugID#" style="font-size:11px;">Audit</a></td>
						<td></td>
						<td align="right" style="padding-top:10px;padding-right:5px;color:###TRIM(AllSettings.BoxColour)#;font-size:11px;" valign="top">&nbsp;</td>
						<td style="padding-top:10px;color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top">&nbsp;</td>
						</tr>
					
					</cfif>
					
					</table>				
				
				</td>				
				</tr>
				
				</table><br>			
				
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					
				<tr>
				<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" border="0" width="1" height="6"></td>
				</tr>			
			
				<tr>
				<td width="50"></td>
				<td style="padding-left:10px;"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#WinningSuggestions.categoryID#"><img src="#request.imageroot#/ideaFunL/view_feedback.gif" width="167" height="18" alt="View Feedback" border="0"></a></td>
				</tr>				
				
				</table><br>				
			
			</td>			
			</tr>			
			
			</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" alt="" border="0"><br>
			
			</cfloop>
			
			<table cellpadding="0" cellspacing="0" border="0" width="100%">
		
			<tr>
			<td align="right" style="font-size:11px;"><cfif session.WinIdeas_Startrow GT session.WinIdeas_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=78&WinIdeas_Startrow=#prev#<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">Prev Page</a> | </cfif><cfif WinIdeas_endrow LT WinningSuggestions.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=78&WinIdeas_Startrow=#next#<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;">Next Page</a> &gt;</cfif><cfif session.WinIdeas_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#WinIdeasNumberCount#" index="NumberCount"><cfset thisStartRow=(session.WinIdeas_Maxrows * NumberCount - session.WinIdeas_Maxrows + 1)><cfif thisStartRow EQ session.WinIdeas_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=78&WinIdeas_Startrow=#thisStartRow#<cfif IsDefined('returnIdeas') AND returnIdeas NEQ ''>&returnIdeas=#returnIdeas#</cfif>" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><cfif session.WinIdeas_StartRow EQ NumberCount><strong></cfif>#NumberCount#<cfif session.WinIdeas_StartRow EQ NumberCount></strong></cfif><cfif thisStartRow EQ session.WinIdeas_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ WinIdeasNumberCount> - </cfif></cfloop></cfif></td>
			</tr>
			
			</table>
		
		<cfelse>
		
			<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 1px ##b4b4b4;">
			
			<tr>
			<td>			
				
				<table width="100%" cellpadding="0" cellspacing="0" border="0" style="padding-left:4px;padding-right:4px;padding-top:4px;padding-bottom:4px;">
				<tr>
				<td valign="top" width="100%" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>#noideamsg#.</strong></td>
				</tr>				
				</table>				
				
			</td>
			</tr>
				
			</table>
		
		</cfif>	

</td>
</tr>

</table>
		
</cfoutput>
		