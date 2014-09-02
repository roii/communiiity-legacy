<cfoutput>

<script language="JavaScript">
	<!--
	function confirmSMSDelete(aURL) {
	    if(confirm('Are you sure you want to delete this tagline?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfquery name="Default_TagLines" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SMS_Taglines
WHERE SponsorID=0
</cfquery>
	
<cfquery name="Sponsor_TagLines" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SMS_Taglines
WHERE SponsorID <> 0
</cfquery>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE SMS TAG-LINES</strong></td>
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
<td class="small"><a href="#request.webroot#/administration/dsp_smstag_add.cfm" target="addTag" onclick="fdbackwindow=window.open ('','addTag','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A TAG-LINE &raquo;</strong></a>

<hr width="100%" size="1" color="##e2e2e2">
	

	
	<table cellpadding="0" cellspacing="0" border="0">

	
	<tr>
	<td width="60" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="60" height="2" border="0"></td>
	<td width="300" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="300" height="2" border="0"></td>
	<td width="40" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td align="center">Current</td>
	<td>Details</td>
	<td align="right"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	</tr>
	
	<form method="post" action="#request.webroot#/administration/act_smstags_update.cfm" name="DefaultTags">
	<input type="hidden" name="NumTags" value="#Default_TagLines.RecordCount#">
	
	
	<cfloop query="Default_TagLines">
	
	<input type="hidden" name="TagID_#Default_TagLines.CurrentRow#" value="#Default_TagLines.TagID#">

	
	<tr>
	<td align="center"><input type="radio" class="whitefield" name="DefaultTag" value="#Default_TagLines.TagID#"<cfif Default_TagLines.DefaultTag EQ 1> checked</cfif>></td>
	<td><input type="text" class="whitefield" name="TagLine_#Default_TagLines.CurrentRow#" value="#TRIM(Default_TagLines.TagLine)#" style="width:300px;"></td>	
	<td align="right"><a href="javascript:confirmSMSDelete('#request.webroot#/administration/act_smstag_delete.cfm?TagID=#Default_TagLines.TagID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Tag-line" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	<tr>
	<td colspan="3" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><input type="submit" class="whitefield" value="Update Tag-Lines &raquo;"></td>
	</tr>
	
	</form>
	
	</table>
	

</td>
</tr>

</table>


</cfoutput>