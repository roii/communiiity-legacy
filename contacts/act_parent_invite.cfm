<cfquery name="CheckParentEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ParentInviteID, ContactID, ParentID
FROM ParentInvites
WHERE EmailAddress LIKE '%#TRIM(form.ParentEmail)#%'
</cfquery>


<!--- EXISTING INVITATION FOUND --->
<cfif CheckParentEmail.RecordCount GT 0>

	
	<!--- IF THIS IS THE SAME MEMBER INVITING AGAIN --->
	<cfif CheckParentEmail.ContactID EQ session.UserID>
	
		<cfoutput>
		<script type="text/javascript">
		alert("You have already inivted your parent to join you!\nIf you wish to resend the invite please use the RESEND button on the previous page.");
		self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
		</script>
		</cfoutput>
		<cfabort>
		
		
	<!--- IF THIS IS ANOTHER MEMBER (ie. brother or sister) --->
	<cfelse>
	
		
		<!--- CREATE UNIQUE 6 DIGIT PIN --->
		<cfset this_PIN = "">
		
		<cfloop from="1" to="6" index="LoopCount">
			<cfset this_PIN = this_PIN & "#RandRange(0, 9)#">
		</cfloop>
		
		
	
		<!--- GET LAST ID --->
		<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT ParentInviteID
		FROM ParentInvites
		ORDER BY ParentInviteID DESC
		</cfquery>
		
		<cfif lastid.recordcount>
			<cfset newid = (lastID.ParentInviteID + 1)>
		<cfelse>
			<cfset newid = 1>
		</cfif>
	
	
		<!--- SEND THE INVITE BUT TAG AS ALREADY AN EXISTING PARENT --->
		<cfquery name="InsertParentInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO ParentInvites(
		ParentInviteID,
		ContactID,
		Status,
		DateSent,
		DateLastSent,
		EmailAddress,
		MobileNumber,
		ParentID,
		ExistingParent,
		ParentName,
		PINNumber
		)
		VALUES(
		#newID#,
		#session.UserID#,
		'Pending',
		#CreateODBCDateTime(localdatetime)#,
		#CreateODBCDateTime(localdatetime)#,
		'#form.ParentEmail#',
		'#form.ParentPhone#',
		#CheckParentEmail.ParentID#,
		1,
		'#form.ParentName#',
		#this_PIN#
		)
		</cfquery>
		
		
		<cfif ListLen(form.ParentName, " ") GT 1>
			
			<cfset loopcount = 1>
			<cfloop list="#form.ParentName#" index="loopItem" delimiters=" ">
				<cfif loopcount EQ 1>
					<cfset this_firstname = loopItem>
				</cfif>
				<cfset loopcount = (loopcount + 1)>		
			</cfloop>
		
		<cfelse>
			<cfset this_firstname = form.ParentName>
		</cfif>
		
		
<cfmail server="#application.emailserver#" to="#form.ParentEmail#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(session.User_FirstName)# wants you to join them on my3P.com!">
Hi #this_firstname#!

#session.User_FirstName# has sent you this invitation to join them on my3P.com.

Follow the link below and enter the following referral code and PIN number...

----------------------------------------------------------------------------------
Link: #request.webroot#/parents
----------------------------------------------------------------------------------
Invitation Code: #session.User_ScreenName#
----------------------------------------------------------------------------------
PIN: #this_PIN#
----------------------------------------------------------------------------------
</cfmail>


		<!--- IF THEY ENTERED A MOBILE NUMBER --->
		<cfif form.ParentPhone NEQ ''>
		
			<cfset this_msg = '#session.User_FirstName# wants you to join them on my3P.com. Go to "www.my3p.com/parents" and register using "#session.User_ScreenName#" as the invitation code and "#this_PIN#" as the PIN.'>
			
			
			<!--- CHECK FOR USER MOBILE NUMBER --->
			<cfquery name="GetMobile" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT mobilePhone
			FROM Contacts
			WHERE ContactID=#session.UserID#
			</cfquery>
			
			<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false">
			<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
			<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
			<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
			<cfhttpparam type="FORMFIELD" name="text" value="#this_msg#">
			<cfhttpparam type="FORMFIELD" name="to" value="#form.ParentPhone#">
			
			<cfif GetMobile.mobilePhone NEQ ''>
				<cfhttpparam type="FORMFIELD" name="from" value="#GetMobile.mobilePhone#">
			</cfif>
			
			</cfhttp>
		
		</cfif>
		
		<cfoutput>
		<script type="text/javascript">
		alert("You have inivted your parent to join you!\nAsk them to check their email account for the invitation\nand follow the link contained within it. Once they have done\nthis you will then need to verify them and activate their link to you.");
		self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
		</script>
		</cfoutput>
		<cfabort>
		
	
	</cfif>
	

	
