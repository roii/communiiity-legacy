<cfoutput>

<cfquery name="bizideaType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea_Type 
ORDER BY biz_type
</cfquery>

<cfquery name="nextBizorder" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT bizOrder
FROM bizidea 
ORDER BY bizOrder DESC
</cfquery>

<cfif nextBizorder.recordcount>
	<cfset nextorder = nextBizorder.bizOrder + 1>
<cfelse>
	<cfset nextorder = 1>
</cfif>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Add Business</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(addform) {    

if (addform.biz_idea.value == "") {
	alert("You must enter the Business Title.");
	addform.biz_idea.focus();
	return;
	} 

else if (addform.bizideaTypeID.selectedIndex == "0") {
alert("You must select a business Type.");
addform.bizideaTypeID.focus();
return;
}
	
else if (addform.biz_summary.value == "") {
	alert("Please enter a brief summary.");
	addform.biz_summary.focus();
	return;
	} 
	
else {
	ae_onSubmit(); //This function must execute before onSubmit(). You won't be able to use the onSubmit event handler in the form 	header. Notice the submit type="button". When using an image for submit, place javacript: void(validate()) inside the href attribute to call the function.
	addform.submit(); //submit form
	}
}
// -->
</script>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add Business</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<cfform method="post" action="#request.webroot#/administration/act_add_bizidea.cfm" name="addform" enctype="multipart/form-data">

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Title</td>
	<td class="normal" valign="top"><input type="text" name="biz_idea" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Type</td>
	<td class="normal" valign="top"><select name="bizideaTypeID" class="whitefield" style="width:300px;">
	<option value="0">Please select a type
	<cfloop query="bizideaType">
	<option value="#bizideaType.bizideatypeid#">#TRIM(bizideaType.biz_type)#	
	</cfloop>
	</select></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Minimum Age</td>
	<td class="normal" valign="top"><cfinput type="text" required="Yes" message="Please enter kids minimum age first" name="min_age" class="whitefield" style="width:300px;"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Summary</td>
	<td class="normal" valign="top"><textarea rows="5" style="width:300px;font-family:Arial;font-size:11px;" name="biz_summary"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Thumbnail Image</td>
	<td class="normal" valign="top"><input type="file" style="width:300px;font-family:Arial;font-size:11px;" name="lowres_image"><br>NOTE: Resizes to 80px(w) x 60px(h) when creating the thumbnail.<br>
	To avoid bad results please size originals to match scale (&frac34;)<br>
	i.e. 200px(w) x 150px(h)... 400px(w) x 300px(h)</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr><!--- 
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Hi-res Image<br>(300 x 300 @ 300dpi)</td>
	<td class="normal" valign="top"><input type="file" style="width:300px;font-family:Arial;font-size:11px;" name="hires_image"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	 --->
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Display Order</td>
	<td Class="normal" valign="top"><input type="text" style="width:300px;font-family:Arial;font-size:11px;" name="bizOrder" value="#nextorder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Display</td>
	<td Class="normal" valign="top"><input type="Radio" name="show" value="1" checked> Yes &nbsp; <input type="Radio" name="show" value="0"> No</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" value="ADD BUSINESS NOW >>" class="whitefield" onclick="javascript:ae_onSubmit(); validate(addform); return false;"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</cfform>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>