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
 
<cfquery name="AllLevel4Articles" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Level4Articles.*, SubArticleLevel4Link.displayorder
FROM Level4Articles, SubArticleLevel4Link
WHERE SubArticleLevel4Link.SubArticleID=#attributes.SubArticleID#
AND SubArticleLevel4Link.Level4ArticleID=Level4Articles.Level4ArticleID

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

<cfelse>
AND Level4Articles.Level4Released=1

	<cfif #session.userIsAuthenticated# EQ 'no'>
		AND Level4Articles.UserType='all'
	<cfelse>
		AND (Level4Articles.UserType LIKE '%#session.UserType#%' OR Level4Articles.UserType='all')
	</cfif>

AND (Level4Articles.Level4ExpireDate > #localDateTime# 
OR Level4Articles.Level4ExpireDate IS NULL)
</cfif>


ORDER BY SubArticleLevel4Link.displayorder
</cfquery>