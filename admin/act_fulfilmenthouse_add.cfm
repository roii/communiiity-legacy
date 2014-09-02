

<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT fulfilmenthouseID
	FROM FulfilmentHouses
	ORDER BY fulfilmenthouseID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.fulfilmenthouseID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddAdministrator" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO FulfilmentHouses(fulfilmenthouseID, BusinessName, EmailAddress, ContactName, PhoneNumber, Address)
	VALUES(#newid#, '#form.BusinessName#', '#form.EmailAddress#', '#form.ContactName#', '#form.PhoneNumber#', '#form.address#')
	</cfquery>

	


	<cfoutput>
	<cfset logdetails = 'Add Fulfilment House - (#form.BusinessName#)'>
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
