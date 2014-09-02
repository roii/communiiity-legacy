<cfoutput>

<cfquery name="CommunityDocs" datasource="#dsn#">
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
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(session.AllSettings_BoxColour)#;" valign="bottom"><a name="dashBiz"><strong>News</strong></a></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/homepage/dash_articles.gif" alt="Commjnity Writers" border="0"></td>
	</tr>
	
	</table>

</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td>
	
	
	
		<table cellpadding="0" cellspacing="0" border="0" width="100%">
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<cfloop query="CommunityDocs">
		<cfset this_contacttypeview = TRIM(CommunityDocs.ContactTypeView)>
		
		<tr>
		<td width="30" align="center"><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFindNoCase(this_contacttypeview, session.User_ContactTypeID, ",")) OR CommunityDocs.PublicView CONTAINS 1><a href="#request.webroot#/index.cfm?fuseaction=community_content&fusesubaction=docs&documentID=#CommunityDocs.DocumentID#"></cfif><img src="#request.imageroot#/icon_relatedresource_doc.gif" width="8" height="9" border="0"></a></td>
		<td><cfif (session.UserIsAuthenticated EQ 'Yes' AND ListFindNoCase(this_contacttypeview, session.User_ContactTypeID, ",")) OR CommunityDocs.PublicView CONTAINS 1><a href="#request.webroot#/index.cfm?fuseaction=community_content&fusesubaction=docs&documentID=#CommunityDocs.DocumentID#" style="color:###TRIM(session.AllSettings_BoxColour)#;"><strong>#TRIM(CommunityDocs.Title)#</strong></a><cfelse><strong>#TRIM(CommunityDocs.Title)#</strong><br>
		[Members only - please register and login to view]</cfif></td>
		</tr>
		
		<cfif CommunityDocs.CurrentRow NEQ CommunityDocs.RecordCount>
		
			<tr>
			<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
		
		</cfif>
		
		</cfloop>
		
		<tr>
		<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>	
		
		</table>


	
</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>
	
	



</cfoutput>