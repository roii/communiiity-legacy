<cfoutput>


<cfquery name="ActiveAgree" datasource="AgreeTool">
SELECT ContactID
FROM AgreeAdministrators
WHERE Status='active'
</cfquery>


<cfset ActiveAgreeAdministrators=valuelist(ActiveAgree.ContactID,  ",")>

<cfif #ActiveAgreeAdministrators# EQ ''>
	<cfset ActiveAgreeAdministrators=0>
</cfif>

<cfquery name="CurrentAgreeAdministrators" datasource="#OrganisationDSN#">
SELECT OrganisationContacts.ContactID, OrganisationContacts.ContactFirstName, OrganisationContacts.ContactLastName, OrganisationContacts.ContactEmailAddress, Organisations.EnglishName
FROM OrganisationContacts, Organisations
WHERE OrganisationContacts.ContactID IN (#ActiveAgreeAdministrators#)
AND OrganisationContacts.OrganisationID=Organisations.OrganisationID
ORDER BY Organisations.EnglishName
</cfquery>







<cfquery name="PendingAgree" datasource="AgreeTool">
SELECT ContactID
FROM AgreeAdministrators
WHERE Status='pending'
</cfquery>


<cfset PendingAgreeAdministrators=valuelist(PendingAgree.ContactID,  ",")>

<cfif #PendingAgreeAdministrators# EQ ''>
	<cfset PendingAgreeAdministrators=0>
</cfif>



<cfquery name="PendAgreeAdministrators" datasource="#OrganisationDSN#">
SELECT OrganisationContacts.ContactID, OrganisationContacts.ContactFirstName, OrganisationContacts.ContactLastName, OrganisationContacts.ContactEmailAddress, Organisations.EnglishName
FROM OrganisationContacts, Organisations
WHERE OrganisationContacts.ContactID IN (#PendingAgreeAdministrators#)
AND OrganisationContacts.OrganisationID=Organisations.OrganisationID
ORDER BY Organisations.EnglishName
</cfquery>


</cfoutput>