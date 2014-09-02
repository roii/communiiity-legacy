<cfoutput>

<cfparam name="articles_Srow" default="1">
<cfparam name="articles_Mrow" default="5">


<!--- SET END ROW VALUE --->

<cfif #articleResults.RecordCount# GT (#articles_Srow#+#articles_Mrow#)-1>
	<cfset articles_endrow = #articles_Srow#+#articles_Mrow#-1>
<cfelse>
	<cfset articles_endrow = #articleResults.RecordCount#>
</cfif>


<!--- SET THE PREV VALUE --->
	<cfif #articles_Srow# GT #articles_Mrow#>
		<cfset articles_prev = #articles_Srow#-#articles_Mrow#>
	
	<cfelse>
		<cfset articles_prev = #articles_Srow#>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif #articles_endrow# LT #articleResults.RecordCount#>
		<cfset articles_next = (#articles_endrow#+1)>
	
	<cfelse>
		<cfset articles_next = #articles_Srow#>
	
	</cfif>
	
	
<table width="90%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="FF3300"</cfif> width="17">

		<table width="17" cellpadding="1" cellspacing="0" border="0">
		<tr>
		<td><font face="WebDings" size="2" color="White"><strong>4</strong></font></td>
		</tr>
		</table>
	
</td>
<td valign="top" width="2"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="16" border="0"></td>
<td valign="top" <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="#TRIM(sectionDetails.barColor)#"</cfif>><span style="color:white; letter-spacing:.5em;"><strong>&nbsp;ARTICLE RESULTS</strong></span></td>
</tr>

<tr>
<td valign="top" width="16" height="16" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="16" height="16" border="0"></td>
<td valign="top" width="2"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="16" border="0"></td>
<td valign="top" bgcolor="e2e2e2">

	<table width="100%" cellpadding="10" cellspacing="0" border="0">
	
	<tr>
	<td><cfif #articleresults.recordcount# GT 0>Your search retrieved: <b>#articleresults.recordcount#</b> articles.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Displaying records: <strong>#articles_srow# - #articles_endrow#<cfelse>No articles were found matching your search criteria</cfif></td>
	</tr>
	
	</table>

</td>
</tr>

<cfif #articleresults.recordcount# GT 0>
<tr>
<td valign="top" bgcolor="f4f4f4"></td>
<td valign="top" width="2"></td>
<td valign="top" bgcolor="f4f4f4"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="5" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="2" border="0">
	
	<tr>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	<td width="100%"> </td>
	</tr>
	
	<cfloop query="articleresults" startrow="#articles_Srow#" endrow="#articles_endrow#">
	
	<cfquery name="GetDoc" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT DocumentID
	FROM DocumentArticles_Link
	WHERE DocumentArticles_Link.ArticleID=#articleresults.ArticleID#
	</cfquery>
	
	<cfif #GetDoc.RecordCount# GT 0>
	
	<cfquery name="GetSection" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT sections.fuseaction
	FROM SectionDocuments_Link, Sections
	WHERE SectionDocuments_Link.DocumentID=#GetDoc.DocumentID#
	AND SectionDocuments_Link.SectionID=Sections.SectionID
	</cfquery>
	
	<cfif #GetSection.RecordCount# GT 0>
	<tr>
	<td width="40">&nbsp; #articleresults.currentrow#</td>
	<td width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#GetSection.fuseaction#&fusesubaction=article&articleID=#articleresults.ArticleID#&DocumentID=#GetDoc.DocumentID#" style="color:blue;">#articleresults.ArticleTitle#</a></td>
	</tr>
	</cfif>
	</cfif>
	</cfloop>
	
	<tr>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="5" border="0"></td>
	<td width="100%"> </td>
	</tr>
	
	</table>


</td>
</tr>



<tr>
<td valign="top" width="16" height="30" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="16" height="30" border="0"></td>
<td valign="top" width="2"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="16" border="0"></td>
<td valign="middle" bgcolor="e2e2e2">

	<table cellpadding="0" cellspacing="1" width="110">

	<tr>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	<!--- IF THE CURRENT DISPLAY COUNT IS GREATER THAN THE START ROW PLUE THE MAX ROWS THEN SHOW 
	THE PREVIOUS BUTTON--->

	<cfif #articles_Srow# gt #articles_mrow#>
	<FORM action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" method="post">
	
	<cfif IsDefined("SearchType")>
	<input type="hidden" name="SearchType" value="#SearchType#">
	</cfif>
	
	<cfif IsDefined("keywords")>
	<input type="hidden" name="keywords" value="#keywords#">
	</cfif>
	
	<cfif IsDefined("keywords2")>
	<input type="hidden" name="keywords2" value="#keywords2#">
	</cfif>
	
	<cfif IsDefined("keywords3")>
	<input type="hidden" name="keywords3" value="#keywords3#">
	</cfif>
	
	<cfif IsDefined("Operator1")>
	<input type="hidden" name="Operator1" value="#Operator1#">
	</cfif>
	
	<cfif IsDefined("Operator2")>
	<input type="hidden" name="Operator2" value="#Operator2#">
	</cfif>
	
	<cfif IsDefined("UsePubDate")>
	<input type="hidden" name="UsePubDate" value="#UsePubDate#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_startday")>
	<input type="hidden" name="PublicationDate_startday" value="#PublicationDate_startday#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_startmonth")>
	<input type="hidden" name="PublicationDate_startmonth" value="#PublicationDate_startmonth#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_startyear")>
	<input type="hidden" name="PublicationDate_startyear" value="#PublicationDate_startyear#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_endday")>
	<input type="hidden" name="PublicationDate_endday" value="#PublicationDate_endday#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_endmonth")>
	<input type="hidden" name="PublicationDate_endmonth" value="#PublicationDate_endmonth#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_endyear")>
	<input type="hidden" name="PublicationDate_endyear" value="#PublicationDate_endyear#">
	</cfif>
	
	<cfif IsDefined("UseAuthor")>
	<input type="hidden" name="UseAuthor" value="#UseAuthor#">
	</cfif>
	
	<cfif IsDefined("Author")>
	<input type="hidden" name="Author" value="#Author#">
	</cfif>
	
	
	
	<td width="50">
	<INPUT type="hidden" name="articles_mrow" value="#articles_mrow#">
	<INPUT type="hidden" name="articles_Srow" value="#Evaluate(articles_Srow - articles_mrow)#">
	<INPUT type="submit" value="<<< Prev." class="whitefield" style="cursor:hand">
	</td>
	</FORM>
	<td width="10">&nbsp;</td>
	</cfif>

	<!--- IF THE RECORD COUNT IS GREATER THAN THE MAX ROWS THEN SHOW THE NEXT BUTTON--->

	<cfif #articleresults.recordcount# gt (#articles_mrow#+#articles_Srow# -1)>
	<FORM action="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#" method="post">

	<cfif IsDefined("SearchType")>
	<input type="hidden" name="SearchType" value="#SearchType#">
	</cfif>
	
	<cfif IsDefined("keywords")>
	<input type="hidden" name="keywords" value="#keywords#">
	</cfif>
	
	<cfif IsDefined("keywords2")>
	<input type="hidden" name="keywords2" value="#keywords2#">
	</cfif>
	
	<cfif IsDefined("keywords3")>
	<input type="hidden" name="keywords3" value="#keywords3#">
	</cfif>
	
	<cfif IsDefined("Operator1")>
	<input type="hidden" name="Operator1" value="#Operator1#">
	</cfif>
	
	<cfif IsDefined("Operator2")>
	<input type="hidden" name="Operator2" value="#Operator2#">
	</cfif>
	
	<cfif IsDefined("UsePubDate")>
	<input type="hidden" name="UsePubDate" value="#UsePubDate#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_startday")>
	<input type="hidden" name="PublicationDate_startday" value="#PublicationDate_startday#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_startmonth")>
	<input type="hidden" name="PublicationDate_startmonth" value="#PublicationDate_startmonth#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_startyear")>
	<input type="hidden" name="PublicationDate_startyear" value="#PublicationDate_startyear#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_endday")>
	<input type="hidden" name="PublicationDate_endday" value="#PublicationDate_endday#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_endmonth")>
	<input type="hidden" name="PublicationDate_endmonth" value="#PublicationDate_endmonth#">
	</cfif>
	
	<cfif IsDefined("PublicationDate_endyear")>
	<input type="hidden" name="PublicationDate_endyear" value="#PublicationDate_endyear#">
	</cfif>
	
	<cfif IsDefined("UseAuthor")>
	<input type="hidden" name="UseAuthor" value="#UseAuthor#">
	</cfif>
	
	<cfif IsDefined("Author")>
	<input type="hidden" name="Author" value="#Author#">
	</cfif>
	
	<td width="50">
	<INPUT type="hidden" name="articles_mrow" value="#articles_mrow#">
	<INPUT type="hidden" name="articles_Srow" value="#Evaluate(articles_Srow + articles_mrow)#">
	<INPUT type="submit" value="Next >>>" class="whitefield" style="cursor:hand">
	</td>
	</FORM>
	</cfif>

	</tr>	
	
	</table>

</td>
</tr>
</cfif>
</table>


</cfoutput>