<!--- GET THE TITLE FOR THE LOG --->
	
	<cfquery name="GetTitle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Title
	FROM News
	WHERE RecordID = #newsID#
	</cfquery>

	

<!--- DELETE THE ARTICLE --->

	<cfquery name="DeleteArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM News
	WHERE RecordID = #newsID#
	</cfquery>
	
	
	
<!--- DELETE ANY LINKS --->

	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE NewsID=#newsID#
	</cfquery>
	
	
	
<!--- DELETE WHATS NEW --->
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Type='news'
	AND NewsID=#newsID#
	</cfquery>

	
	
	<cfset logdetails = 'Delete News - (Article: #GetTitle.title#)'>
		<cfinclude template="act_adminlog.cfm">

<cfif IsDefined("ArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#">			

<cfelseif IsDefined("DocumentID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#">
			
<cfelse>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#">
	
</cfif>