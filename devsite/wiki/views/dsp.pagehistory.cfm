<!---
	Name         : dsp.pagehistory.cfm
	Author       : Raymond Camden 
	Created      : 09/07/05
	Last Updated : 10/04/06
	History      : added authorization and diff
--->

<cfset page = viewState.getValue("page")>
<cfset pagehistory = viewState.getValue("pagehistory")>
<cfset webpath = viewState.getValue("webpath")>
<cfset pageAuth= viewState.getValue("pageAuth")>
<cfset viewState.setValue("title","Page History: #page.getPath()#")>
<cfset canCompare=(pagehistory.recordCount GT 1)>
<cfoutput>
<h1>Page History: #page.getTitle()#</h1>
<p>
<cfif pageHistory.recordCount>
	<cfif canCompare>
	<form action="#webpath#/index.cfm">
		<input type="hidden" name="path" value="#page.getPath()#" />
		<input type="hidden" name="event" value="pageDiff" />
		<input type="submit" name="submit" value="Compare selected versions" />
	</cfif>
	<table class="versionHistory" border="1" id="wiki_pagehistory">
		<tr>
			<th>Version</th>
			<th>Compare</th>
			<th>Created</th>
			<th>Author</th>
			<th>Summary</th>
			<th>Options</th>
		</tr>
</cfif>
<cfloop query="pagehistory">
	<tr <cfif currentRow mod 2>class="alt"</cfif>>
		<td>#version#</td>
		<td>
			<cfif canCompare>
				<span class="wiki_nobreak">
					<input type="radio" value="#version#" name="version"<cfif currentRow EQ 1> style="visibility:hidden"</cfif><cfif currentRow EQ 2> checked="checked"</cfif> />
					<input type="radio" value="#version#" name="diffver"<cfif currentRow EQ 1> checked="checked"<cfelse> style="visibility:hidden"</cfif> />
				</span>
			<cfelse>
				N/A<!--- don't output radio buttons if there is nothing to compare --->
			</cfif>
		</td>
		<td>#dateFormat(datetimecreated, "short")# #timeFormat(datetimecreated, "short")#</td>
		<td><cfif len(author)>#author#<cfelse>Anonymous</cfif></td>
		<td><cfif len(summary)>#summary#<cfelse>&nbsp;</cfif></td>
		<td align="center">
			<!--- check credentials before displaying edit or view links --->
			<cfif pageAuth["edit"]>
				<a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=edit&version=#version#">Edit</a>
			</cfif>
			<cfif pageAuth["view"]>
				<cfif pageAuth["edit"]>|</cfif>
				<a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=main&version=#version#">View</a>
			</cfif>
		</td>
	</tr>
</cfloop>
<cfif pageHistory.recordCount>
	</table>
	<cfif canCompare>
		<input type="submit" name="submit" value="Compare selected versions" />
		</form>
	</cfif>
<cfelse>
This page does not have a history yet.
</cfif>
</p>
</cfoutput>