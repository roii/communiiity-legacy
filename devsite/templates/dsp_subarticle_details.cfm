<!--- 

<fusedoc language="ColdFusion" FUSE="Document Handling" Specification="2.0">

<responsibilities>To display specific Sub-article details from the qry_subarticle_details recordset</responsibilities>

<properties>
	<history email="alanb@enigma.co.nz" author="Alan Barlow" type="create" date="15 January 2003" role="Architect"/>
</properties>

<in>
	<recordset name="SubArticleDetails" format="CFML" Scope="variables" primarykeys="SubArticleID">
</in>

</fusedoc>

 --->
 
 <cfoutput> 
 
 
  <cfif #SubArticleDetails.NonMember# EQ 0 AND #session.UserIsAuthenticated# EQ 'no'>
 
 <script>
alert("You must be a G-I-N member and logged-in to access this part of the website.");
self.location="javascript:history.back();";
</script>
<cfabort>
 
 </cfif>
 
 
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
	function confirmSubArticleDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Sub-article?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
</cfif>
 
<cfset newdetails='#SubArticleDetails.Subdetails#'>

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
<td colspan="2"><span class="small" style="color:gray;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#" style="color:gray; text-decoration:none;">#sectionDetails.title#</a> / <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=#attributes.documentID#" style="color:gray; text-decoration:none;">#documentDetails.title#</a> / <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=article&documentID=#attributes.documentID#&articleID=#attributes.articleID#" style="color:gray; text-decoration:none;">#articleDetails.ArticleTitle#</a></span><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"><br></td>
</tr>

<tr>
<td class="page_header" width="100%">#SubArticleDetails.SubArticleTitle#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_subarticle_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#&articleID=#articleID#&subarticleID=#SubArticleID#" target="editSubArt" ONCLICK="fdbackwindow=window.open ('','editSubArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit SubArticle" border="0"></a>&nbsp;<a href="javascript:confirmSubArticleDelete('#request.webroot#/admin/act_subarticle_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#&articleID=#articleID#&subarticleID=#SubArticleID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete SubArticle" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2">
<cfif NOT IsDefined("ShowIdeaPond")>
<a href="#request.webroot#/index.cfm?#request.attributeslist#&ShowIdeaPond=1&this_query_string=#URLEncodedFormat(cgi.query_string)#&##IdeaPond" style="font-size:10px;color:red;"><strong>- Go to ideaPond for this section -</strong></a><br>
</cfif>

<cfif #TRIM(newdetails)# NEQ ''><span class="normal">#newdetails#</span></cfif></td>
</tr>

</table>

</cfoutput>