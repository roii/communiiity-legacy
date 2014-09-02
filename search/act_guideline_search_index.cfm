<!--- 
<!--- INDEX THE FILE COLLECTION --->

<cfset IndexCollection = "nzgg_guideline_files">

<cfset CollectionPath = "c:\cfusion\verity\collections\">
<cfset IndexRecurse = "YES">
<cfset IndexExtensions = ".htm, .html, .txt, .pdf, .doc, .ppt, .xls, .vsd, .rtf, .zip">
<cfset IndexLanguage = "english">
<cfset IndexPath = "e:\inetpub\wwwroot\enigma\nzgg_new\guidelines">


<cftry>	
				
	<cfcollection action="CREATE" collection="#IndexCollection#" path="#CollectionPath#">
	<cfindex action="REFRESH" collection="#IndexCollection#" key="#IndexPath#" type="PATH" extensions="#IndexExtensions#" recurse="Yes">
			
	<cfcatch>
					
		<cfindex action="PURGE" collection="#IndexCollection#">
		<cfindex action="REFRESH" collection="#IndexCollection#" key="#IndexPath#" type="PATH" extensions="#IndexExtensions#" recurse="Yes">
					
	</cfcatch>
			
</cftry> --->
			
			

<cfset IndexCollection = "nzgg_guideline_files">
<cfset CollectionPath = "c:\cfusion\verity\collections\">
<cfset IndexExtensions = ".htm, .html, .txt, .pdf, .doc, .ppt, .xls, .vsd, .rtf, .zip">




<!--- DELETE OLD CONTENT --->
	
	<cfquery name="DeleteSearchStuff" datasource="#GuidelineDSN#">
	DELETE 
	FROM GuidelineSearchIndex
	</cfquery>




