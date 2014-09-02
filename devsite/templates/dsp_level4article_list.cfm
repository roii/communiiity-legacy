
<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmLevel4ArticleDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Level 4 Article?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>


<cfif (#AllLevel4Articles.recordcount# GT 0) OR ((#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator'))>

	
	<cfoutput>
	<br>
	<table width="100%" cellpadding="0" cellspacing="2" border="0">
	<tr>
	<td bgcolor="FF3300" width="17">

		<table width="17" cellpadding="1" cellspacing="0" border="0">
		<tr>
		<td><font face="WebDings" size="2" color="White"><strong>4</strong></font></td>
		</tr>
		</table>
	
	</td>
	<td bgcolor="#TRIM(sectionDetails.barColor)#">

		<table width="100%" cellpadding="1" cellspacing="0" border="0">
		<tr>
		<td><span class="small" style="color:white;"><b>&nbsp;&nbsp;S E L E C T&nbsp;&nbsp; A&nbsp;&nbsp; T O P I C</b></span></td>
		</tr>
		</table>
	
	</td>
	</tr>
	</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="5" border="0">

	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
	<tr>
	<td class="normal" width="5" valign="top"><font face="webdings" size="2" color="red">4</font></td>
	<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td class="small"><a href="#request.webroot#/admin/dsp_level4article_add.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#attributes.documentID#&fusesubaction=#attributes.fusesubaction#&articleID=#attributes.articleID#&subarticleID=#attributes.subarticleID#" target="addLevel4Art" ONCLICK="fdbackwindow=window.open ('','addLevel4Art','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A LEVEL 5 DOCUMENT</strong></a></td>
	<td width="40"> </td>
	<td width="40"> </td>
	</tr>
	</cfif>	
	
	
	
	<cfloop query="AllLevel4Articles">
	<tr class="searchresults" onmouseover="this.className='searchresultson';" onmouseout="this.className='searchresults';">
	<td class="normal" width="5" valign="top"><font face="webdings" size="2" color="#TRIM(sectionDetails.barColor)#">4</font></td>
	<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td class="normal" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=level4&documentid=#attributes.documentID#&articleID=#attributes.ArticleID#&subarticleID=#SubArticleID#&level4articleID=#level4ArticleID#" style="color:666666; text-decoration:none;">#Level4ArticleTitle#</a></td>
	<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<td width="40" class="small" align="right"><cfif (#TRIM(AllLevel4Articles.Level4ExpireDate)# NEQ '') AND (#DateCompare(AllLevel4Articles.Level4ExpireDate, localDateTime)# EQ -1)>Expired</cfif></td>
		<td width="40" class="small" align="right"><a href="#request.webroot#/admin/dsp_level4article_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#&articleID=#articleID#&subarticleID=#SubArticleID#&level4articleID=#level4ArticleID#" target="editSubArt" ONCLICK="fdbackwindow=window.open ('','editSubArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit SubArticle" border="0"></a> <a href="javascript:confirmLevel4ArticleDelete('#request.webroot#/admin/act_level4article_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#&articleID=#articleID#&subarticleID=#SubArticleID#&level4articleID=#level4ArticleID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete SubArticle" border="0"></a><br><a href="#request.webroot#/admin/act_whatnew_add.cfm?type=content&fuseaction=#attributes.fuseaction#&fusesubaction=Level4<cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif><cfif IsDefined("attributes.SubArticleID")>&SubArticleID=#attributes.SubArticleID#</cfif>&level4articleID=#level4ArticleID#"><img src="#request.imageroot#/butt_whatnew_add.gif" width="24" height="10" alt="Add to Whats New" border="0"></a></td>
		</cfif>
	</tr>
	</cfloop>
	
	
	
	</table><br>
	
	</cfoutput>

</cfif>