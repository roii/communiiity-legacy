<!--- UPDATE ARTICLE DETAILS --->
	
	<cfquery name="UpdateCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE LibraryCats
	SET LibraryCatTitle = '#form.LibraryCatTitle#',
	NonMember=<cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>,
	Member=<cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>,
	Released=#form.released#,	
	DisplayOrder = #form.DisplayOrder#	
	WHERE LibraryCatID = #form.LibraryCatID#
	</cfquery>
	
	
	

<!--- LOG THE ACTION --->
	
	<cfoutput>
	<cfset logdetails = 'Edit Library Category - (Category: #form.LibraryCatTitle#)'>
	<cfinclude template="act_adminlog.cfm">
	</cfoutput>
	
	
	
	
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
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=download')"></body>
	</cfoutput>