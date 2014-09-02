
<!--- INSERT THE TRANSACTION --->	
	<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, RoyaltyPaid, PointsType)
	VALUES(#form.contactID#, <cfif IsDate("#form.Transaction_Date#")>#CreateODBCDate(form.Transaction_Date)#<cfelse>#CreateODBCDate(localDateTime)#</cfif>, '#form.Transaction_Type#', #Replace(form.Transaction_Amount, '$', '', "ALL")#, '#form.Transaction_Description#', '#form.Transaction_Account#', 0, 0, 'Earned')
	</cfquery>


	
<!--- LOG THIS ACTION --->

	<cfoutput>
	<cfset logdetails = 'Add Kids Transaction - (Date: #form.Transaction_Date# Amount: #form.Transaction_Amount#)'>
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
