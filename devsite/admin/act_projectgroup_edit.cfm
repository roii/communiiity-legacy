
<!--- UPDATE CATEGORY  --->

	<cfquery name="UpdateGroup" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE ProjectGroups
	SET GroupName='#form.GroupName#',
	
	<cfif IsNumeric("#form.DocumentID#")>
		DocumentID = #form.DocumentID#
	<cfelse>
		DocumentID = 0
	</cfif>
	
	WHERE GroupID=#form.GroupID#
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	<cfset logdetails = 'Edit Cash Project Group - (Group: #form.GroupName#)'>
	<cfinclude template="act_adminlog.cfm">
	</cfoutput>


	
	
	
	<cfoutput>
		

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_projectgroups')"></body>

	</cfoutput>
		
		


