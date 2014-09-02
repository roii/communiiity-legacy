<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To display all records retreived from the qry_linked_articles query</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<in>
	<recordset name="AllArticles" format="CFML" Scope="variables" primarykeys="ArticleID" onCondition="AllArticles.recordcount GT 0">
</in>

</fusedoc>

 --->

<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
<cfset alertmsg = #deletelinktext#>
	<script language="JavaScript">
	   var alertmsgJS = '<cfoutput>#alertmsg#</cfoutput>';
	<!--
	function confirmArticleDelete(aURL) {
	    if(confirm(alertmsgJS)) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>



<cfif AllArticles.recordcount OR ((session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator'))>
	
	<cfoutput>
	<br>
	<table width="100%" cellpadding="0" cellspacing="2" border="0">
	
	
	<tr>
	<td bgcolor="###TRIM(AllSettings.BoxColour)#">
		
		<table width="100%" cellpadding="2" cellspacing="0" border="0">
	
		<tr>
		<td height="22" style="color:###TRIM(AllSettings.BoxTextColour)#;font-face:Trebuchet MS;font-size:12px;">&nbsp;<b>#futherInf#</b></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
	<tr>
	<td class="normal" width="20" align="right" valign="top"><li style="color:###TRIM(AllSettings.BoxColour)#;"></td>
	<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td class="small"><a href="#request.webroot#/admin/dsp_article_add.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#attributes.documentID#&fusesubaction=#attributes.fusesubaction#" target="addArt" onclick="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>#addlevel2doc# &raquo;</strong></a></td>
	<td width="40"> </td>
	<td width="40"> </td>
	</tr>
	</cfif>	
	
	
		<cfloop query="AllArticles">
		<tr class="searchresults" onmouseover="this.className='searchresultson';" onmouseout="this.className='searchresults';">
		<td class="normal" width="20" align="right" valign="top"><li></td>
		<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		<td class="normal" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#&fusesubaction=article&documentid=#attributes.documentID#&articleID=#allArticles.ArticleID#" style="color:666666; text-decoration:none;">#ArticleTitle#</a></td>
		<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
		<td width="40" class="small" align="right"><cfif (#TRIM(AllArticles.ExpireDate)# NEQ '') AND (#DateCompare(AllArticles.ExpireDate, localDateTime)# EQ -1)>#Expired#</cfif></td>
		<td width="40" class="small" align="right"><a href="#request.webroot#/admin/dsp_article_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#&articleID=#articleID#" target="editArt" ONCLICK="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Article" border="0"></a> <a 
		href="javascript:confirmArticleDelete('#request.webroot#/admin/act_article_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#&articleID=#articleID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></td>
		</cfif>
		</tr>
		</cfloop>
	

	
	</table><br>
	
	
	</cfoutput>

</cfif>