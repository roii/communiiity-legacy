<!--- GET RECORD TO UPDATE --->
<cfquery name="qry_trans" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT *
FROM PurchasePoints
WHERE TransactionID=#TransactionID#
</cfquery>	
	
<!--- UPDATE RECORD IN POINTS PURCHASE TABLE AS AUTHORISED --->
<cfquery name="act_update_pointspurchase" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE PurchasePoints
SET TransactionStatus='Authorised',
AuthoriseDate=#CreateODBCDateTime(localDateTime)#
WHERE TransactionID=#TransactionID#
</cfquery>

<!--- ALLOCATE POINTS TO ACCOUNT --->
<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, RoyaltyPaid, PointsType)
VALUES(#qry_trans.ContactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #qry_trans.PointsAmount#, 'Points Purchased via #qry_trans.TransactionType#', 'Points', 0, 0, 'Purchased')
</cfquery>


<!--- GET MEMBERS MOBILE --->
<cfquery name="qry_memberstuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT MobilePhone, FirstName
FROM Contacts
WHERE ContactID=#qry_trans.ContactID#
</cfquery>


<!--- CHECK IF THEY HAVE A VALID MOBILE NUMBER --->
<cfif TRIM(qry_memberstuff.mobilePhone) NEQ '' AND IsNumeric("#qry_memberstuff.mobilePhone#")>

	 <!--- GET DEFAULT TAGLINE --->
	<cfquery name="DefaultTag" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT TagLine
	FROM SMS_Taglines
	WHERE DefaultTag=1
	AND TagType LIKE '%Normal%'
	</cfquery>
	
	<!--- CREATE MESSAGE - ADD TAGLINE --->
	<cfset this_message = "Hi #TRIM(qry_memberstuff.FirstName)# yr $#NumberFormat(qry_trans.DollarValue, "0")# pts purchase is all gud! #INT(qry_trans.PointsAmount)#pts now paid 2 yr my3P pts account...thanks!" & "#chr(10)#----#chr(10)#" & "#TRIM(DefaultTag.TagLine)#">		
		
	<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false" timeout="600">
	<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
	<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
	<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
	<cfhttpparam type="FORMFIELD" name="text" value="#this_message#">
	<cfhttpparam type="FORMFIELD" name="to" value="#TRIM(qry_memberstuff.mobilePhone)#">
	<cfhttpparam type="FORMFIELD" name="from" value="6421319911">
	</cfhttp>


	<!--- LOG TXT --->
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT TxtLogID
	FROM TxtLog
	ORDER BY TxtLogID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.TxtLogID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>		
	
	<!--- LOG TXT --->
	<cfquery name="LogTxtMessage" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO TxtLog(TxtLogID, ContactID, TxtDateTime, TxtTo, TxtFrom, TxtMsg)
	VALUES(#newid#, 9999999, #CreateODBCDateTime(localdatetime)#, '#TRIM(qry_memberstuff.mobilePhone)#', '6421319911', '#this_message#')
	</cfquery>

</cfif>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=pointspurchases">