<cfsetting enablecfoutputonly=true>
<!---
	Name         : views/layout.amin.cfm
	Author       : Raymond Camden 
	Created      : 11/05/05
	Last Updated : 10/04/06
	History      : Used tables to help make it a bit more stable (11/5/05)
				   Added utils.js, print icons, and onload hook
				   Split navigation to it's own view
--->

<cfset page = viewState.getValue("page")>
<cfset appTitle = viewState.getValue("appTitle")>
<cfset title = viewState.getValue("title", "#page.getPath()#")>
<cfset webpath = viewState.getValue("webpath")>
<cfset event = viewState.getValue("event")>
 
<cfoutput>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>#appTitle# | #title#</title>
<link rel="stylesheet" href="#webpath#/stylesheets/blueheaven.css" type="text/css" />
<script src="#webpath#/lib/utils.js" type="text/javascript"></script>
</head>

<body>
<div class="header" style="height:76px;"><a href="#webpath#/index.cfm">#appTitle#</a></div>
<table width="100%">
<tr valign="top">
	<td >
</cfoutput>

<cfif viewCollection.exists("body")>
	<cfoutput>
	<div class="wiki_printicons">
		<p>
			<a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=Main&printFormat=PDF" target="_blank"><img src="#webpath#/media/print_pdf.gif" alt="PDF" title="PDF" border="0" /></a>
			<a href="#webpath#/index.cfm?path=#urlEncodedFormat(page.getPath())#&event=Main&printFormat=HTML" target="_blank"><img src="#webpath#/media/print_html.gif" alt="HTML" title="HTML" border="0" /></a>
		</p>
	</div>
	#viewCollection.getView("body")#
	</cfoutput>
</cfif>

<cfoutput></td></cfoutput>

<cfif viewCollection.exists("navigation")>
	<cfoutput><td id="nav">#viewCollection.getView("navigation")#</td></cfoutput>
</cfif>
<cfoutput>
</tr>
</table>
<script language="javascript" type="text/javascript"><!-- 
if (window.runOnloadHook) runOnloadHook();
// -->
</script>
</body>
</html>
</cfoutput>
<cfsetting enablecfoutputonly=false>
