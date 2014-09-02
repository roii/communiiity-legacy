<!---
	Name         : dsp.googlesitemap.cfm
	Author       : Lucas Sherwood 
	Created      : 15/06/06
	Last Updated : 
	History      : 
--->

<cfset pageIndex = viewState.getValue("pageQuery")>
<cfset webpath = viewState.getValue("webpath")>
<cfset viewState.setValue("title","Page Index")>

<cfset z = getTimeZoneInfo()>
<cfif not find("-", z.utcHourOffset)>
	<cfset utcPrefix = "-">
<cfelse>
	<cfset z.utcHourOffset = right(z.utcHourOffset, len(z.utcHourOffset) -1 )>
	<cfset utcPrefix = "+">
</cfif>

<cfcontent type="text/xml"><cfoutput><?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.google.com/schemas/sitemap/0.84"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.google.com/schemas/sitemap/0.84
	http://www.google.com/schemas/sitemap/0.84/sitemap.xsd">
<cfloop query="pageIndex">
	<cfset dateStr = dateFormat(datetimecreated,"yyyy-mm-dd")>
	<cfset dateStr = dateStr & "T" & timeFormat(datetimecreated,"HH:mm:ss") & utcPrefix & numberFormat(z.utcHourOffset,"00") & ":00">
	<url>
		<loc>http://#cgi.HTTP_HOST##webpath#/index.cfm/#urlEncodedFormat(path)#</loc>
		<lastmod>#dateStr#</lastmod>
	</url>
</cfloop>
</urlset>


</cfoutput>

