<!---
	Name         : dsp.generic.message.cfm
	Author       : Mark Mazelin
	Created      : 11/28/06
	Last Updated : 
	History      : 
--->

<cfset webpath = viewState.getValue("webpath")>
<cfset pageHeader = viewState.getValue("pageHeader", "Action Completed")>
<cfset pageMessage = viewState.getValue("pageMessage", pageHeader)>
<cfset viewState.setValue("title", pageHeader)>

<cfoutput>
<h1>#pageHeader#</h1>
<p>#pageMessage#</p>
<p>Return <a href="#webpath#/index.cfm">Home</a></p>
</cfoutput>
