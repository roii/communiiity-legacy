
<!--- UPDATE CATEGORY  --->

	<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM ProjectCategories
	WHERE ProjectCategoryID=#ProjectCategoryID#
	</cfquery>
	
	<cfquery name="DeleteProjects" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Projects
	WHERE ProjectCategoryID=#ProjectCategoryID#
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	<cfset logdetails = 'Delete Cash Project Category'>
	<cfinclude template="act_adminlog.cfm">
	</cfoutput>


	

	
	<cfoutput>
		
		<cflocation url="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#">

	</cfoutput>
		
		


