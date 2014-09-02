<cfquery name="Updaterequest" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE RewardTransactions
SET RewardTrans_Status='#form.RewardTrans_Status#',

<cfif IsDate("#form.Shipped_Date#")>
	Shipped_Date=#createODBCDate(form.Shipped_Date)#,
<cfelse>
	Shipped_Date=NULL,
</cfif>

Shipped_Details='#form.Shipped_Details#'

WHERE RewardTransID=#RewardTransID#
</cfquery>


<cfoutput>


<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    alert("Reward request has been updated.");
	window.opener.document.location = givenURL;
	self.close();
}

// -->
</script>

<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_reward_requests')">


</cfoutput>


