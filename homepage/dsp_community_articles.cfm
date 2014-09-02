<cfoutput>

<cfquery name="CommunityDocs" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Documents.DocumentID, Documents.Title, Documents.ContactTypeView, Documents.PublicView
FROM SectionDocuments_Link, Documents
WHERE SectionDocuments_Link.SectionID=32
AND SectionDocuments_Link.DocumentID=Documents.DocumentID
AND Documents.Released=1
ORDER BY SectionDocuments_Link.DisplayOrder
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(session.AllSettings_BoxColour)#;" valign="bottom"><a name="dashBiz"><img src="#request.imageroot#/news_title.gif" width="121" height="23" alt="" border="0"></a></td>
	</tr>
	
	</table>

</td>
</tr>

<tr>
<td height="1" colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td height="2" colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td>#TRIM(SectionDetails.HomepageContent)#</td>
<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>


</table>

</cfoutput>