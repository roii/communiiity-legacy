<!---
	Name         : dsp.movepageform.cfm
	Author       : Mark Mazelin
	Created      : 11/28/06
	Last Updated : 
	History      : 
--->

<cfset page = viewState.getValue("page")>
<cfset webpath = viewState.getValue("webpath")>
<cfset viewState.setValue("title","Confirm Delete Page")>
<cfset errorMsg = viewState.getValue("errorMsg", "")>
<!--- fields --->
<!---<cfset reason = viewState.getValue("reason", "content was: '#HTMLEditFormat(page.getBody()#'")> --->
<cfset reason = viewState.getValue("reason", "")>


<cfoutput>
<h1>Confirm Delete Page: "#page.getTitle()#"</h1>
<cfif page.getVersion() GT 1>
	<strong>Warning: The page you are about to delete has a history: <a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=pagehistory">Page history</a></strong>
</cfif>
<p>You are about to permanently delete a page or image along with all of its history from the database. Please confirm that you intend to do this and that you understand the consequences.</p>
<cfif len(errorMsg)>
	<h3>The following error occurred:</h3>
	<p>#ErrorMsg#</p>
</cfif>
<form id="wiki_deletepageform" action="#viewState.getValue("myself")#DeletePage" method="post">
	<label for="reason">Reason for deletion:</label><input type="text" name="reason" id="reason" value="#reason#" size="40" /><br />
	<input type="hidden" name="path" value="#page.getPath()#" />
	<input type="submit" value="Delete Page" />
</form>
</cfoutput>

<!---
Action complete

"Test" has been deleted. See _deletion log_ (Special:Log/delete) for a record of recent deletions.

Return to _Main Page_.
 --->