

<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT AdministratorID
	FROM Administrator
	ORDER BY AdministratorID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.AdministratorID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddAdministrator" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO Administrator(AdministratorID, FirstName, LastName, EmailAddress, Password)
	VALUES(#newid#, '#form.FirstName#', '#form.LastName#', '#form.EmailAddress#', '#form.Password#')
	</cfquery>

	


	<cfoutput>
	<cfset logdetails = 'Add Administrator - (#form.FirstName# #form.LastName#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=administrators')"></body>
	
	
	</cfoutput>
