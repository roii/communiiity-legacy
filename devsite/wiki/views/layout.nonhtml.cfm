<!---
	Name         : layout.nonhtml.cfm
	Author       : Mark Mazelin
	Created      : 10/12/06
	Last Updated : 
	History      : 
--->
<cfset contenttype=viewState.getValue("contenttype")>
<cfset contentfile=viewState.getValue("contentfile")>

<cfheader name="content-disposition" value="inline; filename=#GetFileFromPath(contentFile)#">
<cfcontent file="#contentfile#" deletefile="no" reset="true" type="#contenttype#">
<!--- do we want this cached?
<cfheader name="Expires" value="#GetHttpTimeString(now())#">
<cfheader name="pragma" value="no-cache">
<cfheader name="cache-control" value="no-cache, no-store, must-revalidate"> 
--->