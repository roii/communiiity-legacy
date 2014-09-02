<cfoutput>
<cflock scope="session" timeout="5" type="readonly">

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>NZGG</title>
<link rel="stylesheet" type="text/css" href="#request.webroot#/templates/ie.css">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="198F74" width="40" align="center"><img src="#request.imageroot#/settings_title_icon.gif" width="24" height="40" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="0A2A6B" valign="middle"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Display Side Images</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="198F74" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	
	<table width="250" cellpadding="0" cellspacing="0" border="0">
	
	
	<form action="#request.webroot#/templates/act_sideimages.cfm" method="post">
	<input type="hidden" name="calledfrom" value="#calledfrom#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="30"><input type="radio" style="border:1px gray solid;" class="whitefield" name="sideimages" value="Yes"<cfif #session.sideimages# EQ 'Yes'> checked</cfif>></td>
	<td width="200" class="normal">Yes</td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="30"><input type="radio" class="whitefield" style="border:1px gray solid;" name="sideimages" value="No"<cfif #session.sideimages# EQ 'No'> checked</cfif>></td>
	<td width="200" class="normal">No</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><input type="submit" class="whitefield" style="border:1px gray solid;" value="Update >>"> <input type="button" class="whitefield" style="border:1px gray solid;" value="Close Window" onclick="javascript:window.close();'"></td>
	</tr>
	
	</form>
	
	</table>




</td>
</tr>

</table>

</body>
</html>

</cflock>
</cfoutput>