<!--- GET ALL GUIDELINES AND LOOP, ADDING CONTENT TO SEARCH --->

	<cfquery name="AllGuidelines" datasource="#GuidelineDSN#">
	SELECT GuidelineID, GuidelineTitle, StatementOfIntent, NotesForUsers
	FROM dbo.Guidelines
	ORDER BY GuidelineID
	</cfquery>
	
		
		
	<cfoutput query="AllGuidelines">
	
		<cfset ThisGuidelineID = #AllGuidelines.GuidelineID#>
		
		
		<!--- ADD GUIDELINE TABLE INFO --->
			
			<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
			SELECT SearchIndexID
			FROM dbo.GuidelineSearchIndex
			ORDER BY SearchIndexID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.SearchIndexID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>		
		
			<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
			INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
			VALUES(#newID#, #ThisGuidelineID#, '#TRIM(AllGuidelines.GuidelineTitle)#')
			</cfquery>
			
			
			<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
			SELECT SearchIndexID
			FROM dbo.GuidelineSearchIndex
			ORDER BY SearchIndexID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid1 = (#lastID.SearchIndexID# + 1)>
			<cfelse>
				<cfset newid1 = 1>
			</cfif>		
		
			<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
			INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
			VALUES(#newID1#, #ThisGuidelineID#, '#TRIM(AllGuidelines.StatementOfIntent)#')
			</cfquery>
			
			
			<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
			SELECT SearchIndexID
			FROM dbo.GuidelineSearchIndex
			ORDER BY SearchIndexID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid2 = (#lastID.SearchIndexID# + 1)>
			<cfelse>
				<cfset newid2 = 1>
			</cfif>		
		
			<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
			INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
			VALUES(#newID2#, #ThisGuidelineID#, '#TRIM(AllGuidelines.NotesForUsers)#')
			</cfquery>
			
			
			
						
			
		<!--- ADD GUIDELINE FAQS --->
		
			<cfquery name="FAQDetails" datasource="#guidelineDSN#">
			SELECT GuidelineFAQs.*
			FROM GuidelineFAQs, GuidelineFAQLink
			WHERE GuidelineFAQLink.GuidelineID=#ThisGuidelineID#
			AND GuidelineFAQLink.FaqID=GuidelineFAQs.FaqID
			ORDER BY GuidelineFAQs.DisplayOrder
			</cfquery>
			
			
			<cfloop query="FAQDetails">
			
				<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
				SELECT SearchIndexID
				FROM dbo.GuidelineSearchIndex
				ORDER BY SearchIndexID DESC
				</cfquery>
				
				<cfif #lastid.recordcount# GT 0>
					<cfset newid = (#lastID.SearchIndexID# + 1)>
				<cfelse>
					<cfset newid = 1>
				</cfif>		
			
				<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
				INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
				VALUES(#newID#, #ThisGuidelineID#, '#FAQDetails.FaqDetails#')
				</cfquery>			
			
			</cfloop>
			
			
			
			
			
			
		<!--- ADD GUIDELINE ALGORITHMS --->
		
			<cfquery name="AlgorithmList" datasource="#GuidelineDSN#">
			SELECT GuidelineAlgorithms.*
			FROM GuidelineAlgorithmLink, GuidelineAlgorithms
			WHERE GuidelineAlgorithmLink.GuidelineID=#ThisGuidelineID#
			AND GuidelineAlgorithmLink.AlgorithmID=GuidelineAlgorithms.AlgorithmID
			</cfquery>
			
			
			<cfloop query="AlgorithmList">
			
				<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
				SELECT SearchIndexID
				FROM dbo.GuidelineSearchIndex
				ORDER BY SearchIndexID DESC
				</cfquery>
				
				<cfif #lastid.recordcount# GT 0>
					<cfset newid = (#lastID.SearchIndexID# + 1)>
				<cfelse>
					<cfset newid = 1>
				</cfif>		
			
				<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
				INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
				VALUES(#newID#, #ThisGuidelineID#, '#AlgorithmList.AlgorithmDetails#')
				</cfquery>			
			
			</cfloop>
			
			
			
			
			
			
		<!--- ADD GUIDELINE APPENDICES --->
		
			<cfquery name="AppendiceList" datasource="#GuidelineDSN#">
			SELECT *
			FROM GuidelineAppendices
			WHERE GuidelineID=#ThisGuidelineID#
			ORDER BY DisplayOrder
			</cfquery>
			
			
			<cfloop query="AppendiceList">
			
				<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
				SELECT SearchIndexID
				FROM dbo.GuidelineSearchIndex
				ORDER BY SearchIndexID DESC
				</cfquery>
				
				<cfif #lastid.recordcount# GT 0>
					<cfset newid = (#lastID.SearchIndexID# + 1)>
				<cfelse>
					<cfset newid = 1>
				</cfif>		
			
				<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
				INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
				VALUES(#newID#, #ThisGuidelineID#, '#AppendiceList.AppendiceHTML#')
				</cfquery>			
			
			</cfloop>
			
			
			
			
			
			
			
			
		<!--- ADD GUIDELINE EVIDENCE --->
		
			<cfquery name="EvidenceTables" datasource="#guidelineDSN#">
			SELECT *
			FROM GuidelineEvidenceTables
			WHERE GuidelineID=#ThisGuidelineID#
			ORDER BY DisplayOrder
			</cfquery>
			
			
			<cfloop query="EvidenceTables">
			
				<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
				SELECT SearchIndexID
				FROM dbo.GuidelineSearchIndex
				ORDER BY SearchIndexID DESC
				</cfquery>
				
				<cfif #lastid.recordcount# GT 0>
					<cfset newid = (#lastID.SearchIndexID# + 1)>
				<cfelse>
					<cfset newid = 1>
				</cfif>		
			
				<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
				INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
				VALUES(#newID#, #ThisGuidelineID#, '#EvidenceTables.EvidenceHTMLDetails#')
				</cfquery>			
			
			</cfloop>
			
						
			
			
			
			
			
		<!--- ADD NEWS RELEASES --->
		
			<cfquery name="NewsDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT News.*
			FROM LibraryLinks, News
			WHERE LibraryLinks.Type='guidelineNews'
			AND LibraryLinks.GuidelineID=#ThisGuidelineID#
			AND LibraryLinks.NewsID=News.RecordID
			ORDER BY News.ReleasedDate DESC
			</cfquery>
			
			
			<cfloop query="NewsDetails">
			
				<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
				SELECT SearchIndexID
				FROM dbo.GuidelineSearchIndex
				ORDER BY SearchIndexID DESC
				</cfquery>
				
				<cfif #lastid.recordcount# GT 0>
					<cfset newid = (#lastID.SearchIndexID# + 1)>
				<cfelse>
					<cfset newid = 1>
				</cfif>		
			
				<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
				INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
				VALUES(#newID#, #ThisGuidelineID#, '#NewsDetails.Details#')
				</cfquery>			
			
			</cfloop>
			
		
			
			
			
			<!--- INDEX FILES --->
			
		<cfset IndexPath = "e:\inetpub\wwwroot\enigma\nzgg_new\guidelines\#numberformat(ThisGuidelineID, "0000")#">
		
		
		<cftry>	
			
			<cfcollection action="CREATE" collection="#IndexCollection#" path="#CollectionPath#">
			<cfindex action="REFRESH" collection="#IndexCollection#" key="#IndexPath#" type="PATH" extensions="#IndexExtensions#" recurse="Yes">
		
			<cfcatch>
			
				<cfcollection action="DELETE" collection="#IndexCollection#">
				<cfcollection action="CREATE" collection="#IndexCollection#" path="#CollectionPath#">
			<cfindex action="REFRESH" collection="#IndexCollection#" key="#IndexPath#" type="PATH" extensions="#IndexExtensions#" recurse="Yes">
			
			</cfcatch>
		
		</cftry>
		
		
		
		<cfsearch collection="#IndexCollection#" name="filesearch">			
		
		
		<cfloop query="filesearch">			
		
		
			<!--- ADD FILE INFO --->
		
			<cfquery name="LastID" datasource="#GuidelineDSN#" maxrows="1">
			SELECT SearchIndexID
			FROM dbo.GuidelineSearchIndex
			ORDER BY SearchIndexID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.SearchIndexID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>		
		
			<cfquery name="UpdateSearch" datasource="#GuidelineDSN#">
			INSERT INTO GuidelineSearchIndex(SearchIndexID, GuidelineID, SearchDetails)
			VALUES(#newID#, #ThisGuidelineID#, 'Verity_#ThisGuidelineID#_#filesearch.summary#')
			</cfquery>
			
		
		</cfloop>
		
		
			
		
	</cfoutput>
		
		






<cfoutput>		

		
<script>
alert("Indexing completed successfully!");
self.location="#request.webroot#/search/test.cfm";
</script>


</cfoutput>
		

