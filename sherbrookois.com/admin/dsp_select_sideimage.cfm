<cfoutput>


<cfdirectory action="LIST" directory="#request.fileroot#\images\corner" name="dirlist" filter="*.gif">


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Select a Side-Image</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Select a Side-Image</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


		
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<cfloop query="dirlist">
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="150" class="normal"><a href="#request.webroot#/admin/act_sideimage.cfm?imagename=#dirlist.name#&sectionID=#SectionID#&fuseaction=#fuseaction#" style="color:black; text-decoration:none;">:: Use this Image</a><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
	<a href="#request.webroot#/admin/act_delete_sideimage.cfm?imagename=#dirlist.name#&sectionID=#sectionID#&fuseaction=#fuseaction#" style="color:black; text-decoration:none;">:: Delete this Image</a></td>	
	<td width="221"><img src="#request.imageroot#/corner/#dirlist.name#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	</cfloop>
	
	</table>
	
		
		
		
		
</td>
</tr>

</table>

</body>
</html>
	
</cfoutput>

