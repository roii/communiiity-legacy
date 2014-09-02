<cfoutput>



<!--- SELECT THE PRODUCT CAT DETAILS TO DELETE AND ADD TO LOG --->
	
	<cfquery name="ProductStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ProductImage_big, ProductImage_sml
	FROM Products
	WHERE ProductCategoryID=#ProductCategoryID#
	</cfquery>
	
		

	<cfloop query="ProductStuff">
	

		<!--- TRY DELETING THE  IMAGE FILES FROM THE SERVER --->
		
		<cftry>
			<cffile action="delete" file="#request.fileroot#\images\products\#ProductStuff.ProductImage_big#">
		<cfcatch></cfcatch>
		</cftry>		
		
			
		<cftry>
			<cffile action="delete" file="#request.fileroot#\images\products\#ProductStuff.ProductImage_sml#">
		<cfcatch></cfcatch>
		</cftry>		
		
		
		
		<!--- DELETE THE PRODUCT RECORD --->
		
		<cfquery name="DeleteProductDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE Products
		SET Deleted=1
		WHERE ProductID=#ProductStuff.ProductID#
		</cfquery>
	
		
		<!--- LOG THIS ACTION --->
	
		<cfset logdetails = 'Delete Product - (Product: #ProductStuff.ProductName#)'>
		
		<cfinclude template="act_adminlog.cfm">
		

	</cfloop>



	<cfquery name="DeleteProductCatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM ProductCategories
	WHERE ProductCategoryID=#ProductCategoryID#
	</cfquery>


	
	
	
	
	<cflocation url="#request.webroot#/index.cfm?fuseaction=shoppers">


</cfoutput>