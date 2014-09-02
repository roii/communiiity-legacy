<cfparam name="attributes.bizkidslinkid" default="0">
<cfparam name="attributes.transactionID" default="0">

<cfquery name="Currentbiz" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT * 
FROM Business, bizKidsLink
WHERE bizKidsLink.kidsid=#session.UserID#
AND Business.bizID=bizKidsLink.bizID

<cfif session.InActiveMode EQ 'Hide'>
	AND Business.BizStatus LIKE 'Active'
</cfif>

ORDER BY Business.bizid desc
</cfquery>


<cfif attributes.bizkidslinkID NEQ "0">

	<cfquery name="CurrentBizDetail" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT * FROM Business, bizKidsLink
	WHERE bizKidsLink.kidsid=#session.UserID#
	AND Business.bizID=bizKidsLink.bizID
	AND bizkidslink.bizkidslinkid=#attributes.bizkidslinkid#
	</cfquery>
	
	<cfquery name="AllTransactions" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT * 
	FROM bizTransaction 
	WHERE bizkidslinkid=#attributes.bizkidslinkid#
	ORDER BY transactionID DESC
	</cfquery>

</cfif>


<cfif attributes.transactionID NEQ "0">
	
	<cfquery name="TranDetail" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT * 
	FROM bizTransaction 
	WHERE transactionid=#attributes.transactionid#
	</cfquery>
  
</cfif>