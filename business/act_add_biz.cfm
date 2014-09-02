<cfif IsDefined("form.bizIdeaID") AND form.bizIdeaID NEQ 0>

	<cfquery name="IdeaStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT biz_idea, biz_summary
	FROM bizidea
	WHERE bizideaID=#form.bizideaID#
	</cfquery>
	
	<cfset idea_title = IdeaStuff.biz_idea>
	<cfset idea_details = IdeaStuff.biz_summary>

<cfelse>

	<cfset idea_title = form.bizName>
	<cfset idea_details = form.bizdescription>

</cfif>


<cfset bywhen = CREATEODBCDATE(form.dateCreated)>
<cfset bywhen = DateFormat(#bywhen#,"mm/dd/yyyy")>


<!--- INSERT BUSINESS --->

<cfquery name="AddBiz" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
INSERT INTO Business(
bizdescription,
bizName,
bizideaID,
bizStatus
)

VALUES(
'#idea_details#', 
'#idea_title#',
#form.bizideaID#,
'Active'
)
</cfquery>


<cfquery name="LastID" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
SELECT bizID
FROM business
ORDER BY bizID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = lastID.bizID>
<cfelse>
	<cfset newid = 1>
</cfif>

<cfquery name="Addlink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
INSERT INTO bizkidsLink(
bizID,
KidsID,
datecreated
)		
VALUES(
#newid#, 
#session.UserID#,
'#bywhen#'
)
</cfquery>

<!--- PROCESS REWARDS REWARDS --->
<cfset ExtraDescription = "<BR>Business: #TRIM(idea_title)#">

<!--- PROCESS REWARDS --->
<cfset this_activity = 8>
<cfset this_contactID = session.UserID>
<cfset this_relatedDescription = "Business">
<cfset this_relatedID = "#newID#">
						
<cfinclude template="../templates/act_activity_reward_payment.cfm">



<cflocation url="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47">