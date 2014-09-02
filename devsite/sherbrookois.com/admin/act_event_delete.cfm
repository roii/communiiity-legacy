<!--- GET TITLE INFO FOR LOG --->
	
	<cfquery name="TitleStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventTitle
	FROM Events
	WHERE EventID=#EventID#
	</cfquery>
	
	
<!--- DELETE EVENT --->

	<cfquery name="DeleteEvent" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM Events
	WHERE EventID=#EventID#
	</cfquery>
	
	
<!--- DELETE ANY LINKS --->

	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE EventID=#EventID#
	</cfquery>
	
	
	
<!--- DELETE WHATS NEW --->
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Type='event'
	AND EventID=#EventID#
	</cfquery>
	
	
	<cfset logdetails = 'Delete Event - (Event: #TitleStuff.EventTitle#)'>
	<cfinclude template="act_adminlog.cfm">


<cfif IsDefined("ArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#">			

<cfelseif IsDefined("DocumentID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#">
			
<cfelse>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#">
	
</cfif>
	
	