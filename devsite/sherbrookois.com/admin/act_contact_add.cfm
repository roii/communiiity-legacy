<!--- GENERATE NEW CONTACT ID --->

	<cfquery name="LastID" datasource="#OrganisationDSN#" maxrows="1">
	SELECT ContactID
	FROM OrganisationContacts
	ORDER BY ContactID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.ContactID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	
	
<!--- INSERT ORGANISATION --->

	<cfquery name="AddOrgContact" datasource="#OrganisationDSN#">
	INSERT INTO OrganisationContacts(
	ContactID,
	OrganisationID,  
	ContactFirstName, 
	ContactLastName, 
	ContactJobtitle, 
	ContactEmailAddress, 
	ContactTelephone, 
	ContactFax,
	PrimaryContact,
	Password,
	AccessOrgProfile,
	ReceiveBulletin)
	
	VALUES(#newid#,
	#form.OrganisationID#,
	'#form.ContactFirstName#',
	'#form.ContactLastName#',
	'#form.ContactJobtitle#',
	'#form.ContactEmailAddress#',
	'#form.ContactTelephone#',
	'#form.ContactFax#',
	#form.PrimaryContact#,
	'#form.Password#',
	#form.AccessOrgProfile#,
	#form.ReceiveBulletin#)
	</cfquery>
	
	
	<!--- GET THE ORGANISATION NAME --->
	<cfquery name="OrgDetails" datasource="#OrganisationDSN#">
	SELECT EnglishName
	FROM Organisations
	WHERE OrganisationID=#form.organisationID#
	</cfquery>
	
	
	<!--- ADMIN LOG --->

	<cfoutput>
	<cfset logdetails = 'Add Organisaton Contact - (Organisation: #OrgDetails.EnglishName# | Contact: #form.ContactFirstName# #form.ContactLastName#)'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	

<!--- REFRESH THE CALLING PAGE --->
	
	
	
	<cfoutput>
	
		<script language="JavaScript">
	<!--
	alert("You have successfully created a new Organisation Contact.");
	self.location="dsp_organisation_edit.cfm?organisationID=#organisationID#&editmode=contacts";
	
	
	// -->
	</script>
	
	
	</cfoutput>
	
	
	
	