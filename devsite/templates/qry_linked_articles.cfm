<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To query for all articles linked to the calling document</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<number name="DocumentID" format="CFML" Scope="attributes" precision="Integer"/>
	</in>
	
	<out>
	<recordset name="AllArticles" format="CFML" Scope="variables" primarykeys="ArticleID" onCondition="AllArticles.recordcount GT 0">
	</out>

</IO>

</fusedoc>

 --->
<cfquery name="AllArticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Articles.*, DocumentArticles_Link.displayorder
FROM Articles, DocumentArticles_Link
WHERE DocumentArticles_Link.DocumentID=#attributes.documentID#
AND DocumentArticles_Link.ArticleID=Articles.ArticleID

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		AND (Articles.ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR Articles.ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR Articles.ContactTypeView LIKE '%,#session.User_ContactTypeID#')
		AND (Articles.ExpireDate > #localDateTime# 
		OR Articles.ExpireDate IS NULL)
		AND Articles.Released=1
		AND Articles.AdminView = 1
	</cfif>

<cfelse>
	AND Articles.PublicView = 1
	AND (Articles.ExpireDate > #localDateTime# 
	OR Articles.ExpireDate IS NULL)
	AND Articles.Released=1
</cfif>

ORDER BY DocumentArticles_Link.DisplayOrder	
</cfquery>
