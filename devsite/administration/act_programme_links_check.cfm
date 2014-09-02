<cfoutput>



<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>G-I-N - Check Programme Links</title>
<link rel="stylesheet" type="text/css" href="#request.webroot#/templates/#session.textsize#.css">

	<script language="JavaScript">
		<!--
	function confirmLinkDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Link?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	</script>
	
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="FF3300" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/settings_title_icon.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td background="#request.imageroot#/top_blue_pattern.gif" valign="middle" valign="top" height="40"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Check for Bad Programme Associated Documents Links</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="FF3300" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<table width="100%" cellpadding="2" cellspacing="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2">
	<strong>The following links indicated possible problems.</strong>
	<hr width="100%" size="1" color="white"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<cfloop list="#BadLinks#" index="ThisLink" delimiters="|">
	
	
	<cfquery name="LinkDetails" datasource="#OrganisationDSN#">
	SELECT Programmes.ProgrammeID, Programmes.OrganisationID
	FROM ProgrammeDocuments, Programmes
	WHERE ProgrammeDocuments.DocumentURL='#TRIM(ThisLink)#'
	AND ProgrammeDocuments.ProgrammeID=Programmes.ProgrammeID
	</cfquery>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td><a href="#TRIM(ThisLink)#" target="_blank">#TRIM(ThisLink)#</a></td>
	<td align="right"><a href="#request.webroot#/admin/dsp_programmes.cfm?ProgrammeID=#LinkDetails.ProgrammeID#&organisationID=#LinkDetails.OrganisationID#&editmode=programmeedit" target="editLink" ONCLICK="fdbackwindow=window.open ('','editLink','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Link" border="0"></a></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="white"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	

	
	</cfloop>
	
	
	</table>
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>