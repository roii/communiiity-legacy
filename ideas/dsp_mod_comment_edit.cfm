<cfquery name="CommentDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugComments
WHERE SugCommentID=#SugCommentID#
</cfquery>

<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Suggestion.*, SugCategory.Name, Contacts.FirstName, Contacts.EmailAddress
FROM Suggestion, SugCategory, Contacts
WHERE Suggestion.SugID=#CommentDetails.SugID#
AND Suggestion.CategoryID=SugCategory.CategoryID
AND Suggestion.ContactID=Contacts.ContactID
</cfquery>

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(session.AllSettings_SiteName)# - Edit Moderator Comment</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Moderator Comment</strong></span></td>
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
	
	
	<form method="post" action="#request.webroot#/ideas/act_mod_comment_edit.cfm">
	
	<input type="hidden" name="SugID" value="#CommentDetails.SugID#">
	<input type="hidden" name="currentcategory" value="#currentcategory#">
	<input type="hidden" name="SugCommentID" value="#SugCommentID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2" style="color:###TRIM(session.allSettings_DkTextColor)#;"><strong>Edit Comment</strong>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Display To:</td>
	<td><input type="radio" name="PublicView" value="1"<cfif CommentDetails.PublicView EQ 1> checked</cfif>> Everyone &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="PublicView" value="0"<cfif CommentDetails.PublicView EQ 0> checked</cfif>> Idea Author Only</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Details:</td>
	<td><textarea class="whitefield" name="Comment" style="width:300px;" rows="8">#TRIM(CommentDetails.Comment)#</textarea><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br><input type="submit" class="whitefield" value="Update Comment &raquo;"></td>
	</tr>			
	</form>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</table><br>
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>