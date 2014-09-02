<cfoutput>

<script language="JavaScript">

<!--
function confirmAlertDelete(aURL) {
    if(confirm('Are you sure you want to delete this Email Alert?')) {
      location.href = aURL;
    }
  }
//-->

</script>

<cfquery name="AllAlerts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertID, AlertTitle, AlertSubject, AlertDetails, AlertFormat, VariablesUsed, SMSDetails
FROM EmailAlerts
ORDER BY AlertID
</cfquery>



<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE EMAIL/SMS ALERTS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">

<tr>
<td><a href="#request.webroot#/administration/dsp_popup_add_emailalert.cfm" target="AddAlert" onclick="fdbackwindow=window.open ('','AddAlert','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=550,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD AN ALERT &raquo;</strong></a><br>


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="18"><img src="#request.imageroot#/spacer.gif" width="1" height="1" border="0"></td>
	<td width="80%"><img src="#request.imageroot#/spacer.gif" width="1" height="1" border="0"></td>
	<td width="190"><img src="#request.imageroot#/spacer.gif" width="1" height="1" border="0"></td>
	<td width="10"><img src="#request.imageroot#/spacer.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	
	
	
	<tr>
	<td width="18"><br></td>
	<td colspan="2"><br>
		
		<table border="0" cellpadding="1" cellspacing="0">
		
		<tr>
		<td width="100%" style="font-size:11px;color:##333333;"><img src="#request.imageroot#/spacer.gif" width="1" height="1" border="0"><br>
		<strong>Alert Name</strong></td>
		<td width="120" style="font-size:11px;color:##333333;" align="center"><img src="#request.imageroot#/spacer.gif" width="120" height="1" border="0"><br>
		<strong>Send Email</strong></td>
		<td width="120" style="font-size:11px;color:##333333;" align="center"><img src="#request.imageroot#/spacer.gif" width="120" height="1" border="0"><br>
		<strong>Send SMS</strong></td>
		<td width="40">&nbsp;</td>
		</tr>
		
		<tr>
		<td colspan="4"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		
		<cfloop query="AllAlerts">
		<tr>
		<td style="font-size:11px;">#TRIM(AllAlerts.AlertTitle)#</td>
		<td style="font-size:11px;" align="center"><cfif TRIM(AllAlerts.AlertDetails) NEQ ''>Yes<cfelse>No</cfif></td>
		<td style="font-size:11px;" align="center"><cfif TRIM(AllAlerts.SMSDetails) NEQ ''>Yes<cfelse>No</cfif></td>
		<td width="40"><a href="#request.webroot#/administration/dsp_edit_emailalert_popup.cfm?AlertID=#AllAlerts.AlertID#" target="editCharity" onclick="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Alert" border="0"></a>&nbsp;<a href="javascript:confirmAlertDelete('#request.webroot#/administration/act_delete_emailalert.cfm?AlertID=#AllAlerts.AlertID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Alert" border="0"></a></td>
		</tr>
		
		<tr>
		<td colspan="4"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		</cfloop>
		
		</table><br>
		
	
	</td>
	</tr>
	
	</table><br>



</td>
</tr>

</table>

</cfoutput>