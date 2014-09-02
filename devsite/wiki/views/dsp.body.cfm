<cfsetting enablecfoutputonly=true>
<!---
	Name         : dsp.body.cfm
	Author       : Raymond Camden 
	Created      : 09/07/05
	Last Updated : 8/23/06
	History      : Set title (rkc 8/9/06)
				 : Sam Curren's changes to title (rkc 8/23/06)
--->
<!--- TODO: if we are looking at a version other than the current, we need to somehow indicate that --->

<cfset page = viewState.getValue("page")>
<cfset pageRender = viewState.getValue("pagerender")>
<cfset webpath = viewState.getValue("webpath")>
<cfset redirectedfrom = viewState.getValue("redirectedfrom", "")>

<!--- Translate xx.aa_bb to xx / aa bb --->
<cfset viewState.setValue("title", page.getTitle())>

<!--- use getTitle() here instead of getpath() since it handles the special files page better --->
<cfoutput><h1></cfoutput>
<cfset pathSoFar = ""/>
<cfset segmentCount = listLen(page.getTitle(), "|")/>
<cfloop from="1" to="#segmentCount#" index="i">
	<cfset segment = trim(ListGetAt(page.getTitle(), i, "|"))/>
	<cfif i EQ 1><cfset pathSoFar = segment/><cfelse><cfset pathSoFar = "#pathSoFar#.#segment#"/></cfif>
	<cfif i LT segmentCount>
		<cfif LCase(segment) EQ "special">
			<!--- don't link the word "Special" and use a colon instead of a vertical pipe --->
			<cfoutput>#segment#: </cfoutput>
		<cfelse>
			<cfoutput><a href="#webpath#/index.cfm/#replace(pathSoFar, " ", "_", "all")#">#segment#</a> | </cfoutput>
		</cfif>
	<cfelse>
		<cfoutput>#segment#</cfoutput>
	</cfif>
</cfloop>

<cfoutput></h1></cfoutput>

<cfif len(redirectedFrom)>
	<cfoutput><p id="wiki_redirectedfrom">(Redirected from <a href="#webpath#/index.cfm?path=#replace(redirectedfrom, " ", "_", "all")#&redirect=no">#redirectedfrom#</a>)</p></cfoutput>
</cfif>

<cfif len(pageRender)>
	<cfoutput>#pageRender#</cfoutput>
</cfif>

<cfsetting enablecfoutputonly=false>
