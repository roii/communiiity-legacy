<cfoutput>

<cfparam name="shoppers_sortby" default="bizideaID">
<cfparam name="sortorder" default="DESC">

<script language="JavaScript">
<!--
function confirmAdministratorDelete(aURL) {
    if(confirm('Are you sure you want to delete this BizIdea?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<cfquery name="allpribiz" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM Business 
WHERE Business.BizStatus LIKE '%Active%' 
AND bizideaID = 0
ORDER BY bizideaid desc
</cfquery>

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE PRIVATE BUSINESSES</strong></td>
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
<a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;">
<strong>MANAGE BUSINESS &raquo;</strong></a>&nbsp;&nbsp;
<hr width="100%" size="1" color="e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
	<tr>
	<td nowrap style="padding-right:10px;"><b>Business</b></td>
	<td nowrap style="padding-right:10px;"><b>User</b></td>
	<td nowrap style="padding-right:10px;"><b>Profit</b></td>
	<td nowrap style="padding-right:10px;"><b>Avg.Profit/Hr</b></td>
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

	
	<cfloop query="allpribiz">
	
	<cfquery name="allprofit" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT sum(income1_amount+income2_amount+income3_amount+income4_amount+income5_amount) as total
		FROM biztransaction bt,bizkidslink bz 
		WHERE bt.bizkidslinkid = bz.bizkidslinkid and clientid <> 0
		and bz.bizid=#allpribiz.bizid#
    </cfquery>
	
	<cftry>
	
		<cfquery name="avgprofit" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT (income1_amount+income2_amount+income3_amount+income4_amount+income5_amount)/hours as avg_hr
		FROM biztransaction bt,bizkidslink bz 
		WHERE bt.bizkidslinkid = bz.bizkidslinkid and clientid <> 0
		and bz.bizid=#allpribiz.bizid#
	    </cfquery>
	
	<cfcatch>
		
		<cfquery name="avgprofit" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT (income1_amount+income2_amount+income3_amount+income4_amount+income5_amount)/1 as avg_hr
		FROM biztransaction bt,bizkidslink bz 
		WHERE bt.bizkidslinkid = bz.bizkidslinkid and clientid <> 0
		and bz.bizid=#allpribiz.bizid#
	    </cfquery>
	
	</cfcatch>
	</cftry>
	
	<cfquery name="userqry" datasource="#dsn#" username="#request.username#" password="#request.password#">
		select firstname, lastname 
		from bizkidslink, contacts 
		where contacts.contactid = bizkidslink.kidsid
        and bizkidslink.bizkidslinkid = #allpribiz.bizid#
    </cfquery>
	
	<cfif userqry.RecordCount>
	<tr>
	<td valign="top" style="padding-right:10px;">#allpribiz.bizname#</td>
	<td valign="top" style="padding-right:10px;">#userqry.firstname# #userqry.lastname#</td>
	<td valign="top" style="padding-right:10px;">#dollarformat(allprofit.total)#</td>
	<td valign="top" style="padding-right:10px;">#dollarformat(avgprofit.avg_hr)#</td>
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
	</cfif>
	</cfloop>
	
	</table>
	

</td>
</tr>

</table>


</cfoutput>