<!--- NO EXISTING INVITATION FOUND --->	
<cfelse>

	
	<!--- CHECK IF EXISTING PARENT --->
	<cfquery name="CheckContacts" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ContactID
	FROM Contacts
	WHERE EmailAddress LIKE '%#TRIM(form.ParentEmail)#%'
	</cfquery>
	
	
	<cfif CheckContacts.RecordCount>
	
		<!--- CREATE UNIQUE 6 DIGIT PIN --->
		<cfset this_PIN = "">
		
		<cfloop from="1" to="6" index="LoopCount">
			<cfset this_PIN = this_PIN & "#RandRange(0, 9)#">
		</cfloop>
		
		
	
		<!--- GET LAST ID --->
		<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT ParentInviteID
		FROM ParentInvites
		ORDER BY ParentInviteID DESC
		</cfquery>
		
		<cfif lastid.recordcount>
			<cfset newid = (lastID.ParentInviteID + 1)>
		<cfelse>
			<cfset newid = 1>
		</cfif>
	
	
		<!--- SEND THE INVITE BUT TAG AS ALREADY AN EXISTING PARENT --->
		<cfquery name="InsertParentInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO ParentInvites(
		ParentInviteID,
		ContactID,
		Status,
		DateSent,
		DateLastSent,
		EmailAddress,
		MobileNumber,
		ParentID,
		ExistingParent,
		ParentName,
		PINNumber
		)
		VALUES(
		#newID#,
		#session.UserID#,
		'Pending',
		#CreateODBCDateTime(localdatetime)#,
		#CreateODBCDateTime(localdatetime)#,
		'#form.ParentEmail#',
		'#form.ParentPhone#',
		#CheckContacts.ContactID#,
		1,
		'#form.ParentName#',
		#this_PIN#
		)
		</cfquery>
		
		
		<cfif ListLen(form.ParentName, " ") GT 1>
			
			<cfset loopcount = 1>
			<cfloop list="#form.ParentName#" index="loopItem" delimiters=" ">
				<cfif loopcount EQ 1>
					<cfset this_firstname = loopItem>
				</cfif>
				<cfset loopcount = (loopcount + 1)>		
			</cfloop>
		
		<cfelse>
			<cfset this_firstname = form.ParentName>
		</cfif>
		
		
<cfmail server="#application.emailserver#" to="#form.ParentEmail#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(session.User_FirstName)# wants you to join them on my3P.com!">
Hi #this_firstname#!

#session.User_FirstName# has sent you this invitation to join them on my3P.com.

Follow the link below and enter the following referral code and PIN number...

