<!---
	Name         : dsp.subpagelist.cfm
	Author       : Sam Curren
	Created      : 16 Aug 06
	Last Updated : 
	History      : 
--->

<cfset page = viewState.getValue("page")>
<cfset pageChildren = viewState.getValue("pagechildren")>
<cfset webpath = viewState.getValue("webpath")>

<cfset parentPagePathLength = LEN(page.getPath()) + 1/>

<cfif pageChildren.recordCount>
	<cfoutput>
		<li><br /><h6>Sub Pages</h6></li>
		<cfloop query="pageChildren">
			<li><a href="#webpath#/index.cfm/#path#">#Replace(segment, "_", " ", "ALL")#</a></li>
		</cfloop>
	</cfoutput>
</cfif>

