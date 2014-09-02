
<!--- GET CATEGORY NAME FOR ADMIN LOG --->
<cfquery name="GetCatname" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Title
FROM LinkCats
WHERE LinkCatID = #LinkCatID#
</cfquery>


<!--- GET RELATED LINKS --->
<cfquery name="AllLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT LinkID, Title
FROM Links
WHERE LinkCatID=#LinkCatID#
</cfquery>


<!--- DELETE RELATED ARTICLES, LINKS, AND WHAT NEW LISTINGS --->
<cfloop query="AllLinks">

	<cfquery name="DeleteLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Links
	WHERE LinkID=#AllLinks.LinkID#
	</cfquery>
	
	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE WebLinkID=#AllLinks.LinkID#
	</cfquery>
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Type='link'
	AND RelatedID=#AllLinks.LinkID#
	</cfquery>
	
	
	<!--- LOG THE ARTICLE DELETE --->
	
	<cfset logdetails = 'Delete Link - (#AllLinks.Title#)'>
	<cfinclude template="act_adminlog.cfm">
	
</cfloop>



<!--- DELETE CATEGORY --->
<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE 
FROM LinkCats
WHERE LinkCatID = #LinkCatID#
</cfquery>
	
	

<!--- LOG CATEGORY DELETE --->
	
	<cfset logdetails = 'Delete Link Category - (Category: #GetCatname.Title#)'>	
	<cfinclude template="act_adminlog.cfm">



<!--- RELOCATE BACK TO NEWS PAGE --->
<cfif IsDefined("ArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#">			

<cfelseif IsDefined("DocumentID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#">
			
<cfelse>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#">
	
</cfif>
	
	
	
	