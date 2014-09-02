
<!--- UPDATE CATEGORY  --->

	<cfquery name="UpdateCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE ProjectCategories
	SET Title='#form.title#',
	displayorder = #form.displayorder#,
	active = #form.active#,
	GroupID=#form.GroupID#
	WHERE ProjectCategoryID=#form.ProjectCategoryID#
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	<cfset logdetails = 'Edit Cash Project Category - (Category: #form.Title#)'>
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
	 
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_categories')"></body>

	</cfoutput>
		
		


