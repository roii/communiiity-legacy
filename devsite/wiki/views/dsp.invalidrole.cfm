<!---
	Name         : dsp.invalidrole.cfm
	Author       : Mark Mazelin
	Created      : 09/06/06
	Last Updated : 
	History      : 
--->
<cfset pageMode = viewState.getValue("pageMode", "work with")>
<cfoutput>
<h1>Insufficient Rights</h1>
<p>ERROR: You do not have sufficient rights to #lcase(pageMode)# this page.</p>
</cfoutput>