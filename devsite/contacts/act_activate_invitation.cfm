<cfoutput>

<cfset this_contactID = REReplace(NewMemberCode,  "[A-Z]",  "",  "ALL")>

<!--- GET THE CONTACT DETAILS --->
<cfquery name="ContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#this_contactID#
</cfquery>


<cfif ContactStuff.RecordCount>
	
	<!--- CREATE UNIQUE LOGIN DETAILS --->
	<cfset thispassword="">
	
	<cfset chars1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789">
	
	<cfloop index="indx1" from="1" to="5">
		<cfset rnum = RANDRANGE(1,36)>
		<cfset thispassword = (thispassword & MID(chars1,rnum,1))>
	</cfloop>	
	
	<!--- INSERT CONTACT INFO --->
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT ContactID
	FROM Contacts
	ORDER BY ContactID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newcontactid = (lastID.ContactID + 1)>
	<cfelse>
		<cfset newcontactid = 1>
	</cfif>
	
	<cfquery name="AddContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Contacts(
	ContactID,
	ContactTypeID,
	ContactStatus,
	OrganisationID,
	FirstName,
	LastName,
	EmailAddress,
	DateJoined,
	Password,
	CountryID,
	SchoolID,
	Charity
	)

	VALUES(
	#newcontactid#, 
	1,
	'Active',
	0,
	'#TRIM(ContactStuff.FirstName)#',
	'#TRIM(ContactStuff.LastName)#',
	'#TRIM(ContactStuff.EmailAddress)#',
	#CreateODBCDate(localDateTime)#,
	'#TRIM(thispassword)#',
	0,
	0,
	0
	)
	</cfquery>
	
	
	<!--- CHANGE STATUS OF INVITATION --->
	<cfquery name="UpdateInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Invitations
	SET InvitationStatus='Successful',
	DateResponded=#CreateODBCDate(localDateTime)#
	WHERE InvitationTo=#this_contactID#
	</cfquery>	
	
	<!--- GET THE REFFERING MEMBERS DETAILS --->
	<cfquery name="ReferDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT InvitationFrom
	FROM Invitations
	WHERE InvitationTo=#this_contactID#
	</cfquery>	
	
	<!--- REWARD NEW MEMBER --->
	<cfset this_activity = 22>
	<cfset this_contactID = newcontactid>
	<cfset this_relatedDescription = "ActivateInvitation">
	<cfset this_relatedID = "#this_contactID#">

	<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
	<!--- SEND EMAIL TO NEW MEMBER --->
	<cfinclude template="dsp_activate_email_member.cfm">	
	
	<!--- SEND EMAIL TO REFERRING MEMBER --->
	<cfinclude template="dsp_activate_email_referrer.cfm">	
	
	<cfset ExtraDescription = "<BR>Contact: #TRIM(ContactStuff.FirstName)# #TRIM(ContactStuff.LastName)#">
	
	<!--- REWARD REFERRING MEMBER --->
	<cfset this_activity = 19>
	<cfset this_contactID = ReferDetails.InvitationFrom>
	<cfset this_relatedDescription = "SuccessfulInvitation">
	<cfset this_relatedID = "#this_contactID#">
	
	<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	<script type="text/javascript">
	alert("You have successfully activated your account and have just earned your first rewards!\nYou will now be redirected to your profile page where you can update your\npersonal information and login details");
	self.location="#request.webroot#/index.cfm?fuseaction=join&fusesubaction=Step2&contactID=#newcontactid#";
	</script>
	
<cfelse>
	
	<script type="text/javascript">
	alert("Sorry, we could not find your details in our database!\nYou can still join by clicking the Sign-up Now link\nbelow the login box.");
	self.location="#request.webroot#";
	</script>

</cfif>


</cfoutput>