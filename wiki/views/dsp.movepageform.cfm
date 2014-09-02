<!---
	Name         : dsp.movepageform.cfm
	Author       : Mark Mazelin
	Created      : 11/28/06
	Last Updated : 
	History      : 
--->

<cfset page = viewState.getValue("page")>
<cfset viewState.setValue("title","Move Path")>
<cfset errorMsg = viewState.getValue("errorMsg", "")>
<!--- fields --->
<cfset newpath = viewState.getValue("newpath", page.getPath())>
<cfset reason = viewState.getValue("reason", "")>


<cfoutput>
<h1>Move Page</h1>
<p>Using the form below will rename a page, moving all of its history to the new name. The old title will become a redirect page to the new title. Links to the old page title will not be changed; be sure to check for double or broken redirects. You are responsible for making sure that links continue to point where they are supposed to go.</p>
<p>Note that the page will <strong>not</strong> be moved if there is already a page at the new title, unless it is empty or a redirect and has no past edit history. This means that you can rename a page back to where it was just renamed from if you make a mistake, and you cannot overwrite an existing page.</p>
<p><strong>WARNING!</strong> This can be a drastic and unexpected change for a popular page; please be sure you understand the consequences of this before proceeding. </p>
<cfif len(errorMsg)>
	<div class="wiki_error">
		<h3>The following error occurred:</h3>
		<p>#ErrorMSg#</p>
	</div>
</cfif>
<form id="wiki_movepageform" action="#viewState.getValue("myself")#MovePage" method="post">
	<label for="currpath">Move Page:</label><span id="currpath" style="font-weight:bold">#page.getPath()#</span><br />
	<label for="newpath">New Title:</label><input type="text" name="newpath" id="newpath" value="#newpath#" size="40" /><br />
	<label for="reason">Reason:</label><textarea cols="50" rows="5" name="reason">#reason#</textarea><br />
	<input type="hidden" name="path" value="#page.getPath()#" />
	<input type="submit" value="Move Page" />
</form>
</cfoutput>

<!---
_Move Page_
Move succeeded

Page "Test" moved to "Test2". 
 --->