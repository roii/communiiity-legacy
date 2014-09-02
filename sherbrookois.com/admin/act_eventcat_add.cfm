<!--- CREATE NEW ID --->

	<cfquery name="NextID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT EventCatID
	FROM EventCats
	ORDER BY EventCatID DESC
	</cfquery>
	
	
	<cfif #nextid.recordcount# GT 0>
		<cfset nextid = (#nextid.EventCatID# + 1)>
	<cfelse>
		<cfset nextid = 1>
	</cfif>





<!--- INSERT CATEGORY  --->

	<cfquery name="InsertCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO EventCats(EventCatID, EventCatName, DisplayOrder, NonMember, Member, Released, Fuseaction)
	VALUES(#nextID#, '#form.EventCatName#', #form.DisplayOrder#, <cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>, <cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>, #form.released#, '#fuseaction#')
	</cfquery>


	
<!--- LOG THE ACTION --->

	<cfoutput>
	<cfset logdetails = 'Add Event Category - (Category: #form.EventCatName#)'>
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
		<cfif IsDefined("ArticleID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#')"></body>


<cfelseif IsDefined("DocumentID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#')"></body>
	
	<cfelse>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#')"></body>
	
	</cfif>
	</cfoutput>
		
		


