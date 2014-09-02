<cfcomponent displayname="Controller" output="false" extends="ModelGlue.Core.Controller">

<!--- WARNING

The following are "reserved" terms, used by the base
ModelGlue.Core.Controller.

Do not name functions any of the following:

GetModelGlue
GetControllerName
AddToCache
ExistsInCache
GetFromCache
RemoveFromCache

Do not declare variables in the variables scope named the following:

variables.ModelGlue


		 /WARNING --->


<!--- Constructor --->
<cffunction name="Init" access="Public" returnType="Controller" output="false">
	<cfargument name="ModelGlue" required="true" type="ModelGlue.ModelGlue" />
	<cfargument name="InstanceName" required="true" type="string" />
	<cfset var mimeTypeConfig="">
	<cfset var currExt="">
	<cfset var mimeTypeList="">
	<cfset var settings = structNew()>
	<cfset var key = "">
	
	<cfset super.Init(arguments.ModelGlue) />

	<!--- get the canvas setup config bean --->
	<cfset variables.CanvasConfig = GetModelGlue().GetBean("CanvasConfig").getConfig() />
	 

	<!---
	Allow for dynamic overwrites. This is something of a hack, but allows for runtime configuration
	of the wiki and multiple dynamic instances. 
	--->
	<cfif structKeyExists(application, "runtimeoverridesettings")>
		<cfloop item="key" collection="#application.runtimeoverridesettings#">
			<!--- ignore application name --->
			<cfif key is not "applicationname">
				<cfset variables.canvasconfig[key] = application.runtimeoverridesettings[key]>
			</cfif>
		</cfloop>
	</cfif>
		
	<!--- fix the upload path if necessary --->
	<cfif variables.CanvasConfig.UploadEnabled and len(variables.CanvasConfig.UploadPath)>
		<cfset variables.CanvasConfig.UploadPath=ExpandPath(variables.CanvasConfig.UploadPath)>
		<cfif not DirectoryExists(variables.CanvasConfig.UploadPath)>
			<cftry>
				<!--- try to create the directory --->
				<cfdirectory action="create" directory="#variables.CanvasConfig.UploadPath#">
			<cfcatch>
				<!--- ignore errors for now since the DirectoryExists will fail anyway --->
			</cfcatch>
			</cftry>
			<cfif not DirectoryExists(variables.CanvasConfig.UploadPath)>
				<cfthrow message="Invalid UploadPath specified. Path does not exist and could not be created.">
			<cfelse>
				<cfset variables.CanvasConfig.UploadPath=ExpandPath(variables.CanvasConfig.UploadPath)>
			</cfif>
		</cfif>
	</cfif>

	<!--- create the list of acceptable mime-types for file upload --->
	<cfset mimeTypeConfig=GetModelGlue().GetConfigBean("MimeTypes").GetConfig()>
	<cfloop list="#CanvasConfig.UploadAllowedExtensions#" index="currExt">
		<cfset currExt=trim(currExt)>
		<cfif StructKeyExists(mimeTypeConfig, currExt)>
			<cfset mimeTypeList=ListAppend(mimeTypeList, mimeTypeConfig[currExt])>
		<cfelse>
			<!--- if the current extension is not listed in the MimeTypes config, then set it to the unknown default --->
			<cfset mimeTypeList=ListAppend(mimeTypeList, mimeTypeConfig[""])>
		</cfif>
	</cfloop>
	<!--- add the mime type list to the CanvasConfig for easy reference --->
	<cfset variables.CanvasConfig.UploadAllowedMimeTypes = mimeTypeList />

	<!--- create an instance of the factory --->
	<!--- 
		I'm passing all the settings to the factory. 
		I don't think this is great - but for now, it gets the factory "in the know" about
		all settings, and the factory can handle using what it needs where it needs to.
		Need to investigate CS later...
	--->
	<cfset settings.dsn = variables.canvasconfig.dsn>
	<cfset settings.databasetype = variables.CanvasConfig.databaseType>
	<cfset settings.databasetableprefix = variables.CanvasConfig.databaseTablePrefix>
	<cfset settings.wikitermsenabled =  variables.CanvasConfig.WikiTermsEnabled>
	<cfset settings.wikitocminitems = variables.CanvasConfig.WikiTOCMinItems>
	<cfset settings.wiki = variables.CanvasConfig.wiki>
	
	<cfset variables.factory = createObject("component","#variables.canvasconfig.root#.model.Factory").init(settings)>

	<!--- create an instance of the PageGateway --->
	<cfset variables.pageGateway = variables.factory.getInstance('pageGateway')>
	
	<!--- create an instance of the PageDAO --->	
	<cfset variables.pageDAO = variables.factory.getInstance('pageDAO')>
	
	<!--- setup a diff object --->
	<cfset variables.diffObj = variables.factory.getInstance('diffObj')>
	
	<!--- map diff operation to CSS classes, legend output, etc. (used on display page) --->
	<cfset variables.WikiDiffOperationClassStruct=StructNew()>
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_INSERT]=StructNew()>
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_INSERT].class="wiki_diff_ins">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_INSERT].name="insert">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_INSERT].legend="Inserted Lines">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_DELETE]=StructNew()>
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_DELETE].class="wiki_diff_del">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_DELETE].name="delete">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_DELETE].legend="Deleted Lines">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_UPDATE]=StructNew()>
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_UPDATE].class="wiki_diff_upd">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_UPDATE].name="update">
	<cfset variables.WikiDiffOperationClassStruct[diffObj.OPERATION_UPDATE].legend="Updated Lines">
	<cfset variables.WikiDiffOperationClassStruct[""]=StructNew()>
	<cfset variables.WikiDiffOperationClassStruct[""].class="">
	<cfset variables.WikiDiffOperationClassStruct[""].name="">
	<cfset variables.WikiDiffOperationClassStruct[""].legend="">
	<!--- set this to create a dynamic legend sorted in the order we want --->
	<cfset variables.WikiDiffOperationClassStruct.legendsortorder="#diffObj.OPERATION_INSERT#,#diffObj.OPERATION_DELETE#,#diffObj.OPERATION_UPDATE#">
	<!--- mimic the operations from the diffObj --->
	<cfset variables.WikiDiffOperationClassStruct.operations=StructNew()>
	<cfset variables.WikiDiffOperationClassStruct.operations.OPERATION_INSERT=diffObj.OPERATION_INSERT>
	<cfset variables.WikiDiffOperationClassStruct.operations.OPERATION_DELETE=diffObj.OPERATION_DELETE>
	<cfset variables.WikiDiffOperationClassStruct.operations.OPERATION_UPDATE=diffObj.OPERATION_UPDATE>

	<cfset variables.utils = variables.factory.getInstance('utils')>
		
	<cfreturn this />
