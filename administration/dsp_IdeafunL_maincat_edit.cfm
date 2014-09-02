<cfquery name="qry_category_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugMainCategory
WHERE MainCatID=#MainCatID#
</cfquery>

<cfoutput>
<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Edit IDEAfunL Category</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit IDEAfunL Category</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>
	
		
	<script language="JavaScript">
	<!--
	function validate(AddTopic) {    
		
	
	if (AddTopic.MainCatTitle.value == "") {
		alert("You must enter a Title for this category.");
		AddTopic.MainCatTitle.focus();
		return;
		} 
		
	else {
		AddTopic.submit(); //submit form
		}
	}
	// -->
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="AddTopic" action="#request.webroot#/administration/act_edit_ideafunl_maincat.cfm" method="post" onsubmit="javascript:validate(AddTopic); return false;">
	
	<input type="hidden" name="MainCatID" value="#MainCatID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Title</td>
	<td><input type="text" name="MainCatTitle" class="whitefield" style="width:300px;" value="#TRIM(qry_category_stuff.MainCatTitle)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Description</td>
	<td><textarea name="Description" style="width:300px" rows="4" class="whitefield">#TRIM(qry_category_stuff.Description)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Active</td>
	<td style="font-size:11px;"><input type="radio" name="Active" class="whitefield" value="1"<cfif qry_category_stuff.Active EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp; <input type="radio" name="Active" class="whitefield" value="0"<cfif qry_category_stuff.Active EQ 0> checked</cfif>> No</td>
	</tr>

	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Display Order</td>
	<td><input type="text" name="DisplayOrder" class="whitefield" style="width:300px;" value="#qry_category_stuff.DisplayOrder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" value="UPDATE CATEGORY NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br><br>


	
</td>
</tr>

</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/administration/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>
</body>
</html>

</cfoutput>