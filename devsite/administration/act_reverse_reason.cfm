<!--- SEND EMAIL --->
<cfmail server="#application.emailserver#" from="#TRIM(AllSettings.EmailAlertFrom)#" to="#form.SendTo_Email#" subject="#TRIM(form.subject)#">
#TRIM(form.reason)#
</cfmail>

<cfoutput>


<!--- CLOSE AND RELOAD --->
<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	alert("You have reversed the membership and sent the reversal notification.");
	self.close();
}

// -->
</script>

	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members')"></body>


</cfoutput>