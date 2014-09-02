
<cfparam name="sortby" default="date">
<cfparam name="sortorder" default="desc">
<cfparam name="categoryID" default="0">
<cfparam name="add" default="0">

<!--- Edit --->
<cfif categoryID NEQ 0>

	<cfquery name="currentCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT 	categoryID,
					convert(varchar(8),whenCategoryCreated,3) as [date],
					Name,
					Priority,
					Description
			FROM 	sugCategory
			WHERE 	categoryID = #categoryID#
	</cfquery>

<!--- Add --->
<cfelseif add EQ 1>

	<cfquery name="AddCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT distinct priority
		FROM SugCategory
	</cfquery>
	
<!--- All --->	
<cfelse>

<cfquery name="sugCategory" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT 	categoryID,
				convert(varchar(8),whenCategoryCreated,3) as [date],
				Name,
				Priority,
				Description
		FROM 	sugCategory
		WHERE 	whenCategoryEnded is null
		ORDER BY #sortby# #sortorder#
</cfquery>

</cfif>