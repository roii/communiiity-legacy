<cfif IsDefined("form.ContactID")>

	<cfloop list="#form.ContactID#" index="Moderator" delimiters=",">
	
	<cfquery name="qry_current_roles" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Roles
	FROM Contacts
	WHERE ContactID=#Moderator#
	</cfquery>
	
	<cfset newRoles = ListAppend(qry_current_roles.Roles, 2, ",")>
	
	<cfquery name="qry_update_roles" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET Roles='#newRoles#'
	WHERE ContactID=#Moderator#
	</cfquery>	
	
	</cfloop>	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("New moderators were added.");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
		
	<cfoutput>	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_idea_moderators')"></body>
	</cfoutput>
	
	<cfabort>
	

<cfelse>

	<script type="text/javascript">
	alert("No moderators were selected.");
	window.close();
	</script>
	<cfabort>

</cfif>