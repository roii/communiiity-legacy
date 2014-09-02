<!--- GET TITLE INFO FOR LOG --->
	
	<cfquery name="TitleStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title
	FROM Links
	WHERE LinkID=#LinkID#
	</cfquery>
	
	
<!--- DELETE EVENT --->

	<cfquery name="DeleteLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM Links
	WHERE LinkID=#LinkID#
	</cfquery>
	
	
<!--- DELETE ANY LINKS --->

	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE WebLinkID=#LinkID#
	</cfquery>
	
	
	
<!--- DELETE WHATS NEW --->
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Type='link'
	AND LinkID=#LinkID#
	</cfquery>
	
	
	<cfset logdetails = 'Delete Link - (#TitleStuff.Title#)'>
	<cfinclude template="act_adminlog.cfm">


<cfif IsDefined("ArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#">			

<cfelseif IsDefined("DocumentID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#">


<cfelseif IsDefined("CheckLinks")>	

		
		<cflocation url="#request.webroot#/administration/act_links_check.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#">
			
<cfelse>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#">
	
</cfif>