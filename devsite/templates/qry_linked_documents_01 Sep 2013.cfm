<cfquery name="AllDocuments" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Documents.*, SectionDocuments_Link.*
FROM Documents, SectionDocuments_Link
WHERE SectionDocuments_Link.SectionID=#SectionDetails.sectionid#
AND SectionDocuments_Link.DocumentID=Documents.DocumentID

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		<!--- AND (Documents.ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#') --->
		AND (Documents.DocExpireDate > #localDateTime# 
		OR Documents.DocExpireDate IS NULL)
		AND Documents.Released=1
	</cfif>

<cfelse>
	<!--- AND Documents.PublicView = 1 --->
	AND (Documents.DocExpireDate > #localDateTime# 
	OR Documents.DocExpireDate IS NULL)
	AND Documents.Released=1
</cfif>

ORDER BY SectionDocuments_Link.DisplayOrder	
</cfquery>