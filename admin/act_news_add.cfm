<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT RecordID
	FROM News
	ORDER BY RecordID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.RecordID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	
	
<!--- INSERT ARTICLE  --->
	
	<cfquery name="InsertArticle" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO News(RecordID, ReleasedDate, Title, introduction, Details, Feature, NewsExpireDate, NewsCatID, NonMember, Member, Released)
	VALUES(#newID#, #CreateODBCDate(form.ReleaseDate)#, '#form.title#', '#form.introduction#', '#form.details#', 1, #CreateODBCDate(form.ExpireDate)#, #form.NewsCatID#, <cfif #form.NonMember# EQ '0,1'>1<cfelse>0</cfif>, <cfif #form.member# EQ '0,1'>1<cfelse>0</cfif>, #form.released#)
	</cfquery>

	
	
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	
	
	
	
	<cfoutput>
	
	<cfset logdetails = 'Add News Article - (Article: #form.title#)'>	
	<cfinclude template="act_adminlog.cfm">

	
	
<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->	
		<cfif IsDefined("ArticleID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#&ArticleID=#ArticleID#')"></body>


<cfelseif IsDefined("DocumentID")>	
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#&documentID=#documentID#')"></body>
	
	<cfelse>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#TRIM(fuseaction)#&fusesubaction=#TRIM(fusesubaction)#')"></body>
	
	</cfif>
	
		
		
	</cfoutput>

