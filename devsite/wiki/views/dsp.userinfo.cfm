<!---
	Name         : dsp.userinfo.cfm
	Author       : Mark Mazelin
	Created      : 09/06/06
	Last Updated : 
	History      : 
--->
<cfset UserRecord = viewstate.getvalue("UserRecord") />
<cfoutput>
<h1>User Information</h1>
#UserRecord._toString("<br />")#
</cfoutput>
