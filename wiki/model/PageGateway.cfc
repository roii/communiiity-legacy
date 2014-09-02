<cfcomponent displayName="Page Gateway" output="false" hint="Gateway CFC for Pages">

	<cfset variables.dsn = "">
	<cfset variables.databaseType = "">
	<cfset variables.databaseTableName = "pages">
	
	<cffunction name="init" access="public" returnType="PageGateway" output="false">
		<cfargument name="dsn" type="string" required="true">
		<cfargument name="databaseType" type="string" required="true">
		<cfargument name="databaseTablePrefix" type="string" default="">
		<cfargument name="pageDAO" type="any" required="true">
		<cfargument name="utils" type="any">
		<cfargument name="pageRender" type="any">
		<cfargument name="wiki" type="string" required="true">

		
		<cfset variables.dsn = arguments.dsn>
		<cfset variables.databaseType = arguments.databaseType>
		<cfset variables.databaseTableName = "#arguments.databaseTablePrefix#pages">
		<cfset variables.pageDAO = arguments.pageDAO>
		<cfset variables.utils = arguments.utils>
		<cfset variables.pageRender = arguments.pageRender>
		<cfset variables.wiki = arguments.wiki>

		<cfreturn this>
	</cffunction>	

	<cffunction name="deletePage" access="public" returnType="void" output="false">
		<cfargument name="currPage" type="pageBean" required="true">
		<cfargument name="reasonForDeletion" type="string" required="false" default="">
		<cfset var qData="">
		<cfquery name="qData" datasource="#variables.dsn#">
		DELETE FROM
			#variables.databaseTableName#
		WHERE
			path = <cfqueryparam value="#currPage.getPath()#" cfsqltype="cf_sql_varchar">
			and	wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
			
		</cfquery>
		<!--- TODO: Create a log of deleted items? --->
	</cffunction>

	<cffunction name="doesPageExist" access="public" returnType="boolean" output="false"
				hint="Method to determine if a given page exists in the database.">
		<cfargument name="pagePath" type="string" required="true">
		<cfargument name="version" type="numeric" required="false" default="0">
		<cfset var id=getIdForPage(arguments.pagePath, arguments.version)>
		<cfif len(id)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="getCategoryList" access="public" returnType="string" output="false"
				hint="Returns a list of all categories on all pages.">
		<cfset var q = "">
		<cfset var categoryList = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
		select     categories
		from       #variables.databaseTableName# p1
		where     (version =
                  (select     max(p2.version)
                   from          #variables.databaseTableName# p2
                   where      p1.path = p2.path
				   and p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))
		and			wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">		
		</cfquery>
		<!--- get list of all categories --->
		<cfset categoryList=ValueList(q.categories)>
		<!--- eliminate duplicates --->
		<cfset categoryList=variables.utils.listRemoveDuplicates(categoryList)>
		<!--- sort them --->
		<cfset categoryList=ListSort(categoryList, "textnocase", "asc")>
		<cfreturn categoryList>
	</cffunction>

	<cffunction name="getFileList" access="public" returnType="string" output="false"
				hint="Returns a list of all special file pages.">
		<cfset var q = "">
		<cfset var fileList = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
		select     path
		from       #variables.databaseTableName# p1
		where
	   		(version =
	           (select     max(p2.version)
	            from          #variables.databaseTableName# p2
	            where      p1.path = p2.path
	            and		   p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))
			AND
			path like 'Special.Files.%'
			and wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		order by
			path	
		</cfquery>
		<!--- get list of all files --->
		<cfset fileList=ValueList(q.path)>
		<cfreturn fileList>
	</cffunction>
			
	<cffunction name="getIdForPage" access="public" returnType="string" output="false"
				hint="Method to get the id a given page from the database.">
		<cfargument name="pagePath" type="string" required="true">
		<cfargument name="version" type="numeric" required="false" default="0">
		<cfset var pLookup = "">
		<cfquery name="pLookup" datasource="#variables.dsn#">
			select	id
			from	#variables.databaseTableName#
			where	path = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.pagePath#">
			and		wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
			<cfif arguments.version GT 0>
				and		version = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.version#">
			</cfif>
		</cfquery>
					
		<cfif pLookup.recordCount>
			<cfreturn pLookup.id>
		<cfelse>
			<cfreturn "">
		</cfif>
	</cffunction>

	<cffunction name="getOrphanedPages" access="public" returnType="query" output="false"
				hint="Returns a query of all pages that are not linked to.">
		<cfargument name="numPages" type="numeric" default="25" hint="Only return this many pages.">
		<cfargument name="Roles" type="string" default="">
		<cfargument name="HasDefaultViewRole" type="boolean" default="true">
		<cfset var columnList="id,path,body,datetimecreated,author,version,summary,categories,authrolestoview,authrolestoedit">
		<cfset var outQuery = QueryNew(columnList)>
		<cfset var linksQuery="">
		<cfset var currRole = "">
		<cfset var rowNum=0>
		<cfset var allPagesQuery=getPageIndex(arguments.roles, arguments.hasDefaultViewRole)>
		<cfset var col = "">
		
		<!--- TODO: Needs to be replaced as this will NOT scale; likely need to track page links... --->
		<!--- loop through all pages, calling getWhatLinksHere to see if there are any results --->	
		<cfloop query="allPagesQuery">
			<!--- don't check Main or Special pages --->
			<cfif (path NEQ "Main") AND (ListFirst(path, ".") NEQ "Special")>
				<cfset linksQuery=getWhatLinksHere(path, 1, arguments.Roles, arguments.hasDefaultViewRole)>
				<cfif linksQuery.recordCount EQ 0>
					<cfset queryAddRow(outQuery)>
					<cfset rowNum=outQuery.recordCount>
					<cfloop list="#columnList#" index="col">
						<cfset outQuery[col][rowNum]=evaluate("allPagesQuery.#col#")>
					</cfloop>
				</cfif>
			</cfif>
		</cfloop>
		<cfreturn outQuery>
	</cffunction>
		
	<cffunction name="getPage" access="public" returnType="PageBean" output="false"
				hint="Method to get the 'current' page, which is based on cgi.path_info.">
		<cfargument name="thisPage" type="string" required="false" default="">
		<cfargument name="version" type="numeric" required="false" default="0">
		<cfset var defaultPage = "Main">
		<cfset var vLookup = "">
		<cfset var pob = "">
		<cfset var existingPageId="">
		
		<!--- current page is either default, Main, or based on url.path, or cgi.path_info --->
		<cfif not len(arguments.thisPage)>
			<cfif len(cgi.path_info) and cgi.path_info neq cgi.script_name>
				<cfset arguments.thisPage = cgi.path_info>
				<!--- should always be /XXXX.XXXX --->
				<cfif left(arguments.thisPage,1) is "/">
					<cfset arguments.thisPage = right(arguments.thisPage, len(arguments.thisPage)-1)>
				</cfif>
			<cfelse>
				<cfset arguments.thisPage = defaultPage>
			</cfif>
		</cfif>		

		<cfif arguments.version is 0>
			<cfquery name="vLookup" datasource="#variables.dsn#">
			select	max(version) as maxversion
			from	#variables.databaseTableName#
			where	path = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.thisPage#">
			and		wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
			</cfquery>
			<cfif vLookup.recordCount and isNumeric(vLookup.maxversion)>
				<cfset arguments.version = vLookup.maxversion>
			</cfif>
		</cfif>

		<cfset existingPageId=getIdForPage(arguments.thisPage, arguments.version)>
		<cfif len(existingPageId)>
			<cfreturn variables.pageDAO.read(existingPageId)>
		<cfelse>
			<cfset pob = variables.pageDAO.new()>
			<cfset pob.setPath(arguments.thisPage)>
			<cfreturn pob>
		</cfif>
			
	</cffunction>

	<cffunction name="getPageChildren" access="public" returnType="query" output="false"
				hint="Returns a list of all pages with version, lastmod, etc.">
		<cfargument name="pageBean" type="PageBean" required="true">
		<cfset var q = "">
		<cfset var l = QueryNew("path,segment")/>
		<cfset var alreadyListed = ""/>
		<cfset var segment = ""/>

		<!--- don't show children on special pages --->
		<cfif pageBean.isSpecialPage()>
			<cfreturn l>
		</cfif>
		<cfquery name="q" datasource="#variables.dsn#">
		select     id, path, body, datetimecreated, author, version, summary, categories, authrolestoview, authrolestoedit
		from       #variables.databaseTableName# p1
		where     (version =
                  (select     max(p2.version)
                   from          #variables.databaseTableName# p2
                   where      p1.path = p2.path
				   and		  p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))
				and (path LIKE <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.pageBean.getPath()#.%">
					and
					wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
					)
		order by   p1.path asc		
		</cfquery>
		<!--- eliminate sub-sub pages with sub page in the listing --->
		<!--- this will only show the next level down, instead of all sub pages --->
		<cfloop query="q">
			<cfset segment = ListGetAt(path, ListLEN(arguments.pageBean.getPath(), ".")+1, ".")/>
			<cfif NOT ListFind(alreadyListed, segment)>
				<cfset alreadyListed = ListAppend(alreadyListed, segment)/>
				<cfset QueryAddRow(l)/>
				<cfset QuerySetCell(l, "path", ListAppend(arguments.pageBean.getPath(), segment, "."))/>
				<cfset QuerySetCell(l, "segment", segment)/>
			</cfif>
		</cfloop>
				
		<cfreturn l>
	</cffunction>

	<cffunction name="getPagesForCategory" access="public" returnType="query" output="false"
				hint="Returns a query of all pages for a given category.">
		<cfargument name="category" type="string" required="true">
		<cfset var qData = "">
		<cfset var rData = "">
	
		<cfquery name="qData" datasource="#variables.dsn#" result="rData">
		select     id, path, body, datetimecreated, author, version, summary, categories, authrolestoview, authrolestoedit
		from       #variables.databaseTableName# p1
		where     (version =
                  (select     max(p2.version)
                   from          #variables.databaseTableName# p2
                   where      p1.path = p2.path
				   and		  p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))		
			AND
			categories like <cfqueryparam value="%#arguments.category#%" cfsqltype="cf_sql_varchar" maxlength="255">
			and wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		order by path asc
		</cfquery>
		<cfreturn qData>
	</cffunction>

	<cffunction name="getPageHistory" access="public" returnType="query" output="false"
				hint="Returns the history of a page.">
		<cfargument name="pageBean" type="PageBean" required="true">
		<cfset var q = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
		select		id, body, datetimecreated, author, version, summary, categories, authrolestoview, authrolestoedit
		from		#variables.databaseTableName#
		where		path = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#arguments.pageBean.getPath()#">
		and			wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		order by 	datetimecreated DESC
		</cfquery>
		
		<cfreturn q>
	</cffunction>

	<cffunction name="getPageIndex" access="public" returnType="query" output="false"
				hint="Returns a list of all pages with version, lastmod, etc.">
		<cfargument name="Roles" type="string" default="">
		<cfargument name="HasDefaultViewRole" type="boolean" default="true">
		<cfset var q = "">
		<cfset var r = "">
		<cfset var currRole = "">
		
		<cfquery name="q" datasource="#variables.dsn#" result="r">
		select     id, path, body, datetimecreated, author, version, summary, categories, authrolestoview, authrolestoedit
		from       #variables.databaseTableName# p1
		where     (version =
                  (select     max(p2.version)
                   from          #variables.databaseTableName# p2
                   where      p1.path = p2.path
				   and		  p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))		
		<cfif len(arguments.Roles)>
			AND (
			<cfif arguments.HasDefaultViewRole>
				authrolestoview = <cfqueryparam value="" cfsqltype="cf_sql_varchar">
				OR
				authrolestoview IS NULL
				OR
			</cfif>
			<cfloop list="#arguments.roles#" index="currRole">
				authrolestoview LIKE <cfqueryparam value="%#trim(currRole)#%" cfsqltype="cf_sql_varchar">
				<cfif trim(currRole) NEQ trim(ListLast(arguments.Roles))>
				OR
				</cfif>
			</cfloop>
			)
		</cfif>
		and		wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		order by   p1.path asc		
		</cfquery>
		<!--- <cfdump var="#r#" label="r">
		<cfdump var="#q#" label="q">
		<cfabort> --->
		<cfreturn q>
	</cffunction>

	<cffunction name="getRecentUpdates" access="public" returnType="query" output="false"
				hint="Returns a query of all pages recently updated.">
		<cfargument name="numPages" type="numeric" default="25" hint="Only return this many pages.">
		<cfargument name="numDays" type="numeric" default="30" hint="Only return pages updates in the past x number of days.">
		<cfargument name="Roles" type="string" default="">
		<cfargument name="HasDefaultViewRole" type="boolean" default="true">
		<cfset var q = "">
		<cfset var r = "">
		<cfset var currRole = "">
	
		<cfquery name="q" datasource="#variables.dsn#" result="r">
		select  
			<cfif variables.databaseType EQ "mssql">
				TOP #arguments.numPages#
			</cfif>
			id, path, body, datetimecreated, author, version, summary, categories, authrolestoview, authrolestoedit
		from       #variables.databaseTableName# p1
		where     (version =
                  (select     max(p2.version)
                   from          #variables.databaseTableName# p2
                   where      p1.path = p2.path
				   and		  p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))		
			AND
			<cfif variables.databaseType EQ "mssql">
				DATEDIFF(DAY, GETDATE(), dateTimeCreated) < <cfqueryparam value="#arguments.numDays#" cfsqltype="cf_sql_integer" maxlength="255">
			<cfelseif variables.databaseType EQ "mysql">
				dateTimeCreated > DATE_SUB(NOW(), INTERVAL #arguments.numDays# DAY)
			<cfelseif variables.databaseType EQ "oracle">
				<!--- TODO: find somewhere to test these two clauses --->
				(SYSDATE - dateTimeCreated) < <cfqueryparam value="#arguments.numDays#" cfsqltype="cf_sql_integer" maxlength="255">
				AND
				ROWNUM <= #arguments.numPages#
			</cfif>
		<cfif len(arguments.Roles)>
			AND (
			<cfif arguments.HasDefaultViewRole>
				authrolestoview = <cfqueryparam value="" cfsqltype="cf_sql_varchar">
				OR
				authrolestoview IS NULL
				OR
			</cfif>
			<cfloop list="#arguments.roles#" index="currRole">
				authrolestoview LIKE <cfqueryparam value="%#trim(currRole)#%" cfsqltype="cf_sql_varchar">
				<cfif trim(currRole) NEQ trim(ListLast(arguments.Roles))>
				OR
				</cfif>
			</cfloop>
			)
		</cfif>
		and wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		ORDER BY
			dateTimeCreated DESC
		<cfif variables.databaseType EQ "mysql">
			LIMIT #arguments.numPages#
		</cfif>
		</cfquery>
		<cfreturn q>
	</cffunction>
	
	<cffunction name="getRenderInstructions" access="public" returnType="string" output="false"
				hint="Call the render object to generate documentation.">
		<cfreturn variables.pageRender.instructions()>		
	</cffunction>

	<cffunction name="getTemplateList" access="public" returnType="string" output="false"
				hint="Returns a list of all special template pages.">
		<cfset var q = "">
		<cfset var templateList = "">
		
		<cfquery name="q" datasource="#variables.dsn#">
		select     path
		from       #variables.databaseTableName# p1
		where
	   		(version =
	           (select     max(p2.version)
	            from          #variables.databaseTableName# p2
	            where      p1.path = p2.path
	            and		   p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))
			AND
			path like 'Special.Templates.%'
			and wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		order by
			path	
		</cfquery>
		<!--- get list of all templates --->
		<cfset templateList=ValueList(q.path)>
		<cfreturn templateList>
	</cffunction>
	
	<cffunction name="getWhatLinksHere" access="public" returnType="query" output="false"
				hint="Returns a query of all pages that link to a specific page.">
		<cfargument name="page" type="any" required="true">
		<cfargument name="numPages" type="numeric" default="25" hint="Only return this many pages.">
		<cfargument name="Roles" type="string" default="">
		<cfargument name="HasDefaultViewRole" type="boolean" default="true">
		<cfset var q = "">
		<cfset var r = "">
		<cfset var currRole = "">
		<cfset var pagePath="">
		<cfif IsSimpleValue(arguments.page)>
			<cfset pagePath=arguments.page>
		<cfelse>
			<cfset pagePath=arguments.page.getPath()>
		</cfif>
		<!--- TODO: this won't find camel-case auto wiki links! --->
		<cfquery name="q" datasource="#variables.dsn#" result="r">
		select  
			id, path, body, datetimecreated, author, version, summary, categories, authrolestoview, authrolestoedit
		from       #variables.databaseTableName# p1
		where     (version =
                  (select     max(p2.version)
                   from          #variables.databaseTableName# p2
                   where      p1.path = p2.path
				   and		  p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))		
			AND
			<cfif variables.databaseType eq "mssql">
				(body LIKE <cfqueryparam value="%\[\[#pagePath#\]\]%"> ESCAPE '\' OR
				 body LIKE <cfqueryparam value="%\[\[#pagePath#|%\]\]%"> ESCAPE '\')
			<cfelseif ListFindNoCase("mysql,oracle", variables.databaseType)>
				(body LIKE <cfqueryparam value="%[[#pagePath#]]%"> OR
				 body LIKE <cfqueryparam value="%[[#pagePath#|%]]%">)
			</cfif>
		<cfif len(arguments.Roles)>
			AND (
			<cfif arguments.HasDefaultViewRole>
				authrolestoview = <cfqueryparam value="" cfsqltype="cf_sql_varchar">
				OR
				authrolestoview IS NULL
				OR
			</cfif>
			<cfloop list="#arguments.roles#" index="currRole">
				authrolestoview LIKE <cfqueryparam value="%#trim(currRole)#%" cfsqltype="cf_sql_varchar">
				<cfif trim(currRole) NEQ trim(ListLast(arguments.Roles))>
				OR
				</cfif>
			</cfloop>
			)
		</cfif>
		and wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		ORDER BY
			p1.path ASC
		</cfquery>
		<cfreturn q>
	</cffunction>

	<cffunction name="movePage" access="public" returnType="string" output="false">
		<cfargument name="currPage" type="pageBean" required="true">
		<cfargument name="newPagePath" type="string" required="true">
		<cfargument name="author" type="string" required="false" default="">
		<cfargument name="reasonForMove" type="string" required="false" default="">
		<cfset var currTitle=currPage.getTitle()>
		<cfset var newPage=variables.pageDAO.new()>
		<cfset var errors="">
		<cfset var summary="[[#currPage.getPath()#]] moved to [[#arguments.newPagePath#]]">
		<!--- replace spaces in new page name --->
		<cfset arguments.newPagePath=replace(arguments.newPagePath, " ", "_", "all")>
		<cfif len(arguments.reasonForMove)>
			<cfset summary=summary & ": " & arguments.reasonForMove>
		</cfif>
		<!--- TODO: should the new page creation happen in the controller instead? --->
		<!--- create the new page bean --->
		<cfset newPage.setId(createUUID())>
		<cfset newPage.setPath(currPage.getPath()) />
		<cfset newPage.setBody("##redirect [[#arguments.newPagePath#]]") />
		<cfset newPage.setDateTimeCreated(now()) />
		<cfset newPage.setAuthor(arguments.author) />
		<cfset newPage.setVersion(1)>
		<cfset newPage.setSummary(summary) />
		<cfset newPage.setAuthRolesToView(currPage.getAuthRolesToView()) />
		<cfset newPage.setAuthRolesToEdit(currPage.getAuthRolesToEdit()) />
		<cfset newPage.setWiki(currPage.getWiki())>
		
		<!--- TODO: validate newPage data? --->
		<cfset errors=newPage.validate()>
		<!--- rename the current page --->
		<!--- TODO: catch errors on rename --->
		<cftry>
			<cfset renamePage(arguments.currPage, arguments.newPagePath)>
		<cfcatch type="canvaserror">
			<cfreturn cfcatch.Message>
		</cfcatch>
		</cftry>
		<!--- save the new page (must be done after the current page has been renamed)--->
		<cfset variables.pageDAO.create(newPage)>
		<!--- TODO: should the new page creation happen in the controller instead? --->
		<!--- create a new version with this as the summary: "m (Test moved to Test2: Here is my reason.)" --->
		<!--- create the new page bean --->
		<cfset newPage=variables.pageDAO.new()>
		<cfset newPage.setId(createUUID())>
		<cfset newPage.setPath(arguments.newPagePath) /><!--- the page has been renamed, so use the new path --->
		<cfset newPage.setBody(currPage.getBody()) />
		<cfset newPage.setDateTimeCreated(now()) />
		<cfset newPage.setAuthor(arguments.author) />
		<cfset newPage.setVersion(currPage.getVersion()+1)>
		<cfset newPage.setSummary(summary) />
		<cfset newPage.setAuthRolesToView(currPage.getAuthRolesToView()) />
		<cfset newPage.setAuthRolesToEdit(currPage.getAuthRolesToEdit()) />
		<cfset newPage.setWiki(currPage.getWiki())>
		<!--- TODO: validate newPage data? --->
		<cfset errors=newPage.validate()>
		<!--- save the new page (must be done after the current page has been renamed)--->
		<cfset variables.pageDAO.create(newPage)>
		<cfreturn "">
	</cffunction>

	<cffunction name="renamePage" access="public" returnType="void" output="false">
		<cfargument name="currPage" type="pageBean" required="true">
		<cfargument name="newPagePath" type="string" required="true">
		<cfset var newPage=variables.pageDAO.new()>
		<cfset var qData="">
		<!--- throw error if new page path exists, unless it is a version 1 redirect page --->
		<cfif doesPageExist(arguments.newPagePath)>
			<cfthrow message="New page [#arguments.newPagePath#] already exists. Please enter a different title." type="canvaserror">
		<cfelse>
			<cfquery name="qData" datasource="#variables.dsn#">
			UPDATE
				#variables.databaseTableName#
			SET
				path = <cfqueryparam value="#arguments.newPagePath#" cfsqltype="cf_sql_varchar">
			WHERE
				path = <cfqueryparam value="#currPage.getPath()#" cfsqltype="cf_sql_varchar">
			and	wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
				
			</cfquery>
		</cfif>
	</cffunction>
	
	<cffunction name="render" access="public" returnType="string" output="false"
				hint="I do the heavy lifting of transforming a page body into the display.">
		<cfargument name="pageBean" type="PageBean" required="true">
		<cfargument name="webpath" type="string" required="true">
		
		<!--- I'm not sure why I'm keeping this here, since it just passed off to render, but I kind of like the abstraction --->
		<cfreturn variables.pageRender.render(pageBean, webpath, this)>		
	</cffunction>
	
	<cffunction name="search" access="public" returnType="query" output="false"
				hint="Search pages.">
		<cfargument name="searchterms" type="string" required="true">
		<cfargument name="Roles" type="string" default="">
		<cfargument name="HasDefaultViewRole" type="boolean" default="true">
		<cfset var currRole = "">
		<cfset var search = "">
		
		<cfquery name="search" datasource="#variables.dsn#">
		select     id, path, body, datetimecreated, author, version, summary, categories, authrolestoview, authrolestoedit
		from       #variables.databaseTableName# p1
		where     (version =
                  (select     max(p2.version)
                   from          #variables.databaseTableName# p2
                   where      p1.path = p2.path
				   and		  p2.wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">))		
		and (
			path like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.searchterms#%">	
			or 
			body like <cfqueryparam cfsqltype="cf_sql_longvarchar" value="%#arguments.searchterms#%">	
			or 
			summary like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.searchterms#%">
			or 
			author like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#arguments.searchterms#%">
		)
		and	wiki = <cfqueryparam cfsqltype="cf_sql_varchar" maxlength="255" value="#variables.wiki#">
		<cfif len(arguments.Roles)>
			AND (
			<cfif arguments.HasDefaultViewRole>
				authrolestoview = <cfqueryparam value="" cfsqltype="cf_sql_varchar">
				OR
				authrolestoview IS NULL
				OR
			</cfif>
			<cfloop list="#arguments.roles#" index="currRole">
				authrolestoview LIKE <cfqueryparam value="%#trim(currRole)#%" cfsqltype="cf_sql_varchar">
				<cfif trim(currRole) NEQ trim(ListLast(arguments.Roles))>
				OR
				</cfif>
			</cfloop>
			)
		</cfif>
		order by   p1.path asc		
		</cfquery>

		<cfreturn search>
	</cffunction>	

</cfcomponent>