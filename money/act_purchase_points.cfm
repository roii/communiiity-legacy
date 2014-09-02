<!--- CREATE UNIQUE IDENTIFIER --->
	<cfset verificationcode = "">
	<cfset chars1 = "abcdefghjkmnoprstwxyz0123456789">
	<cfloop index="indx1" from="1" to="9">
		<cfset rnum = RANDRANGE(1,36)>
		<cfset verificationcode = (verificationcode & MID(chars1,rnum,1))>
	</cfloop>
	
	
<!--- IF BANK PURCHASE --->
<cfif IsDefined("form.action") AND form.action EQ 'bank'>	
	
	<!--- SAVE RECORD IN POINTS PURCHASE TABLE --->
	<cfquery name="act_add_pointspurchase" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO PurchasePoints(TransactionType, TransactionStatus, StartDate, PointsAmount, DollarValue, TransactionCurrency, ContactID, ScreenName, Identifier)
	VALUES('Bank', 'Pending', #createODBCDateTime(localDateTime)#, #form.PointsAmount#, #DollarFormat(form.PointsAmount/100)#, 'NZD', #session.UserID#, '#session.User_ScreenName#', '#verificationcode#')
	</cfquery>

	<cflocation url="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentID=122&PurchaseMode=Step2Bank">


<!--- IF PAYPAL PURCHASE --->
<cfelseif IsDefined("form.action") AND form.action EQ 'paypal'>

	<!--- SAVE RECORD IN POINTS PURCHASE TABLE --->
	<cfquery name="act_add_pointspurchase" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO PurchasePoints(TransactionType, TransactionStatus, StartDate, PointsAmount, DollarValue, TransactionCurrency, ContactID, ScreenName, Identifier)
	VALUES('PayPal', 'Pending', #createODBCDateTime(localDateTime)#, #form.PointsAmount#, #DollarFormat(form.PointsAmount/100)#, 'NZD', #session.UserID#, '#session.User_ScreenName#', '#verificationcode#')
	</cfquery>

	<cflocation url="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentID=122&PurchaseMode=Step2PayPal">




</cfif>
