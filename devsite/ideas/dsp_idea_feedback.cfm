<cfoutput>

<br>
<table cellpadding="0" cellspacing="0" border="0">

<tr>
<td><img src="#request.imageroot#/ideaFunL/feedback_lrg.gif" width="29" height="26" border="0"></td>
<td style="font-size:12px;color:Blue;"><strong>Members Feedback</strong></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</table>

<table width="100%" cellpadding="4" cellspacing="0" style="border:dashed 1px ##b4b4b4;">

<tr>
<td colspan="3">	
				

	<cfset max_date = localdatetime>					
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="padding-left:10px;" width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="5" border="0"></td>
	<td width="130" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="5" border="0"></td>
	<td width="60" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="5" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="5" border="0"></td>
	<td width="15" align="right"><img src="#request.imageroot#/transparent_spc.gif" width="15" height="5" border="0"></td>
	</tr>
	
	<tr>
	<td style="padding-left:10px;font-size:11px;color:##444444;"><strong>When</strong></td>
	<td style="font-size:11px;color:##444444;"><strong>Who</strong></td>
	<td style="font-size:11px;color:##444444;" align="center"><strong>Vote</strong></td>
	<td style="font-size:11px;color:##444444;"><strong>Comments</strong></td>
	<td style="font-size:11px;color:##444444;"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_idea_votes">
	
	<cfset this_voteby = qry_idea_votes.ContactID>
	
	<cfquery name="qry_vote_by" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, ScreenName
	FROM Contacts
	WHERE ContactID=#this_voteby#
	</cfquery>

	<!--- CHECK FOR REVISIONS --->
	<cfquery name="qry_revision_history" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT RevisionDate
	FROM Sug_Revision
	WHERE SugID=#SugID# 
	AND RevisionDate < #CreateODBCDateTime(max_date)#
	AND RevisionDate > #CreateODBCDateTime(qry_idea_votes.whenVoteMade)#
	ORDER BY RevisionDate DESC
	</cfquery>
	
	<cfif qry_revision_history.RecordCount>
		
		<tr>
		<td style="font-size:11px;padding-left:10px;color:###TRIM(AllSettings.BoxColour)#;" valign="top" title="#TimeFormat(qry_revision_history.RevisionDate, 'HH:MM TT')#">#DateFormat(qry_revision_history.RevisionDate, "d-mmm-yyyy")#</td>
		<td style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;" valign="top">IDEA UPDATED</td>
		<td style="font-size:11px;"></td>
		<td style="font-size:11px;"></td>
		<td style="font-size:11px;"></td>
		</tr>
	
		<tr>
		<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
	
	</cfif>
	
						
	<tr>
	<td style="font-size:11px;padding-left:10px;" valign="top" title="#TimeFormat(qry_idea_votes.whenVoteMade, 'HH:MM TT')#">#DateFormat(qry_idea_votes.whenVoteMade, "d-mmm-yyyy")#</td>
	<td style="font-size:11px;" valign="top"><cfif qry_vote_by.recordcount><cfif TRIM(qry_vote_by.ScreenName) NEQ ''><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(qry_vote_by.ScreenName)#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(qry_vote_by.ScreenName)#" style="color:###TRIM(Allsettings.BoxColour)#;" title="View Profile"><strong>#TRIM(qry_vote_by.ScreenName)#</strong><cfelse><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(this_voteby)#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(this_voteby)#" style="color:###TRIM(Allsettings.BoxColour)#;" title="View Profile"><strong>#TRIM(qry_vote_by.FirstName)#</strong></cfif></a><cfelse>User profile removed</cfif></td>
	<td style="font-size:11px;" valign="top" align="center"><cfif qry_idea_votes.Vote GTE 3>YES<cfelse>NO</cfif></td>
	<td style="font-size:11px;padding-right:10px;" valign="top"><cfif qry_idea_votes.Removed EQ 1><span style="color:###TRIM(AllSettings.BoxColour)#;">Inappropriate feedback removed by moderator</span><cfelse>#TRIM(qry_idea_votes.comments)#</cfif></td>
	<td style="font-size:11px;" valign="top"><cfif session.UserIsAuthenticated EQ 'Yes' AND session.Permission3_View EQ 1 AND session.UserID NEQ this_ContactID AND ListFind(qry_current_topic.Moderators, session.UserID, ",") AND qry_idea_votes.Removed NEQ 1><a href="##" onclick="window.open('#request.webroot#/ideas/dsp_remove_feedback.cfm?sugID=#this_sugID#&currentcategory=#currentcategory#&member=#this_voteby#','removefeedback','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10');" style="cursor:hand;"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Remove Feedback" border="0"></a></cfif></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>

	<cfset max_date = qry_idea_votes.whenVoteMade>					
	
	</cfloop>				
	
	</table>

</td>
</tr>

</table><br></cfoutput>