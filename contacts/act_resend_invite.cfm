<cfoutput>

<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ReferralCode
FROM Contacts
WHERE EmailAddress='#TRIM(form.FriendEmail)#'
AND EmailAddress <> ''
AND ContacttypeID IN (1,2,4,6,7)
</cfquery>

<cfif CheckUserEmail.RecordCount>
	
	<cfif TRIM(CheckUserEmail.ReferralCode) EQ ''>
	
		<script type="text/javascript">
		alert("Your friend has already joined #TRIM(AllSettings.SiteName)# but forgot to enter a referral code.");
		self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
		</script>
	
	<cfelseif TRIM(CheckUserEmail.ReferralCode) EQ TRIM(session.User_ScreenName)>
		
		<script type="text/javascript">
		alert("Your friend has already joined #TRIM(AllSettings.SiteName)# and used your referral code.");
		self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
		</script>
		
	<cfelse>
	
		<script type="text/javascript">
		alert("Your friend has already joined #TRIM(AllSettings.SiteName)# but entered another members referral code.");
		self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
		</script>	
	
	</cfif>
	
	<cfabort>

</cfif>


<!--- UPDATE INVITATION --->
<cfquery name="UpDateInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Invitations
SET InvitationToEmail='#form.FriendEmail#',
DateLastSent=#CreateODBCDateTime(localDateTime)#,
InvitationTo_FirstName='#form.Friend_FirstName#',
InvitationTo_Mobile='#form.FriendMobile#'
WHERE InvitationID=#form.InvitationID#
</cfquery>

<cfset fromemail="#TRIM(session.User_Email)#">
<cfset NewAlertDetails = Replace(form.Message,  '<BR>',  '#chr(10)#' ,  "ALL")>
	

</cfoutput>

<cfmail server="#application.emailserver#" to="#TRIM(form.FriendEmail)#" from="#TRIM(fromemail)#" subject="#TRIM(form.EmailSubject)#">#TRIM(NewAlertDetails)#</cfmail>


<cfif IsDefined("form.FriendMobile")>

	<cfset sender_mobilenumber = rereplace(session.User_Mobile, '[^0-9]+', '', 'all')>
	<cfset this_mobilenumber = rereplace(form.FriendMobile, '[^0-9]+', '', 'all')>
	
	<!--- CHECK IF THEY HAVE A MOBILE NUMBER --->
	<cfif IsNumeric("#sender_mobilenumber#") AND IsNumeric("#this_mobilenumber#")>

		<!--- CREATE MESSAGE - ADD TAGLINE --->
		<cfset this_message = "Go to www.my3p.com and register with my Invite Code to get extra points!#chr(10)#- - - - - - - - - - - #chr(10)#Invite Code: #session.User_Screenname##chr(10)#- - - - - - - - - - - #chr(10)#">
		
		<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false" timeout="600">
		<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
		<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
		<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
		<cfhttpparam type="FORMFIELD" name="text" value="#this_message#">
		<cfhttpparam type="FORMFIELD" name="to" value="#this_mobilenumber#">
		<cfhttpparam type="FORMFIELD" name="from" value="#sender_mobilenumber#">
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
		VALUES(#newid#, 9999999, #CreateODBCDateTime(localdatetime)#, '#this_mobilenumber#', '#sender_mobilenumber#', '#this_message#')
		</cfquery>
			
	</cfif>
	
</cfif>

<cfoutput>

<script type="text/javascript">
alert("You have successfully resent the invitation to your friend!");
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
</script>

</cfoutput>
