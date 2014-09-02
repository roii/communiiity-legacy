<cfoutput>

<cfif form.Friend_FirstName EQ '' OR form.FriendEmail EQ ''>

	<script type="text/javascript">
	alert("Please enter Your friend's name and email address first");
	history.back();
	</script>
	
	<cfabort>

</cfif>

<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE EmailAddress='#TRIM(form.FriendEmail)#'
AND EmailAddress <> ''
AND ContactTypeID IN (1,2,4,6,7)
</cfquery>

<cfif CheckUserEmail.RecordCount>

	<script type="text/javascript">
	alert("Your friend has already joined #TRIM(AllSettings.SiteName)#!");
	self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
	</script>
	<cfabort>

</cfif>

<!--- CHECK FOR CURRENT LINK --->
<cfquery name="CheckCurrentfriends" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Invitations.*, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress
FROM Invitations, Contacts
WHERE Invitations.InvitationFrom=#session.UserID#
AND Invitations.InvitationTo=Contacts.ContactID
AND Contacts.EmailAddress = '#TRIM(form.FriendEmail)#'
</cfquery>

<cfif CheckCurrentfriends.RecordCount>

	<script type="text/javascript">
	alert("You have already sent an invitation to this friend.");
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
	</script>

	<cfabort>

</cfif>

<!--- INSERT INVITE LINK --->
<cfquery name="LastInviteID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT InvitationID
FROM Invitations
ORDER BY InvitationID DESC
</cfquery>

<cfif LastInviteID.recordcount>
	<cfset newInviteid = (LastInviteID.InvitationID + 1)>
<cfelse>
	<cfset newInviteid = 1>
</cfif>


<cfquery name="AddInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Invitations(
InvitationID,
InvitationStatus,
InvitationFrom,
InvitationToEmail,
DateFirstSent,
DateLastSent,
InvitationTo_FirstName,
InvitationTo_Mobile
)
VALUES(
#newInviteid#, 
'Pending',
#session.UserID#,
'#TRIM(form.FriendEmail)#',
#CreateODBCDateTime(localDateTime)#,
#CreateODBCDateTime(localDateTime)#,
'#TRIM(form.Friend_FirstName)#',

<cfif IsDefined("form.FriendMobile")>
	'#TRIM(form.FriendMobile)#'
<cfelse>
	''
</cfif>)
</cfquery>


<cfif session.userIsAuthenticated EQ 'yes'>
	<cfset fromemail="#TRIM(session.User_Email)#">
<cfelse>
	<cfset fromemail="#TRIM(AllSettings.EmailAlertFrom)#">
</cfif>

<cfset NewAlertDetails = Replace(form.Message,  '<BR>',  '#chr(10)#' ,  "ALL")>

</cfoutput>

<cfmail server="#application.emailserver#" to="#TRIM(form.FriendEmail)#" from="#fromemail#" subject="#form.EmailSubject#">#TRIM(NewAlertDetails)#</cfmail>

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
alert("You have successfully told your friend about #TRIM(AllSettings.SiteName)#!");
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
</script>

</cfoutput>
