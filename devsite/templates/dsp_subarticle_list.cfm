<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To display all records retreived from the qry_linked_subarticles query</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<in>
	<recordset name="AllSubArticles" format="CFML" Scope="variables" primarykeys="SubArticleID" onCondition="AllSubArticles.recordcount GT 0">
</in>

</fusedoc>

 --->

<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmSubArticleDelete(aURL) {
	    if(confirm('Are you sure you want to delete this SubArticle?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>


<cfif (#AllSubArticles.recordcount# GT 0) OR ((#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator'))>

	
	<cfoutput>
	<br>
	<table width="100%" cellpadding="0" cellspacing="2" border="0">
	
	<tr>
	<td width="100%" background="#request.imageroot#/background_dots.gif"></td>
	</tr>
	
	<tr>
	<td class="moreinfo" style="font-size:12px;"><br><strong>More Information</strong></td>
	</tr>
	
	</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="5" border="0">

	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
	<tr>
	<td class="normal" width="20" align="right" valign="top"><li></td>
	<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td class="small"><a href="#request.webroot#/admin/dsp_subarticle_add.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#attributes.documentID#&fusesubaction=#attributes.fusesubaction#&articleID=#attributes.articleID#" target="addSubArt" ONCLICK="fdbackwindow=window.open ('','addSubArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A LEVEL 4 DOCUMENT</strong></a></td>
	<td width="40"> </td>
	<td width="40"> </td>
	</tr>
	</cfif>	
	
	
	
	<cfloop query="AllSubArticles">
	<tr class="searchresults" onmouseover="this.className='searchresultson';" onmouseout="this.className='searchresults';">
	<td class="normal" width="20" align="right" valign="top"><li></td>
	<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td class="normal" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=subarticle&documentid=#attributes.documentID#&articleID=#attributes.ArticleID#&subarticleID=#SubArticleID#" style="color:666666; text-decoration:none;">#SubArticleTitle#</a></td>
	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<td width="40" class="small" align="right"><cfif (#TRIM(AllSubArticles.SubExpireDate)# NEQ '') AND (#DateCompare(AllSubArticles.SubExpireDate, localDateTime)# EQ -1)>Expired</cfif></td>
		<td width="40" class="small" align="right"><a href="#request.webroot#/admin/dsp_subarticle_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#&articleID=#articleID#&subarticleID=#SubArticleID#" target="editSubArt" ONCLICK="fdbackwindow=window.open ('','editSubArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit SubArticle" border="0"></a> <a href="javascript:confirmSubArticleDelete('#request.webroot#/admin/act_subarticle_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#&articleID=#articleID#&subarticleID=#SubArticleID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete SubArticle" border="0"></a><br><a href="#request.webroot#/admin/act_whatnew_add.cfm?type=content&fuseaction=#attributes.fuseaction#&fusesubaction=subarticle<cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>&SubArticleID=#SubArticleID#"><img src="#request.imageroot#/butt_whatnew_add.gif" width="24" height="10" alt="Add to Whats New" border="0"></a></td>
		</cfif>
	</tr>
	</cfloop>
	
	
	
	</table><br>
	
	</cfoutput>

</cfif>