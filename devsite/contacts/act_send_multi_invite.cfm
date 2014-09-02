<!--- CHECK FOR CURRENT LINK --->
<cfquery name="CheckCurrentfriends" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Invitations
WHERE Invitations.InvitationFrom=#session.UserID#
AND Invitations.InvitationToEmail LIKE '#TRIM(this_email)#'
</cfquery>			

<cfif CheckCurrentfriends.RecordCount>

	<!--- UPDATE DATE LAST SENT --->
	<cfquery name="UpdateInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Invitations
	SET DateLastSent=#CreateODBCDateTime(localdatetime)#,
	InvitationTo_FirstName='#this_name#'
	WHERE InvitationID = #TRIM(CheckCurrentfriends.InvitationID)#
	</cfquery>

<cfelse>

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
	InvitationTo_FirstName
	)
	VALUES(
	#newInviteid#, 
	'Pending',
	#session.UserID#,
	'#TRIM(this_Email)#',
	#CreateODBCDateTime(localDateTime)#,
	#CreateODBCDateTime(localDateTime)#,
	'#this_name#'
	)
	</cfquery>
			
</cfif>	
	
	
<cfset fromemail="#TRIM(session.User_Email)#">

<!--- GET THE ALERT DETAILS 
{invitee_firstname} {member_firstname} {sitename} {siteurl} {sitelogo}
--->

<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertSubject, AlertDetails, AlertFormat
FROM EmailAlerts
WHERE AlertID=4
</cfquery>

<!--- REPLACE {siteurl} --->
<cfset NewAlertSubject = ReplaceNoCase(AlertStuff.AlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(AlertStuff.AlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>

<!--- REPLACE {sitename} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>	

<!--- REPLACE {member_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{member_firstname}',  '#session.User_FirstName# #session.User_LastName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{member_firstname}',  '#session.User_FirstName# #session.User_LastName#' ,  "ALL")>	

<!--- REPLACE {referralcode} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
	
<!--- REPLACE {invitee_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{invitee_firstname}',  '#this_Name#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{invitee_firstname}',  '#this_Name#' ,  "ALL")>	

<cfset NewAlertDetails = Replace(NewAlertDetails,  '<BR>',  '#chr(10)#' ,  "ALL")>


<cftry>
<cfmail server="#application.emailserver#" to="#TRIM(this_Email)#" from="#fromemail#" subject="#form.EmailSubject#">#TRIM(NewAlertDetails)#</cfmail>
<cfcatch></cfcatch>
</cftry>


<cfif IsDefined("this_mobile")>

	<cfif IsDefined("session.User_Mobile")>
		<cfset sender_mobilenumber = ReReplace(session.User_Mobile, '[^0-9]+', '', 'all')>
	<cfelse>
		<cfset sender_mobilenumber = "123">
	</cfif>
	
	<cfset this_mobile = REReplace(this_mobile, '[^0-9]+', '', 'all')>
	
	<!--- CHECK IF THEY HAVE A MOBILE NUMBER --->
	<cfif IsNumeric("#sender_mobilenumber#") AND IsNumeric("#this_mobile#")>

		<!--- CREATE MESSAGE - ADD TAGLINE --->
		<cfset this_message = "Go to www.my3p.com and register with my Invite Code to get extra points!#chr(10)#- - - - - - - - - - - #chr(10)#Invite Code: #session.User_Screenname##chr(10)#- - - - - - - - - - - #chr(10)#">
		
		<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false" timeout="600">
		<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
		<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
		<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
		<cfhttpparam type="FORMFIELD" name="text" value="#this_message#">
		<cfhttpparam type="FORMFIELD" name="to" value="#this_mobile#">
		
		<cfif IsDefined("session.User_Mobile")>
			<cfhttpparam type="FORMFIELD" name="from" value="#sender_mobilenumber#">
		</cfif>

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
		VALUES(#newid#, 9999999, #CreateODBCDateTime(localdatetime)#, '#this_mobile#', '#sender_mobilenumber#', '#this_message#')
		</cfquery>
			
	</cfif>
	
</cfif>
