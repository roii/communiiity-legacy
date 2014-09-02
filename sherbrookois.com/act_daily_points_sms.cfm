<cfoutput>

<!--- GET ALL MEMBERS --->
<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, mobilePhone
FROM Contacts
WHERE ContactStatus LIKE '%Active%'
ORDER BY ContactID
</cfquery>


<!--- GET THE ALERT DETAILS --->
<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SMSDetails
FROM EmailAlerts
WHERE AlertID=19
</cfquery>


<!--- GET DEFAULT TAGLINE --->
<cfquery name="DefaultTag" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TagLine
FROM SMS_Taglines
WHERE DefaultTag=1
AND TagType LIKE '%Normal%'
</cfquery>



<!--- LOOP MEMBERS --->
<cfloop query="AllMembers">

	
	<cfset this_contactID = AllMembers.ContactID>
	<cfset this_mobilenumber = rereplace(AllMembers.mobilePhone, '[^0-9]+', '', 'all')>
	
	
	<!--- CHECK IF THEY HAVE A MOBILE NUMBER --->
	<cfif IsNumeric("#this_mobilenumber#")>
		
		
		<!--- GET POINTS IN --->
		<cfquery name="PointsIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SUM(Transaction_Amount) AS TotalPointsIn
		FROM contact_transactions
		WHERE ContactID = #this_contactID#
		AND Transaction_Type LIKE '%credit%'
		AND Transaction_Account LIKE '%Points%'
		</cfquery>
		
		<cfif IsNumeric("#PointsIn.TotalPointsIn#")>
			<cfset TotalUserPointsIn = INT(PointsIn.TotalPointsIn)>
		<cfelse>
			<cfset TotalUserPointsIn = 0>
		</cfif>
		
		<!--- GET POINTS OUT --->
		<cfquery name="PointsOut" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SUM(Transaction_Amount) AS TotalPointsOut
		FROM contact_transactions
		WHERE ContactID = #this_contactID#
		AND Transaction_Type LIKE '%debit%'
		AND Transaction_Account LIKE '%Points%'
		</cfquery>
		
		<cfif IsNumeric("#PointsOut.TotalPointsOut#")>
			<cfset TotalUserPointsOut = INT(PointsOut.TotalPointsOut)>
		<cfelse>
			<cfset TotalUserPointsOut = 0>
		</cfif>
		
		<!--- SET POINTS BALANCE --->
		<cfset user_points = INT(TotalUserPointsIn - TotalUserPointsOut)>
	
		<!--- CREATE MESSAGE - REPLACE {firstname} --->
		<cfset this_message = ReplaceNoCase(AlertStuff.SMSDetails, '{firstname}', '#TRIM(AllMembers.Firstname)#', "ALL")>
		
		<!--- CREATE MESSAGE - REPLACE {balance} --->
		<cfset this_message = ReplaceNoCase(this_message, '{balance}', '#user_points#', "ALL")>
		
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


</cfloop>


</cfoutput>