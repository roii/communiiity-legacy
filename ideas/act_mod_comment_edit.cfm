<cfquery name="edit_comment" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE SugComments
SET comment='#Replace(form.Comment, "'", "'", "ALL")#',
PublicView=#form.PublicView#
WHERE SugCommentID=#form.SugCommentID#
</cfquery>

<!--- ADD MODERATOR LOG --->
<cfquery name="AddModLog" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO ModeratorLog(ModDate, Moderator, type, RelatedID)
VALUES(#createODBCDateTime(localdatetime)#, #session.UserID#, 'IdeaCommentEdit', #form.sugID#)
</cfquery>

<cflocation url="#request.webroot#/ideas/dsp_moderator_comments.cfm?SugID=#TRIM(form.SugID)#&currentcategory=#form.currentcategory#">
