<!--- GET RECORD TO UPDATE --->
<cfquery name="qry_transID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM PurchasePoints
WHERE TransactionID=#TransactionID#
</cfquery>


<cfoutput>
<cfset logdetails = 'Delete Points Purchase - (Trans Date:#TRIM(qry_transID.StartDate)# - Trans Status:#TRIM(qry_transID.TransactionStatus)# - Points:#qry_transID.PointsAmount# - Member:#qry_transID.ScreenName#)'>
</cfoutput>

<cfinclude template="act_adminlog.cfm">	
	
<!--- DELETE RECORD FROM POINTS PURCHASE TABLE --->
<cfquery name="act_delete_pointspurchase" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM PurchasePoints
WHERE TransactionID=#TransactionID#
</cfquery>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=pointspurchases">