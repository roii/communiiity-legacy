

<!--- return dynamic category name --->
<cfquery name="selCategory" datasource="mykidsbiznewi" username="#request.username#" password="#request.password#">
  
  SELECT CategoryID,Name
  FROM SugCategory
  WHERE whenCategoryEnded is null
  ORDER BY name asc
 
</cfquery>