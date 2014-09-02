<cfoutput>


<cfquery name="AllEvents" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT EventID, EventTitle
FROM Events
ORDER BY StartDate DESC
</cfquery>

<cfparam name="CurrentEventLinks" default="">


<!--- GET THE CURRENT LINKAGES --->
<cfif #fusesubaction# EQ 'docs'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventID
	FROM LibraryLinks
	WHERE DocumentID=#DocumentID#
	AND EventID <> ''
	</cfquery>
	
	<cfset CurrentEventLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentEventLinks= '#CurrentEventLinks#' & ',' & '#CurrentLinks.EventID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'article'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventID
	FROM LibraryLinks
	WHERE ArticleID=#ArticleID#
	AND EventID <> ''
	</cfquery>
	
	<cfset CurrentEventLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentEventLinks= '#CurrentEventLinks#' & ',' & '#CurrentLinks.EventID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'subarticle'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventID
	FROM LibraryLinks
	WHERE SubArticleID=#SubArticleID#
	AND EventID <> ''
	</cfquery>
	
	<cfset CurrentEventLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentEventLinks= '#CurrentEventLinks#' & ',' & '#CurrentLinks.EventID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'level4'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventID
	FROM LibraryLinks
	WHERE level4ArticleID=#level4ArticleID#
	AND EventID <> ''
	</cfquery>
	
	<cfset CurrentEventLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentEventLinks= '#CurrentEventLinks#' & ',' & '#CurrentLinks.EventID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'news_template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventID
	FROM LibraryLinks
	WHERE NewsID=#NewsID#
	AND EventID <> ''
	</cfquery>
	
	<cfset CurrentEventLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentEventLinks= '#CurrentEventLinks#' & ',' & '#CurrentLinks.EventID#'>
	</cfloop>
	
	
<cfelseif #fusesubaction# EQ 'template'>
	
	<cfquery name="CurrentLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT EventID
	FROM LibraryLinks
	WHERE LibraryID=#LibraryID#
	AND EventID <> ''
	</cfquery>
	
	<cfset CurrentEventLinks=''>
	<cfloop query="CurrentLinks">
		<cfset CurrentEventLinks= '#CurrentEventLinks#' & ',' & '#CurrentLinks.EventID#'>
	</cfloop>

</cfif>



<input type="hidden" name="EventRecords" value="#AllEvents.RecordCount#">
<a name="events"> </a>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td class="normal" valign="top">

	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	<tr>
	<td bgcolor="gray" class="normal" style="color:white;"><strong>UPCOMING EVENTS</strong></td>
	</tr>
	</table>
	
	

<hr width="100%" size="1" color="silver">



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="35"><img src="#request.imageroot#/transparent_spc.gif" width="35" height="1" border="0"></td>
	<td></td>
	</tr>
	
	<cfloop query="AllEvents">
	<input type="hidden" name="EventAssociate#AllEvents.currentrow#" value="0">
	<input type="hidden" name="EventID#AllEvents.currentrow#" value="#AllEvents.EventID#">
	<tr>
	<td><input type="checkbox" name="EventAssociate#currentrow#" value="1" class="whitefield"<cfif #LISTFIND(CurrentEventLinks, EventID, ',')# NEQ 0> checked</cfif>></td>
	<td class="normal" width="100%">#AllEvents.EventTitle#</td>
	</tr>	
	
	<tr>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</cfloop>
	
	<tr>
	<td colspan="2"><input type="submit" class="whitefield" value="UPDATE RELATED LINKS >>>"> &nbsp; <input type="button" class="whitefield" value=":: CLOSE ::" onclick="javascript:window.close();">
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</table>



</td>
</tr>


</table>


</cfoutput>