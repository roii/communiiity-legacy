<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Suggestion.*, SugCategory.Name, SugCategory.SponsorID, Contacts.FirstName, Contacts.EmailAddress
FROM Suggestion, SugCategory, Contacts
WHERE Suggestion.SugID=#form.SugID#
AND Suggestion.CategoryID=SugCategory.CategoryID
AND Suggestion.ContactID=Contacts.ContactID
</cfquery>

<!--- GET FEEDBACK DETAILS --->
<cfquery name="FeedbackDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugVote.*, Contacts.ScreenName, Contacts.FirstName, Contacts.EmailAddress
FROM SugVote, Contacts
WHERE SugVote.SugID=#form.SugID#
AND SugVote.ContactID=Contacts.ContactID
AND Contacts.ContactID=#form.member#
</cfquery>

<!--- UPDATE THE IDEA --->
<cfquery name="UpdateIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE SugVote
SET Removed=1
WHERE SugID=#form.SugID#
AND contactID=#form.member#
</cfquery>

<cfif SiteMode NEQ 'dev'>

<!--- EMAIL IDEA OWNER --->
<cfmail server="#application.emailserver#" to="#TRIM(IdeaStuff.EmailAddress)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="Idea Feedback Removed">Hi #TRIM(IdeaStuff.FirstName)#

Inapproriate feedback has been removed from your idea by the moderator...

Idea:
"#TRIM(IdeaStuff.suggestion)#"

Feedback:
"#TRIM(FeedbackDetails.Comments)#"

Feedback Author:
"#TRIM(FeedbackDetails.ScreenName)#"

They Voted:
<cfif FeedbackDetails.Vote GT 3>"YES"<cfelse>"NO"</cfif>
(This vote will still count towards the total "yes" / "no" votes received)

The feedback author has been reminded that as a member of the my3P community they have a responsibility to help the other members by providing them with constructive feedback which helps them to develop their ideas. 

If they continue to post inappropriate feedback they may lose their voting rights.

TheModerators@my3P.com</cfmail>


<!--- EMAIL FEEDBACK AUTHOR --->
<cfmail server="#application.emailserver#" to="#TRIM(FeedbackDetails.EmailAddress)#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="Your IDEAfunL feedback was inappropriate">Hi #TRIM(FeedbackDetails.FirstName)#

The feedback you posted on the following idea was reported to the IDEAfunL moderator who thought it inapproriate and removed it...

Idea:
"#TRIM(IdeaStuff.suggestion)#"

Your Feedback:
"#TRIM(FeedbackDetails.Comments)#"

As a member of the my3P community you have a responsibility to help the other members by providing them with constructive feedback which helps them develop their ideas. 

If you continue to post inappropriate feedback you may lose your voting rights.

TheModerators@my3P.com</cfmail>


<cfelse>

	<!--- EMAIL IDEA OWNER --->
<cfmail server="#application.emailserver#" to="alan@my3p.com" cc="roy@my3p.com" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="Idea Feedback Removed">Hi #TRIM(IdeaStuff.FirstName)#

Inapproriate feedback has been removed from your idea by the IDEAfunL moderator...

Idea:
"#TRIM(IdeaStuff.suggestion)#"

Feedback:
"#TRIM(FeedbackDetails.Comments)#"

Feedback Author:
"#TRIM(FeedbackDetails.ScreenName)#"

They Voted:
<cfif FeedbackDetails.Vote GT 3>"YES"<cfelse>"NO"</cfif>
(This vote will still count towards the total "yes" / "no" votes received)

The feedback author has been reminded that as a member of the my3P community they have a responsibility to help the other members by providing them with constructive feedback which helps them to develop their ideas. 

If they continue to post inappropriate feedback they may lose their voting rights.

TheModerators@my3P.com</cfmail>


<!--- EMAIL FEEDBACK AUTHOR --->
<cfmail server="#application.emailserver#" to="alan@my3p.com" cc="roy@my3p.com" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="Your IDEAfunL feedback was inappropriate">Hi #TRIM(FeedbackDetails.FirstName)#

The feedback you posted on the following idea was reported to the IDEAfunL moderator who thought it inapproriate and removed it...

Idea:
"#TRIM(IdeaStuff.suggestion)#"

Your Feedback:
"#TRIM(FeedbackDetails.Comments)#"

As a member of the my3P community you have a responsibility to help the other members by providing them with constructive feedback which helps them develop their ideas. 

If you continue to post inappropriate feedback you may lose your voting rights.

TheModerators@my3P.com</cfmail>

</cfif>


<!--- ADD MODERATOR LOG --->
<cfquery name="AddModLog" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO ModeratorLog(ModDate, Moderator, type, RelatedID, RelatedID2)
VALUES(#createODBCDateTime(localdatetime)#, #session.UserID#, 'Idea Feedback Removed', #form.sugID#, #form.member#)
</cfquery>



<cfoutput>

<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location.reload(true);
    self.close();
}
// -->
</script>
	

<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&ideafunl_mode=voteresults&SingleIdea=#form.sugID#&currentcategory=#form.currentcategory#')">
</body>

</cfoutput>