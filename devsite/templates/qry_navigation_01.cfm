<cfprocessingdirective suppresswhitespace="Yes"><cfoutput><!--- <cfquery name="ArticleStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Articles.*, DocumentArticles_Link.displayorder
FROM Articles, DocumentArticles_Link
WHERE DocumentArticles_Link.DocumentID=#ThisDoc#
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

</cfquery><cfif ArticleStuff.RecordCount><cfset HasChild = 1><cfelse> ---><cfset HasChild = 0><!--- </cfif> ---><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(TRIM(DocumentStuff.ContactTypeView), session.User_ContactTypeID, ",")) OR (DocumentStuff.PublicView EQ 1) OR (session.UserType EQ 'Administrator')><cfset MenuItemString = '#TRIM(MenuItemString)#' & '#TRIM(Replace(DocumentStuff.Title, ',', '&##44', "ALL"))#' & ',' & 'index.cfm?fuseaction=#TRIM(thisfuseaction)#&fusesubaction=docs&documentID=#ThisDoc#' & ',' & '1' & ',' & '0' & ',' & '#HasChild#' & ';'><cfelse><cfset MenuItemString = "#TRIM(MenuItemString)#" & "<span title='Members only area'>#TRIM(Replace(DocumentStuff.Title, ',', '&##44', "ALL"))#</span>" & "," & "javascript:alert('Members only area. Please register or login to view this page.')" & "," & "1" & "," & "0" & "," & "#HasChild#" & ";"></cfif><cfset SubMenuItemString = '#TRIM(SubMenuItemString)#' & '_' & '#documentStuff.currentrow#' & ';'><!--- <cfloop query="ArticleStuff"><cfset ThisArt = ArticleStuff.ArticleID><cfif ArticleStuff.currentrow NEQ ArticleStuff.recordcount><cfset SubHasChild = 0><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(TRIM(ArticleStuff.ContactTypeView), session.User_ContactTypeID, ",")) OR (ArticleStuff.PublicView EQ 1) OR (session.UserType EQ 'Administrator')><cfset SubMenuItemString = '#TRIM(SubMenuItemString)#' & '#TRIM(Replace(ArticleStuff.ArticleTitle, ',', '&##44', "ALL"))#' & ',' & 'index.cfm?fuseaction=#thisfuseaction#&fusesubaction=article&documentID=#ThisDoc#&articleID=#ThisArt#' & ',' & '1' & ';'><cfelse><cfset SubMenuItemString = "#TRIM(SubMenuItemString)#" & "<span title='Members only area'>#TRIM(Replace(ArticleStuff.ArticleTitle, ',', '&##44', "ALL"))#</span>" & "," & "javascript:alert('Members only area. Please register or login to view this page.')" & "," & "1" & ";"></cfif><cfelse><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(TRIM(ArticleStuff.ContactTypeView), session.User_ContactTypeID, ",")) OR (ArticleStuff.PublicView EQ 1) OR (session.UserType EQ 'Administrator')><cfset SubMenuItemString = '#TRIM(SubMenuItemString)#' & '#Replace(ArticleStuff.ArticleTitle, ',', '&##44', "ALL")#' & ',' & 'index.cfm?fuseaction=#TRIM(thisfuseaction)#&fusesubaction=article&documentID=#ThisDoc#&articleID=#ThisArt#' & ',' & '1' & ';'><cfelse><cfset SubMenuItemString = "#TRIM(SubMenuItemString)#" & "<span title='Members only area'>#Replace(ArticleStuff.ArticleTitle, ',', '&##44', "ALL")#</span>" & "," & "javascript:alert('Members only area. Please register or login to view this page.')" & "," & "1" & ";"></cfif></cfif></cfloop> ---></cfoutput></cfprocessingdirective>