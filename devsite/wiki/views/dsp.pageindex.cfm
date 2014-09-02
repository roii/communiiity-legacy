<!---
	Name         : dsp.pageindex.cfm
	Author       : Raymond Camden 
	Created      : 09/07/05
	Last Updated : 
	History      : 
--->

<cfset pageQuery = viewState.getValue("pagequery")>
<cfset webpath = viewState.getValue("webpath")>
<cfset viewState.setValue("title","Page Index")>

<cfoutput>
<h3 class="title">Page Index</h3>

<p>
<cfif pageQuery.recordCount>
	<table class="versionHistory" border="1">
		<tr>
			<th>Name</th>
			<th>Author</th>
			<th>Time Created</th>
			<th>Version</th>
		</tr>
</cfif>
<cfloop query="pagequery">
	<tr <cfif currentRow mod 2>class="alt"</cfif>>
		<td><a href="#webpath#/index.cfm/#urlEncodedFormat(path)#">#path#</a></td>
		<td><cfif len(author)>#author#<cfelse>Anonymous</cfif></td>
		<td>#dateFormat(datetimecreated, "short")# #timeFormat(datetimecreated, "short")#</td>
		<td>#version#</td>
	</tr>
</cfloop>
<cfif pageQuery.recordCount>
	</table>
</cfif>
</p>


</cfoutput>

