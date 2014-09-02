<cfoutput>


<script language="JavaScript">

function ValidateAddIdea(frmSuggestionInputForm){

if (frmSuggestionInputForm.rate1.selectedIndex == "0") {
	alert("You must vote on Idea 1.");
	frmSuggestionInputForm.rate1.focus();
	return;
	}
	

	
else if (document.frmSuggestionInputForm.comments1.value == "comments..." || document.frmSuggestionInputForm.comments1.value == "") {

if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
	document.frmSuggestionInputForm.submit();
	}
	return;
}

else if (frmSuggestionInputForm.rate2.selectedIndex == "0") {
	alert("You must vote on Idea 2.");
	frmSuggestionInputForm.rate2.focus();
	return;
	}
	
else if (document.frmSuggestionInputForm.comments2.value == "comments..." || document.frmSuggestionInputForm.comments2.value == "") {

if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
	document.frmSuggestionInputForm.submit();
	}
	return;
}

	
else if (frmSuggestionInputForm.rate3.selectedIndex == "0") {
	alert("You must vote on Idea 3.");
	frmSuggestionInputForm.rate3.focus();
	return;
	}
	

else if (document.frmSuggestionInputForm.comments3.value == "comments..." || document.frmSuggestionInputForm.comments3.value == "") {

if(confirm('Are you sure you don\'t want to add some comments?\n\nAdding constructive comments helps the author of the\nidea to either refine it further or understand why it\nis not so great. It also earns you more points!')) {
	document.frmSuggestionInputForm.submit();
	}
	return;
}

	
else {
	frmSuggestionInputForm.submit(); //submit form
}
}
</script>

	
<cfquery name="selCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryID, Name
FROM SugCategory
WHERE whenCategoryEnded IS NULL
ORDER BY Name ASC
</cfquery>

	
<!--- QUERY FOR UN-AUTHORISED --->
<cfquery name="AllUnauthorised" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUGID, suggestion, details
FROM suggestion
WHERE ContactID <> #session.UserID#
AND Authorise LIKE '%No%'
AND SugStage LIKE '%Pending%'
AND Archived = 0
ORDER BY WhenSugMade ASC
</cfquery>

<table width="100%" cellspacing="0" cellpadding="0" border="0">

