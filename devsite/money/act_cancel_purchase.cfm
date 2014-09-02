<!--- DELETE RECORD FROM POINTS PURCHASE TABLE --->
<cfquery name="act_cancel_pointspurchase" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM PurchasePoints
WHERE TransactionStatus='Pending'
AND ContactID=#session.UserID#
</cfquery>

<cfoutput>

<script type="text/javascript">
alert('Your points purchase transaction has been cancelled.');
self.location="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentID=122";
</script>

</cfoutput>