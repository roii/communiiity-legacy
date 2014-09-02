<cfset session.MissingDetails = "The following contacts did not have either a First Name or an Email Address so they were not sent an invitation...<BR>">
<cfset session.MissingDetails_display=0>

<cfset session.AlreadyJoined = "The following contacts have already joined my3P.com!...<BR>">
<cfset session.AlreadyJoined_display=0>

<!--- LOOP SELECTED CONTACTS --->
<cfloop from="1" to="#form.TotalInvites#" index="loopitem">

<cfif IsDefined("form.UseContact_#loopitem#")>
	<cfset this_sendinvite = 1>
<cfelse>
	<cfset this_sendinvite = 0>
</cfif>

<cfset this_contact = evaluate("form.ContactID_" & loopitem)>
<cfset this_firstname = evaluate("form.FirstName_" & loopitem)>
<cfset this_lastname = evaluate("form.LastName_" & loopitem)>
<cfset this_email = evaluate("form.EmailAddress_" & loopitem)>
<cfset this_phone = evaluate("form.MobilePhone_" & loopitem)>

<!--- UPDATE CONTACT DETAILS --->
<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET FirstName = '#TRIM(this_firstname)#',
LastName = '#TRIM(this_lastname)#',
EmailAddress='#TRIM(this_email)#',
MobilePhone='#TRIM(this_phone)#'
WHERE ContactID=#this_contact#
</cfquery>


<!--- IF TICKED THEN SEND INVITE --->
<cfif this_sendinvite EQ 1>

	<cfif this_FirstName EQ '' OR this_Email EQ ''>
		
		<cfset session.MissingDetails = session.MissingDetails & "<li><strong>Name:</strong> #this_firstname# #this_lastname# | <strong>Email:</strong> #this_email# | <strong>Mobile:</strong> #this_phone#</li>">		
		<cfset session.MissingDetails_display=1>
	<cfelse>

		<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID
		FROM Contacts
		WHERE EmailAddress='#TRIM(this_email)#'
		AND EmailAddress <> ''
		AND ContactTypeID IN (1,2,4,6,7)
		AND ContactStatus LIKE '%Active%'
		</cfquery>		
		
		<cfif CheckUserEmail.RecordCount>
		
			<cfset session.AlreadyJoined = session.AlreadyJoined & "<li><strong>Name:</strong> #this_firstname# #this_lastname# | <strong>Email:</strong> #this_email# | <strong>Mobile:</strong> #this_phone#</li>">
			<cfset session.AlreadyJoined_display=1>
		<cfelse>			
		
			<!--- CHECK FOR CURRENT LINK --->
			<cfquery name="CheckCurrentfriends" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Invitations.*, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress
			FROM Invitations, Contacts
			WHERE Invitations.InvitationFrom=#session.UserID#
			AND Invitations.InvitationTo=Contacts.ContactID
			AND Contacts.EmailAddress = '#TRIM(this_email)#'
			</cfquery>			
			
			<cfif CheckCurrentfriends.RecordCount>
	
				<!--- UPDATE DATE LAST SENT --->
				<cfquery name="UpdateInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Invitations
				SET DateLastSent=#CreateODBCDateTime(localdatetime)#,
				InvitationTo_FirstName='#this_firstname#',
				InvitationTo_LastName='#this_lastname#'
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
				InvitationTo_FirstName,
				InvitationTo_LastName
				)
				VALUES(
				#newInviteid#, 
				'Pending',
				#session.UserID#,
				'#TRIM(this_Email)#',
				#CreateODBCDateTime(localDateTime)#,
				#CreateODBCDateTime(localDateTime)#,
				'#this_firstname#',
				'#this_lastname#'
				)
				</cfquery>
				
			</cfif>
			
			
			<cfset fromemail="#TRIM(session.User_Email)#">
			
			<cfset NewAlertDetails = Replace(form.Message,  '<BR>',  '#chr(10)#' ,  "ALL")>

			<!--- REPLACE {invitee_firstname} --->
			<cfset NewAlertSubject = ReplaceNoCase(form.EmailSubject,  '{invitee_firstname}',  '#this_FirstName#' ,  "ALL")>
			<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{invitee_firstname}',  '#this_FirstName#' ,  "ALL")>


<cfmail server="#application.emailserver#" to="#TRIM(this_Email)#" from="#fromemail#" subject="#NewAlertSubject#">#TRIM(NewAlertDetails)#</cfmail>
			
			
		</cfif>		
			
	</cfif>
	
</cfif>


</cfloop>



<cfoutput>

<script type="text/javascript">
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=45&InviteMode=SendConfirm";
</script>

</cfoutput>
