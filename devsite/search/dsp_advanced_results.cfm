<cfoutput>
<table border="0" cellpadding="0" cellspacing="2" width="100%">
			
<tr>
<td class="section_header" width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(sectiondetails.fuseaction)#" style="text-decoration:none; color:black;"><cfif #session.textonly# EQ 'yes'>#SectionDetails.Title#<cfelse><img src="#request.imageroot#/title_#TRIM(sectiondetails.fuseaction)#.gif" border="0"></cfif></a></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>	

<tr>
<td bgcolor="676767"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>	

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>	

</table>

	



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="100%" colspan="2" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
</tr>
	
	
<tr>
<td width="37" align="center" height="37" width="37"> </td>
<td width="100%">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="12" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	<td colspan="2"><strong>Please Note: this Site Search does not return results for G-I-N Members or Guidelines.</strong><br>
	To search for Members use the <a href="#request.webroot#/index.cfm?fuseaction=ourmembers">Members Search Tools</a><br>
To search for Guidelines use the <cfif session.UserIsAuthenticated EQ 'Yes'><a href="#request.webroot#/index.cfm?fuseaction=membersarea&fusesubaction=docs&documentID=20"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=membersarea"></cfif>Guideline Search Tools</a></td>
	</tr>
	
	<tr>
	<td></td>
	<td colspan="2"><br><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<tr>
	<td width="12" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	<td width="120" class="normal"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1"  border="0"><br><strong>Search For:</strong></td>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1"  border="0"><br><cfif #SearchType# EQ 'ALL'>ALL<cfelseif #SearchType# EQ 'Documents'>Online Documents / Pages<cfelseif #SearchType# EQ 'Events'>Meetings / Events<cfelseif #SearchType# EQ 'Downloads'>File Downloads<cfelseif #SearchType# EQ 'News'>News Articles<cfelseif #SearchType# EQ 'Links'>Related Links</cfif></td>
	</tr>
	
	<tr>
	<td></td>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="12" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	<td width="120" class="normal"><strong>Keywords:</strong></td>
	<td>#attributes.keywords# <cfif (IsDefined("keywords2")) AND (#TRIM(keywords2)# NEQ '') AND (#Operator1# NEQ 'NONE')> <em>#Operator1#</em> #keywords2#</cfif><cfif (IsDefined("keywords3")) AND (#TRIM(keywords3)# NEQ '') AND (#Operator2# NEQ 'NONE')> <em>#Operator2#</em> #keywords3#</cfif></td>
	</tr>
	
	<cfif IsDefined("UsePubDate")>
	
	<tr>
	<td></td>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<tr>
	<td width="12" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	<td width="120" class="normal"><strong>Published Between:</strong></td>
	<td>#Pub_StartDate#&nbsp; &ndash; &nbsp;#Pub_EndDate#</td>
	</tr>
	</cfif>
	
	<cfif IsDefined("UseAuthor")>
	
	<tr>
	<td></td>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<tr>
	<td width="12" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	<td width="120" class="normal"><strong>Authored By:</strong></td>
	<td>#Author#</td>
	</tr>
	</cfif>
	
	<tr>
	<td></td>
	<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	</table>
	
	<br><br>
	
	<cfif (#SearchType# EQ 'Documents') OR (#SearchType# EQ 'ALL')>
	
		
		<cfinclude template="dsp_results_sections.cfm"><br>
		
		<cfinclude template="dsp_results_documents.cfm"><br>
		
		<cfinclude template="dsp_results_articles.cfm"><br>
		
		
		<cfif #subarticleresults.recordcount# GT 0>
			<cfinclude template="dsp_results_subarticles.cfm"><br>
		</cfif>

	</cfif>
	
	
	
	<cfif (#SearchType# EQ 'Events') OR (#SearchType# EQ 'ALL')>
	
		<cfinclude template="dsp_results_events.cfm"><br>
			
	</cfif>
	
	
	
	<cfif (#SearchType# EQ 'Downloads') OR (#SearchType# EQ 'ALL')>
	
		<cfinclude template="dsp_results_downloads.cfm"><br>
			
	</cfif>
	
	
	
	<cfif (#SearchType# EQ 'News') OR (#SearchType# EQ 'ALL')>
	
		<cfinclude template="dsp_results_news.cfm"><br>
		
	</cfif>
	
	
	

</td>
</tr>

</table>
</cfoutput>