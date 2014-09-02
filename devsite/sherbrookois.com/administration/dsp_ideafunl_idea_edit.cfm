<cfoutput>

<cfinclude template="qry_bizidea.cfm">

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Edit Business</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit IDEAfunL idea</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>


	<form name="frmEditSug" action="#request.webroot#/administration/act_sugEdit.cfm" method="post">
	<input type="hidden" name="sugID" value="#sugID#">
	<input type="hidden" name="contactID" value="#CurrentSuggestion.contactID#">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Closing Date</td>
	<td class="normal" valign="top"><input name="closeDate" id="d#CurrentSuggestion.sugID#" type="text" class="whitefield" style="width:260px;" value="#CurrentSuggestion.voteCloseDate#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.frmEditSug.closeDate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0"></a></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Submitted By:</td>
	<td class="normal" valign="top"><input name="closeDate" id="d#CurrentSuggestion.sugID#" type="text" class="whitefield" style="width:260px;" value="#CurrentSuggestion.voteCloseDate#"><a href="javascript:void(0)" onclick="if(self.gfPop)gfPop.fPopCalendar(document.frmEditSug.closeDate);return false;" hidefocus><img name="popcal" align="absmiddle" src="#request.imageroot#/calbtn.gif" width="34" height="22" border="0"></a></td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td Class="small"><br><input type="submit" value="UPDATE BUSINESS NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>	
	
	</table>
	</cfform>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>