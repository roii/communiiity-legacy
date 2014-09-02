

<!--- UPDATE INFO --->
<cfquery name="updateEvent" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Events
SET EventTitle='#form.EventTitle#', 
StartDate=#CreateODBCDate(form.StartDate)#, 
EndDate=#CreateODBCDate(form.EndDate)#, 
WebAddress='#form.WebAddress#', 
Venue='#form.Venue#', 
Details='#form.Details#', 
FurtherInfo='#form.furtherinfo#', 
ContactEmail='#form.ContactEmail#', 
EventCatID=#form.EventCatID#, 
PastEventReport=#form.PastEventReport#, 
PastEventDetails='#form.PastEventDetails#', 
NonMember=<cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>, 
Member=<cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>
WHERE EventID=#form.EventID#
</cfquery>



<cfoutput>
<cfset logdetails = 'Update Event - (Event: #form.EventTitle#)'>
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