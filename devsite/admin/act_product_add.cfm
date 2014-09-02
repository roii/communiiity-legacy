
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





<!--- GENERATE NEW PRODUCT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ProductID
	FROM Products
	ORDER BY ProductID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.ProductID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>



<!--- INSERT THE FILE --->
	
	<cfquery name="InsertProduct" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Products(ProductID, ProductCategoryID, ProductName, ProductDetails, <cfif #IsDefined("ThumbnailFileName")#> ProductImage_sml,</cfif><cfif #IsDefined("LargeFileName")#> ProductImage_big,</cfif> buyprice, NormalSellPrice, SpecialSellPrice, OnSpecial, StockAvailable, ProductReleased, FulfilmentHouseID, Deleted)
	VALUES(#newID#, #form.ProductCategoryID#, '#form.ProductName#', '#form.ProductDetails#', <cfif #IsDefined("ThumbnailFileName")#> '#ThumbnailFileName#',</cfif><cfif #IsDefined("LargeFileName")#> '#LargeFileName#',</cfif> #Replace(form.buyprice, '$', '', "ALL")#, #Replace(form.NormalSellPrice, '$', '', "ALL")#, #Replace(form.SpecialSellPrice, '$', '', "ALL")#, #form.OnSpecial#, <cfif IsNumeric("#form.StockAvailable#")>#form.StockAvailable#<cfelse>0</cfif>, #form.ProductReleased#, #form.FulfilmentHouseID#, 0)
	</cfquery>


	
<!--- LOG THIS ACTION --->

	<cfoutput>
	<cfset logdetails = 'Add Product - (Product: #form.productName#)'>
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
