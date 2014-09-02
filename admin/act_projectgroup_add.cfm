<!--- CREATE NEW ID --->

<cfquery name="nextid" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
SELECT GroupID
FROM ProjectGroups
ORDER BY GroupID DESC
</cfquery>
	
	
	<cfif nextid.recordcount>
		<cfset nextGroupid = (nextid.GroupID + 1)>
	<cfelse>
		<cfset nextGroupid = 1>
	</cfif>
	
	<cfif IsNumeric("#form.DocumentID#")>
		<cfset insert_docID = form.DocumentID>
	<cfelse>
		<cfset insert_docID = 0>
	</cfif>


<!--- INSERT GROUP  --->

	<cfquery name="InsertGroup" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO ProjectGroups(GroupID, GroupName, DocumentID)
	VALUES('#nextGroupid#', '#form.GroupName#', #insert_docID#)
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	
	
	<cfset logdetails = 'Add Cash Project Group - (Group: #form.GroupName#)'>
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
		
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_projectgroups')"></body>

	</cfoutput>
		
		