----------------------------------------------------------------------------------
Link: #request.webroot#/parents
----------------------------------------------------------------------------------
Invitation Code: #session.User_ScreenName#
----------------------------------------------------------------------------------
PIN: #this_PIN#
----------------------------------------------------------------------------------
</cfmail>


		<!--- IF THEY ENTERED A MOBILE NUMBER --->
		<cfif form.ParentPhone NEQ ''>
		
			<cfset this_msg = '#session.User_FirstName# wants you to join them on my3P.com. Go to "www.my3p.com/parents" and register using "#session.User_ScreenName#" as the invitation code and "#this_PIN#" as the PIN.'>
			
			
			<!--- CHECK FOR USER MOBILE NUMBER --->
			<cfquery name="GetMobile" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT mobilePhone
			FROM Contacts
			WHERE ContactID=#session.UserID#
			</cfquery>
			
			<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false">
			<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
			<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
			<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
			<cfhttpparam type="FORMFIELD" name="text" value="#this_msg#">
			<cfhttpparam type="FORMFIELD" name="to" value="#form.ParentPhone#">
			
			<cfif GetMobile.mobilePhone NEQ ''>
				<cfhttpparam type="FORMFIELD" name="from" value="#GetMobile.mobilePhone#">
			</cfif>
			
			</cfhttp>
		
		</cfif>
		
		<cfoutput>
		<script type="text/javascript">
		alert("You have inivted your parent to join you!\nAsk them to check their email account for the invitation\nand follow the link contained within it. Once they have done\nthis you will then need to verify them and activate their link to you.");
		self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
		</script>
		</cfoutput>
		<cfabort>
		
		
	<cfelse>
	
	
	
		<!--- CREATE UNIQUE 6 DIGIT PIN --->
		<cfset this_PIN = "">
			
		<cfloop from="1" to="6" index="LoopCount">
			<cfset this_PIN = this_PIN & "#RandRange(0, 9)#">
		</cfloop>
			
	
		<!--- GET LAST ID --->
		<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT ParentInviteID
		FROM ParentInvites
		ORDER BY ParentInviteID DESC
		</cfquery>
		
		<cfif lastid.recordcount>
			<cfset newid = (lastID.ParentInviteID + 1)>
		<cfelse>
			<cfset newid = 1>
		</cfif>
	
	
		<!--- SEND THE INVITE BUT TAG AS ALREADY AN EXISTING PARENT --->
		<cfquery name="InsertParentInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO ParentInvites(
		ParentInviteID,
		ContactID,
		Status,
		DateSent,
		DateLastSent,
		EmailAddress,
		MobileNumber,
		ParentID,
		ExistingParent,
		ParentName,
		PINNumber
		)
		VALUES(
		#newID#,
		#session.UserID#,
		'Pending',
		#CreateODBCDateTime(localdatetime)#,
		#CreateODBCDateTime(localdatetime)#,
		'#form.ParentEmail#',
		'#form.ParentPhone#',
		0,
		0,
		'#form.ParentName#',
		#this_PIN#
		)
		</cfquery>
		
		
		<cfif ListLen(form.ParentName, " ") GT 1>
			
			<cfset loopcount = 1>
			<cfloop list="#form.ParentName#" index="loopItem" delimiters=" ">
				<cfif loopcount EQ 1>
					<cfset this_firstname = loopItem>
				</cfif>
				<cfset loopcount = (loopcount + 1)>		
			</cfloop>
		
		<cfelse>
			<cfset this_firstname = form.ParentName>
		</cfif>
		
		
<cfmail server="#application.emailserver#" to="#form.ParentEmail#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(session.User_FirstName)# wants you to join them on my3P.com!">
Hi #this_firstname#!

#session.User_FirstName# has sent you this invitation to join them on my3P.com.

Follow the link below and enter the following referral code and PIN number...

----------------------------------------------------------------------------------
Link: #request.webroot#/parents
----------------------------------------------------------------------------------
Invitation Code: #session.User_ScreenName#
----------------------------------------------------------------------------------
PIN: #this_PIN#
----------------------------------------------------------------------------------
</cfmail>

	
		<!--- IF THEY ENTERED A MOBILE NUMBER --->
		<cfif form.ParentPhone NEQ ''>
		
			<cfset this_msg = '#session.User_FirstName# wants you to join them on my3P.com. Go to "www.my3p.com/parents" and register using "#session.User_ScreenName#" as the invitation code and "#this_PIN#" as the PIN.'>
			
			
			<!--- CHECK FOR USER MOBILE NUMBER --->
			<cfquery name="GetMobile" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT mobilePhone
			FROM Contacts
			WHERE ContactID=#session.UserID#
			</cfquery>
			
			<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false">
			<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
			<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
			<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
			<cfhttpparam type="FORMFIELD" name="text" value="#this_msg#">
			<cfhttpparam type="FORMFIELD" name="to" value="#form.ParentPhone#">
			
			<cfif GetMobile.mobilePhone NEQ ''>
				<cfhttpparam type="FORMFIELD" name="from" value="#GetMobile.mobilePhone#">
			</cfif>
			
			</cfhttp>
			
			
		</cfif>
		
		<cfoutput>
		
		<script type="text/javascript">
		alert("You have inivted your parent to join you!\nAsk them to check their email account for the invitation\nand follow the link contained within it. Once they have done\nthis you will then need to verify them and activate their link to you.");
		self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
		</script>
		
		</cfoutput>
		
		<cfabort>

	</cfif>
	
	
</cfif>