
<!--- GENERATE NEW ID --->
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT EventID
FROM Events
ORDER BY EventID DESC
</cfquery>

<cfif #lastid.recordcount# GT 0>
	<cfset newid = (#lastID.EventID# + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>


<!--- INSERT DOC INFO --->
<cfquery name="AddEvent" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Events(EventID, EventTitle, StartDate, EndDate, WebAddress, Venue, Details, FurtherInfo, ContactEmail, EventCatID, PastEventReport, PastEventDetails, NonMember, Member)
VALUES(#newid#, '#form.EventTitle#', #CreateODBCDate(form.StartDate)#, #CreateODBCDate(form.EndDate)#, '#form.WebAddress#', '#form.Venue#', '#form.Details#', '#form.furtherinfo#', '#form.ContactEmail#', #form.EventCatID#, #form.PastEventReport#, '#form.PastEventDetails#', <cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>, <cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>)
</cfquery>



<cfoutput>
<cfset logdetails = 'Add Event - (Event: #form.EventTitle#)'>
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