
<!--- GENERATE NEW ID --->
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT LinkID
FROM Links
ORDER BY LinkID DESC
</cfquery>

<cfif #lastid.recordcount# GT 0>
	<cfset newid = (#lastID.LinkID# + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>


<!--- INSERT DOC INFO --->
<cfquery name="AddLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Links(LinkID, LinkCatID, Title, Details, LinkURL, Released, NonMember, Member)
VALUES(#newid#, #form.LinkCatID#, '#form.Title#', '#form.Details#', '#form.LinkURL#', #form.released#, <cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>, <cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>)
</cfquery>



<cfoutput>
<cfset logdetails = 'Add Link - (Link: #form.Title#)'>
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
	
	
	<cfif IsDefined("ArticleID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#')"></body>


<cfelseif IsDefined("DocumentID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#')"></body>
	
	<cfelse>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#')"></body>
	
	</cfif>
	
	
	</cfoutput>