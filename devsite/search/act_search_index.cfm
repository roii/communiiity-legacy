<!--- DELETE OLD CONTENT --->
<cfquery name="DeleteSearchStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM SearchStuff
</cfquery>


<!--- ADD SECTIONS --->

		<cfquery name="AllSections" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM sections
		</cfquery>
		
		<cfloop query="AllSections">
		
			<!--- GENERATE SEARCHID --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SearchID
			FROM SearchStuff
			ORDER BY SearchID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid = (#lastID.SearchID# + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>
		
		
			<cfquery name="UpdateSections" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SearchStuff(SearchID, Type, Title, introduction, Details, Fuseaction, PrimaryLinkID)
			VALUES(#newID#, 'Section', '#AllSections.Title#', '#AllSections.introduction#', '#AllSections.Details#', '#AllSections.Fuseaction#', #allsections.sectionID#)
			</cfquery>
		
		</cfloop>
		
		
		
		
<!--- ADD DOCUMENTS --->
		
		<cfquery name="AllDocs" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Documents
		</cfquery>
		
		<cfloop query="AllDocs">
		
		
			<!--- GENERATE SEARCHID --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SearchID
			FROM SearchStuff
			ORDER BY SearchID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid1 = (#lastID.SearchID# + 1)>
			<cfelse>
				<cfset newid1 = 1>
			</cfif>
		
		
			<cfquery name="UpdateDocs" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SearchStuff(SearchID, Type, Title, introduction, Details, PrimaryLinkID)
			VALUES(#newID1#, 'Doc', '#allDocs.Title#', '#allDocs.introduction#', '#allDocs.Details#', #allDocs.DocumentID#)
			</cfquery>
		
		</cfloop>
		
		
		
		
<!--- ADD ARTICLES --->
		
		<cfquery name="AllArts" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Articles
		</cfquery>
		
		<cfloop query="AllArts">
		
			<!--- GENERATE SEARCHID --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SearchID
			FROM SearchStuff
			ORDER BY SearchID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid2 = (#lastID.SearchID# + 1)>
			<cfelse>
				<cfset newid2 = 1>
			</cfif>
		
			<cfquery name="UpdateArts" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SearchStuff(SearchID, Type, Title, introduction, Details, PrimaryLinkID)
			VALUES(#newID2#, 'Art', '#AllArts.ArticleTitle#', '#AllArts.introduction#', '#AllArts.Details#', #AllArts.ArticleID#)
			</cfquery>
		
		</cfloop>
		
		
		
		
<!--- ADD SUBARTICLES --->
		
		<cfquery name="AllSubArts" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM SubArticles
		</cfquery>
		
		<cfloop query="AllSubArts">
		
			<!--- GENERATE SEARCHID --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SearchID
			FROM SearchStuff
			ORDER BY SearchID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid3 = (#lastID.SearchID# + 1)>
			<cfelse>
				<cfset newid3 = 1>
			</cfif>
		
			<cfquery name="UpdateArts" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SearchStuff(SearchID, Type, Title, introduction, Details, PrimaryLinkID)
			VALUES(#newid3#, 'SubArt', '#AllSubArts.SubArticleTitle#', '#AllSubArts.SubIntroduction#', '#AllSubArts.SubDetails#', #AllSubArts.SubArticleID#)
			</cfquery>
		
		</cfloop>
		
		
		
		
<!--- ADD FILES --->
		
		<cfquery name="AllFiles" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Library
		</cfquery>
		
		<cfloop query="AllFiles">
		
			<!--- GENERATE SEARCHID --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SearchID
			FROM SearchStuff
			ORDER BY SearchID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid3 = (#lastID.SearchID# + 1)>
			<cfelse>
				<cfset newid3 = 1>
			</cfif>
		
			<cfquery name="UpdateFiles" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SearchStuff(SearchID, Type, Title, introduction, Details, PrimaryLinkID)
			VALUES(#newID3#, 'File', '#AllFiles.Title#', ' ', '#AllFiles.Details#', #AllFiles.RecordID#)
			</cfquery>
		
		</cfloop>
		
		
		
		
<!--- ADD EVENTS --->
		
		<cfquery name="AllEvents" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Events
		</cfquery>
		
		<cfloop query="AllEvents">
		
			<!--- GENERATE SEARCHID --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SearchID
			FROM SearchStuff
			ORDER BY SearchID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid4 = (#lastID.SearchID# + 1)>
			<cfelse>
				<cfset newid4 = 1>
			</cfif>
		
			<cfquery name="UpdateFiles" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SearchStuff(SearchID, Type, Title, introduction, Details, PrimaryLinkID)
			VALUES(#newID4#, 'Event', '#AllEvents.EventTitle#', ' ', '#AllEvents.Details#', #AllEvents.EventID#)
			</cfquery>
		
		</cfloop>
		
		
		
		
<!--- ADD NEWS --->
		
		<cfquery name="AllNews" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM News
		</cfquery>
		
		<cfloop query="AllNews">
		
			<!--- GENERATE SEARCHID --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SearchID
			FROM SearchStuff
			ORDER BY SearchID DESC
			</cfquery>
			
			<cfif #lastid.recordcount# GT 0>
				<cfset newid5 = (#lastID.SearchID# + 1)>
			<cfelse>
				<cfset newid5 = 1>
			</cfif>
		
			<cfquery name="UpdateFiles" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO SearchStuff(SearchID, Type, Title, introduction, Details, PrimaryLinkID)
			VALUES(#newID5#, 'News', '#AllNews.Title#', '#AllNews.introduction#', '#AllNews.Details#', #AllNews.RecordID#)
			</cfquery>
		
		</cfloop>


		
		





<cfquery name="SearchInfo" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SearchStuff
</cfquery>

<cftry>
	<cfcollection action="CREATE" collection="gin_search" path="C:\CFusionMX\verity\collections">
	<cfindex action="UPDATE" collection="gin_search" key="searchID" type="CUSTOM" title="Title" query="SearchInfo" body="Title,introduction,Details">
<cfcatch>
	<cfindex action="UPDATE" collection="gin_search" key="searchID" type="CUSTOM" title="Title" query="SearchInfo" body="Title,introduction,Details">
</cfcatch>

</cftry>

	
