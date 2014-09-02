
<!--- UPDATE CATEGORY  ---> 

<cfquery name="getProjectCategoryID" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT max(ProjectCategoryID) as maxid FROM ProjectCategories
</cfquery>
	
<cfif getProjectCategoryID.maxid eq ''>
    <cfset maxid = 1>
<cfelse>
    <cfset maxid = getProjectCategoryID.maxid + 1>
</cfif>	 
	
	<cfquery name="UpdateCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO ProjectCategories (Title, displayorder, active, GroupID, ProjectCategoryID)
	VALUES
	('#form.title#', #form.displayorder#, 1, #form.GroupID#, #maxid#) 
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	<cfset logdetails = 'Add Cash Project Category - (Category: #form.Title#)'>
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
	
	
		<body onLoad="showParentAndClose('#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=docs&documentID=#documentID#')"></body>

	</cfoutput>
		
		


