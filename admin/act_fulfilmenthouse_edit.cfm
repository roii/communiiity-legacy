
	
	<cfquery name="UpdateHouse" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE FulfilmentHouses
	SET BusinessName='#form.BusinessName#', 
	EmailAddress='#form.EmailAddress#', 
	ContactName='#form.ContactName#',
	PhoneNumber='#form.PhoneNumber#',
	Address='#form.address#'
	WHERE fulfilmenthouseID=#form.fulfilmenthouseID#
	</cfquery>

	


	<cfoutput>
	<cfset logdetails = 'Update Fulfilment House - (#form.BusinessName#)'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	
	

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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=fulfilment')"></body>
	
	
	</cfoutput>
