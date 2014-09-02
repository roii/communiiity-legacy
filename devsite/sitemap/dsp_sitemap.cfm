<cfoutput>

<cfquery name="Sitemap_Sections" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SectionID, Fuseaction, MenuTitle
FROM Sections
WHERE (MainMenu=1 OR BottomMenu=1 OR TopMenu=1)

<cfif session.UserIsAuthenticated>

	<cfif session.UserType NEQ 'Administrator'>
		AND (ContactTypeView LIKE '#session.User_ContactTypeID#' OR ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR ContactTypeView LIKE '%,#session.User_ContactTypeID#')
	</cfif>

<cfelse>
	AND PublicView = 1
</cfif>

ORDER BY MainMenu DESC, MainMenuOrder
</cfquery>

<table border="0" cellpadding="0" cellspacing="2" width="100%">
 		
<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#"><strong>#UCASE(TRIM(SectionDetails.MenuTitle))#</strong></td>
<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" onclick="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<tr>
<td colspan="2">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<cfloop query="Sitemap_Sections">
	<cfset thisfuse=Sitemap_Sections.fuseaction>
	
	<cfquery name="Sitemap_Documents" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Documents.*, SectionDocuments_Link.*
	FROM Documents, SectionDocuments_Link
	WHERE SectionDocuments_Link.SectionID=#Sitemap_Sections.sectionid#
	AND SectionDocuments_Link.DocumentID=Documents.DocumentID
	
	<cfif session.UserIsAuthenticated>
	
		<cfif session.UserType NEQ 'Administrator'>
			AND (Documents.ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR Documents.ContactTypeView LIKE '%,#session.User_ContactTypeID#')
			AND (Documents.DocExpireDate > #now()# 
			OR Documents.DocExpireDate IS NULL)
			AND Documents.Released=1
		</cfif>
	
	<cfelse>
		AND Documents.PublicView = 1
		AND (Documents.DocExpireDate > #now()# 
		OR Documents.DocExpireDate IS NULL)
		AND Documents.Released=1
	</cfif>
	
	ORDER BY SectionDocuments_Link.DisplayOrder	
	</cfquery>
	
	<tr>
	<td style="font-size:12px;" width="100%">&nbsp;<strong><a href="#request.webroot#/index.cfm?fuseaction=#thisfuse#" style="text-decoration:none;color:###TRIM(AllSettings.BoxColour)#">»</a> <a href="#request.webroot#/index.cfm?fuseaction=#thisfuse#" style="text-decoration:underline;color:###TRIM(AllSettings.BoxColour)#">#TRIM(Sitemap_Sections.MenuTitle)#</a></strong><br></td>
	<td align="right" width="40" nowrap><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#Sitemap_Sections.sectionID#&fuseaction=#thisfuse#" target="editSection" onclick="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Section" border="0"></a></cfif></td>
	</tr>
	
	<tr>
	<td colspan="2">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
			
		<cfloop query="Sitemap_Documents">
		<cfset thisdoc=Sitemap_Documents.DocumentID>
		
		<cfquery name="Sitemap_Articles" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Articles.*, DocumentArticles_Link.displayorder
		FROM Articles, DocumentArticles_Link
		WHERE DocumentArticles_Link.DocumentID=#Sitemap_Documents.documentID#
		AND DocumentArticles_Link.ArticleID=Articles.ArticleID
		
		<cfif session.UserIsAuthenticated>
		
			<cfif session.UserType NEQ 'Administrator'>
				<!--- AND (Articles.ContactTypeView LIKE '#session.User_ContactTypeID#,%' OR Articles.ContactTypeView LIKE '%,#session.User_ContactTypeID#,%' OR Articles.ContactTypeView LIKE '%,#session.User_ContactTypeID#') --->
				AND (Articles.ExpireDate > #now()# 
				OR Articles.ExpireDate IS NULL)
				AND Articles.Released=1
				AND Articles.AdminView = 1
			</cfif>
		
		<cfelse>
			<!--- AND Articles.PublicView = 1 --->
			AND (Articles.ExpireDate > #now()# 
			OR Articles.ExpireDate IS NULL)
			AND Articles.Released=1
		</cfif>
		
		ORDER BY DocumentArticles_Link.DisplayOrder	
		</cfquery>

		
		<tr>
		<td width="15"><img src="#request.imageroot#/transparent_spc.gif" width="15" height="1" border="0"></td>
		<td width="100%"><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(Sitemap_Documents.ContactTypeView, session.User_ContactTypeID, ",")) OR (Sitemap_Documents.PublicView EQ 1) OR (session.UserType EQ 'Administrator')><strong><a href="#request.webroot#/index.cfm?fuseaction=#thisfuse#&fusesubaction=docs&documentID=#thisdoc#" style="text-decoration:none;"> » &nbsp; #Sitemap_Documents.Title#</a></strong><cfelse><strong><span style="text-decoration:none;color:gray;"> » &nbsp; #Sitemap_Documents.Title#</span></strong> &nbsp;&nbsp;<span style="color:gray;font-size:10px;">(members only)</span></cfif></td>
		<td width="40" align="right" nowrap><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#Sitemap_Sections.SectionID#&fuseaction=#thisfuse#&documentID=#thisdoc#" target="editDoc" onclick="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Document" border="0"></a> <cfif Sitemap_Documents.allowdelete EQ 1><a 
	href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#thisdoc#&fuseaction=#thisfuse#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Document" border="0"></a></cfif></cfif></td>
		</tr>
		
		
		<tr>
		<td colspan="3">
		
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
					
			<cfloop query="Sitemap_Articles">
			<cfset thisart=Sitemap_Articles.ArticleID>
			
			
			<cfquery name="Sitemap_SubArticles" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT SubArticles.SubArticleID, SubArticles.SubArticleTitle
			FROM ArticleSubArticle_Link, SubArticles
			WHERE ArticleSubArticle_Link.ArticleID=#Sitemap_Articles.ArticleID#
			AND ArticleSubArticle_Link.SubArticleID=SubArticles.SubArticleID
			</cfquery>
			
			
			
			
			<tr>
			<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
			<td width="100%"><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFind(Sitemap_Articles.ContactTypeView, session.User_ContactTypeID, ",")) OR (Sitemap_Articles.PublicView EQ 1) OR (session.UserType EQ 'Administrator')><a href="#request.webroot#/index.cfm?fuseaction=#thisfuse#&fusesubaction=article&documentID=#thisdoc#&articleID=#thisart#"> » &nbsp; #Sitemap_Articles.ArticleTitle#</a><cfelse><span style="text-decoration:none;color:gray;"> » &nbsp; #Sitemap_Articles.ArticleTitle#</span> &nbsp;&nbsp;<span style="color:gray;font-size:10px;">(members only)</span></cfif></td>
			<td width="40" align="right" nowrap><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_article_edit.cfm?sectionID=#Sitemap_Sections.SectionID#&fuseaction=#thisfuse#&documentID=#thisdoc#&articleID=#thisart#" target="editArt" onclick="fdbackwindow=window.open ('','editArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Article" border="0"></a> <a 
		href="javascript:confirmArticleDelete('#request.webroot#/admin/act_article_delete.cfm?documentID=#thisdoc#&fuseaction=#thisfuse#&articleID=#thisart#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Article" border="0"></a></cfif></td>
			</tr>
			
			
			
			
			<tr>
			<td colspan="3">
		
			
				<table width="100%" cellpadding="2" cellspacing="1" border="0">
				
						
				<cfloop query="Sitemap_SubArticles">
				<cfset thissubart=Sitemap_SubArticles.SubArticleID>
				
				
				<tr>
				<td width="45"><img src="#request.imageroot#/transparent_spc.gif" width="45" height="1" border="0"></td>
				<td width="100%"><a href="#request.webroot#/index.cfm?fuseaction=#thisfuse#&fusesubaction=subarticle&documentID=#thisdoc#&articleID=#thisart#&subarticleID=#thissubart#"> » #Sitemap_SubArticles.SubArticleTitle#</a></td>
				</tr>
				</cfloop>
				</table>
		
		
			</td>
			</tr>
			
						
			</cfloop>
			</table>
	
	
		</td>
		</tr>
		
		
	
		</cfloop>
		</table>
	
	
	</td>
	</tr>
	
	<tr>
	<td><hr width="100%" color="e2e2e2" size="1"></td>
	</tr>
	
	</cfloop>
	
	</table>




</td>
</tr>

</table>

</cfoutput>