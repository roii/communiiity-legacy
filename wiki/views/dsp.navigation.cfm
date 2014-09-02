<cfsetting enablecfoutputonly=true>
<!---
	Name         : dsp.navigation.cfm
	Author       : Mark Mazelin
	Created      : 10/04/06
	Last Updated : 
	History      : Split from layout.main.cfm
--->
<cfset page = viewState.getValue("page")>
<cfset appTitle = viewState.getValue("appTitle")>
<cfset title = viewState.getValue("title", "#page.getPath()#")>
<cfset webpath = viewState.getValue("webpath")>
<cfset event = viewState.getValue("event")>
<cfset UserRecord = viewstate.getvalue("UserRecord") />
<cfset pageAuth= viewState.getValue("pageAuth")>
<cfset CanvasConfig = viewState.getValue("CanvasConfig")>
<cfset showViewLinks=((NOT CanvasConfig.LoginRequiredForViewing) OR (CanvasConfig.LoginRequiredForViewing AND UserRecord.getIsLoggedIn()))>

<cfoutput>     
<div id="navcontainer">
	<ul id="navlinks">
		<li><br /><h6>Site Navigation</h6></li>
		</cfoutput>
		<cfif showViewLinks>
			<cfoutput>
			<li><a href="#webpath#/index.cfm">Home</a></li>
			<li><a href="#webpath#/index.cfm?event=showallpages">Page Index</a></li>
			<li><a href="#webpath#/index.cfm/Special.Categories">Category List</a></li>
			<li><a href="#webpath#/index.cfm?event=recentUpdates">Recent Updates</a></li>
			<li><a href="#webpath#/index.cfm?event=search">Search</a></li>
			<li><a href="#webpath#/index.cfm?event=specialPages">Special Pages</a></li>
			</cfoutput>
			<cfif CanvasConfig.UploadEnabled>
				<cfoutput>
				<li><a href="#webpath#/index.cfm?event=UploadForm">Upload File</a></li>
				</cfoutput>
			</cfif>
			<cfif UserRecord.getIsLoggedIn()>
				<cfoutput>
				<li><a href="#webpath#/index.cfm?event=logout">Logout</a></li>
				</cfoutput>
			</cfif>
		</cfif>
		<cfif (CanvasConfig.LoginRequiredForViewing OR CanvasConfig.LoginRequiredForEditing) AND NOT UserRecord.getIsLoggedIn()>
			<cfoutput>
			<li><a href="#webpath#/index.cfm?event=LoginForm">Login</a></li>
			</cfoutput>
		</cfif>
		<cfif showViewLinks AND ListFindNoCase("main,pagehistory,whatlinkshere,edit,deletepageform,movepageform", event) and not ListFindNoCase("special.categories,special.files,special.templates", page.getPath())>
			<cfoutput>
			<li><br /><h6>Page Navigation</h6></li>
			<li><a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=pagehistory">Page history</a></li>
			<li><a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=whatlinkshere">What links here</a></li>
			</cfoutput>
			<!--- check credentials before displaying Edit links --->
			<cfif (NOT CanvasConfig.LoginRequiredForEditing) OR (CanvasConfig.LoginRequiredForEditing AND isStruct(pageAuth) AND StructKeyExists(pageAuth, "edit") AND pageAuth["edit"])>
				<cfoutput>
				<li><a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=edit">Edit this page</a></li>
				<li><a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=deletepageform">Delete this page</a></li>
				<li><a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=movepageform">Move this page</a></li>
				</cfoutput>
			</cfif>
			<cfif (NOT CanvasConfig.LoginRequiredForEditing) OR (CanvasConfig.LoginRequiredForEditing AND UserRecord.getIsLoggedIn())>
				<cfoutput>
				<li><a href="#webpath#/index.cfm?event=edit&new=true">Add page</a></li>
				</cfoutput>
			</cfif>
			<cfif viewCollection.exists("subpagelist")>
				<cfoutput>
				#viewCollection.getView("subpagelist")#
				</cfoutput>
			</cfif>	 
		</cfif>
		<!--- TODO: THIS SHOULD BE REMOVED FOR PRODUCTION USE IF LOGINS ARE NOT REQUIRED --->
		<cfif  (NOT (CanvasConfig.LoginRequiredForViewing OR CanvasConfig.LoginRequiredForEditing)) OR (UserRecord.hasRole("sysop"))>
			<cfoutput>
			<li><br /><h6>SYSOP</h6></li>
			<li><a href="#webpath#/index.cfm?init=true">Re-init</a></li>
			<li><a href="#webpath#/index.cfm?init=true&initsession=1">Re-init w/ session</a></li>
			</cfoutput>
		</cfif>
	<cfoutput>
	</ul>
	<br/><br/>
	<b>Credits</b>
	<div id="copyright">
	Sherbrookois Wiki created by <a href="http://www.sherbrookois.com">Roii Patterson</a><br />
	</div>
</div>
</cfoutput>
<cfsetting enablecfoutputonly=false>
