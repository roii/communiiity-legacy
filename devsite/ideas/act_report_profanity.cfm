<!--- SEND EMAIL TO ADMINISTRATOR --->

<cfmail server="#application.emailserver#" bcc="alan@proworkflow.com" to="roy@my3p.com" from="#form.email#" subject="myKidsBiz.com - Bad Content Report" type="html">
<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Bad Content Report</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="389BA9" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/settings_title_icon.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td background="#request.imageroot#/top_blue_pattern.gif" valign="middle" valign="top" height="40"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#TRIM(AllSettings.SiteName)# - Bad Content Report</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="389BA9" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Reported By</td>
	<td class="normal" valign="top">#TRIM(Form.Name)#<br>
	<a href="mailto:#TRIM(form.Email)#">#TRIM(form.Email)#</a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">URL</td>
	<td class="normal" valign="top"><a href="#TRIM(form.LinkToURL)#">#TRIM(form.LinkToURL)#</a><br><br>
	<strong><em>NOTE: You may need to click on the red link to open the IdeaPond to see the reported bad content.</em></strong></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Details</td>
	<td class="normal" valign="top">#TRIM(form.Details)#</td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	</table><br>
	
	
	
</td>
</tr>

</table>

</body>
</html>
</cfmail>


<cfoutput>
<script>
alert("Thanks for your report!\nThe Content Review Panel will review the page you reported.\nWe will let you know what we find and what reward you'll receive.\nThe #TRIM(AllSettings.SiteName)# Team");
self.location="#request.webroot#/index.cfm?fuseaction=ideas";
</script>
</cfoutput>