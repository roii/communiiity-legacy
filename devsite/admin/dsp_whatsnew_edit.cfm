
<cfoutput>

<cfquery name="WhatsNewStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM WhatsNew
WHERE WNID=#WNID#
</cfquery>



<cfif #TRIM(WhatsNewStuff.Type)# EQ 'Event'>
		
			<cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT EventTitle AS DisplayTitle
			FROM Events
			WHERE EventID=#WhatsNewStuff.EventID#
			</cfquery>
		
		
		<cfelseif #TRIM(WhatsNewStuff.Type)# EQ 'News'>
		
			<cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT News.Title AS DisplayTitle
			FROM News
			WHERE RecordID=#WhatsNewStuff.NewsID#
			</cfquery>	
		
		
		<cfelseif #TRIM(WhatsNewStuff.Type)# EQ 'download'>
		
			<cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Title AS DisplayTitle
			FROM Library
			WHERE RecordID=#WhatsNewStuff.LibraryID#
			</cfquery>	
		
		
		<cfelseif #TRIM(WhatsNewStuff.Type)# EQ 'link'>
		
			<cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT Title AS DisplayTitle
			FROM Links
			WHERE LinkID=#WhatsNewStuff.LinkID#
			</cfquery>	
				
		
		<cfelseif #TRIM(WhatsNewStuff.Type)# EQ 'content'>
		
		
			<cfif #TRIM(WhatsNewStuff.fusesubaction)# EQ 'docs'>
		
				 <cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT Documents.Title AS DisplayTitle
				FROM Documents, SectionDocuments_Link
				WHERE Documents.DocumentID=#WhatsNewStuff.DocumentID#
				AND Documents.DocumentID=SectionDocuments_Link.DocumentID
				</cfquery>
				
			<cfelseif #TRIM(WhatsNewStuff.fusesubaction)# EQ 'article'>
		
				 <cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT Articles.ArticleTitle AS DisplayTitle
				FROM Articles, DocumentArticles_Link
				WHERE Articles.ArticleID=#WhatsNewStuff.ArticleID#
				AND Articles.ArticleID=DocumentArticles_Link.ArticleID
				</cfquery>
				
			<cfelseif #TRIM(WhatsNewStuff.fusesubaction)# EQ 'subarticle'>
			
				<cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT SubArticles.SubArticleTitle AS DisplayTitle
				FROM SubArticles, ArticleSubArticle_Link, DocumentArticles_Link
				WHERE SubArticles.SubArticleID=#WhatsNewStuff.SubArticleID#
				AND SubArticles.SubArticleID=ArticleSubArticle_Link.SubArticleID
				AND ArticleSubArticle_Link.ArticleID=DocumentArticles_Link.ArticleID
				</cfquery>
				
			<cfelseif #TRIM(WhatsNewStuff.fusesubaction)# EQ 'level4'>
			
				<cfquery name="whatnewDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT Level4Articles.Level4ArticleTitle AS DisplayTitle
				FROM Level4Articles, SubArticleLevel4Link, ArticleSubArticle_Link, DocumentArticles_Link
				WHERE Level4Articles.Level4ArticleID=#WhatsNewStuff.Level4ArticleID#
				AND Level4Articles.Level4ArticleID=SubArticleLevel4Link.Level4ArticleID
				AND SubArticleLevel4Link.SubArticleID=ArticleSubArticle_Link.SubArticleID				
				AND ArticleSubArticle_Link.ArticleID=DocumentArticles_Link.ArticleID
				</cfquery>
				
			</cfif>
		
		
		</cfif>
		
		

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Edit What's New</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit this "What's New" Description</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>




	<form method="post" action="act_whatsnew_edit.cfm">
	
	<input type="hidden" name="WNID" value="#WNID#">
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Title</td>
	<td class="normal" valign="top">#whatnewDetails.Displaytitle#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Expiry Date</td>
	<td class="normal" valign="top"><select name="Date_startday" class="whitefield" style="width:40px;"><option value="0">&ndash;<cfloop from="1" to="31" index="loopcount"><option value="#loopcount#"<cfif #DateFormat(WhatsNewStuff.DateExpires, 'd')# EQ #loopcount#> selected</cfif>>#loopcount#</cfloop></select> <select name="Date_startmonth" class="whitefield" style="width:100px;"><option value="0">&ndash;<cfloop from="1" to="12" index="monthloopcount"><option value="#monthasstring(monthloopcount)#"<cfif #DateFormat(WhatsNewStuff.DateExpires, 'm')# EQ #monthloopcount#> selected</cfif>>#monthasstring(monthloopcount)#</cfloop></select> <select name="Date_startyear" class="whitefield" style="width:60px;"><option value="0">&ndash;<cfloop from="2000" to="2020" index="yearloopcount"><option value="#yearloopcount#"<cfif #DateFormat(WhatsNewStuff.DateExpires, 'yyyy')# EQ #yearloopcount#> selected</cfif>>#yearloopcount#</cfloop></select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="110">Description</td>
	<td class="normal" valign="top">
	<textarea name="shortdescription" rows="25" cols="40"></textarea>
	<!--- <cf_activedit name="shortdescription" inc="#request.ActiveEditInc#" image="true" 
	imagepath="#request.fileroot#\images\" 
	imageURL="#request.imageroot#/" width="445" height="200" toolbar="cut,copy,paste,|,undo,redo,|,quickfontsize,bold,italic,underline,|,outdent,indent,justifyleft,justifyright,|,bullets,numbers,table,image,hyperlink,help,showdetails,spellcheck" tabview="no" DEFAULTFONT="8pt Verdana">#WhatsNewStuff.shortdescription#</cf_activedit> --->
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="UPDATE NOW >>>"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	
	
	</table>
	</form>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


