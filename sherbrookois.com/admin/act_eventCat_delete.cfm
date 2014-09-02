
<!--- GET CATEGORY NAME FOR ADMIN LOG --->
<cfquery name="GetCatname" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT EventCatName
FROM EventCats
WHERE EventCatID = #EventCatID#
</cfquery>


<!--- GET RELATED EVENTS --->
<cfquery name="events" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT EventID, EventTitle
FROM Events
WHERE EventCatID=#EventCatID#
</cfquery>


<!--- DELETE RELATED ARTICLES, LINKS, AND WHAT NEW LISTINGS --->
<cfloop query="events">

	<cfquery name="DeleteEvent" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Events
	WHERE EventID=#events.EventID#
	</cfquery>
	
	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE EventID=#events.EventID#
	</cfquery>
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Type='event'
	AND RelatedID=#events.EventID#
	</cfquery>
	
	
	<!--- LOG THE ARTICLE DELETE --->
	
	<cfset logdetails = 'Delete Event Category -  Event - (#events.EventTitle#)'>
	<cfinclude template="act_adminlog.cfm">
	
</cfloop>



<!--- DELETE CATEGORY --->
<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE 
FROM EventCats
WHERE EventCatID = #EventCatID#
</cfquery>
	
	

<!--- LOG CATEGORY DELETE --->
	
	<cfset logdetails = 'Delete Event Category - (Category: #GetCatname.EventCatName#)'>	
	<cfinclude template="act_adminlog.cfm">



<!--- RELOCATE BACK TO NEWS PAGE --->
	
<cfif IsDefined("ArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#">			

<cfelseif IsDefined("DocumentID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#">
			
<cfelse>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#">
	
</cfif>