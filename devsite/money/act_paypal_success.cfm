<!--- GET RECORD TO UPDATE --->
<cfquery name="qry_transID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT TransactionID, PointsAmount, Identifier, DollarValue
FROM PurchasePoints
WHERE ContactID=#session.UserID#
AND TransactionStatus='Pending'
ORDER BY TransactionID DESC
</cfquery>

<cfset authToken="kQY_TBSS2eeYvE9wjY9U5-94LmUc4YaBE7APKM-v5vjxugqqlXdRPG5DYiy">
<cfset txToken = url.tx>
<cfset query="cmd=_notify-synch&tx=" & txToken & "&at=" & authToken>

<cfhttp url="https://www.paypal.com/cgi-bin/webscr?#query#" method="GET" resolveurl="false"></cfhttp>

<cfif left(cfhttp.FileContent,7) is "success"> 

	<cfloop list="#cfhttp.FileContent#" index="curLine" delimiters="#chr(10)#">
	
	<cfif listGetAt(curLine, 1, "=") is "first_name">
		<cfset firstName=listGetAt(curLine, 2, "=")>
	</cfif>
	<cfif listGetAt(curLine, 1, "=") is "last_name">
		<cfset lastName=listGetAt(curLine, 2, "=")>
	</cfif>
	<cfif listGetAt(curLine, 1, "=") is "item_name">
		<cfset itemName=listGetAt(curLine, 2, "=")>
	</cfif>
	<cfif listGetAt(curLine, 1, "=") is "mc_gross">
		<cfset mcGross=listGetAt(curLine, 2, "=")>
	</cfif>
	<cfif listGetAt(curLine, 1, "=") is "mc_currency">
		<cfset mcCurrency=listGetAt(curLine, 2, "=")>
	</cfif>
	
	</cfloop>
		
	
	<cfset TransactionAmount = qry_transID.DollarValue>
	<cfset NewPointsValue = qry_transID.PointsAmount>
	
	
	<!--- UPDATE RECORD IN POINTS PURCHASE TABLE AS AUTHORISED --->
	<cfquery name="act_update_pointspurchase" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE PurchasePoints
	SET TransactionStatus='Authorised',
	
	<cfif IsDefined("NewPointsValue")>
		PointsAmount=#NewPointsValue#,
	</cfif>
	
	DollarValue=#TransactionAmount#,
	AuthoriseDate=#CreateODBCDateTime(localDateTime)#
	WHERE TransactionID=#qry_transID.TransactionID#
	</cfquery>				
	
	<!--- ALLOCATE POINTS TO ACCOUNT --->
	<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, RoyaltyPaid, PointsType)
	VALUES(#session.UserID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #NewPointsValue#, 'Points Purchased via PayPal', 'Points', 0, 0, 'Purchased')
	</cfquery>
	
	<cflocation url="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentID=122&PurchaseMode=paymentconfirmed">		
	<cfabort>
	

<cfelse>

	
	<cfoutput>
	
	<!-- log for investigation -->
	<script type="text/javascript">
	alert("There was a problem processing your payment.\nThe credit card details entered returned an invalid response.\nPlease contact payments@my3p.com and quote your\nScreen Name and the following reference number... #TRIM(qry_transID.Identifier)#... for further assistance.");
	self.location="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentID=122";
	</script>
	
	</cfoutput>
	
	<cfabort>
	
	
</cfif>