</cffunction>

<!--- Functions specified by <message-listener> tags --->
<cffunction name="OnRequestStart" access="Public" returntype="void" output="false" hint="I am an event handler.">
	<cfargument name="event" type="any" required="true">
	<cfset var pageOb = getPageGateway().getPage(arguments.event.getValue("path"), arguments.event.getValue("version", 0))>
	<cfset var webpath = cgi.script_name>
	<cfset webpath = replaceNoCase(webpath, "/index.cfm", "")>

	<!--- Every request has a page. --->
	<cfset arguments.event.setValue("page", pageOb) />
	<!--- Save current web path. This is used in layout. --->
	<cfset arguments.event.setValue("webpath", webpath)>
	<!--- put app title in view state --->
	<cfset arguments.event.setValue("appTitle", variables.CanvasConfig.AppTitle)>
	<!--- put canvas setup in the view state --->
	<cfset arguments.event.setValue("CanvasConfig", variables.CanvasConfig)>
</cffunction>

<cffunction name="OnRequestEnd" access="Public" returntype="void" output="false" hint="I am an event handler.">
	<cfargument name="event" type="any" required="true">
</cffunction>

<cffunction name="commitPage" access="Public" returnType="void" output="false" hint="Handles adding/updating a page.">
	<cfargument name="event" type="any" required="true">

	<cfset var page = arguments.event.getValue("page") />
	<cfset var UserRecord = arguments.event.getValue("UserRecord") />
	<cfset var errors = "">
	<cfset var path = "">
	<cfset var theurl = "">
	
	<cfset page.setID(createUUID()) />
	<cfset page.setPath(page.getPathNoSpaces()) />
	<cfset page.setBody(arguments.event.getValue("body")) />
	<cfset page.setDateTimeCreated(now()) />
	<cfif variables.CanvasConfig.LoginRequiredForEditing>
		<cfset page.setAuthor("#UserRecord.getFullName()# [#UserRecord.getUniqueId()#]") />
	<cfelse>
		<cfset page.setAuthor(arguments.event.getValue("author")) />
	</cfif>
	<cfif page.getVersion() neq "">
		<cfset page.setVersion(page.getVersion()+1) />
	<cfelse>
		<cfset page.setVersion(1)>
	</cfif>
	<cfset page.setSummary(arguments.event.getValue("summary")) />
	<cfset page.setCategories(page.discoverCategories()) />
	<cfset page.setAuthRolesToView(ListToArray(arguments.event.getValue("authRolesToView"))) />
	<cfset page.setAuthRolesToEdit(ListToArray(arguments.event.getValue("authRolesToEdit"))) />
	
	<cfset errors = page.validate()>	

	<cfif arrayLen(errors)>
		<cfset arguments.event.addResult("invalid") />
		<cfset arguments.event.setValue("errors", errors) />
	<cfelse>
		<!--- always create() b/c we never really edit a page--it's always a new version --->
		<cfset getPageDAO().create(page) />
		
		<!--- Notify the admin? --->
		<cfif len(variables.CanvasConfig.emailOnChange)>
			<cfset path = arguments.event.getValue("webpath")>
			<cfset theurl = "http">
			<cfif len(cgi.https) and cgi.https is not "off">
				<cfset theurl = theurl & "s">
			</cfif>

			<cfset theurl = theurl & "://#cgi.server_name##cgi.script_name#/#page.getPath()#">
			
			<cfmail to="#variables.CanvasConfig.emailOnChange#" from="#variables.CanvasConfig.emailOnChange#" subject="#variables.CanvasConfig.AppTitle# Notification: Page Update" type="html">
			<cfoutput>
			Page Updated: <a href="#theurl#">#page.getPath()#</a><br />
			<cfif len(page.getAuthor())>
			Author: #page.getAuthor()#<br />
			</cfif>
			<cfif len(page.getSummary())>
			Summary: #page.getSummary()#<br />
			</cfif>
			Version: #page.getVersion()#<br />
			Updated: #dateFormat(page.getDateTimeCreated(), "short")# #timeFormat(page.getDateTimeCreated(), "short")#<br />
			<hr>
			#variables.pageGateway.render(page,path)#
			</cfoutput>
			</cfmail>
		</cfif>
		<!--- reset the path in case it changed from what the user entered (e.g. removal of spaces) --->
		<cfset arguments.event.setValue("path", page.getPath()) />
		<cfset arguments.event.addResult("success") />
	</cfif>

