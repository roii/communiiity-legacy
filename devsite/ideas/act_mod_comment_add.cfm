<cfquery name="add_comment" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO SugComments(sugID, ModeratorID, CommentDate, comment, PublicView)
VALUES(#form.SugID#, #Session.UserID#, #CreateODBCDateTime(localdatetime)#, '#Replace(form.Comment, "'", "'", "ALL")#', #form.PublicView#)	
</cfquery>

<!--- ADD MODERATOR LOG --->
<cfquery name="AddModLog" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO ModeratorLog(ModDate, Moderator, type, RelatedID)
VALUES(#createODBCDateTime(localdatetime)#, #session.UserID#, 'IdeaComment', #form.sugID#)
</cfquery>

<cflocation url="#request.webroot#/ideas/dsp_moderator_comments.cfm?SugID=#TRIM(form.SugID)#&currentcategory=#form.currentcategory#">
