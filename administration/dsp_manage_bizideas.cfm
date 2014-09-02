<cfoutput>

<cfparam name="shoppers_sortby" default="bizideaID">
<cfparam name="sortorder" default="DESC">

<script language="JavaScript">
<!--
function confirmAdministratorDelete(aURL) {
    if(confirm('#alertBizideas#?')) {
      location.href = aURL;
    }
  }
//-->
</script>

	
<cfinclude template="qry_bizidea.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#managebusi#</strong></td>
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
<a href="#request.webroot#/administration/dsp_bizidea_add.cfm" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;" target="addbusiness" onclick="fdbackwindow=window.open ('','addbusiness','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=850,height=600,top=10,left=10')">
<strong>#addabusi# &raquo;</strong></a><br>
<a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_pribiz" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;">
<strong>#manageprivbusi# &raquo;</strong></a>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td nowrap style="padding-right:10px;"><b>#Business#</b></td>
	<td nowrap style="padding-right:10px;"><b>#typet#</b></td>
	<!---<td nowrap style="padding-right:10px;" align="center"><b>Min.Age</b></td>--->
	<td nowrap style="padding-right:10px;" align="center"><b>#Display#</b></td>
	<td nowrap style="padding-right:10px;" align="center"><b>#Active#</b></td>
	<td nowrap style="padding-right:10px;" align="center"><b>#Jobs#</b></td>
	<td align="right">&nbsp;</td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="allbizideas">
	<cfquery name="activekids" datasource="#dsn#" username="#request.username#" password="#request.password#">
	  SELECT count(*) as total FROM Business, bizKidsLink WHERE  Business.bizID=bizKidsLink.bizID AND Business.BizStatus LIKE 'Active'
      and bizideaid = #allbizideas.bizideaid#
	</cfquery>  
	<cfquery name="jobsdone" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT count(*) as total FROM Business, bizKidsLink,bizTransaction WHERE  
		bizTransaction.bizkidslinkid = bizKidsLink.bizkidslinkid and
		Business.bizID=bizKidsLink.bizID AND Business.BizStatus LIKE 'Active'
		and bizideaid = #allbizideas.bizideaid#
	</cfquery>	
	<tr>
	<td valign="top" style="padding-right:10px;">#allbizideas.biz_idea#</td>
	<td valign="top" style="padding-right:10px;">#allbizideas.biz_type#</td>
	<!---<td valign="top" style="padding-right:10px;" align="center">#allbizideas.min_age#</td>--->
	<td valign="top" style="padding-right:10px;" align="center"><cfif allbizideas.show EQ '1'>Y<cfelse>N</cfif></td>
	<td valign="top" style="padding-right:10px;" align="center"><a href="#request.webroot#/administration/dsp_biz_kids.cfm?bizideaID=#bizideaid#&fuseaction=administration&fusesubaction=#fusesubaction#" target="showkids" onclick="fdbackwindow=window.open ('','showkids','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=600,top=10,left=10')">#activekids.total#</a></td>
	<td valign="top" style="padding-right:10px;" align="center">#jobsdone.total#</td>
	<td align="right" valign="top"><a href="#request.webroot#/administration/dsp_bizidea_edit.cfm?bizideaID=#bizideaid#&fuseaction=administration&fusesubaction=#fusesubaction#" target="editbusiness" onclick="fdbackwindow=window.open ('','editbusiness','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=850,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Business" border="0"></a>&nbsp;<a href="javascript:confirmAdministratorDelete('#request.webroot#/administration/act_remove_bizidea.cfm?bizideaid=#bizideaid#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Business" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	

</td>
</tr>

</table>


</cfoutput>