</cffunction>

<cffunction name="movePage" access="Public" returnType="void" output="false" hint="Handles moving a page.">
	<cfargument name="event" type="any" required="true">

	<cfset var page = arguments.event.getValue("page") />
	<cfset var UserRecord = arguments.event.getValue("UserRecord") />
	<cfset var author = "">
	<cfset var newpath = arguments.event.getValue("newpath")>
	<cfset var reason = arguments.event.getValue("reason")>
	<cfset var webpath = arguments.event.getValue("webpath")>
	<cfset var msg="">
	<cfset var errorMsg="">
	<cfif variables.CanvasConfig.LoginRequiredForEditing>
		<cfset author="#UserRecord.getFullName()# [#UserRecord.getUniqueId()#]" />
	<cfelse>
		<cfset author=page.getAuthor("author") />
	</cfif>
	<!--- move page and check for errors --->
	<cfset errorMsg=getPageGateway().movePage(page, newpath, author, reason) />
	<cfif len(errorMsg)>
		<!--- error --->
		<cfset arguments.event.setValue("errorMsg", errorMsg) />
		<cfset arguments.event.addResult("invalid") />
	<cfelse>
		<!--- success --->
		<cfset arguments.event.setValue("pageHeader", "Move successful") />
		<cfsavecontent variable="msg"><cfoutput>Page "<a href="#webpath#/index.cfm/#URLEncodedFormat(page.getPath())#">#page.getPath()#</a>" was successfully moved to "<a href="#webpath#/index.cfm/#replace(newpath, " ", "_", "ALL")#">#newpath#</a>".</cfoutput></cfsavecontent>
		<cfset arguments.event.setValue("pageMessage", msg) />
		<cfset arguments.event.addResult("success") />
	</cfif>

