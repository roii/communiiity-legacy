<!--- GENERATE NEW ORGANISATION ID --->	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT OrganisationID
FROM Organisations
ORDER BY OrganisationID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.OrganisationID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
	

<!--- INSERT ORGANISATION INFO --->	
<cfquery name="AddCharity" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Organisations(OrganisationID,
OrgCatID,
Organisation_Name,
Organisation_Status,
WorkPhone,
Address1,
Address2,
City,
RegionID,
CountryID,
State,
WebsiteURL,
Notes,
Charity,
DefaultSponsor
)

VALUES(#newid#, 
5, 
'#form.Organisation_Name#', 
'Active', 
'#form.WorkPhone#', 
'#form.Address1#', 
'#form.Address2#', 
'#form.City#', 

<cfif IsDefined("form.RegionID") AND IsNumeric("#form.RegionID#")>
	#form.RegionID#, 
<cfelse>
	0,
</cfif>

<cfif IsDefined("form.countryID") AND IsNumeric("#form.countryID#")>
	#form.countryID#, 
<cfelse>
	0,
</cfif>

<cfif IsDefined("form.State")>
	'#form.State#', 
<cfelse>
	'',
</cfif>

'#form.Website#',	
'#form.Notes#',
0,
0)
</cfquery>



<!--- GENERATE NEW CONTACT ID --->	
<cfquery name="LastContactID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT ContactID
FROM Contacts
ORDER BY ContactID DESC
</cfquery>

<cfif LastContactID.recordcount>
	<cfset newcontactid = (LastContactID.ContactID + 1)>
<cfelse>
	<cfset newcontactid = 1>
</cfif>
	

<!--- INSERT PRIAMRY CONTACT INFO --->	
<cfquery name="AddPrimaryContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Contacts(ContactID,
ContactTypeID,
ContactStatus,
OrganisationID,
DateJoined,
FirstName,
LastName,
City,
RegionID,
CountryID,
EmailAddress,
EmailConfirmed,
Password,
receiveEmail,
Charity)

VALUES(#newcontactid#, 
2, 
'Active', 
#newID#, 
#CreateODBCDateTime(localDateTime)#, 
'#form.FirstName#', 
'#form.LastName#', 
'#form.City#', 

<cfif IsDefined("form.RegionID") AND IsNumeric("#form.RegionID#")>
	#form.RegionID#, 
<cfelse>
	0,
</cfif>

<cfif IsDefined("form.countryID") AND IsNumeric("#form.countryID#")>
	#form.countryID#, 
<cfelse>
	0,
</cfif>

'#form.EmailAddress#',
1,	
'#form.Password#',
1,
1)
</cfquery>


<!--- UPDATE PARTNER WITH PRIMARY CONTACT ID --->
<cfquery name="UpdateCharity" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Organisations
SET PrimaryContactID=#newcontactid#
WHERE OrganisationID=#newID#
</cfquery>

<!--- CLOSE THE POP-UP AND REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("You have successfully added the partner.");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_partners')"></body>
	
	
	</cfoutput>
