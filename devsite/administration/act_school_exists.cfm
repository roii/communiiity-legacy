<!--- UPDATE MEMBER --->
<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET SchoolID=#form.SchoolID#, 
School_Other='',
School_Other_Phone='',
School_Other_Address=''
WHERE ContactID=#form.ContactID#
</cfquery>


<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("You have successfully updated the contact with the correct school.");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools_toadd')"></body>
	
	
	</cfoutput>