</cffunction>

<cffunction name="deletePage" access="Public" returnType="void" output="false" hint="Handles deleting a page.">
	<cfargument name="event" type="any" required="true">
	<cfset var page = arguments.event.getValue("page") />
	<cfset var reason = arguments.event.getValue("reason")>
	<!--- TODO: check for errors? error result? --->
	<cfset getPageGateway().deletePage(page, reason) />
	<cfset arguments.event.setValue("pageHeader", "Deletion successful") />
	<cfset arguments.event.setValue("pageMessage", """#page.getTitle()#"" has been deleted.") />
	<!---<cfset arguments.event.setValue("message", """#page.getTitle()#"" has been deleted. See _deletion log_ (Special:Log/delete) for a record of recent deletions.") /> --->
	<!--- success --->
	<cfset arguments.event.addResult("success") />

</cffunction>

<cffunction name="editInstructions" access="public" returnType="void" output="false"
			hint="Gets the documentation for editing pages.">
	<cfargument name="event" type="any" required="true">
			
	<cfset arguments.event.setValue("editInstructions", getPageGateway().getRenderInstructions()) />

</cffunction>

<cffunction name="getPageChildren" access="public" returnType="void" output="false"
			hint="Gets all of the page names of pages that are children to this page.">
	<cfargument name="event" type="any" required="true">
				
	<cfset arguments.event.setValue("pagechildren", getPageGateway().getPageChildren(arguments.event.getValue("page"))) />
	
</cffunction>

<cffunction name="getPageDAO" access="private" output="false">
	<cfreturn variables.pageDAO>
</cffunction>

<cffunction name="getPageGateway" access="private" output="false">
	<cfreturn variables.pageGateway>
</cffunction>

<cffunction name="getPageRender" access="public" returnType="void" output="false"
			hint="Gets the render for the current page.">
	<cfargument name="event" type="any" required="true">
	<cfset var pageBean=arguments.event.getValue("page")>			
	<cfset var webpath=arguments.event.getValue("webpath")>
	<cfset var showfile=arguments.event.getValue("showfile", false)>
	<cfset var redirect=arguments.event.getValue("redirect", true)><!--- add "redirect=no" to URL to view/edit page --->
	<cfset var fileFullPath="">
	<cfset var destfile="">
	
	<cfif isObject(pageBean)>
		<cfif pageBean.isRedirectPage() and redirect>
			<cfset arguments.event.setValue("path", pageBean.getRedirectPage())>
			<cfset arguments.event.setValue("redirectedfrom", pageBean.getPath())>
			<cfset arguments.event.forward("Main", "path,redirectedfrom") />
		<cfelseif pageBean.isNonHtmlPage()>
			<cfset fileFullPath="#variables.CanvasConfig.UploadPath#/#pageBean.getFileName()#">
			<cfif (len(pageBean.getFileName()) EQ 0) OR (NOT FileExists(fileFullPath))>
				<!--- media file doesn't exist, so redirect to the upload form, prefilling the destination file --->
				<cfset destfile=replaceNoCase(pageBean.getPath(), "special.files.", "")>
				<cfset arguments.event.setValue("destfile", destfile)>
				<cfset arguments.event.forward("UploadForm", "destfile") />
			</cfif>
			<cfif showfile>
				<cfset arguments.event.setValue("contenttype", pageBean.getFileMimeType())>
				<cfset arguments.event.setValue("contentfile", "#fileFullPath#")>
				<cfset arguments.event.addResult("nonhtml") />
			<cfelse>
				<cfset arguments.event.setValue("pagerender", getPageGateway().render(pageBean, webPath)) />
			</cfif>
		<cfelse>
			<cfset arguments.event.setValue("pagerender", getPageGateway().render(pageBean, webPath)) />
		</cfif>
	</cfif>
	
</cffunction>

<cffunction name="getPageCredentials" access="public" returnType="void" output="false"
			hint="Gets the credentials for the current page.">
	<cfargument name="event" type="any" required="true">
	<!--- need to page to determine page-level auth requirements --->
	<cfset var pageBean=arguments.event.getValue("page")>		
	<!--- determine the pageMode we are in: edit or view --->	
	<cfset var pageMode=arguments.event.getArgument("pageMode", "VIEW")>
	<cfset var pageRoles="">
	<!--- save the pageMode so we can use it in the invalidrole view --->
	<cfset arguments.event.setValue("pageMode", lcase(pageMode))>
	<cfswitch expression="#pageMode#">
		<cfcase value="VIEW">
			<cfset pageRoles=pageBean.getAuthRolesToViewList()>
			<!--- if empty, use the default for this app --->
			<cfif len(trim(pageRoles)) EQ 0>
				<cfset pageRoles=variables.CanvasConfig.defaultAuthRolesToView>
			</cfif>
		</cfcase>
		<cfcase value="EDIT,MOVE,DELETE">
			<cfset pageRoles=pageBean.getAuthRolesToEditList()>
			<!--- if empty, use the default for this app --->
			<cfif len(trim(pageRoles)) EQ 0>
				<cfset pageRoles=variables.CanvasConfig.defaultAuthRolesToEdit>
			</cfif>
		</cfcase>
		<cfdefaultcase>
			<cfthrow message="Invalid pageMode (#pageMode#)">
		</cfdefaultcase>
	</cfswitch>
	<cfset arguments.event.setValue("pageRoles", pageRoles)>
</cffunction>

<cffunction name="ValidatePageCredentials" access="public" returnType="void" output="false"
			hint="Validate the credentials for the current page and user.">
	<cfargument name="event" type="any" required="true">
	<cfset var pageRoles=arguments.event.getValue("pageRoles", "")>
	<cfset var userRoles=arguments.event.getValue("userRoles", "")>
	<cfset var pageMode=arguments.event.getValue("pageMode", "")>
	<cfset var roleDelimiter=arguments.event.getValue("roleDelimiter", ",")>
	<cfset var roleToCheck="">
	<cfset var hasRole=false>
	<cfset var pageAuth=arguments.event.getValue("pageAuth", StructNew())>
	<cfset var loginRequired=false>
	<cfswitch expression="#pageMode#">
		<cfcase value="EDIT,MOVE,DELETE">
			<cfset loginRequired=variables.CanvasConfig.LoginRequiredForEditing>
		</cfcase>
		<cfcase value="VIEW">
			<cfset loginRequired=variables.CanvasConfig.LoginRequiredForViewing>
		</cfcase>
	</cfswitch>
	<cfif isArray(pageRoles)>
		<cfset pageRoles=ArrayToList(pageRoles, roleDelimiter)>
	</cfif>
	<cfif isArray(userRoles)>
		<cfset userRoles=ArrayToList(userRoles, roleDelimiter)>
	</cfif>

	<cfif not LoginRequired>
		<!--- no login is required, return valid --->
		<cfset hasRole=true>
	<cfelseif (len(trim(pageRoles)) EQ 0)>
		<!--- if there are no pageRoles, return valid --->
		<cfset hasRole=true>
	<cfelseif len(trim(userRoles)) EQ 0>
		<!--- page has required roles, but the user has no roles, return invalid --->
		<cfset hasRole=false>
	<cfelseif ListFindNoCase(userRoles, "sysop")>
		<!--- user has sysop role, return valid --->
		<cfset hasRole=true>
	<cfelse>
		<!--- at least one of the page roles must match at least one of the user roles --->
		<cfloop index="roleToCheck" list="#pageRoles#" delimiters="#roleDelimiter#">
			<cfif ListFindNoCase(userRoles, trim(roleToCheck))>
				<cfset hasRole=true>
				<cfbreak>
			</cfif>
		</cfloop>
	</cfif>
	<!--- return valid or invalid --->
	<cfif hasRole>
		<cfset arguments.event.addResult("validRole") />
	<cfelse>
		<cfset arguments.event.addResult("invalidRole") />
	</cfif>
	<!--- store the result of this; access using pageAuth["edit"] or pageAuth["view"] --->
	<cfif len(pageMode)>
		<cfset pageAuth[pageMode]=hasRole>
		<cfset arguments.event.setValue("pageAuth", pageAuth)>
	</cfif>
</cffunction>

<cffunction name="getDefaultPageAuthRoles" access="public" returnType="void" output="false"
			hint="Gets the default page authorization roles.">
	<cfargument name="event" type="any" required="true">
	<cfset arguments.event.setValue("defaultAuthRolesToView", variables.CanvasConfig.defaultAuthRolesToView)>
	<cfset arguments.event.setValue("defaultAuthRolesToEdit", variables.CanvasConfig.defaultAuthRolesToEdit)>
</cffunction>

<cffunction name="getPageHistory" access="public" returnType="void" output="false"
			hint="Gets the history for the current page.">
	<cfargument name="event" type="any" required="true">
				
	<cfset arguments.event.setValue("pagehistory", getPageGateway().getPageHistory(arguments.event.getValue("page"))) />
	
</cffunction>

<cffunction name="getPageDiff" access="public" returnType="void" output="false"
			hint="Gets the history for the current page.">
	<cfargument name="event" type="any" required="true">
	<!---
	* Controller.OnRequestStart gets the main page (dsp.pagehistory passes the path and version number)
	* Mimic the OnRequestStart calls to get the secondary pageToDiff page object
	 --->
 	<cfset var pageToDiff = getPageGateway().getPage(arguments.event.getValue("path"), arguments.event.getValue("diffver", 0))>
	<cfset var diffObj=variables.diffObj>
	<cfset var diffQuery="">
	<cfset var page=arguments.event.getValue("page")>
	<!--- store the second page obj in an accessible variable so the display page can get the version number --->
	<cfset arguments.event.setValue("pageToDiff", pageToDiff) />
	<!--- Use the diff component to compare the bodies of the two pages --->
	<cfset diffObj.init(page.getBody(), pageToDiff.getBody())>
	<cfset diffObj.doDiff()>
	<cfset diffQuery=diffObj.getResult()>
	<!--- Set the result output into some variable --->
	<cfset arguments.event.setValue("diffQuery", diffQuery) />
	<!--- put diff operation class structure in the view state --->
	<cfset arguments.event.setValue("WikiDiffOperationClassStruct", variables.WikiDiffOperationClassStruct)>
</cffunction>

<cffunction name="getPageIndex" access="public" returnType="void" output="false"
			hint="Gets all of the page names.">
	<cfargument name="event" type="any" required="true">
	<cfset var UserRecord=arguments.event.getValue("UserRecord")>
	<cfset var pageQuery=getPageGateway().getPageIndex(UserRecord.getRoles(), UserRecord.hasRole(CanvasConfig.defaultAuthRolesToView)) />
	<cfset var pageMessage = "">
	<cfset arguments.event.setValue("pageQuery", pageQuery) />
	<cfset arguments.event.setValue("pageHeader", "Site Index") />
	<cfsavecontent variable="pageMessage"><cfoutput>
		This site currently has 
		<cfif pageQuery.recordCount gt 0>#pageQuery.recordCount# page<cfif pageQuery.recordCount NEQ 1>s</cfif><cfelse>no pages</cfif>.
	</cfoutput></cfsavecontent>
	<cfset arguments.event.setValue("pageMessage", pageMessage) />
</cffunction>

<cffunction name="getRecentUpdates" access="public" returnType="void" output="false"
			hint="Gets all of the recent updated pages.">
	<cfargument name="event" type="any" required="true">
	<cfset var numPages = arguments.event.getValue("numPages", 25)>			
	<cfset var numDays = arguments.event.getValue("numDays", 30)>	
	<cfset var UserRecord=arguments.event.getValue("UserRecord")>
	<cfset var pageQuery=getPageGateway().getRecentUpdates(numPages, numDays, UserRecord.getRoles(), UserRecord.hasRole(CanvasConfig.defaultAuthRolesToView))>
	<cfset var pageMessage="">
	<!--- set these in case they were not set so that we can access them in the view --->		
	<cfset arguments.event.setValue("numPages", numPages)>
	<cfset arguments.event.setValue("numDays", numDays)>			
	<cfset arguments.event.setValue("pageQuery", pageQuery) />
	<cfset arguments.event.setValue("pageHeader", "Recent Updates") />
	<cfsavecontent variable="pageMessage"><cfoutput>
		The following is a list of the 
		#pageQuery.recordCount# most recently updated page<cfif pageQuery.recordCount NEQ 1>s</cfif>
		from the past #numDays# day<cfif numDays NEQ 1>s</cfif>.
	</cfoutput></cfsavecontent>
	<cfset arguments.event.setValue("pageMessage", pageMessage) />
</cffunction>

<cffunction name="search" access="public" returnType="void" output="false"
			hint="Search Wiki.">
	<cfargument name="event" type="any" required="true">
	<cfset var searchTerms = arguments.event.getValue("searchterms")>
	<cfset var autoRedirect = arguments.event.getValue("autoRedirect", true)>
	<cfset var pageQuery="">
	<cfset var searchTitleList="">
	<cfset var redirectPage="">
	<cfset var pageMessage="">
	<cfset var UserRecord=arguments.event.getValue("UserRecord")>
	
	<cfif searchTerms neq "">
		<cfset pageQuery=getPageGateway().search(searchterms, UserRecord.getRoles(), UserRecord.hasRole(CanvasConfig.defaultAuthRolesToView)) />
		<cfset arguments.event.setValue("pageQuery", pageQuery) />
		<cfif autoRedirect>
			<!--- look for exact title match --->
			<!--- TODO: should we split out paths with dots and check each piece individually? --->
			<cfset searchTitleList=ValueList(pageQuery.path, chr(9))>
			<cfif ListFindNoCase(searchTitleList, searchTerms, chr(9))>
				<!--- replace spaces with underscores --->
				<cfset redirectPage=replace(searchTerms, " ", "_", "ALL")>
				<cfset arguments.event.setValue("path", redirectPage)>
				<!--- go directly to the matching page --->
				<cfset arguments.event.forward("Main", "path") />
			</cfif>
		</cfif>
		<cfset arguments.event.setValue("pageQuery", pageQuery) />
		<cfsavecontent variable="pageMessage"><cfoutput>Your search for "#searchterms#" returned
			<cfif isQuery(pageQuery) and pageQuery.recordCount gt 0>#pageQuery.recordCount# result<cfif pageQuery.recordCount NEQ 1>s</cfif><cfelse>no results</cfif>.
		</cfoutput></cfsavecontent>
		<cfset arguments.event.setValue("pageMessage", pageMessage) />
	</cfif>
</cffunction>

<cffunction name="GetWhatLinksHere" access="public" returnType="void" output="false"
			hint="Find all pages that link to a given page.">
	<cfargument name="event" type="any" required="true">
	<cfset var page = arguments.event.getValue("page")>
	<cfset var numPages = arguments.event.getValue("numPages", 25)>			
	<cfset var pageQuery="">
	<cfset var UserRecord=arguments.event.getValue("UserRecord")>
	<cfset pageQuery=getPageGateway().getWhatLinksHere(page, numPages, UserRecord.getRoles(), UserRecord.hasRole(CanvasConfig.defaultAuthRolesToView)) />
	<!--- set these to provide access in the view --->		
	<cfset arguments.event.setValue("numPages", numPages)>
	<cfset arguments.event.setValue("pageQuery", pageQuery) />
	<cfset arguments.event.setValue("pageHeader", "What Links Here: ""#page.getPath()#""") />
</cffunction>

<cffunction name="GetOrphanedPages" access="public" returnType="void" output="false"
			hint="Find all pages that are not linked to.">
	<cfargument name="event" type="any" required="true">
	<cfset var numPages = arguments.event.getValue("numPages", 25)>			
	<cfset var pageQuery="">
	<cfset var UserRecord=arguments.event.getValue("UserRecord")>
	<cfset pageQuery=getPageGateway().getOrphanedPages(numPages, UserRecord.getRoles(), UserRecord.hasRole(CanvasConfig.defaultAuthRolesToView)) />
	<!--- set these to provide access in the view --->		
	<cfset arguments.event.setValue("numPages", numPages)>
	<cfset arguments.event.setValue("pageQuery", pageQuery) />
	<cfset arguments.event.setValue("pageHeader", "Orphaned Pages") />
</cffunction>

<cffunction name="CheckForPrintable" access="public" returnType="void" output="false"
			hint="">
	<cfargument name="event" type="any" required="true">
	<cfif arguments.event.valueExists("printFormat")>
		<cfset arguments.event.addResult("printable") />
	<cfelse>
		<cfset arguments.event.addResult("normal") />
	</cfif>
</cffunction>

<cffunction name="ValidateUploadEnabled" access="Public" returnType="void" output="false" hint="Validates if file uploads are enabled.">
	<cfargument name="event" type="any" required="true">
	<cfif variables.CanvasConfig.UploadEnabled>
		<cfset arguments.event.addResult("UploadEnabled") />
	<cfelse>
		<cfset arguments.event.addResult("UploadDisabled") />
	</cfif>
</cffunction>

<cffunction name="uploadFile" access="Public" returnType="void" output="false" hint="Handles uploading a file.">
	<cfargument name="event" type="any" required="true">
	<cfset var page = arguments.event.getValue("page") />
	<cfset var fileRes="">
	<cfset var destFile=arguments.event.getValue("destfile")>
	<!--- eliminate spaces in file names for use with cffile destination --->
	<cfset var destFileWithUnderscores=ReReplace(destFile, "[\W ]", "_", "ALL")>
	<!--- convert the last underscore back to a period --->
	<cfset var extension=ListLast(destFileWithUnderscores, "_")>
	<cfset destFileWithUnderscores=ListDeleteAt(destFileWithUnderscores, ListLen(destFileWithUnderscores, "_"), "_") & "." & extension>
	<cftry>
		<cfif len(variables.CanvasConfig.UploadAllowedMimeTypes)>
			<cffile action="upload" destination="#variables.CanvasConfig.UploadPath#" nameconflict="overwrite" result="fileRes" filefield="sourcefile" accept="#variables.CanvasConfig.UploadAllowedMimeTypes#">
		<cfelse>
			<!--- don't pass in the accept attribute when there is a blank mime types list --->
			<cffile action="upload" destination="#variables.CanvasConfig.UploadPath#" nameconflict="overwrite" result="fileRes" filefield="sourcefile">
		</cfif>
		<cfif not fileRes.fileWasSaved>
			<cfset arguments.event.setValue("errorMsg", "File could not be uploaded") />
		</cfif>
	<cfcatch>
		<cfif FindNoCase("MIME type", cfcatch.Message)>
			<cfset arguments.event.setValue("errorMsg", cfcatch.detail) />
		<cfelse>
			<cfset arguments.event.setValue("errorMsg", cfcatch.detail) />
		</cfif>
	</cfcatch>
	</cftry>

	<cfif NOT len(arguments.event.getValue("errorMsg"))>
		<!--- set the special path in the page object (don't use the original destFile b/c it may have invalid characters) --->
		<cfset page.setPath("Special.Files.#destFileWithUnderscores#")>
		<!--- reset the path variable so the the load works and the redirect in the ModelGlue.xml goes to this page --->
		<cfset arguments.event.setValue("path", page.getPath())>
		<!--- try loading the page again since the path value will have changed from the upload page --->
		<cfset page=getPageGateway().getPage(arguments.event.getValue("path"), arguments.event.getValue("version", 0))>
	
		<!--- use the server file name here because this is how we will reference it --->
		<cfset page.setFileName(fileRes.ServerFile)>
		<cfset page.setFileMimeType(fileRes.ContentType & "/" & fileRes.ContentSubType)>
		<cfset page.setFileSize(fileRes.FileSize)>
		<!--- if it's an image, get image dimensions --->
		<cfif fileRes.ContentType EQ "image">
			<cfset page.setImageDimensions(variables.utils.getImageDimensions(fileRes.ServerDirectory & "/" & page.getFileName()))>
		</cfif>
		<!--- set a default body since it cannot be blank --->
		<cfset arguments.event.setValue("body", page.getFileName())>
		<!--- save our updated page objecdt back to the event --->
		<cfset arguments.event.setValue("page", page)>
		<cfset commitPage(arguments.event)>
		<cfset arguments.event.addResult("success") />
	<cfelse>
		<cfset arguments.event.addResult("invalid") />
	</cfif>
</cffunction>

<cffunction name="LogPageView" access="Public" returnType="void" output="false" hint="Logs a page view.">
	<cfargument name="event" type="any" required="true">
	<!--- TODO: implement LogPageView --->
	<!--- this will require a separate table for tracking --->
</cffunction>

</cfcomponent>