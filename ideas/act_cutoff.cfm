<!--- GET ALL TOPICS FOR MAIN CAT --->
<cfquery name="Category" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
WHERE MainCatID=1
ORDER BY DisplayOrder
</cfquery>


<cfloop query="Category">

<cfset this_categoryID = Category.categoryID>

<cfquery name="UpdateIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Suggestion
SET SugStage='Stage 1',
Authorise='Yes'
WHERE CategoryID=#this_categoryID#
AND Archived = 0
AND SugStage LIKE '%Pending%'
</cfquery>

</cfloop>