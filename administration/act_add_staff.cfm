<!--- CHECK AVAILABILITY OF EMAIL ADDRESS --->


<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE EmailAddress='#TRIM(form.EmailAddress)#'
</cfquery>


<cfif CheckUserEmail.RecordCount>

	<cfoutput>
	<script>
	alert("We already have a member with the email address you specified.\nEach contact must have a unique email address for authentication purposes.");
	history.back();
	</script>
	</cfoutput>
	<cfabort>
	
</cfif>


<!--- GENERATE NEW CONTACT ID --->
	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT ContactID
FROM Contacts
ORDER BY ContactID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.ContactID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
	
	
	
	<!--- INSERT TEACHER INFO --->
	
	<cfquery name="AddTeacher" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Contacts(contactID, contacttypeID, ContactStatus, DateJoined, FirstName, LastName, EmailAddress, EmailConfirmed, Password, receiveEmail, OrganisationID, Charity)
	VALUES(#newid#, 2, 'Active', #createODBCDateTime(localDateTime)#, '#form.FirstName#', '#form.LastName#', '#form.EmailAddress#', 1, '#form.Profile_Password#', 1, #form.OrganisationID#, #form.OrganisationID#)
	</cfquery>


	<cflocation url="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#form.OrganisationID#&updatemode=stafflist">
	