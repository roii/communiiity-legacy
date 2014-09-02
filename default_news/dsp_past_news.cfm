<cfparam name="totalarticles" default="0">


<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmNewsDelete(aURL) {
	    if(confirm('Are you sure you want to delete this News Article?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	
	<!--
	function confirmNewsCatDelete(aURL) {
	    if(confirm('Deleting a News Category also deletes any linked Articles. Are you sure you want to delete this News Category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>


<table border="0" cellpadding="0" cellspacing="2" width="100%">
 
 <cfoutput>		
<tr>
<td class="section_header" width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#TRIM(sectiondetails.fuseaction)#" style="text-decoration:none; color:black;"><cfif #session.textonly# EQ 'yes'>#SectionDetails.Title#<cfelse><img src="#request.imageroot#/title_#TRIM(sectiondetails.fuseaction)#.gif" border="0"></cfif></a></td>
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
<td class="page_header" width="100%">#UCASE(DocumentDetails.Title)# - Archived</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Document" border="0"></a>&nbsp;<a 
	href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Document" border="0"></a></cfif></td>
</tr>



<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br> <a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>&newsmode=current" style="color:blue;">>> Click here</a> to view current news articles
<hr width="100%" size="1" color="e2e2e2">
</td>
</tr>


</cfoutput>

<!--- DISPLAY NEWS --->
<tr>
<td colspan="2"><br>


		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
		<cfoutput>
		<tr>
		<td class="small" colspan="2"><a href="#request.webroot#/admin/dsp_newsCat_add.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="addNewsCat" ONCLICK="fdbackwindow=window.open ('','addNewsCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=235,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A CATEGORY »</strong></a> &nbsp;&nbsp;&nbsp; <a href="#request.webroot#/admin/dsp_news_add.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="addNews" ONCLICK="fdbackwindow=window.open ('','addNews','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD AN ARTICLE »</strong></a><br><br></td>
		</tr>
		</cfoutput>
		</cfif>
		
		<cfoutput query="NewsCategories" group="NewsCatID">
			<cfinclude template="qry_past_news.cfm">
			<cfif (#headlines.recordcount# GT 0) OR (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><cfset totalarticles=1>
			<tr>
			<td><ul><li class="normal" style="color:#TRIM(sectionDetails.barColor)#;"><a href="###NewsCatName#" style="color:gray; text-decoration:none;">#NewsCatName#</a> <span class="small">(#headlines.recordcount#)</span></td>
			<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
			<td align="right"><a href="#request.webroot#/admin/dsp_newscat_edit.cfm?newsCatID=#newsCatID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="editNewsCat" ONCLICK="fdbackwindow=window.open ('','editNewsCat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=235,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Article" border="0"></a> <a href="javascript:confirmNewsCatDelete('#request.webroot#/admin/act_newsCat_delete.cfm?newsCatID=#newsCatID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></td>
			</cfif>
			</tr>
			</cfif>
		</cfoutput>
		
		
			<cfif #totalarticles# EQ 0>
			<tr>
			<td colspan="2"><span class="normal">There are no archived News Releases currently available.</span></td>
			</tr>
			</cfif>
		
		
		</table><br>
		<cfoutput><img src="#request.imageroot#/transparent_spc.gif" width="5" height="6" border="0"></cfoutput><br>
		
		
		
		
		
		<cfoutput query="NewsCategories" group="NewsCatID">
		<cfinclude template="qry_past_news.cfm">
		
		
		
		<a name="#NewsCatName#"> </a>
		
		
	
			
			<table width="100%" cellpadding="0" cellspacing="2" border="0">
			<tr>
			<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="FF3300"</cfif> width="17">
		
				<table width="17" cellpadding="1" cellspacing="0" border="0">
				<tr>
				<td><font face="WebDings" size="2" color="White"><strong>4</strong></font></td>
				</tr>
				</table>
			
			</td>
			<td <cfif #session.textonly# EQ 'yes'>bgcolor="black"<cfelse>bgcolor="#TRIM(sectionDetails.barColor)#"</cfif>>
		
				<table width="100%" cellpadding="1" cellspacing="0" border="0">
				<tr>
				<td width="5"><img src="#request.imageroot#/transparent_spc.gif" width="5" height="1" border="0"></td>
				<td><span style="color:white; letter-spacing:.5em;"><b>#UCASE(NewsCatName)#</b></span></td>
				</tr>
				</table>
			
			</td>
			</tr>
			</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"><br>
			
			
			<table width="100%" cellpadding="0" cellspacing="2" border="0">
			
			<cfif #headlines.recordcount# GT 0>	
			
			<cfloop query="headlines">	
			
			<tr>
			<td class="normal" width="17" valign="top" align="center"><font face="webdings" size="2" color="#TRIM(sectionDetails.barColor)#">4</font></td>
			<td width="7"><img src="#request.imageroot#/transparent_spc.gif" width="7" height="1" border="0"></td>
			<td class="normal" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>&newsmode=template&NewsID=#RecordID#&newsCatID=#NewsCatID#" style="color:black; text-decoration:none;"><b>#Title#</b></a><br>
			<cfif #trim(introduction)# NEQ ''><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>&newsmode=template&NewsID=#RecordID#&newsCatID=#NewsCatID#" style="color:gray; text-decoration:none;">#introduction#</a><br></cfif>
			(#DateFormat(ReleasedDate, "d-mmm-yy")#)</td>
			<cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')>
			<td width="28" align="center" class="normal" valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"><br><img src="#request.imageroot#/icon_permissions.gif" width="7" height="15" alt="<cfif #NonMember# EQ 1>Public</cfif> | <cfif #member# EQ 1>Member</cfif>" border="0"></td>
			<td align="right" valign="top" width="28"><a href="#request.webroot#/admin/dsp_news_edit.cfm?newsID=#RecordID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>" target="editNews" ONCLICK="fdbackwindow=window.open ('','editNews','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Article" border="0"></a> <a href="javascript:confirmNewsDelete('#request.webroot#/admin/act_news_delete.cfm?newsID=#RecordID#&fuseaction=#fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a><br><a href="#request.webroot#/admin/act_whatnew_add.cfm?type=news&fuseaction=#attributes.fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif><cfif IsDefined("attributes.SubArticleID")>&SubArticleID=#attributes.SubArticleID#</cfif>&NewsID=#RecordID#"><img src="#request.imageroot#/butt_whatnew_add.gif" width="24" height="10" alt="Add to Whats New" border="0"></a></td>
			</cfif>
			</tr>
				
			<tr>
			<td class="small"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
			</tr>
			</cfloop>
		
		<cfelse>
		<tr>
		<td class="normal" width="17" valign="top" align="center"><font face="webdings" size="2" color="#TRIM(sectionDetails.barColor)#">4</font></td>
		<td width="7"><img src="#request.imageroot#/transparent_spc.gif" width="7" height="1" border="0"></td>
		<td class="normal" style="color:gray;">No archived news articles available. Click here to view <a href="#request.webroot#/index.cfm?fuseaction=#attributes.fuseaction#<cfif IsDefined("attributes.fusesubaction")>&fusesubaction=#attributes.fusesubaction#</cfif><cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.ArticleID")>&ArticleID=#attributes.ArticleID#</cfif>&newsmode=current" style="color:Gray;">Current News &raquo;</a></td>
		</tr>
		
		</cfif>	
			
			</table>
			<br>
			
			
					
		</cfoutput>
		
</td>
</tr>

</table>