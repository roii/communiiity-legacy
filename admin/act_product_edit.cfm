
<cfif #TRIM(form.ProductImage_sml)# NEQ ''>
	
	<!--- UPLOAD THE FILE --->
	<cftry>
	
		<cffile action="UPLOAD" filefield="ProductImage_sml" destination="#request.fileroot#\images\products" nameconflict="OVERWRITE">
	
	
	<!--- REPLACE ANY STRANGE CHARACTERS IN THE FILENAME TO UNDERSCORES --->
		<cfset ThumbnailFileName = #Replace(#File.ServerFile#,  '&',  '_', 'All')#>
		<cfset ThumbnailFileName = #Replace(#ThumbnailFileName#,  '-',  '_', 'All')#>
		<cfset ThumbnailFileName = #Replace(#ThumbnailFileName#,  ' ',  '_', 'All')#>
		<cfset ThumbnailFileName = #Replace(#ThumbnailFileName#,  '?',  '_', 'All')#>
		
		<cffile action="RENAME" source="#request.fileroot#\images\products\#file.serverfile#" destination="#request.fileroot#\images\products\#ThumbnailFileName#">
	
		
	
	<cfcatch>
	
		<script>
		alert("There was a problem uploading your thumb-nail image file. Please try again or leave the field blank.")
		self.location="javascript:history.back();";
		</script>
		
		<cfabort>
	
	</cfcatch>	
	
	</cftry>

</cfif>


<cfif #TRIM(form.ProductImage_big)# NEQ ''>
	
	<!--- UPLOAD THE FILE --->
	<cftry>
	
		<cffile action="UPLOAD" filefield="ProductImage_big" destination="#request.fileroot#\images\products" nameconflict="OVERWRITE">
	
	
	<!--- REPLACE ANY STRANGE CHARACTERS IN THE FILENAME TO UNDERSCORES --->
		<cfset LargeFileName = #Replace(#File.ServerFile#,  '&',  '_', 'All')#>
		<cfset LargeFileName = #Replace(#LargeFileName#,  '-',  '_', 'All')#>
		<cfset LargeFileName = #Replace(#LargeFileName#,  ' ',  '_', 'All')#>
		<cfset LargeFileName = #Replace(#LargeFileName#,  '?',  '_', 'All')#>
		
		<cffile action="RENAME" source="#request.fileroot#\images\products\#file.serverfile#" destination="#request.fileroot#\images\products\#LargeFileName#">
	
		
	
	<cfcatch>
	
		<script>
		alert("There was a problem uploading your large image file. Please try again or leave the field blank.")
		self.location="javascript:history.back();";
		</script>
		
		<cfabort>
	
	</cfcatch>	
	
	</cftry>

</cfif>




<!--- UPDATE THE FILE --->
	
	<cfquery name="UpdateProduct" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Products
	SET ProductCategoryID=#form.ProductCategoryID#, 
	ProductName='#form.ProductName#',
	ProductDetails='#form.ProductDetails#', 
	
	<cfif #IsDefined("ThumbnailFileName")#> 
	ProductImage_sml='#ThumbnailFileName#',
	</cfif>
	
	<cfif #IsDefined("LargeFileName")#>
	ProductImage_big='#LargeFileName#',
	</cfif> 
	
	<cfif IsNumeric("#form.StockAvailable#")>
	StockAvailable=#form.StockAvailable#,
	<cfelse>
	StockAvailable=0,
	</cfif>
	
	
	buyprice=#Replace(form.buyprice, '$', '', "ALL")#, 
	NormalSellPrice=#Replace(form.NormalSellPrice, '$', '', "ALL")#, 
	SpecialSellPrice=#Replace(form.SpecialSellPrice, '$', '', "ALL")#, 
	OnSpecial=#form.OnSpecial#, 
	ProductReleased=#form.ProductReleased#,
	FulfilmentHouseID=#form.FulfilmentHouseID#,
	Deleted=0
	
	WHERE ProductID=#form.productID#
	</cfquery>


	
<!--- LOG THIS ACTION --->

	<cfoutput>
	<cfset logdetails = 'Edit Product - (Product: #form.productName#)'>
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
