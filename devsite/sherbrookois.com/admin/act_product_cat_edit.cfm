

<!--- UPDATE THE FILE --->
	
	<cfquery name="UpdateProductCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE ProductCategories
	SET ProductCategoryName='#form.ProductCategoryName#', 
	ProductCategoryDisplayOrder=#form.ProductCategoryDisplayOrder#, 
	ProductCategoryReleased=#form.productCategoryReleased#
	WHERE ProductCategoryID=#form.ProductCategoryID#
	</cfquery>


	
<!--- LOG THIS ACTION --->

	<cfoutput>
	<cfset logdetails = 'Edit Product Category - (Category: #form.ProductCategoryName#)'>
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
