<!--- SEND THE PLAIN EMAIL --->				
<cfmail server="#application.emailserver#" to="#TRIM(form.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(form.Subject)#">#TRIM(form.message)#</cfmail>



<!--- UPDATE EMAIL ADDRESS IN MEMBER PROFILE --->
<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET EmailAddress='#TRIM(form.EmailAddress)#'
WHERE ContactID=#form.contactID#
</cfquery>



<cfoutput>

<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	self.close();
}

// -->
</script>

<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members')">
</body>

</cfoutput>