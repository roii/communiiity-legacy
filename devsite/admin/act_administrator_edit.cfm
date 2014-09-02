<!--- UPDATE ARTICLE DETAILS --->
	<cfquery name="Updateadministrator" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Administrator
	SET FirstName = '#form.FirstName#',
	LastName = '#form.LastName#',	
	EmailAddress = '#form.EmailAddress#',
	Password='#form.Password#'
	WHERE AdministratorID = #form.AdministratorID#
	</cfquery>


	
	<cfoutput>
	<cfset logdetails = 'Edit Administrator - (#form.FirstName# #form.LastName#)'>
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
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=administrators')">
	</body>
	
	
	</cfoutput>