
	<cfquery name="UpdateDoc" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Documents
	SET Title = '#form.title#',
	
	<cfif IsDefined("form.introduction")>
	introduction='#form.introduction#',
	</cfif>
	
	Details='#form.details#',
	
	<cfif #IsDate(form.pubdate)#>
		PubDate=#CreateODBCDate(form.pubdate)#,
	<cfelse>
		PubDate=NULL,
	</cfif>
	
	
	<cfif #IsDate(form.DocExpireDate)#>
		DocExpireDate=#CreateODBCDate(form.DocExpireDate)#,
	<cfelse>
		DocExpireDate=NULL,
	</cfif>
	
	<cfif IsDefined("form.AdminView")>
		AdminView=1,
	<cfelse>
		AdminView=0,
	</cfif>
	
	<cfif IsDefined("form.PublicView")>
		PublicView=1,
	<cfelse>
		PublicView=0,
	</cfif>
	
	<cfif IsDefined("form.ContactTypeView")>
		ContactTypeView='#form.ContactTypeView#',
	<cfelse>
		ContactTypeView='0',
	</cfif>
	
	<cfif IsDefined("form.HomePromote")>
		HomePromote=#form.HomePromote#,
	<cfelse>
		HomePromote='0',
	</cfif>
	
	
	PageTitle='#form.PageTitle#',
	MetaContent='#form.MetaContent#',
	MetaKeywords='#form.MetaKeywords#',
	
	Author = '#form.author#',
	Released = #form.released#
	WHERE DocumentID = #DocumentID#
	</cfquery>


	<!--- GET SECTION ID --->
	<cfquery name="SectionNum" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SectionID
	FROM Sections
	WHERE fuseaction = '#fuseaction#'
	</cfquery>


	<cfquery name="UpdateLinkOrder" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE SectionDocuments_Link
	SET DisplayOrder = #form.displayorder#
	WHERE DocumentID = #form.DocumentID#
	AND SectionID = #SectionNum.sectionID#
	</cfquery>
	
	
	<!--- ANNOUNCEMENT BOX --->
	<cfif IsDefined("form.AnnoucementShort")>
	
		<cfquery name="LastID" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
		SELECT AnnouncementID
		FROM Announcements
		ORDER BY AnnouncementID DESC
		</cfquery>
		
		<cfif lastid.recordcount>
			<cfset newid = (lastID.AnnouncementID + 1)>
		<cfelse>
			<cfset newid = 1>
		</cfif>
		
		
	<!--- INSERT ORGANISATION --->
	
		<cfquery name="AddAnnouncement" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO Announcements(
		AnnouncementID,
		AnnouncementDate,  
		AnnouncementDetails, 
		AnnoucementShort)
		
		VALUES(#newid#,
		#CreateODBCDateTime(localdatetime)#,
		'',
		'#form.AnnoucementShort#')
		</cfquery>
	
	
	
	</cfif>
	
	


	<cfset logdetails = 'Update Document - (Document: #form.title# | Section: #fuseaction#)'>
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
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#documentID#')"></body>
	
	
	</cfoutput>