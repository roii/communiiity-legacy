<cfoutput>

<cfinclude template="../download/qry_download_cats.cfm">

<cfquery name="LastOrder" dbtype="query" maxrows="1">
SELECT DisplayOrder
FROM DownloadCats
ORDER BY DisplayOrder DESC
</cfquery>

<cfif LastOrder.RecordCount>
	<cfset nextOrder=(LastOrder.DisplayOrder + 1)>
<cfelse>
	<cfset nextOrder=1>
</cfif>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Harry Lawton Pty - Add Library Category</title>
<link rel="stylesheet" type="text/css" href="#request.webroot#/styles.css">
	
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="000000" width="40" align="center"><img src="#request.imageroot#/settings_title_icon.gif" width="40" height="40" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="B20923" valign="middle"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add a Library Category</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="808080" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
	
	<form method="post" action="act_librarycat_add.cfm" name="addform">
	<input type="hidden" name="fuseaction" value="#attributes.fuseaction#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Category Name</td>
	<td class="normal" valign="top"><input name="LibraryCatTitle" class="whitefield" size="85"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Display Order</td>
	<td class="normal" valign="top"><input name="DisplayOrder" class="whitefield" size="85" value="#NextOrder#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Released</td>
	<td class="normal" valign="top"><input type="radio" name="Released" class="whitefield" value="1" checked> Yes &nbsp;&nbsp;&nbsp; <input type="radio" name="Released" class="whitefield" value="0"> No</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Board-Member Only</td>
	<td Class="normal" valign="top"><input  type="checkbox" class="whitefield" onClick="if (this.checked) {document.addform.NonMember.checked = false; document.addform.Member.checked = false; document.addform.GP.checked = false;} else {document.addform.NonMember.checked = true; document.addform.Member.checked = true; document.addform.GP.checked = true;}" name="BoardMember" id="BoardMember" value="1"> Yes</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td><hr width="100%" size="1" color="silver"></td>
	<td><br>&nbsp;<strong>OR</strong><br><br></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td Class="normal" valign="top">Allow to View</td>
	<td Class="normal" valign="top"><input type="checkbox" class="whitefield" name="NonMember" value="1" checked> Public &nbsp;&nbsp;&nbsp;<input type="checkbox" Class="whitefield" name="Member" value="1" checked> Staff &nbsp;&nbsp;&nbsp;<input type="checkbox" Class="whitefield" name="GP" value="1" checked> GP</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="ADD NOW >>>"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	
	</table>
	</form>
		
		
		
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


