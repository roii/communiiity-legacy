

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>Untitled</title>
</head>

<body>

<!--- GET ALL EXISTING LINKS --->
<cfquery name="AllLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT KidClientLinks.KidClientLinkID, KidClientLinks.KidID, KidClientLinks.ClientID, Contacts.ContactID, Contacts.Categories, Contacts.EmailAddress
FROM KidClientLinks, Contacts
WHERE KidClientLinks.ClientID=Contacts.ContactID
ORDER BY KidClientLinks.KidClientLinkID
</cfquery>

<cfset members = 0>

<!--- LOOP EXISTING LINKS --->
<cfloop query="AllLinks">

<cfset this_Categories = AllLinks.Categories>
<cfset this_KidClientLinkID = AllLinks.KidClientLinkID>
<cfset this_EmailAddress = AllLinks.EmailAddress>
<cfset this_ClientID = AllLinks.ClientID>

<!--- COPY CATEGORIES TO KIDCLIENT_LINK TABLE --->
<cfquery name="UpdateLinkTable_#AllLinks.CurrentRow#" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE KidClientLinks
SET Categories='#TRIM(this_Categories)#'
WHERE KidClientLinkID=#this_KidClientLinkID#
</cfquery>

<!--- CHECK IF CLIENT HAS BECOME MEMBER --->
<cfif TRIM(this_EmailAddress) NEQ ''>
	
	<cfquery name="CheckIfMember" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE EmailAddress LIKE '%#this_EmailAddress#%'
	AND ContactTypeID IN (1,2)
	AND ContactStatus LIKE '%Active%'
	</cfquery>
		
	<cfif CheckIfMember.RecordCount>
	
		<!--- CHANGE "CLIENTID" TO CONTACTID AND CHANGE "ALLOW-EDIT" TO NO IN KIDCLIENT_LINK TABLE --->
		<cfquery name="UpdateToContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE KidClientLinks
		SET ClientID=#TRIM(CheckIfMember.ContactID)#,
		AllowEdit=0
		WHERE KidClientLinkID=#this_KidClientLinkID#
		</cfquery>
		
		<!--- DELETE ORIGINAL "CLIENT" RECORD --->
		<cfquery name="DeleteClient" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM Contacts
		WHERE ContactID=#this_ClientID#
		</cfquery>
		
		<cfset members = (members + 1)>	
	
	</cfif>	
	
</cfif>

</cfloop>


<cfoutput>
#AllLinks.RecordCount#<br>
#members#
</cfoutput>

<cfabort>



</body>
</html>
