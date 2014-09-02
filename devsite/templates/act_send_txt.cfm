<!--- CHECK THEY LOGGED IN 
IF NOT REDIRECT--->
<cfif session.UserIsAuthenticated EQ 'No'>

	<script>
	alert("You need to be logged-in to send a TXT.");
	history.back();
	</script>
	
	<cfabort>

</cfif>


<cfif session.UserType EQ 'Administrator'>
	
	<!--- ADD TAG LINE TO MESSAGE --->
	<cfset tagged_msg = "#form.TxtMsg##chr(10)#----#chr(10)#Go to my3p.com to snd yr free sms msgs">
	
<cfelse>

	<!--- CHECK THEY HAVE ENOUGH POINTS --->
	<cfquery name="PointsIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalPointsIn
	FROM contact_transactions
	WHERE ContactID = #session.UserID#
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
	WHERE ContactID = #session.UserID#
	AND Transaction_Type LIKE '%debit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsOut.TotalPointsOut#")>
		<cfset TotalUserPointsOut = INT(PointsOut.TotalPointsOut)>
	<cfelse>
		<cfset TotalUserPointsOut = 0>
	</cfif>
	
	
	<cfset user_points = INT(TotalUserPointsIn-TotalUserPointsOut)>
	
	
	<cfif user_points LT 20>
	
		<cfoutput>
		
		<script>
		alert("You don't have enough points to send a TXT.\nYour current points balance is #user_points# pts");
		history.back();
		</script>
		
		</cfoutput>		
		<cfabort>	
	
	</cfif>
	
	
	<!--- LOG MESSAGE --->
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
	
	
	<!--- ADD TAG LINE TO MESSAGE --->
	<cfset tagged_msg = "#form.TxtMsg##chr(10)#----#chr(10)#Go to my3p.com to snd yr free sms msgs">
	
	
	<!--- LOG TXT --->
	<cfquery name="LogTxtMessage" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO TxtLog(TxtLogID, ContactID, TxtDateTime, TxtTo, TxtFrom, TxtMsg)
	VALUES(#newid#, #session.UserID#, #CreateODBCDateTime(localdatetime)#, '#form.TxtTo#', '#form.TxtFrom#', '#tagged_msg#')
	</cfquery>
	
	
	<!--- PROCESS POINTS TRANSACTION --->
	<cftransaction action="BEGIN">	
			
	<!--- INSERT THE TRANSACTION --->
	
	<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_description, RoyaltyPaid)
	VALUES(#session.UserID#, #CreateODBCDateTime(localDateTime)#, 'Debit', 20, 'Txt Msg: #form.TxtTo#', 'Points', 0, #session.UserID#, 'Txt Msg', 0)
	</cfquery>
	
	</cftransaction>

	
</cfif>
	
<!--- SEND MESSAGE --->
<cfoutput>

<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false">
<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
<cfhttpparam type="FORMFIELD" name="text" value="#tagged_msg#">
<cfhttpparam type="FORMFIELD" name="to" value="#form.TxtTo#">
<cfhttpparam type="FORMFIELD" name="from" value="#form.TxtFrom#">
</cfhttp>


<script>
alert("Your TXT has been sent to #form.TxtTo#.");
history.back(-2);
</script>

</cfoutput>