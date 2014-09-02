<cfif IsDefined("librarylinks") and (librarylinks.recordcount) OR (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>


<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>

	<script language="JavaScript">
	<!--
	function confirmRelatedDelete(aURL) {
	    if(confirm('Are you sure you want to delete this related link?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>

</cfif>

<cfoutput>
<br>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td height="1" colspan="3" bgcolor="White"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
</tr>

<tr>
<td height="1" width="1" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
<td bgcolor="###TRIM(AllSettings.BoxColour)#">

	<table width="100%" cellpadding="2" cellspacing="0" border="0">
	
	<tr>
	<td height="22" style="color:###TRIM(AllSettings.BoxTextColour)#;font-face:Trebuchet MS;font-size:12px;">&nbsp;<b>#relatedRes#</b></td>
	</tr>
	
	</table>

</td>
<td height="1" width="1" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
</tr>


<tr>
<td height="1" colspan="3" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
</tr>


<tr>
<td height="1" width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
<td>

	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
	
	<tr bgcolor="##b4b4b4" height="16">
	<td align="center" width="60" style="border-right:solid white 1px;color:white;">#type#</td>
	<td width="*" style="border-right:solid white 1px;color:white;">&nbsp;#Title#</td>
	<td align="center" width="60" style="border-right:solid white 1px;color:white;">#Format#</td>
	<td align="center" width="80" style="border-right:solid white 1px;color:white;">#Uploaded#</td>
	<td align="center" width="60" style="color:white;">#filesize#</td>
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
	<td width="20"> </td>
	</cfif>
	</tr>
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
		<tr>
		<td colspan="6" height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
		</tr>
	<cfelse>
		<tr>
		<td colspan="5" height="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
		</tr>
	
	</cfif>
	
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
		<tr>
		<td colspan="6" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3"  border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6" class="small">&nbsp;<a href="#request.webroot#/admin/dsp_relatedresource_add.cfm?fuseaction=#fuseaction#&fusesubaction=#attributes.fusesubaction#<cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.articleID")>&articleID=#attributes.articleID#</cfif><cfif IsDefined("attributes.subarticleID")>&subarticleID=#attributes.subarticleID#</cfif><cfif IsDefined("attributes.level4articleID")>&level4articleID=#attributes.level4articleID#</cfif><cfif IsDefined("attributes.newsID")>&newsID=#attributes.newsID#</cfif><cfif IsDefined("attributes.eventID")>&eventID=#attributes.eventID#</cfif><cfif IsDefined("attributes.LibraryID")>&LibraryID=#attributes.LibraryID#</cfif><cfif IsDefined("sectionDetails.SectionID")>&SectionID=#sectionDetails.SectionID#</cfif>" target="addArt" ONCLICK="fdbackwindow=window.open ('','addArt','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')" style="color:###AllSettings.BoxColour#; text-decoration:none;"><strong>ADD A RELATED RESOURCE &raquo;</strong></a></td>
		</tr>
		
		<tr>
		<td colspan="6" height="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3"  border="0"></td>
		</tr>	
	
		<tr>
		<td colspan="6" height="1" bgcolor="b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
		</tr>
	
	</cfif>
	
	
<cfif IsDefined("librarylinks")>
	<cfloop query="librarylinks">
	
	
	
	
	<cfif (Type CONTAINS 'Library') AND NOT (isDefined("attributes.LibraryID"))>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT RecordID AS UniqueKey, Title AS DisplayTitle, FileFormat, FileSize, DateUploaded
		FROM Library
		WHERE RecordID=#LibraryID#
		</cfquery>		
		
		<cfset relatedType = 'File'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=download&fusesubaction=template&libraryID=#relatedDetails.uniqueKey#'>
		<cfset format = #relatedDetails.FileFormat#>
		<cfset releaseDate = #relatedDetails.DateUploaded#>
		<cfset size = #relatedDetails.FileSize#>
		
		
	
	<cfelseif (Type CONTAINS 'News') AND NOT (isDefined("attributes.newsID"))>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT RecordID AS UniqueKey, Title AS DisplayTitle, ReleasedDate, NewsCatID
		FROM News
		WHERE RecordID=#NewsID#
		</cfquery>		
		
		<cfset relatedType = 'News'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=news&fusesubaction=index&newsmode=template&newsID=#relatedDetails.uniqueKey#&NewsCatID=#relatedDetails.NewsCatID#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = #relatedDetails.ReleasedDate#>
		<cfset size = 0>
	
	
	<cfelseif (Type CONTAINS 'Guideline') AND NOT (isDefined("attributes.GuidelineID"))>
	
		<cfquery name="relatedDetails" datasource="#Guidelinedsn#">
		SELECT dbo.Guidelines.GuidelineID AS UniqueKey, dbo.Guidelines.GuidelineTitle AS DisplayTitle, dbo.Guidelines.PublishedDate, dbo.GuidelineCatLink.GuidelineCatID
		FROM dbo.Guidelines, dbo.GuidelineCatLink
		WHERE dbo.Guidelines.GuidelineID=#GuidelineID#
		AND dbo.Guidelines.GuidelineID=dbo.GuidelineCatLink.GuidelineID
		</cfquery>		
		
		<cfset relatedType = 'Guideline'>
		<cfset hreftype = 'pop'>
		<cfset directpath = 'guidelines/dsp_guideline_popup.cfm?GuidelineID=#relatedDetails.uniqueKey#&GuidelineCatID=#relatedDetails.GuidelineCatID#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = #relatedDetails.PublishedDate#>
		<cfset size = 0>
		<cfset popwidth="745">	
		<cfset popheight="500">
	
	<cfelseif (Type CONTAINS 'Event') AND NOT (isDefined("attributes.EventID"))>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT EventID AS UniqueKey, EventTitle AS DisplayTitle, StartDate
		FROM Events
		WHERE EventID=#EventID#
		</cfquery>		
		
		<cfset relatedType = 'Event'>
		<cfset hreftype = 'pop'>
		<cfset directpath = 'default_events/dsp_event_details.cfm?EventID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = #relatedDetails.StartDate#>
		<cfset size = 0>
		<cfset popwidth="550">	
		<cfset popheight="400">
		
		
	
	<cfelseif (Type CONTAINS 'Link') AND NOT (isDefined("attributes.LinkID"))>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT LinkID AS UniqueKey, Title AS DisplayTitle, LinkURL
		FROM Links
		WHERE LinkID=#WebLinkID#
		</cfquery>		
		
		<cfset relatedType = 'Link'>
		<cfset hreftype = 'blank'>
		<cfset directpath = '#relatedDetails.LinkURL#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = 'na'>
		<cfset size = 0>
		
	
	
	<cfelseif (Type CONTAINS 'Section') AND NOT (attributes.fusesubaction EQ 'index')>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Sections.SectionID AS UniqueKey, Sections.Title AS DisplayTitle, Sections.fuseaction
		FROM Sections
		WHERE SectionID=#SectionID#
		</cfquery>		
		
		<cfset relatedType = 'Section'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=index'>
		<cfset format = 'HTML'>
		<cfset releaseDate = CreateODBCDate("3 October 2003")>
		<cfset size = 0>
		
		
	
	<cfelseif (Type CONTAINS 'Doc') AND NOT (attributes.fusesubaction EQ 'docs')>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Documents.DocumentID AS UniqueKey, Documents.Title AS DisplayTitle, Documents.PubDate, SectionDocuments_Link.SectionID, Sections.Fuseaction
		FROM Documents, SectionDocuments_Link, Sections
		WHERE Documents.DocumentID=#DocumentID#
		AND Documents.DocumentID=SectionDocuments_Link.DocumentID
		AND SectionDocuments_Link.SectionID=Sections.SectionID
		</cfquery>		
		
		<cfset relatedType = 'Document'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=docs&documentID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = #relatedDetails.PubDate#>
		<cfset size = 0>
		
		
	
	<cfelseif (Type CONTAINS 'Art') AND (#attributes.fusesubaction# NEQ 'article') AND NOT (Type CONTAINS 'Sub') AND NOT (Type CONTAINS 'Level4Art') AND NOT (Type CONTAINS 'ArtArtArt')>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT articles.ArticleID AS UniqueKey, Articles.ArticleTitle AS DisplayTitle, DocumentArticles_Link.DocumentID, 
		Sections.Fuseaction
		FROM Articles, DocumentArticles_Link, Documents, SectionDocuments_Link, Sections
		WHERE Articles.ArticleID=#ArticleID#
		AND Articles.ArticleID=DocumentArticles_Link.ArticleID
		AND DocumentArticles_Link.DocumentID=Documents.DocumentID
		AND Documents.DocumentID=SectionDocuments_Link.DocumentID
		AND SectionDocuments_Link.SectionID=Sections.SectionID
		</cfquery>		
		
		<cfset relatedType = 'Article'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=article&documentID=#relatedDetails.DocumentID#&articleID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = 'na'>
		<cfset size = 0>
		
		
	
	<cfelseif (Type CONTAINS 'ArtSubArt') AND (attributes.fusesubaction EQ 'subarticle')>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT articles.ArticleID AS UniqueKey, Articles.ArticleTitle AS DisplayTitle, DocumentArticles_Link.DocumentID, 
		Sections.Fuseaction
		FROM Articles, DocumentArticles_Link, Documents, SectionDocuments_Link, Sections
		WHERE Articles.ArticleID=#ArticleID#
		AND Articles.ArticleID=DocumentArticles_Link.ArticleID
		AND DocumentArticles_Link.DocumentID=Documents.DocumentID
		AND Documents.DocumentID=SectionDocuments_Link.DocumentID
		AND SectionDocuments_Link.SectionID=Sections.SectionID
		</cfquery>		
		
		<cfset relatedType = 'Article'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=article&documentID=#relatedDetails.DocumentID#&articleID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = 'na'>
		<cfset size = 0>
		
	<cfelseif Type CONTAINS 'ArtArtArt'>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT articles.ArticleID AS UniqueKey, Articles.ArticleTitle AS DisplayTitle, DocumentArticles_Link.DocumentID, 
		Sections.Fuseaction
		FROM Articles, DocumentArticles_Link, Documents, SectionDocuments_Link, Sections
		WHERE Articles.ArticleID=#SubArticleID#
		AND Articles.ArticleID=DocumentArticles_Link.ArticleID
		AND DocumentArticles_Link.DocumentID=Documents.DocumentID
		AND Documents.DocumentID=SectionDocuments_Link.DocumentID
		AND SectionDocuments_Link.SectionID=Sections.SectionID
		</cfquery>		
		
		<cfset relatedType = 'Article'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=article&documentID=#relatedDetails.DocumentID#&articleID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = 'na'>
		<cfset size = 0>	
		
		
		
<cfelseif #Type# EQ 'Level4ArtArt'>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT articles.ArticleID AS UniqueKey, Articles.ArticleTitle AS DisplayTitle, DocumentArticles_Link.DocumentID, 
		Sections.Fuseaction
		FROM Articles, DocumentArticles_Link, Documents, SectionDocuments_Link, Sections
		WHERE Articles.ArticleID=#ArticleID#
		AND Articles.ArticleID=DocumentArticles_Link.ArticleID
		AND DocumentArticles_Link.DocumentID=Documents.DocumentID
		AND Documents.DocumentID=SectionDocuments_Link.DocumentID
		AND SectionDocuments_Link.SectionID=Sections.SectionID
		</cfquery>		
		
		<cfset relatedType = 'Article'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=article&documentID=#relatedDetails.DocumentID#&articleID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = 'na'>
		<cfset size = 0>
		
		
		
	<cfelseif (Type CONTAINS 'SubArt') AND (#attributes.fusesubaction# NEQ 'subarticle')>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SubArticles.SubArticleID AS UniqueKey, SubArticles.SubArticleTitle AS DisplayTitle, Articles.ArticleID, 
		Documents.DocumentID, Sections.Fuseaction
		FROM SubArticles, Articles, ArticleSubArticle_Link, DocumentArticles_Link, Documents, SectionDocuments_Link, Sections
		WHERE SubArticles.SubArticleID=#SubArticleID#
		AND SubArticles.SubArticleID=ArticleSubArticle_Link.SubArticleID
		AND ArticleSubArticle_Link.ArticleID=Articles.ArticleID
		AND Articles.ArticleID=DocumentArticles_Link.ArticleID
		AND DocumentArticles_Link.DocumentID=Documents.DocumentID
		AND Documents.DocumentID=SectionDocuments_Link.DocumentID
		AND SectionDocuments_Link.SectionID=Sections.SectionID
		</cfquery>		
		
		<cfset relatedType = 'Article'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=subarticle&documentID=#relatedDetails.DocumentID#&articleID=#relatedDetails.ArticleID#&subArticleID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = 'na'>
		<cfset size = 0>
		
		
		
	<cfelseif (Type CONTAINS 'Level4Art') AND (#attributes.fusesubaction# NEQ 'level4')>
	
		<cfquery name="relatedDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Level4Articles.Level4ArticleID AS UniqueKey, Level4Articles.Level4ArticleTitle AS DisplayTitle, SubArticles.SubArticleID, Articles.ArticleID, Documents.DocumentID, Sections.Fuseaction
		FROM Level4Articles, SubArticles, Articles, ArticleSubArticle_Link, DocumentArticles_Link, Documents, SectionDocuments_Link, Sections, SubArticleLevel4Link
		WHERE Level4Articles.Level4ArticleID=#Level4ArticleID#
		AND Level4Articles.Level4ArticleID=SubArticleLevel4Link.Level4ArticleID
		AND SubArticleLevel4Link.SubArticleID=SubArticles.SubArticleID
		AND SubArticles.SubArticleID=ArticleSubArticle_Link.SubArticleID
		AND ArticleSubArticle_Link.ArticleID=Articles.ArticleID
		AND Articles.ArticleID=DocumentArticles_Link.ArticleID
		AND DocumentArticles_Link.DocumentID=Documents.DocumentID
		AND Documents.DocumentID=SectionDocuments_Link.DocumentID
		AND SectionDocuments_Link.SectionID=Sections.SectionID
		</cfquery>		
		
		<cfset relatedType = 'Article'>
		<cfset hreftype = 'normal'>
		<cfset directpath = 'index.cfm?fuseaction=#relatedDetails.Fuseaction#&fusesubaction=level4&documentID=#relatedDetails.DocumentID#&articleID=#relatedDetails.ArticleID#&subArticleID=#relatedDetails.subArticleID#&Level4ArticleID=#relatedDetails.uniqueKey#'>
		<cfset format = 'HTML'>
		<cfset releaseDate = 'na'>
		<cfset size = 0>
	
	
	</cfif>
	
	
	
	
	
	
	
	
	
	<tr>
	<td class="small" align="center" width="60">#relatedType#</td>
	<td class="small" width="*">
	
		<table width="100%" cellpadding="4" cellspacing="0" border="0">
		<tr>
		<td valign="top"><cfif #hreftype# EQ 'normal'><a href="#request.webroot#/#directpath#"><cfelseif #hreftype# EQ 'blank'><a href="#directpath#" target="_Blank"><cfelse><a href="#request.webroot#/#directpath#" target="feedback" ONCLICK="fdbackwindow=window.open ('','feedback','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=#popwidth#,height=#popheight#,top=10,left=10')"></cfif>#relatedDetails.DisplayTitle#</a></td>
		</tr>
		</table>
		
	</td>
	<td class="small" align="center" width="60"><cfif #hreftype# EQ 'normal'><a href="#request.webroot#/#directpath#" style="color:666666; text-decoration:none;"><cfelseif #hreftype# EQ 'blank'><a href="#directpath#" style="color:666666; text-decoration:none;" target="_Blank"><cfelse><a href="#request.webroot#/#directpath#" target="feedback" ONCLICK="fdbackwindow=window.open ('','feedback','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=#popwidth#,height=#popheight#,top=10,left=10')" style="color:gray; text-decoration:none;"></cfif>#format#</a></td>
	<td class="small" align="center" width="80"><cfif #hreftype# EQ 'normal'><a href="#request.webroot#/#directpath#" style="color:666666; text-decoration:none;"><cfelseif #hreftype# EQ 'blank'><a href="#directpath#" style="color:666666; text-decoration:none;" target="_Blank"><cfelse><a href="#request.webroot#/#directpath#" target="feedback" ONCLICK="fdbackwindow=window.open ('','feedback','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=#popwidth#,height=#popheight#,top=10,left=10')" style="color:gray; text-decoration:none;"></cfif><cfif #IsDate(releaseDate)#>#Dateformat(releaseDate, "dd/mm/yy")#<cfelse>&ndash;</cfif></a></td>
	<td class="small" align="center" width="60"><cfif #hreftype# EQ 'normal'><a href="#request.webroot#/#directpath#" style="color:666666; text-decoration:none;"><cfelseif #hreftype# EQ 'blank'><a href="#directpath#" style="color:666666; text-decoration:none;" target="_Blank"><cfelse><a href="#request.webroot#/#directpath#" target="feedback" ONCLICK="fdbackwindow=window.open ('','feedback','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=#popwidth#,height=#popheight#,top=10,left=10')" style="color:gray; text-decoration:none;"></cfif>#INT(Size/1000)# k</a></td>
	<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
	<td width="20" align="right"><a href="javascript:confirmRelatedDelete('#request.webroot#/admin/act_relatedresource_delete.cfm?LibraryLinkID=#librarylinks.LinkID#&fuseaction=#fuseaction#&fusesubaction=#attributes.fusesubaction#<cfif IsDefined("attributes.documentID")>&documentID=#attributes.documentID#</cfif><cfif IsDefined("attributes.articleID")>&articleID=#attributes.articleID#</cfif><cfif IsDefined("attributes.subarticleID")>&subarticleID=#attributes.subarticleID#</cfif><cfif IsDefined("attributes.level4articleID")>&level4articleID=#attributes.level4articleID#</cfif><cfif IsDefined("attributes.newsID")>&newsID=#attributes.newsID#</cfif><cfif IsDefined("attributes.eventID")>&eventID=#attributes.eventID#</cfif><cfif IsDefined("attributes.LibraryID")>&LibraryID=#attributes.LibraryID#</cfif>')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Related Link" border="0"></a>&nbsp;</td>
	</cfif>
	</tr>
	
	<cfif #currentrow# NEQ #recordcount#>
		
		<cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')>
	
			<tr>
			<td colspan="6" height="1" bgcolor="Silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
			</tr>
			
		<cfelse>
	
			<tr>
			<td colspan="5" height="1" bgcolor="Silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
			</tr>
	
		</cfif>
		
	</cfif>
	
	</cfloop>
</cfif>	
	</table>


</td>

<td height="1" width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
</tr>

<cfif IsDefined("librarylinks") and librarylinks.recordcount>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1"  border="0"></td>
</tr>

</cfif>


</table>
</cfoutput>	

<br>
</cfif>
