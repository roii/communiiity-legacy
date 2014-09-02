

<!--- UPDATE THE TRANSACTION --->
	
	<cfquery name="UpdateTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE contact_transactions
	SET ContactID=#form.contactID#, 
	
	<cfif IsDate("#form.Transaction_Date#")>
	Transaction_Date=#CreateODBCDate(form.Transaction_Date)#,
	</cfif>
	
	Transaction_Type='#form.Transaction_Type#',	
	Transaction_Amount=#Replace(form.Transaction_Amount, '$', '', "ALL")#,	
	Transaction_Description='#form.Transaction_Description#',	
	Transaction_Account='#form.Transaction_Account#'
	WHERE TransactionID=#form.TransactionID#
	</cfquery>


	
<!--- LOG THIS ACTION --->

	<cfoutput>
	<cfset logdetails = 'Edit Kids Transaction - (Date: #form.Transaction_Date# Amount: #form.Transaction_Amount#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney&this_contactID=#form.contactID#')"></body>
	
	
	</cfoutput>
