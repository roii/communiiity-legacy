<cfoutput>

<cfparam name="downloads_Srow" default="1">
<cfparam name="downloads_Mrow" default="10">


<!--- SET END ROW VALUE --->

<cfif #downloadResults.RecordCount# GT (#downloads_Srow#+#downloads_Mrow#)-1>
	<cfset downloads_endrow = #downloads_Srow#+#downloads_Mrow#-1>
<cfelse>
	<cfset downloads_endrow = #downloadResults.RecordCount#>
</cfif>


<!--- SET THE PREV VALUE --->
	<cfif #downloads_Srow# GT #downloads_Mrow#>
		<cfset downloads_prev = #downloads_Srow#-#downloads_Mrow#>
	
	<cfelse>
		<cfset downloads_prev = #downloads_Srow#>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif #downloads_endrow# LT #downloadResults.RecordCount#>
		<cfset downloads_next = (#downloads_endrow#+1)>
	
	<cfelse>
		<cfset downloads_next = #downloads_Srow#>
	
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
<td valign="top" <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="#TRIM(sectionDetails.barColor)#"</cfif>><span style="color:white; letter-spacing:.5em;"><strong>&nbsp;FILE DOWNLOAD RESULTS</strong></span></td>
</tr>

<tr>
<td valign="top" width="16" height="16" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="16" height="16" border="0"></td>
<td valign="top" width="2"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="16" border="0"></td>
<td valign="top" bgcolor="e2e2e2">

	<table width="100%" cellpadding="10" cellspacing="0" border="0">
	
	<tr>
	<td><cfif #downloadresults.recordcount# GT 0>Your search retrieved: <b>#downloadresults.recordcount#</b> file download results.&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Displaying records: <strong>#downloads_srow# - #downloads_endrow#</strong><cfelse>No downloads found matching your search criteria</cfif></td>
	</tr>
	
	</table>

</td>
</tr>

<cfif #downloadresults.recordcount# GT 0>
<tr>
<td valign="top" bgcolor="f4f4f4"></td>
<td valign="top" width="2"></td>
<td valign="top" bgcolor="f4f4f4"><img src="#request.imageroot#/transparent_spc.gif" width="2" height="5" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="2" border="0">
	
	<tr>
	<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
	<td width="100%"> </td>
	</tr>
	
	<cfloop query="downloadresults" startrow="#downloads_Srow#" endrow="#downloads_endrow#">
	<tr>
	<td width="40">&nbsp; #downloadresults.currentrow#</td>
	<td width="100%"><a href="#request.webroot#/index.cfm?fuseaction=download&fusesubaction=template&libraryID=#downloadresults.recordID#" style="color:blue;">#downloadresults.Title#</a></td>
	</tr>
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

	<cfif #downloads_Srow# gt #downloads_mrow#>
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
	<td width="40">
	<INPUT type="hidden" name="downloads_mrow" value="#downloads_mrow#">
	<INPUT type="hidden" name="downloads_Srow" value="#Evaluate(downloads_Srow - downloads_mrow)#">
	<INPUT type="submit" value="<<< Prev." class="whitefield" style="cursor:hand">
	</td>
	</FORM>
	<td width="10">&nbsp;</td>
	</cfif>

	<!--- IF THE RECORD COUNT IS GREATER THAN THE MAX ROWS THEN SHOW THE NEXT BUTTON--->

	<cfif #downloadresults.recordcount# gt (#downloads_mrow#+#downloads_Srow# -1)>
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
	<td width="40">
	<INPUT type="hidden" name="downloads_mrow" value="#downloads_mrow#">
	<INPUT type="hidden" name="downloads_Srow" value="#Evaluate(downloads_Srow + downloads_mrow)#">
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