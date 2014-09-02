<cfquery name="AllAlerts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM EmailAlerts
WHERE AlertID=#AlertID#
</cfquery>

<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Manage Alerts</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Manage Alerts</strong></span></td>
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
	<td>
	
		<table border="0" cellpadding="1" cellspacing="0">
		
		<form action="#request.webroot#/administration/act_alert_update.cfm" method="post">
		<input Type="hidden" name="AlertID" value="#AllAlerts.AlertID#">
		
		<tr>
		<td width="100" style="font-size:11px;">Alert Name<br></td>
		<td><input Type="text" class="whitefield" style="width:400px;" name="AlertTitle" value="#TRIM(AllAlerts.AlertTitle)#"></td>
		</tr>
		
		<tr>
		<td width="100" style="font-size:11px;">Email Subject</td>
		<td><input Type="text" class="whitefield" style="width:400px;" name="AlertSubject" value="#TRIM(AllAlerts.AlertSubject)#"></td>
		</tr>
		
		<tr>
		<td width="100" valign="top" style="font-size:11px;">Email Message</td>
		<td valign="top" style="font-size:11px;"><textarea class="whitefield" style="width:400px;" rows="6" name="AlertDetails">#TRIM(AllAlerts.AlertDetails)#</textarea></td>
		</tr>
		
		<tr>
		<td width="100" valign="top" style="font-size:11px;">SMS Message</td>
		<td valign="top" style="font-size:11px;"><textarea class="whitefield" style="width:400px;" rows="6" name="SMSDetails">#TRIM(AllAlerts.SMSDetails)#</textarea></td>
		</tr>
		
		<tr>
		<td width="100" style="font-size:11px;">Alert Format</td>
		<td style="font-size:11px;"><input Type="radio" name="AlertFormat" class="whitefield" value="HTML"<cfif TRIM(AllAlerts.AlertFormat) EQ 'HTML'> checked</cfif>> HTML &nbsp;&nbsp; <input Type="radio" name="AlertFormat" class="whitefield" value="Plain"<cfif TRIM(AllAlerts.AlertFormat) EQ 'Plain'> checked</cfif>> Plain Text</td>
		</tr>
		
		<tr>
		<td width="100" style="font-size:11px;"><br>Variables Used</td>
		<td valign="top" style="font-size:11px;color:###AllSettings.DkTextColor#;"><br>#AllAlerts.VariablesUsed#</td>
		</tr>
		
		<tr>
		<td width="100" valign="top">&nbsp;</td>
		<td valign="top"><br><input type="submit" value="Update this Alert" class="whitefield" border="0"></td>
		</tr>		
		
		</form>
		
		</table><br>
		
	
	</td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>