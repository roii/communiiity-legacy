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
<cfinclude template="../templates/set_language.cfm">
	<title>#TRIM(AllSettings.SiteName)# - #addbusi#</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<SCRIPT LANGUAGE="JavaScript">
<!--
function validate(addform) {    

if (addform.biz_idea.value == "") {
	alert("#alertbusi#.");
	addform.biz_idea.focus();
	return;
	} 

else if (addform.bizideaTypeID.selectedIndex == "0") {
alert("#busitypealert#.");
addform.bizideaTypeID.focus();
return;
}
	
else if (addform.biz_summary.value == "") {
	alert("#alertbriefsumm#.");
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
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#addbusi#</strong></span></td>
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
	<td class="normal" valign="top" width="110">#addprojtitlefield#</td>
	<td class="normal" valign="top"><input type="text" name="biz_idea" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#type#</td>
	<td class="normal" valign="top"><select name="bizideaTypeID" class="whitefield" style="width:300px;">
	<option value="0">#selectTypeT#
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
	<td class="normal" valign="top" width="110">#minage#</td>
	<td class="normal" valign="top"><cfinput type="text" required="Yes" message="#enterminage#" name="min_age" class="whitefield" style="width:300px;"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#Summary#</td>
	<td class="normal" valign="top"><textarea rows="5" style="width:300px;font-family:Arial;font-size:11px;" name="biz_summary"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">#thumbimg#</td>
	<td class="normal" valign="top"><input type="file" style="width:300px;font-family:Arial;font-size:11px;" name="lowres_image"><br>#notetxt#: #resizethumb#.<br>
	#badresnote# (&frac34;)<br>
	#sizenote#</td>
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
	<td Class="normal" valign="top">#disporder#</td>
	<td Class="normal" valign="top"><input type="text" style="width:300px;font-family:Arial;font-size:11px;" name="bizOrder" value="#nextorder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">#Display#</td>
	<td Class="normal" valign="top"><input type="Radio" name="show" value="1" checked> #yestitle# &nbsp; <input type="Radio" name="show" value="0"> #notitle#</td>
	</tr>		
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" value="#addbusinow# >>" class="whitefield" onClick="javascript:ae_onSubmit(); validate(addform); return false;"> &nbsp; <input type="button" onClick="javascript:window.close();" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</cfform>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>