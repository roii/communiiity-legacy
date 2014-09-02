<cfoutput>

<cfquery name="CatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM LinkCats
WHERE LinkCatID=#LinkCatID#
</cfquery>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Edit Link Category</title>
<cfinclude template="../templates/styles.cfm">
	
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit this Link Category</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
	
	<form method="post" action="act_linkcat_edit.cfm">
	<input type="hidden" name="LinkCatID" value="#LinkCatID#">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="NonMember" value="0">
	<input type="hidden" name="Member" value="0">
	
	<cfif IsDefined("fusesubaction")>
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	</cfif>
	
	<cfif IsDefined("ArticleID")>
	<input type="hidden" name="ArticleID" value="#ArticleID#">
	</cfif>
	
	<cfif IsDefined("DocumentID")>
	<input type="hidden" name="DocumentID" value="#DocumentID#">
	</cfif>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Category Name</td>
	<td class="normal" valign="top"><input name="Title" class="whitefield" size="85" value="#CatDetails.Title#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Display Order</td>
	<td class="normal" valign="top"><input name="DisplayOrder" class="whitefield" size="85" value="#CatDetails.DisplayOrder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Released</td>
	<td class="normal" valign="top"><input type="radio" name="Released" class="whitefield" value="1"<cfif #catdetails.Released# EQ 1> checked</cfif>> Yes &nbsp;&nbsp;&nbsp; <input type="radio" name="Released" class="whitefield" value="0"<cfif #catdetails.Released# EQ 0> checked</cfif>> No</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Allow to View</td>
	<td Class="normal" valign="top"><input type="checkbox" class="whitefield" name="NonMember" value="1"<cfif #catdetails.NonMember# EQ 1> checked</cfif>> Non-member &nbsp;&nbsp;&nbsp;<input type="checkbox" Class="whitefield" name="Member" value="1"<cfif #catdetails.Member# EQ 1> checked</cfif>> Member</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="UPDATE NOW >>>"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	
	</table>
	</form>
		
		
		
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


