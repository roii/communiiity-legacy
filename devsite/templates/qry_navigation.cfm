<cfprocessingdirective suppresswhitespace="Yes"><cfoutput><cfquery name="DocumentStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Documents.*, SectionDocuments_Link.*
FROM Documents, SectionDocuments_Link
WHERE SectionDocuments_Link.SectionID=#sectionID#
AND SectionDocuments_Link.DocumentID=Documents.DocumentID
<cfif session.UserIsAuthenticated>
	<cfif session.UserType NEQ 'Administrator'>
		<!--- AND (Documents.ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#') --->
		AND (Documents.DocExpireDate > #localDateTime# 
		OR Documents.DocExpireDate IS NULL)
		AND Documents.Released=1
	<cfelse>
		AND Documents.AdminView = 1
	</cfif>
<cfelse>
	<!--- AND Documents.PublicView = 1 --->
	AND (Documents.DocExpireDate > #localDateTime# 
	OR Documents.DocExpireDate IS NULL)
	AND Documents.Released=1
</cfif>
ORDER BY SectionDocuments_Link.DisplayOrder	
</cfquery><cfset MenuItemString = ''><cfset SubMenuItemString = ''><cfset SubSubMenuItemString = ''><cfset ThisDoc = 0><cfloop query="DocumentStuff"><cfset ThisDoc = documentStuff.DocumentID><cfif DocumentStuff.currentrow NEQ DocumentStuff.recordcount><cfinclude template="qry_navigation_01.cfm"><cfelse><cfinclude template="qry_navigation_02.cfm"></cfif></cfloop></cfoutput></cfprocessingdirective>



<!--- 
<cfprocessingdirective suppresswhitespace="Yes"><cfoutput><cfquery name="DocumentStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Documents.*, SectionDocuments_Link.*
FROM Documents, SectionDocuments_Link
WHERE SectionDocuments_Link.SectionID=#sectionID#
AND SectionDocuments_Link.DocumentID=Documents.DocumentID
<cfif session.UserIsAuthenticated>
	<cfif session.UserType NEQ 'Administrator'>
		AND (Documents.ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#')
		AND (Documents.DocExpireDate > #localDateTime# 
		OR Documents.DocExpireDate IS NULL)
		AND Documents.Released=1
	<cfelse>
		AND Documents.AdminView = 1
	</cfif>
<cfelse>
	AND Documents.PublicView = 1
	AND (Documents.DocExpireDate > #localDateTime# 
	OR Documents.DocExpireDate IS NULL)
	AND Documents.Released=1
</cfif>
ORDER BY SectionDocuments_Link.DisplayOrder	
</cfquery><cfset MenuItemString = ''><cfset SubMenuItemString = ''><cfset SubSubMenuItemString = ''><cfset ThisDoc = 0><cfloop query="DocumentStuff"><cfset ThisDoc = documentStuff.DocumentID><cfif DocumentStuff.currentrow NEQ DocumentStuff.recordcount><cfinclude template="qry_navigation_01.cfm"><cfelse><cfinclude template="qry_navigation_02.cfm"></cfif></cfloop></cfoutput></cfprocessingdirective> --->