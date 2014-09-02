<cfoutput>

<cfset newdetails='#Level4ArticleDetails.Level4Details#'>


<!--- <cfif #session.glossarymode# EQ 'On'>
	
	 <!--- SELECT ALL GLOSSARY RECORDS --->
	<cfinclude template="qry_glossary.cfm">
	<!--- LOOP GLOSSARY AND SEARCH CONTENT FOR EACH WORD --->
	<cfloop query="GlossaryStuff">
	
	<cfset newdetails = ReplaceNoCase("#newdetails#",  " #TRIM(GlossaryStuff.GlossaryTitle)# ",  ' <a href="http://www.enigma.co.nz/G-I-N_new/templates/dsp_popup_glossary.cfm?glossaryword=#GlossaryStuff.GlossaryTitle#" target="glossarydesc" style="TEXT-DECORATION: none; color: blue;" onClick="fdbackwindow=window.open ('''',''glossarydesc'',''toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=600,height=220,top=50,left=50'')"><img src="http://www.enigma.co.nz/G-I-N_new/images/glossary_trigger.gif" border="0"> #GlossaryStuff.GlossaryTitle#</A> ',  'ALL')>
	
	<cfset newdetails = ReplaceNoCase("#newdetails#",  " #TRIM(GlossaryStuff.GlossaryTitle)#.",  ' <a href="http://www.enigma.co.nz/G-I-N_new/templates/dsp_popup_glossary.cfm?glossaryword=#GlossaryStuff.GlossaryTitle#" target="glossarydesc" style="TEXT-DECORATION: none; color: blue;" onClick="fdbackwindow=window.open ('''',''glossarydesc'',''toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=600,height=220,top=50,left=50'')"><img src="http://www.enigma.co.nz/G-I-N_new/images/glossary_trigger.gif" border="0"> #GlossaryStuff.GlossaryTitle#</A>.',  'ALL')>
	
	<cfset newdetails = ReplaceNoCase("#newdetails#",  " #TRIM(GlossaryStuff.GlossaryTitle)#,",  ' <a href="http://www.enigma.co.nz/G-I-N_new/templates/dsp_popup_glossary.cfm?glossaryword=#GlossaryStuff.GlossaryTitle#" target="glossarydesc" style="TEXT-DECORATION: none; color: blue;" onClick="fdbackwindow=window.open ('''',''glossarydesc'',''toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=600,height=220,top=50,left=50'')"><img src="http://www.enigma.co.nz/G-I-N_new/images/glossary_trigger.gif" border="0"> #GlossaryStuff.GlossaryTitle#</A>,',  'ALL')>
	
	<cfset newdetails = ReplaceNoCase("#newdetails#",  " #TRIM(GlossaryStuff.GlossaryTitle)#;",  ' <a href="http://www.enigma.co.nz/G-I-N_new/templates/dsp_popup_glossary.cfm?glossaryword=#GlossaryStuff.GlossaryTitle#" target="glossarydesc" style="TEXT-DECORATION: none; color: blue;" onClick="fdbackwindow=window.open ('''',''glossarydesc'',''toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=600,height=220,top=50,left=50'')"><img src="http://www.enigma.co.nz/G-I-N_new/images/glossary_trigger.gif" border="0"> #GlossaryStuff.GlossaryTitle#</A>;',  'ALL')>
	
	</cfloop>

	
</cfif>	 --->

 <cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmSectionDelete(aURL) {
	    if(confirm('Deleting a Section also deletes all linked Documents, Articles and SubArticles.\nAre you sure you want to delete this Section?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
	<script language="JavaScript">
	<!--
	function confirmLevel4ArticleDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Level 4 article?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
</cfif>


<table border="0" cellpadding="0" cellspacing="2" width="100%">
		
<tr>
<td class="page_header" width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(sectiondetails.fuseaction)#"><img src="#request.imageroot#/title_#TRIM(sectiondetails.fuseaction)#.gif" border="0"></a></td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a><cfif #sectionDetails.Admin# EQ 1>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&sectionType=documenthandling')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Section" border="0"></a></cfif></cfif></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>	

<tr>
<td bgcolor="676767" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>	

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>	

<tr>
<td colspan="2"><span class="small" style="color:gray;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#" style="color:gray; text-decoration:none;">#sectionDetails.title#</a> / <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#attributes.documentID#" style="color:gray; text-decoration:none;">#documentDetails.title#</a> / <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=article&documentID=#attributes.documentID#&articleID=#attributes.articleID#" style="color:gray; text-decoration:none;">#articleDetails.ArticleTitle#</a> / <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=subarticle&documentID=#attributes.documentID#&articleID=#attributes.articleID#&subarticleID=#attributes.subarticleID#" style="color:gray; text-decoration:none;">#SubArticleDetails.SubArticleTitle#</a></span><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"><br></td>
</tr>

<tr>
<td class="page_header" width="100%">#Level4ArticleDetails.Level4ArticleTitle#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_level4article_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#&articleID=#articleID#&subarticleID=#SubArticleID#&Level4articleID=#Level4articleID#" target="editLevel4" ONCLICK="fdbackwindow=window.open ('','editLevel4','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit SubArticle" border="0"></a>&nbsp;<a href="javascript:confirmLevel4ArticleDelete('#request.webroot#/admin/act_level4article_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#&articleID=#articleID#&subarticleID=#SubArticleID#&Level4articleID=#Level4articleID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete SubArticle" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2"><br>


<cfif #TRIM(newdetails)# NEQ ''><span class="normal">#newdetails#</span></cfif></td>
</tr>

</table>

</cfoutput>