<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>#UCASE(TRIM(SectionDetails.Title))#</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td background="#request.imageroot#/sidebar_boxL_bg.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	
	
	<table width="207" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td colspan="2"><strong>#UCASE(DocumentDetails.Title)#</strong></td>
	</tr>
	
	<tr>
	<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
	<td width="187"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<cfloop query="AllArticles">
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;" align="center"><strong>&raquo;</strong></td>
	<td width="187"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=article&documentID=#DocumentDetails.DocumentID#&articleID=#AllArticles.ArticleID#">#TRIM(AllArticles.ArticleTitle)#</a></td>
	</tr>
	
	
	</cfloop>
	
	</table><br>


</td>
</tr>

</table><br>


</cfoutput>