<!--- CREATE NEW ID --->

	<cfquery name="NextID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT LibraryCatID
	FROM LibraryCats
	ORDER BY LibraryCatID DESC
	</cfquery>
	
	
	<cfif #nextid.recordcount# GT 0>
		<cfset nextid = (#nextid.LibraryCatID# + 1)>
	<cfelse>
		<cfset nextid = 1>
	</cfif>





<!--- INSERT CATEGORY  --->

	<cfquery name="InsertCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO LibraryCats(LibraryCatID, LibraryCatTitle, DisplayOrder, NonMember, Member, Released, Fuseaction)
	VALUES(#nextID#, '#form.LibraryCatTitle#', #form.DisplayOrder#, <cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>, <cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>, #form.released#, '#fuseaction#')
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	<cfset logdetails = 'Add Library Category - (Category: #form.LibraryCatTitle#)'>
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
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#')"></body>
	</cfoutput>
		
		


