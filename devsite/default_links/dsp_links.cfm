 <cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
		<!--
	function confirmSectionDelete(aURL) {
	    if(confirm('Deleting a Section also deletes all linked Documents, Articles and SubArticles. Are you sure you want to delete this Section?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmLinkDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Link?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmLinkCatDelete(aURL) {
	    if(confirm('Deleting a Link Category also deletes any links within it. Are you sure you want to delete this Link Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>

<table border="0" cellpadding="0" cellspacing="2" width="100%">
 <cfoutput>		
<tr>
<td class="section_header" width="100%"><cfif #session.textonly# EQ 'yes'>#SectionDetails.Title#<cfelse><img src="#request.imageroot#/title_#TRIM(sectiondetails.fuseaction)#.gif" border="0"></cfif></td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td bgcolor="676767" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<tr>
<td colspan="2">
<cfif (#TRIM(sectiondetails.introduction)# NEQ '') AND (#sectiondetails.introduction# NEQ '<P>&nbsp;</P>')><span class="page_introduction"><strong>#sectiondetails.introduction#</strong></span><br><br></cfif>

<cfif (#TRIM(sectiondetails.details)# NEQ '') AND (#sectiondetails.details# NEQ '<P>&nbsp;</P>')><span class="normal">#sectiondetails.details#</span></cfif></td>
</tr>


</cfoutput>

<!--- DISPLAY EVENTS --->
<tr>
<td><br>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<cfoutput>
		<tr>
		<td class="small" colspan="2"><a href="#request.webroot#/admin/dsp_linkCat_add.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="addLinkCat" ONCLICK="fdbackwindow=window.open ('','addLinkCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=235,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A CATEGORY »</strong></a> &nbsp;&nbsp;&nbsp; <a href="#request.webroot#/admin/dsp_link_add.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="addLink" ONCLICK="fdbackwindow=window.open ('','addLink','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A LINK »</strong></a> <!--- &nbsp;&nbsp;&nbsp; <a href="#request.webroot#/administration/act_links_check.cfm?requesttimeout=500&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="checkLinks" ONCLICK="fdbackwindow=window.open ('','checkLinks','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>CHECK FOR BAD LINKS »</strong></a> ---><br><br></td>
		</tr>
		</cfoutput>
	</cfif>
		
		
	<cfoutput query="LinkCats" group="LinkCatID">
	<cfinclude template="qry_all_links.cfm">
	<cfif (#AllLinks.RecordCount# GT 0) OR (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
	<tr>
	<td class="normal"><ul><cfif #session.textonly# EQ 'yes'><li class="normal" style="color:black"><cfelse><li class="normal" style="color:FF3300"></cfif><a href="###LinkCatID#" style="color:dimgray; text-decoration:none;">#Title# &nbsp;(#AllLinks.RecordCount#)</a></td>
	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
	<td align="right"><a href="#request.webroot#/admin/dsp_linkcat_edit.cfm?LinkCatID=#LinkCatID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="editLinkCat" ONCLICK="fdbackwindow=window.open ('','editLinkCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=230,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Link Category" border="0"></a> <a href="javascript:confirmLinkCatDelete('#request.webroot#/admin/act_LinkCat_delete.cfm?LinkCatID=#LinkCatID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></td>
	</cfif>
	</tr>
	</cfif>
	</cfoutput>
	
	</table><br><cfoutput><img src="#request.imageroot#/transparent_spc.gif" width="5" height="6" border="0"></cfoutput><br>
	
	
	<cfoutput query="LinkCats" group="LinkCatID">
	
	<cfinclude template="qry_all_links.cfm">
	
	<cfif #AllLinks.RecordCount# GT 0>
	<a name="#LinkCatID#"> </a>
	<table width="100%" cellpadding="0" cellspacing="2" border="0">
	
	<tr>
	<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="FF3300"</cfif> width="17">
	
		<table width="17" cellpadding="1" cellspacing="0" border="0">
		<tr>
		<td><font face="WebDings" size="2" color="White"><strong>4</strong></font></td>
		</tr>
		</table>
	
	</td>
	<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="#TRIM(sectionDetails.barColor)#"</cfif> width="100%">
	
		<table width="100%" cellpadding="1" cellspacing="0" border="0">
		<tr>
		<td width="5"><img src="#request.imageroot#/transparent_spc.gif" width="5" height="1" border="0"></td>
		<td><span class="small" style="letter-spacing:.2em; color:white;"><b>#UCASE(Title)#</b></span></td>
		</tr>
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td>&nbsp;</td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"><br>	
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<cfloop query="AllLinks">
		<tr>		
		<td width="5"><img src="#request.imageroot#/transparent_spc.gif" width="5" height="1" border="0"></td>
		<td class="normal" valign="top">
		<b>#AllLinks.LinkTitle#</b><BR>	
		
		<cfif #AllLinks.details# neq '' AND #AllLinks.details# neq ' '>
		#AllLinks.Details#<BR>
		</cfif>
	
		<cfif #AllLinks.linkurl# neq ''>
		<div class="small"><a href="#LinkURL#" target="_blank">#AllLinks.LinkURL#</a></div><br></cfif></td>
		
		<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<td align="right" valign="top" width="28"><a href="#request.webroot#/admin/dsp_link_edit.cfm?linkID=#AllLinks.linkID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="editLink" ONCLICK="fdbackwindow=window.open ('','editLink','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Link" border="0"></a> <a href="javascript:confirmLinkDelete('#request.webroot#/admin/act_link_delete.cfm?LinkID=#LinkID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Event" border="0"></a><br><a href="#request.webroot#/admin/act_whatnew_add.cfm?type=link&fuseaction=#attributes.fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif><cfif IsDefined("attributes.SubArticleID")>&SubArticleID=#attributes.SubArticleID#</cfif>&LinkID=#LinkID#"><img src="#request.imageroot#/butt_whatnew_add.gif" width="24" height="10" alt="Add to Whats New" border="0"></a></td>
		</cfif>
		</tr>		
		
		<cfif #AllLinks.currentrow# NEQ #AllLinks.recordcount#>
		<tr>
		<td colspan="3"><hr width="100%" size="1" color="eaeaea"></td>
		</tr>
		</cfif>
		
		</cfloop>
		</table>
		
	
	
	
	</td>
	</tr>
	
	<tr>
	<td colspan="2"><a href="##top"><img src="#request.imageroot#/up_icon.gif" width="17" height="25" alt="Up" border="0"></a><br><br></td>
	</tr>
	
	</table>
	
	</cfif>
	
	
	</cfoutput>
	
</td>
</tr>

</table>