<form name="frmSuggestionInputForm" action="#request.webroot#/ideas/act_new_critical_votes.cfm" method="post" onsubmit="javascript:ValidateAddIdea(frmSuggestionInputForm); return false;">
<tr>
<td><br><img src="#request.imageroot#/ideaFunL/critical_votes.gif" width="379" height="36" alt="Please vote for the following ideas first." border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<cfif AllUnauthorised.recordcount>
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" border="0" width="45"></td>
		<td width="100%">
		
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
					
			<tr>
			<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
			</tr>
			
			<cfset Vote_1 = 0>
			<cfset Vote_2 = 0>
			<cfset Vote_3 = 0>
			
			<cfset IdeaCount = 0>
			
			
			<cfloop query="AllUnauthorised">
			
			<cfset this_sugID = AllUnauthorised.sugID>
			
			
			
			<!--- check if user has voted for this current suggestion --->
			<cfquery datasource="#dsn#"  name="isUserVote" username="#request.username#" password="#request.password#">
			SELECT *
			FROM SugVote
			WHERE SugID = #this_sugID#
			AND ContactID = #session.UserID#
			</cfquery>
			
			
			
			<cfif isUserVote.recordCount EQ 0>
			
				
				<cfquery datasource="#dsn#"  name="Sug_TotalVotes" username="#request.username#" password="#request.password#">
				SELECT contactID
				FROM SugVote
				WHERE sugID = #this_sugID#
				</cfquery>
				
				
				
								
				<!--- IF LOOKING FOR FIRST IDEA (NO VOTES YET) --->
				<cfif Vote_1 EQ 0 AND Sug_TotalVotes.RecordCount EQ 0>
						
						<cfset IdeaCount = IdeaCount+1>
					
						<input type="hidden" name="sugID#IdeaCount#" value="#this_sugID#">
				
						<tr>
						<td width="20" valign="top" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>#IdeaCount#.</strong></td>
						<td width="*" style="padding-left:5px;padding-right:20px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>#suggestion#</strong><cfif TRIM(details) NEQ ''> &nbsp; <a title="#details#" style="font-size:10px;color:black;">[more info]</a></cfif></td>
						</tr>
						
						<tr>
						<td colspan="2" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
						</tr>
						
						<tr>
						<td width="20" valign="top"> </td>
						<td width="*" style="padding-left:5px;padding-right:20px;" valign="top"><select style="font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="rate#IdeaCount#">
						<option value="0">Select</option>
						<option value="5">YES - It's a winner!</option>
						<option value="1">NO - Not so good</option>
						</select> <input type="text" style="width:250px;font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="comments#IdeaCount#" onfocus="javascript: if (document.frmSuggestionInputForm.comments#IdeaCount#.value == 'comments...'){document.frmSuggestionInputForm.comments#IdeaCount#.value='';}" value="comments..."></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
						</tr>
						<cfset Vote_1 = 1>
						
					
					
				
				<cfelseif Vote_2 EQ 0 AND Sug_TotalVotes.RecordCount EQ 1>
				
						<cfset IdeaCount = IdeaCount+1>
						
						<input type="hidden" name="sugID#IdeaCount#" value="#this_sugID#">
				
						<tr>
						<td width="20" valign="top" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong><a title="#Sug_TotalVotes.RecordCount# - ID:#this_sugID#">#IdeaCount#.</a></strong></td>
						<td width="*" style="padding-left:5px;padding-right:20px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>#suggestion#</strong><cfif TRIM(details) NEQ ''> &nbsp; <a title="#details#" style="font-size:10px;color:black;">[more info]</a></cfif></td>
						</tr>
						
						<tr>
						<td colspan="2" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
						</tr>
						
						<tr>
						<td width="20" valign="top"> </td>
						<td width="*" style="padding-left:5px;padding-right:20px;" valign="top"><select style="font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="rate#IdeaCount#">
						<option value="0">Select</option>
						<option value="5">YES - It's a winner!</option>
						<option value="1">NO - Not so good</option>
						</select> <input type="text" style="width:250px;font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="comments#IdeaCount#" onfocus="javascript: if (document.frmSuggestionInputForm.comments#IdeaCount#.value == 'comments...'){document.frmSuggestionInputForm.comments#IdeaCount#.value='';}" value="comments..."></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
						</tr>
						<cfset Vote_2 = 1>
					
					
				
				<cfelseif Vote_3 EQ 0 AND Sug_TotalVotes.RecordCount EQ 2>
				
						<cfset IdeaCount = IdeaCount+1>
						
						<input type="hidden" name="sugID#IdeaCount#" value="#this_sugID#">
				
						<tr>
						<td width="20" valign="top" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong><a title="#Sug_TotalVotes.RecordCount# - ID:#this_sugID#">#IdeaCount#.</a></strong></td>
						<td width="*" style="padding-left:5px;padding-right:20px;color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>#suggestion#</strong><cfif TRIM(details) NEQ ''> &nbsp; <a title="#details#" style="font-size:10px;color:black;">[more info]</a></cfif></td>
						</tr>
						
						<tr>
						<td colspan="2" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
						</tr>
						
						<tr>
						<td width="20" valign="top"> </td>
						<td width="*" style="padding-left:5px;padding-right:20px;" valign="top"><select style="font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="rate#IdeaCount#">
						<option value="0">Select</option>
						<option value="5">YES - It's a winner!</option>
						<option value="1">NO - Not so good</option>
						</select> <input type="text" style="width:250px;font-size:10px;color:###TRIM(AllSettings.BoxColour)#;" name="comments#IdeaCount#" onfocus="javascript: if (document.frmSuggestionInputForm.comments#IdeaCount#.value == 'comments...'){document.frmSuggestionInputForm.comments#IdeaCount#.value='';}" value="comments..."></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
						</tr>
						
						<tr>
						<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
						</tr>
						<cfset Vote_3 = 1>
					
					
				
				</cfif>
				
			
				
			
	
			</cfif>
			
			<cfif (Vote_1 EQ 1) AND (Vote_2 EQ 1) AND (Vote_3 EQ 1)>
				<cfbreak>
			</cfif>
			</cfloop><tr>
		<td colspan="2" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr> 		
		<td> </td>
		<td valign="top"><input type="submit" value="Cast your votes!" class="whitefield"></td>
		</tr>
			
			</table>
		
			
		</td>
		</tr>
	
		<input type="hidden" name="unauthorised" value="yes">
		
	<cfelse>
		
		<cfset session.CriticalVotes = 1>
		
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#">
		
	</cfif>
	
	</table>


</td>
</tr>

</table>
<br><br><br>


</cfoutput>