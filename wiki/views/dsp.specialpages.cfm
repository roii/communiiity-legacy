<!---
	Name         : dsp.specialpages.cfm
	Author       : Mark Mazelin
	Created      : 11/29/06
	Last Updated : 
	History      : 
--->
<cfset webpath = viewState.getValue("webpath")>
<cfset viewState.setValue("title", "Special Pages")>
<cfset UserRecord = viewstate.getvalue("UserRecord") />
<cfset CanvasConfig = viewState.getValue("CanvasConfig")>
<cfset showViewLinks=((NOT CanvasConfig.LoginRequiredForViewing) OR (CanvasConfig.LoginRequiredForViewing AND UserRecord.getIsLoggedIn()))>

<cfoutput>
<h1>Special Pages</h1>
<cfif showViewLinks>
<ul>
	<li><a href="#webpath#/index.cfm/Special.Categories">Category List</a></li>
	<cfif CanvasConfig.UploadEnabled>
		<li><a href="#webpath#/index.cfm/Special.Files">File List</a></li>
	</cfif>
	<li><a href="#webpath#/index.cfm?event=OrphanedPages">Orphaned Pages</a></li>
	<li><a href="#webpath#/index.cfm?event=recentUpdates">Recent Updates</a></li>
	<li><a href="#webpath#/index.cfm?event=showAllPages">Site index</a></li>
	<li><a href="#webpath#/index.cfm/Special.Templates">Template List</a></li>
	<cfif CanvasConfig.UploadEnabled>
		<li><a href="#webpath#/index.cfm?event=UploadForm">Upload File</a></li>
	</cfif>
	<cfif UserRecord.getIsLoggedIn()>
		<li><a href="#webpath#/index.cfm?event=UserInfo">User Info</a></li>
	</cfif>
</ul>
<cfelse>
	<p>You must be logged in to view the Special Pages list.</p>
</cfif>
</cfoutput>
