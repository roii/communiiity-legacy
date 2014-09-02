<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
</script>
	
	
	<!--- DOWNLOAD FILE RELATED LINKS --->

<cfif #fusesubaction# EQ 'template'>


		<cfquery name="DeleteCurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE LibraryID=#LinkToID#
		</cfquery>
	
	
	<!--- LINK DOCUMENTS --->
	
		<CFLOOP FROM="1" TO="#DocumentRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DocumentAssociate" & ThisRow)# EQ "0,1">
		
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
	
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, LibraryID, DocumentID)
			VALUES(#newID#, 'LibraryDoc', #LinkToID#, #Evaluate("DocumentID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK ARTICLES --->
	
		<CFLOOP FROM="1" TO="#articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("ArticleAssociate" & ThisRow)# EQ "0,1">
		
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
	
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, LibraryID, ArticleID)
			VALUES(#newid#, 'LibraryArt', #LinkToID#, #Evaluate("ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK SUBARTICLES --->
	
		<CFLOOP FROM="1" TO="#SubarticleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("SubArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, LibraryID, SubArticleID)
			VALUES(#newid#, 'LibrarySubArt', #LinkToID#, #Evaluate("SubArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK LEVEL 4 ARTICLES --->
	
		<CFLOOP FROM="1" TO="#level4articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("Level4ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, LibraryID, Level4ArticleID)
			VALUES(#newid#, 'LibraryLevel4Art', #LinkToID#, #Evaluate("Level4ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK NEWS --->
	
		<CFLOOP FROM="1" TO="#NewsRecords#" INDEX="ThisRow">


		<cfif #Evaluate("NewsAssociate" & ThisRow)# EQ "0,1">
			
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, LibraryID, NewsID)
			VALUES(#newid#, 'LibraryNews', #LinkToID#, #Evaluate("NewsID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK EVENTS --->
	
		<CFLOOP FROM="1" TO="#EventRecords#" INDEX="ThisRow">


		<cfif #Evaluate("EventAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, LibraryID, EventID)
			VALUES(#newID#, 'LibraryEvent', #LinkToID#, #Evaluate("EventID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK WEBLINKS --->
	
		<CFLOOP FROM="1" TO="#WebLinkRecords#" INDEX="ThisRow">


		<cfif #Evaluate("WebLinkAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, LibraryID, WebLinkID)
			VALUES(#newid#, 'LibraryLink', #LinkToID#, #Evaluate("LinkID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>

	
	
		<cfoutput><body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&LibraryID=#LinkToID#')"></body></cfoutput>







	
	
	
<!--- DOCUMENT RELATED LINKS --->

<cfelseif #fusesubaction# EQ 'docs'>



		<cfquery name="DeleteCurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE DocumentID=#LinkToID#
		</cfquery>
	
	
	<!--- LINK DOWNLOADS --->
	
		<CFLOOP FROM="1" TO="#DownloadRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DownloadAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, DocumentID, LibraryID)
			VALUES(#newid#, 'DocLibrary', #LinkToID#, #Evaluate("DownloadID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK ARTICLES --->
	
		<CFLOOP FROM="1" TO="#articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, DocumentID, ArticleID)
			VALUES(#newid#, 'docArt', #LinkToID#, #Evaluate("ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK SUBARTICLES --->
	
		<CFLOOP FROM="1" TO="#SubarticleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("SubArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, DocumentID, SubArticleID)
			VALUES(#newid#, 'DocSubArt', #LinkToID#, #Evaluate("SubArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK LEVEL 4 ARTICLES --->
	
		<CFLOOP FROM="1" TO="#level4articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("Level4ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, DocumentID, Level4ArticleID)
			VALUES(#newid#, 'DocLevel4Art', #LinkToID#, #Evaluate("Level4ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK NEWS --->
	
		<CFLOOP FROM="1" TO="#NewsRecords#" INDEX="ThisRow">


		<cfif #Evaluate("NewsAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, DocumentID, NewsID)
			VALUES(#newid#, 'DocNews', #LinkToID#, #Evaluate("NewsID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK EVENTS --->
	
		<CFLOOP FROM="1" TO="#EventRecords#" INDEX="ThisRow">


		<cfif #Evaluate("EventAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, DocumentID, EventID)
			VALUES(#newid#, 'DocEvent', #LinkToID#, #Evaluate("EventID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK WEBLINKS --->
	
		<CFLOOP FROM="1" TO="#WebLinkRecords#" INDEX="ThisRow">


		<cfif #Evaluate("WebLinkAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, DocumentID, WebLinkID)
			VALUES(#newid#, 'DocLink', #LinkToID#, #Evaluate("LinkID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		<cfoutput><body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&DocumentID=#LinkToID#')"></body></cfoutput>
		
	
	
	
	
	
	
	
	
	
	
<!--- ARTICLE RELATED LINKS --->
	
<cfelseif #fusesubaction# EQ 'article'>



		<cfquery name="DeleteCurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE ArticleID=#LinkToID#
		</cfquery>
	
	
	<!--- LINK DOWNLOADS --->
	
		<CFLOOP FROM="1" TO="#DownloadRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DownloadAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, LibraryID)
			VALUES(#newid#, 'ArtLibrary', #LinkToID#, #Evaluate("DownloadID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK DOCUMENTS --->
	
		<CFLOOP FROM="1" TO="#DocumentRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DocumentAssociate" & ThisRow)# EQ "0,1">
		
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
	
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, DocumentID)
			VALUES(#newID#, 'ArtDoc', #LinkToID#, #Evaluate("DocumentID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
		
	<!--- LINK ARTICLES --->
	<CFLOOP FROM="1" TO="#articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, SubArticleID)
			VALUES(#newid#, 'ArtArtArt', #LinkToID#, #Evaluate("ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK SUBARTICLES --->
	
		<CFLOOP FROM="1" TO="#SubarticleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("SubArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, SubArticleID)
			VALUES(#newid#, 'ArtSubArt', #LinkToID#, #Evaluate("SubArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK LEVEL 4 ARTICLES --->
	
		<CFLOOP FROM="1" TO="#level4articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("Level4ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, Level4ArticleID)
			VALUES(#newid#, 'ArtLevel4Art', #LinkToID#, #Evaluate("Level4ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
		<!--- LINK NEWS --->
	
		<CFLOOP FROM="1" TO="#NewsRecords#" INDEX="ThisRow">


		<cfif #Evaluate("NewsAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, NewsID)
			VALUES(#newid#, 'ArtNews', #LinkToID#, #Evaluate("NewsID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK EVENTS --->
	
		<CFLOOP FROM="1" TO="#EventRecords#" INDEX="ThisRow">


		<cfif #Evaluate("EventAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, EventID)
			VALUES(#newid#, 'ArtEvent', #LinkToID#, #Evaluate("EventID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK WEBLINKS --->
	
		<CFLOOP FROM="1" TO="#WebLinkRecords#" INDEX="ThisRow">


		<cfif #Evaluate("WebLinkAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, ArticleID, WebLinkID)
			VALUES(#newid#, 'ArtLink', #LinkToID#, #Evaluate("LinkID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		<cfoutput><body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&DocumentID=#form.documentID#&ArticleID=#LinkToID#')"></body></cfoutput>









<!--- SUB ARTICLES --->

<cfelseif #fusesubaction# EQ 'subarticle'>



		<cfquery name="DeleteCurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE SubArticleID=#LinkToID#
		</cfquery>
	
	
	<!--- LINK DOWNLOADS --->
	
		<CFLOOP FROM="1" TO="#DownloadRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DownloadAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SubArticleID, LibraryID)
			VALUES(#newid#, 'SubArtLibrary', #LinkToID#, #Evaluate("DownloadID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK DOCUMENTS --->
	
		<CFLOOP FROM="1" TO="#DocumentRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DocumentAssociate" & ThisRow)# EQ "0,1">
		
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
	
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SubArticleID, DocumentID)
			VALUES(#newID#, 'SubArtDoc', #LinkToID#, #Evaluate("DocumentID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK ARTICLES --->
	
		<CFLOOP FROM="1" TO="#articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SubArticleID, ArticleID)
			VALUES(#newid#, 'ArtSubArt', #LinkToID#, #Evaluate("ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK LEVEL 4 ARTICLES --->
	
		<CFLOOP FROM="1" TO="#level4articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("Level4ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SubArticleID, Level4ArticleID)
			VALUES(#newid#, 'SubArtLevel4Art', #LinkToID#, #Evaluate("Level4ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		<!--- LINK NEWS --->
	
		<CFLOOP FROM="1" TO="#NewsRecords#" INDEX="ThisRow">


		<cfif #Evaluate("NewsAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SubArticleID, NewsID)
			VALUES(#newid#, 'SubArtNews', #LinkToID#, #Evaluate("NewsID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK EVENTS --->
	
		<CFLOOP FROM="1" TO="#EventRecords#" INDEX="ThisRow">


		<cfif #Evaluate("EventAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SubArticleID, EventID)
			VALUES(#newid#, 'SubArtEvent', #LinkToID#, #Evaluate("EventID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK WEBLINKS --->
	
		<CFLOOP FROM="1" TO="#WebLinkRecords#" INDEX="ThisRow">


		<cfif #Evaluate("WebLinkAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SubArticleID, WebLinkID)
			VALUES(#newid#, 'SubArtLink', #LinkToID#, #Evaluate("LinkID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		<cfoutput><body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&DocumentID=#form.documentID#&ArticleID=#form.articleID#&SubArticleID=#LinkToID#')"></body></cfoutput>









<!--- LEVEL 4 ARTICLES --->

<cfelseif #fusesubaction# EQ 'level4'>



		<cfquery name="DeleteCurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE Level4ArticleID=#LinkToID#
		</cfquery>
	
	
	<!--- LINK DOWNLOADS --->
	
		<CFLOOP FROM="1" TO="#DownloadRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DownloadAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, Level4ArticleID, LibraryID)
			VALUES(#newid#, 'Level4ArtLibrary', #LinkToID#, #Evaluate("DownloadID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK DOCUMENTS --->
	
		<CFLOOP FROM="1" TO="#DocumentRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DocumentAssociate" & ThisRow)# EQ "0,1">
		
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
	
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, Level4ArticleID, DocumentID)
			VALUES(#newID#, 'Level4ArtDoc', #LinkToID#, #Evaluate("DocumentID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK ARTICLES --->
	
		<CFLOOP FROM="1" TO="#articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, Level4ArticleID, ArticleID)
			VALUES(#newid#, 'Level4ArtArt', #LinkToID#, #Evaluate("ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	
	<!--- LINK SUBARTICLES --->
	
		<CFLOOP FROM="1" TO="#SubarticleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("SubArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, Level4ArticleID, SubArticleID)
			VALUES(#newid#, 'Level4ArtSubArt', #LinkToID#, #Evaluate("SubArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
	
	
		
		
		<!--- LINK NEWS --->
	
		<CFLOOP FROM="1" TO="#NewsRecords#" INDEX="ThisRow">


		<cfif #Evaluate("NewsAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, Level4ArticleID, NewsID)
			VALUES(#newid#, 'Level4ArtNews', #LinkToID#, #Evaluate("NewsID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK EVENTS --->
	
		<CFLOOP FROM="1" TO="#EventRecords#" INDEX="ThisRow">


		<cfif #Evaluate("EventAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, Level4ArticleID, EventID)
			VALUES(#newid#, 'Level4ArtEvent', #LinkToID#, #Evaluate("EventID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK WEBLINKS --->
	
		<CFLOOP FROM="1" TO="#WebLinkRecords#" INDEX="ThisRow">


		<cfif #Evaluate("WebLinkAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, Level4ArticleID, WebLinkID)
			VALUES(#newid#, 'Level4ArtLink', #LinkToID#, #Evaluate("LinkID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		<cfoutput><body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&DocumentID=#form.documentID#&ArticleID=#form.articleID#&SubArticleID=#form.subarticleID#&level4ArticleID=#LinkToID#')"></body></cfoutput>










<!--- NEWS RELATED LINKS --->
	
<cfelseif #fusesubaction# EQ 'news_template'>



		<cfquery name="DeleteCurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE NewsID=#LinkToID#
		</cfquery>
	
	
	<!--- LINK DOWNLOADS --->
	
		<CFLOOP FROM="1" TO="#DownloadRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DownloadAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, NewsID, LibraryID)
			VALUES(#newid#, 'NewsLibrary', #LinkToID#, #Evaluate("DownloadID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK DOCUMENTS --->
	
		<CFLOOP FROM="1" TO="#DocumentRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DocumentAssociate" & ThisRow)# EQ "0,1">
		
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
	
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, NewsID, DocumentID)
			VALUES(#newID#, 'NewsDoc', #LinkToID#, #Evaluate("DocumentID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK ARTICLES --->
	
		<CFLOOP FROM="1" TO="#articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, NewsID, ArticleID)
			VALUES(#newid#, 'NewsArt', #LinkToID#, #Evaluate("ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK SUBARTICLES --->
	
		<CFLOOP FROM="1" TO="#SubarticleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("SubArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, NewsID, SubArticleID)
			VALUES(#newid#, 'NewsSubArt', #LinkToID#, #Evaluate("SubArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK LEVEL 4 ARTICLES --->
	
		<CFLOOP FROM="1" TO="#level4articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("Level4ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, NewsID, Level4ArticleID)
			VALUES(#newid#, 'NewsLevel4Art', #LinkToID#, #Evaluate("Level4ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
		
		<!--- LINK EVENTS --->
	
		<CFLOOP FROM="1" TO="#EventRecords#" INDEX="ThisRow">


		<cfif #Evaluate("EventAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, NewsID, EventID)
			VALUES(#newid#, 'NewsEvent', #LinkToID#, #Evaluate("EventID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK WEBLINKS --->
	
		<CFLOOP FROM="1" TO="#WebLinkRecords#" INDEX="ThisRow">


		<cfif #Evaluate("WebLinkAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, NewsID, WebLinkID)
			VALUES(#newid#, 'NewsLink', #LinkToID#, #Evaluate("LinkID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		<cfoutput><body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&NewsID=#LinkToID#')"></body></cfoutput>




<!--- SECTION LINKS --->

<cfelseif #fusesubaction# EQ 'index'>



		<cfquery name="DeleteCurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
		DELETE
		FROM LibraryLinks
		WHERE SectionID=#LinkToID#
		</cfquery>
	
	
	<!--- LINK DOWNLOADS --->
	
		<CFLOOP FROM="1" TO="#DownloadRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DownloadAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SectionID, LibraryID)
			VALUES(#newid#, 'SectionLibrary', #LinkToID#, #Evaluate("DownloadID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK DOCUMENTS --->
	
		<CFLOOP FROM="1" TO="#DocumentRecords#" INDEX="ThisRow">


		<cfif #Evaluate("DocumentAssociate" & ThisRow)# EQ "0,1">
		
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
	
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SectionID, DocumentID)
			VALUES(#newID#, 'SectionDoc', #LinkToID#, #Evaluate("DocumentID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK ARTICLES --->
	
		<CFLOOP FROM="1" TO="#articleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("ArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SectionID, ArticleID)
			VALUES(#newid#, 'SectionArt', #LinkToID#, #Evaluate("ArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	
	<!--- LINK SUBARTICLES --->
	
		<CFLOOP FROM="1" TO="#SubarticleRecords#" INDEX="ThisRow">


		<cfif #Evaluate("SubArticleAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SectionID, SubArticleID)
			VALUES(#newid#, 'SectionSubArt', #LinkToID#, #Evaluate("SubArticleID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
	
	
		
		
		<!--- LINK NEWS --->
	
		<CFLOOP FROM="1" TO="#NewsRecords#" INDEX="ThisRow">


		<cfif #Evaluate("NewsAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SectionID, NewsID)
			VALUES(#newid#, 'SectionNews', #LinkToID#, #Evaluate("NewsID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK EVENTS --->
	
		<CFLOOP FROM="1" TO="#EventRecords#" INDEX="ThisRow">


		<cfif #Evaluate("EventAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SectionID, EventID)
			VALUES(#newid#, 'SectionEvent', #LinkToID#, #Evaluate("EventID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		
	<!--- LINK WEBLINKS --->
	
		<CFLOOP FROM="1" TO="#WebLinkRecords#" INDEX="ThisRow">


		<cfif #Evaluate("WebLinkAssociate" & ThisRow)# EQ "0,1">
	
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT LinkID
			FROM LibraryLinks
			ORDER BY LinkID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.LinkID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
			
			<cfquery name="insertLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO LibraryLinks(LinkID, Type, SectionID, WebLinkID)
			VALUES(#newid#, 'SectionLink', #LinkToID#, #Evaluate("LinkID" & ThisRow)#)
			</cfquery>
	
		</cfif>
	
		</cfloop>
		
		
		<cfoutput><body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=#fuseaction#')"></body></cfoutput>










</cfif>
	
	
		