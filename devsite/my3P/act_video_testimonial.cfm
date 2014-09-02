<cfquery name="UpdateContact" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
UPDATE Contacts
SET videotestimonial=1
WHERE contactID=#session.UserID#
</cfquery>


<cflocation url="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=86&projectmode=template&ProjectCategoryID=15&ProjectID=62">