<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Suggestion.*, SugCategory.Name, Contacts.FirstName, Contacts.EmailAddress
FROM Suggestion, SugCategory, Contacts
WHERE Suggestion.SugID=#SugID#
AND Suggestion.CategoryID=SugCategory.CategoryID
AND Suggestion.ContactID=Contacts.ContactID
</cfquery>

<!--- GET FEEDBACK DETAILS --->
<cfquery name="FeedbackDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugVote.*, Contacts.ScreenName, Contacts.FirstName, Contacts.EmailAddress
FROM SugVote, Contacts
WHERE SugVote.SugID=#SugID#
AND SugVote.ContactID=Contacts.ContactID
AND Contacts.ContactID=#member#
</cfquery>

<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(session.AllSettings_SiteName)# - Remove Idea Feedback</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Remove Idea Feedback</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top" style="padding-right:20px;">
<br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form method="post" action="#request.webroot#/ideas/act_remove_feedback.cfm">
	
	<input type="hidden" name="SugID" value="#SugID#">
	<input type="hidden" name="Member" value="#Member#">
	<input type="hidden" name="currentcategory" value="#currentcategory#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2" style="color:##444444;"><ul>	
	<li>Removing feedback will replace the "comments" with a message that it was deeming inappropriate feedback.</li>
	<li>The vote will remain and still count towards the total Yes/No votes received.</li>
	<li>The idea owner and the feedback author will both be notified of the removal via email.</li>
	<li>The moderator (you) will not be identified to anyone other than the my3p management and administration teams.</li>
	</ul>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Topic:</td>
	<td>#TRIM(IdeaStuff.Name)#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Idea:</td>
	<td valign="top"><strong>#TRIM(IdeaStuff.suggestion)#</strong>
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"><br><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Feedback:</td>
	<td>#TRIM(FeedbackDetails.Comments)#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Voted:</td>
	<td><cfif FeedbackDetails.Vote GT 3>YES<cfelse>NO</cfif></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Feedback By:</td>
	<td>#TRIM(FeedbackDetails.ScreenName)#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Submitted:</td>
	<td>#DateFormat(FeedbackDetails.whenVoteMade, "d mmm yy")# &nbsp;-&nbsp; #TimeFormat(FeedbackDetails.whenVoteMade, "h:mm TT")#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="10" height="5" border="0"><br><input type="submit" value="Remove Feedback &raquo;" class="whitefield"></td>
	</tr>	
		
	</form>
	
	</table><br><br>
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>