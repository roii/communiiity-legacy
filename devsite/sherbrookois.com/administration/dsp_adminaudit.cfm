<cfoutput>

<script language="JavaScript">
	<!--
	function confirmAdministratorDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Administrator?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfinclude template="qry_administrators.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>ADMINISTRATION AUDIT</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
	
	<cfinclude template="dsp_adminlog_table.cfm">

</td>
</tr>

</table></cfoutput>