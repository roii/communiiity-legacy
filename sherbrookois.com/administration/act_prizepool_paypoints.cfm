<!--- GET PRIZE DETAILS --->
<cfquery name="PrizeStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE prizepoolID = #prizepoolID#
</cfquery>

<cfif PrizeStuff.InviteFriend EQ 1>
	<cfset desc_insert = 'Winner of daily Invite Friend prize'>
<cfelse>
	<cfset desc_insert = 'Winner of daily points draw'>
</cfif>

<!--- GET WINNER DETAILS --->
<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, Firstname, mobilePhone, EmailAddress
FROM Contacts 
WHERE ContactID = #PrizeStuff.winner#
</cfquery>

<!--- INSERT THE TRANSACTION --->	
<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, RoyaltyPaid, Related_Identifier, Related_Description, PointsType)
VALUES(#WinnerDetails.contactID#, #CreateODBCDate(PrizeStuff.draw_date)#, 'Credit', #PrizeStuff.pointsvalue#, '#desc_insert#', 'Points', 0, 0, '#WinnerDetails.contactID#', '#desc_insert#', 'Earned')
</cfquery>

<!--- UPDATE PRIZE AS PAID --->
<cfquery name="updatePrizeStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE prize_pool 
SET PointsPaid=1
WHERE prizepoolID = #prizepoolID#
</cfquery>

<!--- SEND ALERTS
{first_name}
{prize_name}
 --->

 <!--- GET THE ALERT DETAILS --->
<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM EmailAlerts
WHERE AlertID=18
</cfquery>

<!--- CREATE MESSAGE - REPLACE {firstname} --->
<cfset this_subject = ReplaceNoCase(AlertStuff.AlertSubject, '{first_name}', '#TRIM(WinnerDetails.Firstname)#', "ALL")>
<cfset this_message = ReplaceNoCase(AlertStuff.AlertDetails, '{first_name}', '#TRIM(WinnerDetails.Firstname)#', "ALL")>
		
<!--- CREATE MESSAGE - REPLACE {balance} --->
<cfset this_subject = ReplaceNoCase(this_subject, '{prize_name}', '#TRIM(PrizeStuff.name)#', "ALL")>
<cfset this_message = ReplaceNoCase(this_message, '{prize_name}', '#TRIM(PrizeStuff.name)#', "ALL")>


<!--- SEND THE PLAIN EMAIL --->				
<cfmail server="#application.emailserver#" to="#TRIM(WinnerDetails.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(this_subject)#">#TRIM(this_message)#</cfmail>


<cfset this_mobilenumber = REReplace(WinnerDetails.mobilePhone, '[^0-9]+', '', 'all')>

<!--- CHECK IF THEY HAVE A MOBILE NUMBER --->
<cfif IsNumeric("#this_mobilenumber#")>

	 <!--- GET DEFAULT TAGLINE --->
	<cfquery name="DefaultTag" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT TagLine
	FROM SMS_Taglines
	WHERE DefaultTag=1
	AND TagType LIKE '%Normal%'
	</cfquery>

	
	<!--- CREATE MESSAGE - ADD TAGLINE --->
	<cfset this_message = this_message & "#chr(10)#----#chr(10)#" & "#TRIM(DefaultTag.TagLine)#">
		
		
	<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false" timeout="600">
	<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
	<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
	<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
	<cfhttpparam type="FORMFIELD" name="text" value="#this_message#">
	<cfhttpparam type="FORMFIELD" name="to" value="#this_mobilenumber#">
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
	VALUES(#newid#, 9999999, #CreateODBCDateTime(localdatetime)#, '#this_mobilenumber#', '6421319911', '#this_message#')
	</cfquery>
	

</cfif>



<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes">