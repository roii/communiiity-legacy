<cfoutput>

<!--- UPDATE THE ALERT DETAILS --->

	<cfquery name="UpdateEmailAlerts" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE EmailAlerts
	SET AlertTitle='#form.AlertTitle#',
	AlertSubject='#form.AlertSubject#',
	AlertDetails='#form.AlertDetails#',
	SMSDetails='#form.SMSDetails#',
	AlertFormat='#form.AlertFormat#'
	WHERE AlertID=#form.AlertID#
	</cfquery>
	

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("You have updated the Email Alert!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?Fuseaction=administration&Fusesubaction=manage_alerts')"></body>
	
	
	
	
</cfoutput>