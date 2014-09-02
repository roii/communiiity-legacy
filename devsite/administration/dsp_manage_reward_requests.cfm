<cfoutput>

<cflock Type="exclusive" scope="session" timeout="10">

	<cfparam name="session.RequestSortBy" default="RewardTransactions.RewardTrans_Date">
	<cfif IsDefined("RequestSortBy")>
		<cfset session.RequestSortBy=RequestSortBy>
	</cfif>
	
	<cfparam name="session.RequestSortMode" default="DESC">
	<cfif IsDefined("RequestSortMode")>
		<cfset session.RequestSortMode=RequestSortMode>
	</cfif>
	
	<cfparam name="session.Requests_StartRow" default="1">
	<cfif isdefined("Requests_StartRow")>	
			<cfset session.Requests_StartRow = Requests_StartRow>
	</cfif>
		
	<cfparam name="session.Requests_MaxRows" default="50">
	<cfif isdefined("Requests_MaxRows")>	
		<cfset session.Requests_MaxRows = Requests_MaxRows>
	</cfif>
		
	<cfparam name="session.Requests_DisplayOnly" default="Pending">
	<cfif isdefined("Requests_DisplayOnly")>	
		<cfset session.Requests_DisplayOnly = Requests_DisplayOnly>
	</cfif>

</cflock>

<script language="JavaScript">
<!--
function confirmRewardRequestDelete(aURL) {
    if(confirm('Are you sure you want to delete this Reward Request?')) {
      location.href = aURL;
    }
  }
//-->
<!--
function confirmRewardRequestReverse(aURL) {
    if(confirm('Are you sure you want to reverse this Reward Request?')) {
      location.href = aURL;
    }
  }
//-->
</script>

<cfinclude template="qry_reward_requests.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="*" style="font-size:12px;color:###TRIM(session.AllSettings_DkTextColor)#" height="20"><strong>MANAGE REWARD REQUESTS</strong></td>
<td align="right" width="100"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

</table><br>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>Current Listing: <strong style="color:black">#session.Requests_DisplayOnly#</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Display - <cfif session.Requests_DisplayOnly NEQ 'All'><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_DisplayOnly=ALL&Requests_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">ALL Requests</a> | </cfif><cfif session.Requests_DisplayOnly NEQ 'Pending'><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_DisplayOnly=Pending&Requests_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">Pending</a> | </cfif><cfif session.Requests_DisplayOnly NEQ 'Shipped'><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_DisplayOnly=Shipped&Requests_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">Shipped</a></cfif></td>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_maxrows=20&Requests_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_maxrows=50&Requests_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_maxrows=100&Requests_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_maxrows=ALL&Requests_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">ALL</a></td>
</tr>

<tr>
<td colspan="2">

<hr width="100%" size="1" color="e2e2e2">

