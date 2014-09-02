<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Suggestion.*, SugCategory.Name, Contacts.FirstName, Contacts.EmailAddress
FROM Suggestion, SugCategory, Contacts
WHERE Suggestion.SugID=#SugID#
AND Suggestion.CategoryID=SugCategory.CategoryID
AND Suggestion.ContactID=Contacts.ContactID
</cfquery>


<cfquery name="CurrentComments" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugComments.SugCommentID, SugComments.Comment, SugComments.CommentDate, SugComments.PublicView, Contacts.ScreenName
FROM SugComments, Contacts
WHERE SugComments.SugID=#SugID#
AND SugComments.ModeratorID=Contacts.ContactID
ORDER BY SugComments.CommentDate DESC
</cfquery>

<cfoutput>

<script language="JavaScript">
<!--
function confirmCommentDelete(aURL) {
    if(confirm('Are you sure you want to delete this comment?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(session.AllSettings_SiteName)# - Moderator Comments</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Moderator Comments</strong></span></td>
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
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
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
	<td valign="top"><strong>#TRIM(IdeaStuff.suggestion)#</strong><br>
	#TRIM(IdeaStuff.details)#
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"><br><br></td>
	</tr>
	
	
	<form method="post" action="#request.webroot#/ideas/act_mod_comment_add.cfm">
	
	<input type="hidden" name="SugID" value="#SugID#">
	<input type="hidden" name="currentcategory" value="#currentcategory#">
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2" style="color:###TRIM(session.allSettings_DkTextColor)#;"><strong>Add New Comment</strong>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Display To:</td>
	<td><input type="radio" name="PublicView" value="1" checked> Everyone &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="PublicView" value="0"> Idea Author Only</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Details:</td>
	<td><textarea class="whitefield" name="Comment" style="width:300px;" rows="8"></textarea><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br><input type="submit" class="whitefield" value="Add Comment &raquo;"></td>
	</tr>			
	</form>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</table><br>
		
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="10" border="0"></td>
	<td width="90"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="10" border="0"></td>
	<td width="90"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="10" border="0"></td>
	<td width="90"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="10" border="0"></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="10" border="0"></td>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="10" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5" style="color:###TRIM(session.allSettings_DkTextColor)#;"><strong>Current Comments</strong></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5" height="1" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td valign="top" style="font-size:11px;"><strong>Date</strong></td>
	<td valign="top" style="font-size:11px;"><strong>Moderator</strong></td>
	<td valign="top" style="font-size:11px;"><strong>Display To</strong></td>
	<td valign="top" style="font-size:11px;"><strong>Comment</strong></td>
	<td valign="top" style="font-size:11px;"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5" height="1" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="CurrentComments">
	
	<tr>
	<td></td>
	<td valign="top" style="font-size:11px;">#DateFormat(CurrentComments.CommentDate)#<br>#TimeFormat(CurrentComments.CommentDate, "h:mm tt")#</td>
	<td valign="top" style="font-size:11px;">#TRIM(CurrentComments.ScreenName)#</td>
	<td valign="top" style="font-size:11px;"><cfif CurrentComments.PublicView EQ 1>Everyone<cfelse>Idea Author</cfif></td>
	<td valign="top" style="font-size:11px;">#TRIM(CurrentComments.comment)#</td>
	<td valign="top" style="font-size:11px;"><a href="#request.webroot#/ideas/dsp_mod_comment_edit.cfm?SugCommentID=#CurrentComments.SugCommentID#&currentcategory=#currentcategory#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Comment" border="0"></a>&nbsp;<a href="javascript:confirmCommentDelete('#request.webroot#/ideas/act_delete_comments.cfm?SugCommentID=#CurrentComments.SugCommentID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Comment" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5" height="1" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table><br><br>
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>