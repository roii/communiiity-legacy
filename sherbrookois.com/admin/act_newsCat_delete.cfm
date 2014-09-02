
<!--- GET CATEGORY NAME FOR ADMIN LOG --->
<cfquery name="GetCatname" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT NewsCatName
FROM NewsCats
WHERE NewsCatID = #NewsCatID#
</cfquery>


<!--- GET RELATED ARTICLES --->
<cfquery name="headlines" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT RecordID, Title
FROM News
WHERE NewsCatID=#NewsCatID#
</cfquery>


<!--- DELETE RELATED ARTICLES, LINKS, AND WHAT NEW LISTINGS --->
<cfloop query="headlines">

	<cfquery name="DeleteArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM News
	WHERE RecordID=#headlines.recordID#
	</cfquery>
	
	<cfquery name="DeleteLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM LibraryLinks
	WHERE NewsID=#headlines.recordID#
	</cfquery>
	
	<cfquery name="Deletewhatnew" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM WhatsNew
	WHERE Type='news'
	AND RelatedID=#headlines.recordID#
	</cfquery>
	
	
	<!--- LOG THE ARTICLE DELETE --->
	
	<cfset logdetails = 'Delete News Category -  Related Article - (#Headlines.title#)'>
	<cfinclude template="act_adminlog.cfm">
	
</cfloop>



<!--- DELETE CATEGORY --->
<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE 
FROM NewsCats
WHERE NewsCatID = #NewsCatID#
</cfquery>
	
	

<!--- LOG CATEGORY DELETE --->
	
	<cfset logdetails = 'Delete News Category - (Category: #GetCatname.NewsCatName#)'>	
	<cfinclude template="act_adminlog.cfm">



<!--- RELOCATE BACK TO NEWS PAGE --->
<cfif IsDefined("ArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#">			

<cfelseif IsDefined("DocumentID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#">
			
<cfelse>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#">
	
</cfif>