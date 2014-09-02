<!---
	Name         : dsp.pagelist.cfm
	Author       : Mark Mazelin
	Created      : 11/29/06
	Last Updated : 
	History      : 
--->

<cfset webpath = viewState.getValue("webpath")>
<cfset pageQuery = viewState.getValue("pageQuery")>
<cfset pageHeader = viewState.getValue("pageHeader", "")>
<cfset pageMessage = viewState.getValue("pageMessage", "")>
<cfset numPages = viewState.getValue("numPages", 0)><!--- not currently used --->
<cfset viewState.setValue("title",pageHeader)>

<cfif len(pageHeader)>
	<cfoutput><h1>#pageHeader#</h1></cfoutput>
</cfif>
<cfif not isQuery(pageQuery)>
	<!--- allow no pageQuery b/c search includes this, even before there is a query --->
	<!---<cfthrow message="pageQuery is not a query object"> --->
<cfelse>
	<cfoutput>
	<p>
	<cfif len(pageMessage)>
		#pageMessage#
	<cfelse>
		Found #pageQuery.recordCount# page<cfif pageQuery.recordCount NEQ 1>s</cfif>.
	</cfif>
	</p>
	</cfoutput>
	
	<cfif pageQuery.recordCount gt 0>
		<cfoutput>
		<div class="wiki_results">
		<cfloop query="pageQuery">
			<h3><a href="#webpath#/index.cfm/#urlEncodedFormat(path)#">#replace(replace(path, "_", " ", "ALL"), ".", " - ", "ALL")#</a></h3>
			<p>
				<strong>Author: </strong><cfif len(author)>#author#<cfelse>Anonymous</cfif><br />
				<strong>Created: </strong>#dateFormat(datetimecreated, "short")# #timeFormat(datetimecreated, "short")#<br />
				<strong>Version: </strong>#version#
			</p>
		</cfloop>
		</div>
		</cfoutput>
	</cfif>
</cfif>
