<!---
	Name         : layout.printable.cfm
	Author       : Mark Mazelin
	Created      : 10/04/06
	Last Updated : 
	History      : 
--->
<cfset page = viewState.getValue("page")>
<cfset appTitle = viewState.getValue("appTitle")>
<cfset title = viewState.getValue("title", "#page.getPath()#")>
<cfset webpath = viewState.getValue("webpath")>
<cfset printFormat=viewState.getValue("printFormat", "HTML")><!--- HTML, PDF --->

<cfif viewCollection.exists("body")>
	<cfsavecontent variable="outputContent"><cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>#appTitle# | #title#</title>
<link rel="stylesheet" href="#webpath#/stylesheets/blueheaven.css" type="text/css" />
<link rel="stylesheet" href="#webpath#/stylesheets/blueheavenprint.css" type="text/css" />
</head>

<body>
#viewCollection.getView("body")#
</body>
</html>
</cfoutput></cfsavecontent>
	<cfif printFormat.equalsIgnoreCase("HTML")>
		<cfoutput>#outputContent#</cfoutput>
	<cfelse>
		<cfif printFormat is "PDF">
			<cfheader name="Content-Disposition" value="inline; filename=#title#.pdf">		
			<cfcontent type="application/pdf" reset="true">
		</cfif>
		<cfdocument format="#printFormat#">
			<cfdocumentitem type="header">
				<cfoutput><h1 style="text-align:center;">#appTitle#</h1></cfoutput>
			</cfdocumentitem>
			<cfdocumentItem type="footer">
				<cfset pageUrl="http">
				<cfif ListFind("443,8443", cgi.SERVER_PORT)>
					<cfset pageUrl=pageUrl & "s">
				</cfif>
				<cfset pageUrl=pageUrl & "://#cgi.http_host##webpath#/index.cfm/#page.getPath()#">
				<cfoutput>
					<p style="font-size:8px; text-align:center;">#pageUrl#</p>
					<p style="font-size:8px; text-align:center;">Page #cfdocument.currentpagenumber# of #cfdocument.totalpagecount#</p>
				</cfoutput>
			</cfdocumentitem>
			<cfoutput>#outputContent#</cfoutput>
		</cfdocument>
	</cfif>
</cfif>
