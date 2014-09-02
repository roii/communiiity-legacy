<!--- GET REQUEST DETAILS --->
<cfquery name="requestStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM RewardTransactions
WHERE RewardTransID=#RewardTransID#
</cfquery>
	
	
<cftransaction action="BEGIN">

<cftry>

	<!--- REMOVE DEBIT POINTS TRANSACTION TO GIVE POINTS BACK TO MEMBER ACCOUNT --->
	<cfquery name="deletePointsTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contact_transactions
	WHERE Transaction_Type LIKE '%Debit%'
	AND Related_Description LIKE '%RewardRequest%'
	AND Related_Identifier=#RewardTransID#
	AND ContactID=#requestStuff.ContactID#
	</cfquery>	
	
	<!--- DELETE REQUEST --->
	<cfquery name="deleterequest" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM RewardTransactions
	WHERE RewardTransID=#RewardTransID#
	</cfquery>
	
	<cftransaction action="commit" />

<cfcatch>
	<cftransaction action="rollback" />
</cfcatch>
</cftry>

</cftransaction>

<cfoutput>
<script type="text/javascript">
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_reward_requests";
</script>
</cfoutput>