<!--->
25Oct11 - DJP - New Code added to production.
--->

<cfoutput>

<!--- Add new Alert --->

	<cfquery name="getNextID" datasource="#dsn#" username="#request.username#" password="#request.password#">
		select top 1 AlertID from EmailAlerts order by AlertID desc
	</cfquery>
	<cfif getNextID.recordcount EQ 0>
		<cfset xAlertId = 1>
	<cfelse>
		<cfset xAlertId = getNextID.AlertID + 1>
	</cfif>
	<cfset xVariablesUsed = ''>

	<cfquery name="NewEmailAlerts" datasource="#dsn#" username="#request.username#" password="#request.password#">
		insert into EmailAlerts  ( 
			ALERTID, 
			AlertTitle, 
			AlertSubject, 
			AlertDetails, 
			SMSDetails, 
			AlertFormat, 
			CustomAlert, 
			VariablesUsed
			) values (
			#xAlertId#,
			'#form.AlertTitle#',
			'#form.AlertSubject#', 
			'#form.AlertDetails#', 
			'#form.SMSDetails#', 
			'#form.AlertFormat#', 
			0, 
			'#form.VariablesUsed#'
		)
	</cfquery>

	

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("You have added a new Email Alert!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?Fuseaction=administration&Fusesubaction=manage_alerts')"></body>
	
	
	
	
</cfoutput>