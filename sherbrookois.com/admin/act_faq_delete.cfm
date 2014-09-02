<cfoutput>


<!--- GET TITLE INFO FOR LOG --->
	
	<cfquery name="TitleStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FaqTitle
	FROM FAQs
	WHERE FAQID=#FaqID#
	</cfquery>
	
	
<!--- DELETE THE FAQ --->

	<cfquery name="DeleteFile" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM FAQs
	WHERE FaqID=#FaqID#
	</cfquery>

	
	<cfset logdetails = 'Delete FAQ - (FAQ: #TitleStuff.FAQTitle#)'>
	<cfinclude template="act_adminlog.cfm">



	<cfif IsDefined("SubArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#&subArticleID=#subarticleID#">

	<cfelseif IsDefined("ArticleID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#">


	<cfelseif IsDefined("DocumentID")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#">

	<cfelseif IsDefined("fusesubaction")>	
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#">
	
	<cfelse>
	
		<cflocation url="#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#">
	
	</cfif>
	
	
	</cfoutput>