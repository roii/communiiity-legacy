
	
<!--- UPDATE ORGANISATION DETAILS --->

	<cfquery name="UpdateOrgContact" datasource="#OrganisationDSN#">
	UPDATE OrganisationContacts
	SET ContactFirstName='#form.ContactFirstName#', 
	ContactLastName='#form.ContactLastName#', 
	ContactJobtitle='#form.ContactJobtitle#', 
	ContactEmailAddress='#form.ContactEmailAddress#', 
	ContactTelephone='#form.ContactTelephone#', 
	ContactFax='#form.ContactFax#',
	PrimaryContact=#form.PrimaryContact#,
	Password='#form.Password#',
	AccessOrgProfile=#form.AccessOrgProfile#,
	ReceiveBulletin=#form.ReceiveBulletin#
	WHERE ContactID=#ContactID#
	</cfquery>
	
	
	

	<!--- GET THE ORGANISATION NAME --->
	<cfquery name="OrgDetails" datasource="#OrganisationDSN#">
	SELECT Organisations.EnglishName
	FROM Organisations, OrganisationContacts
	WHERE OrganisationContacts.ContactID=#ContactID#
	AND OrganisationContacts.OrganisationID=Organisations.OrganisationID
	</cfquery>


	
	<!--- ADMIN LOG --->

	<cfoutput>
	<cfset logdetails = 'Edit Organisaton Contact - (Organisation: #OrgDetails.EnglishName# | Contact: #form.ContactFirstName# #form.ContactLastName#)'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	

<!--- REDIRECT TO THE CALLING PAGE --->

	<cfoutput>
	
	
		<script language="JavaScript">
		<!--
		alert("You have successfully updated the Organisation Contact.");
		self.location="#request.webroot#/admin/dsp_organisation_edit.cfm?organisationID=#organisationID#&editmode=contacts";
		
		
		// -->
		</script>
	
	
	

	
	</cfoutput>
	
	
	
	