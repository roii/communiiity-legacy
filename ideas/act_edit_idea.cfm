<cfquery name="EditIdea" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Suggestion
SET categoryID=#form.selCategory#,
details='#form.txtareaDetails#'
WHERE SugID=#form.SugID#
</cfquery>



<!--- UPDATE REVISION HISTORY --->
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT RevisionID
FROM Sug_Revision
ORDER BY RevisionID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.RevisionID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
	

<!--- INSERT ORGANISATION INFO --->	
<cfquery name="AddRevision" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Sug_Revision(
RevisionID,
SugID,
RevisionDate,
OldTopic,
OldDetails)
VALUES(
#newid#,
#form.SugID#,
#CreateODBCDateTime(localdatetime)#,
'#form.Current_categoryID#',
'#form.Current_Details#'
)
</cfquery>

<cfoutput>

<script>
alert('Your idea has been updated!');
self.location="#request.webroot#/index.cfm?fuseaction=ideas&ideafunl_mode=MyIdeas&fusesubaction=docs&documentID=77";
</script>

</cfoutput>
