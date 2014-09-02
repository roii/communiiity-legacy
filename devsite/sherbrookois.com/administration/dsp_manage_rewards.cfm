<cfoutput>

<cfparam name="session.RewardSortBy" default="quantity">
<cfif IsDefined("RewardSortBy")>
	<cfset session.RewardSortBy=RewardSortBy>
</cfif>

<cfparam name="session.RewardSortMode" default="DESC">
<cfif IsDefined("RewardSortMode")>
	<cfset session.RewardSortMode=RewardSortMode>
</cfif>

<script language="JavaScript">
<!--
function confirmRewardDelete(aURL) {
    if(confirm('Are you sure you want to delete this Prize?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<cfinclude template="qry_rewards.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="*" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE REWARDS</strong></td>
<td align="right" width="100"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td style="font-size:11px;"><a href="#request.webroot#/administration/dsp_add_reward.cfm" target="AddReward" onclick="fdbackwindow=window.open ('','AddReward','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=550,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A REWARD &raquo;</strong></a></td>
<td></td>
</tr>

</table><br>





<cfif qry_rewards.recordcount>

<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="padding-right:10px;font-size:11px;"><b>Name</b></td>
<td style="padding-right:10px;font-size:11px;"><b>Desc.</b></td>
<td align="center" style="font-size:11px;"><b>Country</b></td>
<td align="center" style="font-size:11px;"><b>Points</b></td>
<td align="center" style="font-size:11px;"><b>Sold</b></td>
<td align="center" style="font-size:11px;"><b>Avail.</b></td>
<td align="center" style="font-size:11px;"><b>Display</b></td>
<td> </td>
</tr>

<tr>
<td width="130" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0"></td>
<td width="*" height="2"> </td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
<td width="70" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="70" height="1" border="0"></td>
<td width="40" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="40" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
</tr>

<tr>
<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<cfloop query="qry_rewards">

<cfset this_RewardID = qry_rewards.PrizePoolID>
<cfset this_Country = INT(qry_rewards.Country)>
<cfset this_value = qry_rewards.pointsvalue>
<cfset this_quantity = qry_rewards.quantity>


<cfif this_Country NEQ 0>
	
	<cfquery name="CountryDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Name
	FROM Countries 
	WHERE CountryID=#this_Country#
	</cfquery>
	
</cfif>

<cfquery name="TotalSold" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM RewardTransactions 
WHERE RewardID=#this_RewardID#
</cfquery>

<cfif TotalSold.RecordCount>
	<cfset remainingStock = (this_quantity - TotalSold.RecordCount)>
<cfelse>
	<cfset remainingStock = this_quantity>
</cfif> 

<tr>
<td valign="top" style="padding-right:10px;font-size:11px;">#TRIM(qry_rewards.Name)#</td>
<td valign="top" style="font-size:11px;">#TRIM(qry_rewards.Description)#</td>
<td valign="top" align="center" style="font-size:11px;"><cfif this_Country NEQ 0>#TRIM(CountryDetails.Name)#<cfelse>All Countries</cfif></td>
<td valign="top" align="center" style="font-size:11px;">#INT(qry_rewards.pointsvalue)#</td>
<td valign="top" align="center" style="font-size:11px;">#INT(TotalSold.RecordCount)#</td>
<td valign="top" align="center" style="font-size:11px;">#remainingStock#</td>
<td valign="top" align="center" style="font-size:11px;">#YesNoFormat(qry_rewards.Display)#</td>
<td align="right" valign="top" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_edit_reward.cfm?rewardID=#this_RewardID#" target="EditReward" onclick="fdbackwindow=window.open ('','EditReward','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Reward" border="0"></a> <a href="javascript:confirmRewardDelete('#request.webroot#/administration/act_del_reward.cfm?RewardID=#this_RewardID#');"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Reward" border="0"></a></td>
</tr>

<tr>
<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>


</table><br><br>
</cfif>


</cfoutput>