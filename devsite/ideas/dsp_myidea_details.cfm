<cfoutput>


<cfquery name="IdeaDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.WhenSugMade, suggestion.suggestion, suggestion.details, suggestion.totalVote, suggestion.voteNumReceived, suggestion.WhenSugEnded, suggestion.WhenVotingClose, suggestion.madeBy, suggestion.contactID, suggestion.comments, SugCategory.Name, Contacts.FirstName, Contacts.LastName
FROM suggestion, SugCategory, Contacts
WHERE suggestion.SugID=#SugID#
AND suggestion.CategoryID=SugCategory.CategoryID
AND suggestion.ContactID=Contacts.ContactID
</cfquery>

<cfquery datasource="#dsn#"  name="AllVotes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID = #sugID#
ORDER BY whenVoteMade DESC
</cfquery>

<cfquery datasource="#dsn#"  name="YesVotes" username="#request.username#" password="#request.password#">
SELECT *
FROM SugVote
WHERE sugID = #sugID#
AND vote > 3
</cfquery>

<cfif AllVotes.RecordCount>
	<cfset PercentYes = (YesVotes.RecordCount / AllVotes.RecordCount * 100)>
<cfelse>	
	<cfset PercentYes = 0>	
</cfif>



<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td valign="top"><span style="font-size:14px;color:###TRIM(AllSettings.DkTextColor)#"><b>&ldquo;#TRIM(IdeaDetails.suggestion)#&rdquo;</b></span><br><br></td>
</tr>

<cfif TRIM(IdeaDetails.Details) NEQ ''>

<tr>
<td valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#"><b>&ldquo;#TRIM(IdeaDetails.Details)#&rdquo;</b></span><br><br></td>
</tr>

</cfif>

<tr>
<td>
	
	
	<table cellpadding="0" cellspacing="0" border="0" width="90%">
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Category:</strong></td>
	<td>#TRIM(IdeaDetails.Name)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Date Suggested:</strong></td>
	<td><cfif IsDate("#TRIM(IdeaDetails.WhenSugMade)#")>#DateFormat(IdeaDetails.WhenSugMade, "d-mmm-yyyy")#<cfelse>&ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Votes:</strong></td>
	<td>#AllVotes.RecordCount#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>% Yes:</strong></td>
	<td>#INT(PercentYes)#%</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##e2e2e2"></td>
	</tr>
	
	
	</table><br>


	<table width="90%" cellpadding="0" cellspacing="0" border="0">
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height="25">
	<td style="color:###TRIM(AllSettings.BoxTextColour)#;padding-left:10px;" colspan="4"><strong>Comments &amp; Votes...</strong></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;" width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="5" border="0"></td>
	<td width="100" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="5" border="0"></td>
	<td width="100" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="5" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="5" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;"><strong>When</strong></td>
	<td><strong>Who</strong></td>
	<td align="center"><strong>Vote</strong></td>
	<td><strong>Comments</strong></td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfset max_date = localdatetime>
	
	<cfloop query="AllVotes">
			
	<cfquery name="VoteBy" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, ScreenName
	FROM Contacts
	WHERE ContactID=#AllVotes.ContactID#
	</cfquery>
	
	<!--- CHECK FOR REVISIONS --->
	<cfquery name="qry_revision_history" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT RevisionDate
	FROM Sug_Revision
	WHERE SugID=#SugID# 
	AND RevisionDate < #CreateODBCDateTime(max_date)#
	AND RevisionDate > #CreateODBCDateTime(AllVotes.whenVoteMade)#
	ORDER BY RevisionDate DESC
	</cfquery>
	
	<cfif qry_revision_history.RecordCount>
		
		<tr>
		<td valign="top" style="font-size:11px;padding-left:10px;color:###TRIM(AllSettings.BoxColour)#;">#DateFormat(qry_revision_history.RevisionDate, "d-mmm-yyyy")#</td>
		<td valign="top" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">IDEA UPDATED</td>
		<td valign="top" style="font-size:11px;" align="center"></td>
		<td valign="top" style="font-size:11px;"></td>
		</tr>
	
		<tr>
		<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="4" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
	
	</cfif>
	
	<tr>
	<td valign="top" style="font-size:11px;padding-left:10px;">#DateFormat(AllVotes.whenVoteMade, "d-mmm-yyyy")#</td>
	<td valign="top" style="font-size:11px;"><cfif TRIM(VoteBy.ScreenName) NEQ ''>#TRIM(VoteBy.ScreenName)#<cfelse>#TRIM(VoteBy.FirstName)#</cfif></td>
	<td valign="top" style="font-size:11px;" align="center"><cfif AllVotes.Vote GTE 3>YES<cfelse>NO</cfif></td>
	<td valign="top" style="font-size:11px;">#TRIM(AllVotes.comments)#</td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfset max_date = AllVotes.whenVoteMade>
	
	</cfloop>

	
	</table><br>

	

	<br>
	
	<a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas" style="text-decoration:none;">&laquo;</a> <a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=77&ideafunl_mode=MyIdeas">Back to MyIdeas</a>
</td>
</tr>

</table>


</cfoutput>
		