<cfif qry_reward_requests.recordcount>

	<!--- SET THE Requests_endrow VALUE --->
	<cfif session.Requests_MaxRows NEQ 'ALL'>	
		<cfif qry_reward_requests.RecordCount GT (session.Requests_StartRow+session.Requests_MaxRows)-1>
			<cfset Requests_endrow = session.Requests_StartRow+session.Requests_MaxRows-1>
		<cfelse>
			<cfset Requests_endrow = qry_reward_requests.RecordCount>
		</cfif>	
	<cfelse>
		<cfset Requests_endrow = qry_reward_requests.RecordCount>	
	</cfif>	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.Requests_Startrow GT session.Requests_Maxrows>
		<cfset prev = session.Requests_Startrow-session.Requests_Maxrows>	
	<cfelse>
		<cfset prev = session.Requests_StartRow>	
	</cfif>	
	
	<!--- SET THE NEXT VALUE --->
	<cfif Requests_endrow LT qry_reward_requests.RecordCount>
		<cfset next = (Requests_endrow+1)>	
	<cfelse>
		<cfset next = session.Requests_StartRow>	
	</cfif>	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.Requests_MaxRows NEQ 'ALL'>	
		<cfset NumberCount=(qry_reward_requests.RecordCount/session.Requests_Maxrows)>
		<cfset RequestsNumberCount=Ceiling(NumberCount)>	
	<cfelse>	
		<cfset RequestsNumberCount=1>		
	</cfif>
	
	<table cellSpacing="0" cellPadding="0" border="0" width="100%">
	
	<tr>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&RequestSortBy=RewardTransactions.RewardTrans_Date&RequestSortMode=<cfif session.RequestSortMode EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Date</strong></a></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&RequestSortBy=RewardTransactions.RewardTrans_Status&RequestSortMode=<cfif session.RequestSortMode EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Status</strong></a></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&RequestSortBy=Contacts.FirstName&RequestSortMode=<cfif session.RequestSortMode EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Member</strong></a></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&RequestSortBy=Prize_Pool.Description&RequestSortMode=<cfif session.RequestSortMode EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Reward</strong></a></td>
	<td style="font-size:11px;" align="center"><b>In Stock</b></td>
	<td style="font-size:11px;" align="right"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&RequestSortBy=Prize_Pool.pointsvalue&RequestSortMode=<cfif session.RequestSortMode EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Pts Value</strong></a></td>
	<td> </td>
	</tr>
	
	<tr>
	<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
	<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
	<td width="120" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"></td>
	<td width="120" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"></td>
	<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
	<td width="80" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
	<td width="50" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfset total_points = 0>
	
	<cfloop query="qry_reward_requests" startrow="#session.Requests_StartRow#" endrow="#Requests_endrow#">
	
	<cfset this_RewardTransID = qry_reward_requests.RewardTransID>
	<cfset this_rewardID = qry_reward_requests.RewardID>
	<cfset this_quantity = qry_reward_requests.Quantity>
	<cfset this_date = qry_reward_requests.RewardTrans_Date>
	<cfset this_status = qry_reward_requests.RewardTrans_Status>
	<cfset this_contactID = qry_reward_requests.contactID>
	<cfset this_member = "#TRIM(qry_reward_requests.FirstName)# #TRIM(qry_reward_requests.lastName)#">
	<cfset this_reward = qry_reward_requests.Description>
	<cfset this_value = qry_reward_requests.pointsvalue>	

	<cfquery name="TotalSold" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM RewardTransactions 
	WHERE RewardID=#this_rewardID#
	</cfquery>
	
	<cfif TotalSold.RecordCount>
		<cfset remainingStock = (this_quantity - TotalSold.RecordCount)>
	<cfelse>
		<cfset remainingStock = this_quantity>
	</cfif> 
	
	
	<cfquery name="PointsIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalPointsIn
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsIn.TotalPointsIn#")>
		<cfset TotalUserPointsIn = INT(PointsIn.TotalPointsIn)>
	<cfelse>
		<cfset TotalUserPointsIn = 0>
	</cfif>
	
	<cfquery name="PointsOut" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalPointsOut
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%debit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsOut.TotalPointsOut#")>
		<cfset TotalUserPointsOut = INT(PointsOut.TotalPointsOut)>
	<cfelse>
		<cfset TotalUserPointsOut = 0>
	</cfif>
	
	<cfset user_points = INT(TotalUserPointsIn - TotalUserPointsOut)>
	
	
	
	
	
	<tr>
	<td valign="top" style="font-size:11px;">#DateFormat(this_date)#</td>
	<td valign="top" style="font-size:11px;">#TRIM(this_status)#</td>
	<td valign="top" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_contact_details_popup.cfm?contactID=#this_contactID#&rewardID=#this_rewardID#" target="ContactDetails" onclick="fdbackwindow=window.open ('','ContactDetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=450,top=10,left=10')">#TRIM(this_member)#</a> (#user_points#)</td>
	<td valign="top" style="font-size:11px;">#TRIM(this_reward)#</td>
	<td valign="top" style="font-size:11px;" align="center">#remainingStock#</td>
	<td valign="top" style="font-size:11px;" align="right">#INT(this_value)#</td>
	<td align="right" valign="top" style="font-size:11px;"><a href="#request.webroot#/administration/dsp_edit_rewardrequest.cfm?RewardTransID=#this_RewardTransID#" target="EditRequest" onclick="fdbackwindow=window.open ('','EditRequest','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Request" border="0"></a> <a href="javascript:confirmRewardRequestDelete('#request.webroot#/administration/act_del_reward_request.cfm?RewardTransID=#this_RewardTransID#');"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Reward Request" border="0"></a> <a href="javascript:confirmRewardRequestReverse('#request.webroot#/administration/act_rev_reward_request.cfm?RewardTransID=#this_RewardTransID#');"><img src="images/but_reverse_icon.gif" width="10" height="10" alt="Reverse Reward Request" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfset total_points = total_points + this_value>
	
	</cfloop>	
	
	<tr>
	<td valign="top" colspan="6" style="font-size:11px;" align="right"><strong>TOTAL: &nbsp; <strong>#INT(total_points)#</strong></td>
	<td align="right" valign="top" style="font-size:11px;"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</table>
	
	
	<div align="right"><cfif session.Requests_Startrow GT session.Requests_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_Startrow=#prev#">Prev Page</a> | </cfif><cfif Requests_endrow LT qry_reward_requests.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Requests_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#RequestsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Requests_Maxrows*NumberCount-session.Requests_Maxrows+1)><cfif thisStartRow EQ session.Requests_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Requests_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Requests_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ RequestsNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>
	
<cfelse>
<br>
There are no <cfif IsDefined("Requests_DisplayOnly") AND Requests_DisplayOnly NEQ 'ALL'><strong>#Requests_DisplayOnly#</strong></cfif> reward requests.	
	
</cfif>

</td>
</tr>

</table>

</cfoutput>