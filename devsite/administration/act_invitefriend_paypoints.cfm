<!--- GET DRAW DETAILS --->
<cfquery name="qry_draw_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM InviteFriendPrizes 
WHERE DrawID = #DrawID#
</cfquery>


<cfif TRIM(qry_draw_details.type) EQ 'Day'>
	<cfset desc_insert = 'Winner of Daily Invite-a-Friend prize'>
	<cfset txt = 'Daily Invite-a-Friend'>
<cfelseif TRIM(qry_draw_details.type) EQ 'Week'>
	<cfset desc_insert = 'Winner of Weekly Invite-a-Friend prize'>
	<cfset txt = 'Weekly Invite-a-Friend'>
<cfelse>
	<cfset desc_insert = 'Winner of Monthly Invite-a-Friend prize'>
	<cfset txt = 'Monthly Invite-a-Friend'>
</cfif>


<!--- LOOP WINNERS --->
<cfloop list="#qry_draw_details.Winners#" index="loopitem" delimiters=",">

	<!--- GET WINNER DETAILS --->
	<cfquery name="WinnerDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, Firstname, mobilePhone, EmailAddress
	FROM Contacts 
	WHERE ContactID=#loopitem#
	</cfquery>
	
	
	<!--- INSERT THE TRANSACTION --->	
	<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, RoyaltyPaid, Related_Identifier, Related_Description, PointsType)
	VALUES(#WinnerDetails.contactID#, #CreateODBCDate(qry_draw_details.start_date)#, 'Credit', #qry_draw_details.pointsperwinner#, '#desc_insert#', 'Points', 0, 0, '#WinnerDetails.contactID#', '#desc_insert#', 'Earned')
	</cfquery>
	
	<!--- SEND ALERTS
	{first_name}
	{prize_name} --->
	
	 <!--- GET THE ALERT DETAILS --->
	<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM EmailAlerts
	WHERE AlertID=18
	</cfquery>
	
	
	<!--- CREATE MESSAGE - REPLACE {first_name} --->
	<cfset this_subject = ReplaceNoCase(AlertStuff.AlertSubject, '{first_name}', '#TRIM(WinnerDetails.Firstname)#', "ALL")>
	<cfset this_message = ReplaceNoCase(AlertStuff.AlertDetails, '{first_name}', '#TRIM(WinnerDetails.Firstname)#', "ALL")>
	<cfset sms_message = ReplaceNoCase(AlertStuff.SMSDetails, '{first_name}', '#TRIM(WinnerDetails.Firstname)#', "ALL")>
		
	<!--- CREATE MESSAGE - REPLACE {prize_name} --->
	<cfset this_subject = ReplaceNoCase(this_subject, '{prize_name}', '#TRIM(txt)#', "ALL")>
	<cfset this_message = ReplaceNoCase(this_message, '{prize_name}', '#TRIM(txt)#', "ALL")>
	<cfset sms_message = ReplaceNoCase(sms_message, '{prize_name}', '#TRIM(txt)#', "ALL")>
	
	
	<!--- SEND THE PLAIN EMAIL		 --->	
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
		<cfset sms_message = sms_message & "#chr(10)#----#chr(10)#" & "#TRIM(DefaultTag.TagLine)#">
			
			
		<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false" timeout="600">
		<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
		<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
		<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
		<cfhttpparam type="FORMFIELD" name="text" value="#sms_message#">
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
		VALUES(#newid#, 9999999, #CreateODBCDateTime(localdatetime)#, '#this_mobilenumber#', '6421319911', '#sms_message#')
		</cfquery>
		
	
	</cfif>
	
	
	
</cfloop>



<!--- UPDATE DRAW AS PAID --->
<cfquery name="updateqry_draw_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE InviteFriendPrizes  
SET PointsPaid=1
WHERE DrawID = #DrawID#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=invite_friend">