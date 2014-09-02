
<!--- GENERATE NEW PRODUCT CAT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ProductCategoryID
	FROM ProductCategories
	ORDER BY ProductCategoryID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.ProductCategoryID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>



<!--- INSERT THE FILE --->
	
	<cfquery name="InsertProductCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO ProductCategories(ProductCategoryID, ProductCategoryName, ProductCategoryDisplayOrder, ProductCategoryReleased)
	VALUES(#newID#, '#form.ProductCategoryName#', #form.ProductCategoryDisplayOrder#, #form.productCategoryReleased#)
	</cfquery>


	
<!--- LOG THIS ACTION --->

	<cfoutput>
	<cfset logdetails = 'Add Product Category - (Category: #form.ProductCategoryName#)'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=shoppers')"></body>
	
	
	</cfoutput>
