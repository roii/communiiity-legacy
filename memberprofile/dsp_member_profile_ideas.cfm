<cfoutput>

<script>
<!--
function IdeaSwapView(d, n){ 

	var temp_0 = "TBL" + d;
	
	if (document.getElementById(temp_0).style.visibility == "hidden") { 
	document.getElementById(temp_0).style.visibility='visible'; 
	
		if (navigator.appName == 'Microsoft Internet Explorer') {
		document.getElementById(temp_0).style.position ='fixed';
		}
		
		else {
		document.getElementById(temp_0).style.position ='relative';
		}
		
		
	} else {
	document.getElementById(temp_0).style.visibility='hidden'; 
	document.getElementById(temp_0).style.position ='absolute';
	} 
	return 0;	
} 
// -->
</script>


<!--- GET AUTHORISED IDEAS --->
<cfquery name="AllSuggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID, WhenSugMade, suggestion, SugStage, CategoryID, Authorise, Archived
FROM suggestion
WHERE ContactID=#ContactDetails.contactID#
ORDER BY WhenSugMade DESC
</cfquery>

<cfif AllSuggestions.RecordCount>
	<cfset IdeaList = ValueList(AllSuggestions.SugID)>
<cfelse>
	<cfset IdeaList = 0>
</cfif>

<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID IN (#IdeaList#)
</cfquery>

<cfquery datasource="#dsn#"  name="AllYesVotes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID IN (#IdeaList#)
AND vote > 3
</cfquery>

<cfif AllVotes.RecordCount>	
	<cfset PercentYes = (AllYesVotes.RecordCount / AllVotes.RecordCount * 100)>	
<cfelse>		
	<cfset PercentYes = 0>		
</cfif>


<!--- GET AUTHORISED IDEAS --->
<cfquery name="AllActiveSuggestions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID, WhenSugMade, suggestion, SugStage, CategoryID
FROM suggestion
WHERE ContactID=#ContactDetails.contactID#
AND Authorise LIKE '%yes%'
AND Archived=0
ORDER BY WhenSugMade DESC
</cfquery>


<cfquery datasource="#dsn#"  name="AllVotedFor" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE ContactID=#ContactDetails.contactID#
</cfquery>

<cfquery datasource="#dsn#"  name="AllYesVotedFor" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE ContactID=#ContactDetails.contactID#
AND vote > 3
</cfquery>

<cfif AllVotedFor.RecordCount>	
	<cfset Votedfor_PercentYes = (AllYesVotedFor.RecordCount / AllVotedFor.RecordCount * 100)>	
<cfelse>		
	<cfset Votedfor_PercentYes = 0>		
</cfif>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Ideas</strong></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="2" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	<td width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="2" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">Number of ideas submitted:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"><strong>#AllSuggestions.RecordCount#</strong></td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">% Yes votes:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"><strong>#DecimalFormat(PercentYes)#%</strong></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">Number of ideas voted on:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"><strong>#AllVotedFor.RecordCount#</strong></td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-left:5px;">% Yes votes:</td>
	<td style="color:###TRIM(AllSettings.DKTextColor)#;padding-right:5px;"><strong>#DecimalFormat(Votedfor_PercentYes)#%</strong></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	
	</table>


</td>
</tr>

</table><br>


<cfif AllActiveSuggestions.RecordCount>

&nbsp;&nbsp;<span style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Active Ideas:</strong></span>&nbsp; <a href="##" onClick="javascript:IdeaSwapView('1', 0);" style="color:###TRIM(AllSettings.BoxColour)#;text-decoration:none;" id="BY1">Show</a> | <a href="##" onClick="javascript:IdeaSwapView('1', 0);" style="color:###TRIM(AllSettings.BoxColour)#;text-decoration:none;" id="BY1">Hide</a><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>

<div id="TBL1" style="position:absolute; border-style:none; Z-INDEX: TBL; visibility:hidden; padding:5px;">

	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height="35" class="normal">
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;padding-left:5px;font-size:12px;"><strong><cfif TRIM(ContactDetails.ScreenName) NEQ ''>#TRIM(ContactDetails.ScreenName)#<cfelse>#TRIM(ContactDetails.FirstName)#</cfif>'s Active Ideas</strong></td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center">Votes</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center" nowrap>% Yes</td>
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;" align="center" nowrap>Your Vote</td>			
	</tr>


<!--- loop to display the suggestion --->
	<cfloop query="AllActiveSuggestions">
		
	<cfset this_sugID = AllActiveSuggestions.SugID>
	<cfset this_ContactID = ContactDetails.ContactID>
	<cfset this_CategoryID = AllActiveSuggestions.CategoryID>
	
	<cfquery datasource="#dsn#"  name="ContactStuff" username="#request.username#" password="#request.password#">
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
		<cfif isUserVote.recordCount>
	
			<cfset bgColor="eaeaea">
			<cfset vote = 1>
		
		</cfif>
		
		<cfif this_ContactID NEQ '' AND this_ContactID EQ session.UserID>
			<cfset bgColor="eaeaea">
		</cfif>
		
		
	</cfif>
				
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
	
		<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
	
	<cfelse>
		
		<cfset PercentYes = 0>
		
	</cfif>
	
	<cfif vote EQ 1 OR session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID>
	
	<tr bgcolor="#bgColor#" height="23">
	<td style="padding-left:5px;"><a title="View Details" href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#this_SugID#&currentcategory=#this_CategoryID#">#TRIM(AllActiveSuggestions.suggestion)#</a></td>						
	<td align="center">#AllVotes.RecordCount#</td>
	<td align="center">#INT(PercentYes)#%</td>			
	<td align="center"><cfif session.UserIsAuthenticated EQ 'Yes' AND this_ContactID EQ session.userID><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas&EditIdea=1&SugID=#SugID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Idea" border="0"></a>&nbsp;<a href="javascript:confirmIdeaDelete('#request.webroot#/ideas/act_remove_idea.cfm?SugID=#SugID#');"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="REMOVE YOUR IDEA#chr(10)#Your idea will be moved#chr(10)#to your Returned Ideas list" border="0"></a><cfelse><cfif isUserVote.vote LTE 1>NO<cfelse>YES</cfif></cfif></td>		
	</tr>					
	</cfif>
	</cfloop>

	</table><br>
</div>
</cfif>

</cfoutput>