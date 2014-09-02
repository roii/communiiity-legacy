<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Add Related Resource</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add Related Resource</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>
&nbsp;&nbsp; | <cfif #fuseaction# NEQ 'download'><a href="##downloads" style="color:black">Downloads</a> |</cfif><cfif #fusesubaction# NEQ 'docs'> <a href="##documents" style="color:black">Documents</a> |</cfif><cfif #fusesubaction# NEQ 'articles'> <a href="##articles" style="color:black">Articles</a> |</cfif><cfif #fusesubaction# NEQ 'subarticles'> <a href="##subarticles" style="color:black">SubArticles</a> |</cfif><cfif #fusesubaction# NEQ 'news_template'> <a href="##news" style="color:black">Media Releases</a> |</cfif> <a href="##events" style="color:black">Events</a> | <a href="##links" style="color:black">Links</a> |

	<form method="post" action="act_relatedresources_add.cfm" name="addform">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	
	<cfif IsDefined("documentID")>
	<input type="hidden" name="documentID" value="#documentID#">
	</cfif>
	
	<cfif IsDefined("articleID")>
	<input type="hidden" name="articleID" value="#articleID#">
	</cfif>
	
	<cfif IsDefined("subarticleID")>
	<input type="hidden" name="subarticleID" value="#subarticleID#">
	</cfif>
	
	<cfif IsDefined("level4articleID")>
	<input type="hidden" name="level4articleID" value="#level4articleID#">
	</cfif>
	
	<cfif IsDefined("newsID")>
	<input type="hidden" name="newsID" value="#newsID#">
	</cfif>
	
	<cfif IsDefined("eventID")>
	<input type="hidden" name="eventID" value="#eventID#">
	</cfif>
	
	<cfif IsDefined("LibraryID")>
	<input type="hidden" name="LibraryID" value="#LibraryID#">
	</cfif>
	
	
	<cfif #fusesubaction# EQ 'template'>	
		<input type="hidden" name="LinkToID" value="#LibraryID#">
	<cfelseif #fusesubaction# EQ 'docs'>
		<input type="hidden" name="LinkToID" value="#DocumentID#">
	<cfelseif #fusesubaction# EQ 'article'>
		<input type="hidden" name="LinkToID" value="#ArticleID#">
	<cfelseif #fusesubaction# EQ 'subarticle'>
		<input type="hidden" name="LinkToID" value="#SubArticleID#">
	<cfelseif #fusesubaction# EQ 'level4'>
		<input type="hidden" name="LinkToID" value="#Level4ArticleID#">
	<cfelseif #fusesubaction# EQ 'news_template'>
		<input type="hidden" name="LinkToID" value="#NewsID#">
	<cfelseif #fusesubaction# EQ 'index'>
		<input type="hidden" name="LinkToID" value="#SectionID#">
	</cfif>
	
	
	
	
	
	
	<cfif #fuseaction# NEQ 'download'>
		<cfinclude template="dsp_relatedresources_add_downloads.cfm"><br>
	</cfif>
	
	<cfif #fusesubaction# NEQ 'docs'>
		<cfinclude template="dsp_relatedresources_add_documents.cfm"><br>
	</cfif>
	
	<cfif #fusesubaction# NEQ 'articles'>
		<cfinclude template="dsp_relatedresources_add_articles.cfm"><br>
	</cfif>
	
	<cfif #fusesubaction# NEQ 'subarticles'>
		<cfinclude template="dsp_relatedresources_add_subarticles.cfm"><br>
	</cfif>
	
	<cfif #fusesubaction# NEQ 'level4'>
		<cfinclude template="dsp_relatedresources_add_level4articles.cfm"><br>
	</cfif>
	
	<cfif #fusesubaction# NEQ 'news_template'>
		<cfinclude template="dsp_relatedresources_add_news.cfm"><br>
	</cfif>
	
	
	<cfinclude template="dsp_relatedresources_add_events.cfm"><br>
	
	<cfinclude template="dsp_relatedresources_add_links.cfm"><br>
	
	</form>	
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>