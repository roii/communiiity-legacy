<!--- UPDATE THE DETAILS ON EXISTING INVITE --->
<cfquery name="InsertParentInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE ParentInvites
SET DateLastSent=#CreateODBCDateTime(localdatetime)#,
ParentName='#form.ParentName#',
EmailAddress='#form.ParentEmail#',
MobileNumber='#form.ParentPhone#'
WHERE ParentInviteID=#form.ParentInviteID#
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

<cfset this_PIN = form.PINNumber>
		
		
<cfmail server="#application.emailserver#" to="#form.ParentEmail#" from="#TRIM(session.AllSettings_EmailAlertFrom)#" subject="#TRIM(session.User_FirstName)# wants you to join them on my3P.com!">
Hi #this_firstname#!

#session.User_FirstName# has sent you this invitation to join them on my3P.com

Follow the link below and enter the following referral code and PIN number...

----------------------------------------------------------------------------------
Link: #request.webroot#/parents
----------------------------------------------------------------------------------
Referral Code: #session.User_ScreenName#
----------------------------------------------------------------------------------
PIN: #this_PIN#
----------------------------------------------------------------------------------
</cfmail>

	
<!--- IF THEY ENTERED A MOBILE NUMBER --->
<cfif form.ParentPhone NEQ ''>

	<cfset this_msg = '#session.User_FirstName# wants you to join them on my3P.com. Go to "www.my3p.com/parents" and register using "#session.User_ScreenName#" as the referal code and "#this_PIN#" as the PIN.'>
	
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
alert("You have resent the invitation to your parent.\nAsk them to check their email account or mobile phone for the invitation\nand follow the link contained within it. Once they have done\nthis you will then need to verify them and activate their link to you.");
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
</script>

</cfoutput>

<cfabort>