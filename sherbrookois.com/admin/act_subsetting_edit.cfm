
	


<!--- UPDATE --->
	
	<cfquery name="UpdateSubSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE subscriptionSettings
	SET MonthlyAmount=#val(REReplace(form.MonthlyAmount,"[^0-9.]","","ALL"))#,
	DayBilled=#form.DayBilled#
	</cfquery>

	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=subscriptions')"></body>
	
	
	</cfoutput>
