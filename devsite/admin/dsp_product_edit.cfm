
<cfoutput>

<cfquery name="AllProductCategories" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ProductCategories
ORDER BY ProductCategoryDisplayOrder
</cfquery>

<cfquery name="ProductStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Products
WHERE ProductID=#ProductID#
</cfquery>

<cfquery name="allhouses" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Fulfilmenthouses
ORDER BY BusinessName
</cfquery>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Edit Product</title>
<cfinclude template="../templates/styles.cfm">
	
	
	
	
<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(FileAddForm) {    

if (FileAddForm.ProductName.value == "") {
	alert("You must enter a Name for this product.");
	FileAddForm.Title.focus();
	return;
	} 
	
else if (FileAddForm.NormalSellPrice.value == "") {
	alert("You must enter a Retail Price.");
	FileAddForm.NormalSellPrice.focus();
	return;
	}
	
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	FileAddForm.submit(); //submit form
	}
}
// -->
</script>



</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Product</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<cfform method="post" action="#request.webroot#/admin/act_product_edit.cfm" name="FileAddForm" enctype="multipart/form-data">
	<input type="hidden" name="productID" value="#productID#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Category</td>
	<td class="normal" valign="top"><cfselect name="ProductCategoryID" display="ProductCategoryName" query="AllProductCategories" value="ProductCategoryID" class="whitefield" selected="#ProductStuff.ProductCategoryID#"></cfselect></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Product Name</td>
	<td class="normal" valign="top"><textarea class="whitefield" cols="85" rows="2" name="ProductName">#TRIM(ProductStuff.ProductName)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Details</td>
	<td class="normal" valign="top">
	<cf_fckeditor name="ProductDetails" value="#TRIM(ProductStuff.ProductDetails)#" width="650" height="450" toolbarset="Default">
	<!---
	<cf_activedit name="ProductDetails" inc="#request.ActiveEditInc#" image="true" 
imagepath="#request.fileroot#\images\" 
imageURL="#request.imageroot#/" width="445" height="160" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifyright,|,bullets,numbers,table,hyperlink,help,showdetails,spellcheck" tabview="no" DEFAULTFONT="8pt Verdana">#TRIM(ProductStuff.ProductDetails)#</cf_activedit>
--->
</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">New Thumbnail Image</td>
	<td class="normal" valign="top"><input type="file" class="whitefield" name="ProductImage_sml" size="72"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">New Large Image</td>
	<td class="normal" valign="top"><input type="file" class="whitefield" name="ProductImage_big" size="72"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Purchase Price</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="35" name="buyprice" value="#DollarFormat(ProductStuff.buyprice)#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="5" border="0"></td>
	<td colspan="2"> </td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Retail Price</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="35" name="NormalSellPrice" value="#DollarFormat(ProductStuff.NormalSellPrice)#"></td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">On Special</td>
	<td class="normal" valign="top"><input type="radio" name="OnSpecial" class="whitefield" value="1"<cfif #productStuff.OnSpecial# EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp; <input type="radio" name="OnSpecial" class="whitefield" value="0"<cfif #productStuff.OnSpecial# EQ 0> checked</cfif>> No</td>
	</tr>	
		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="5" border="0"></td>
	<td colspan="2"> </td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Special Price</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="35" name="SpecialSellPrice" value="#DollarFormat(ProductStuff.SpecialSellPrice)#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Stock Available</td>
	<td Class="normal" valign="top"><input type="text" Class="whitefield" size="35" name="StockAvailable" value="#ProductStuff.StockAvailable#"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Fulfilment House</td>
	<td class="normal" valign="top"><cfselect name="FulfilmentHouseID" display="BusinessName" query="AllHouses" value="FulfilmentHouseID" class="whitefield" selected="ProductStuff.FulfilmentHouseID"></cfselect></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Released</td>
	<td class="normal" valign="top"><input type="radio" name="ProductReleased" class="whitefield" value="1"<cfif #productStuff.ProductReleased# EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp; <input type="radio" name="ProductReleased" class="whitefield" value="0"<cfif #productStuff.ProductReleased# EQ 0> checked</cfif>> No</td>
	</tr>	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="ADD NOW >>>" onClick="javascript:ae_onSubmit(); validate(FileAddForm); return false;"> &nbsp; <input type="button" onClick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	
	
	</table>
	</cfform>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


