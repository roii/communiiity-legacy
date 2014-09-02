<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To query for all Sub-articles linked to the calling article</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<IO>
	
	<in>
	<number name="ArticleID" format="CFML" Scope="attributes" precision="Integer"/>
	</in>
	
	<out>
	<recordset name="AllSubArticles" format="CFML" Scope="variables" primarykeys="SubArticleID" onCondition="AllSubArticles.recordcount GT 0">
	</out>

</IO>

</fusedoc>

 --->
 
<cfquery name="AllSubArticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SubArticles.*, ArticleSubArticle_Link.displayorder
FROM SubArticles, ArticleSubArticle_Link
WHERE ArticleSubArticle_Link.ArticleID=#attributes.ArticleID#
AND ArticleSubArticle_Link.SubArticleID=SubArticles.SubArticleID

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>
AND SubArticles.SubReleased=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
		AND SubArticles.UserType='all'
	<cfelse>
		AND (SubArticles.UserType LIKE '%#session.UserType#%' OR SubArticles.UserType='all')
	</cfif>

AND (SubArticles.SubExpireDate > #localDateTime# 
OR SubArticles.SubExpireDate IS NULL)
</cfif>


ORDER BY ArticleSubArticle_Link.DisplayOrder
</cfquery>