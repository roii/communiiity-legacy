<cfoutput>


<!--- GET TOPICS SPONSORED BY THIS SPONSOR --->
<cfquery name="qry_sponsored_topics" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryID, Name
FROM SugCategory
WHERE SponsorID=#this_organisationID#
</cfquery>


<cfif qry_sponsored_topics.recordcount>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td align="center" height="20" colspan="3">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>IDEAfunL Topics &amp; Ideas</strong></td>
		<td align="right" valign="bottom"><!--- <img src="#request.imageroot#/SiteIcons/Community_sml.jpg" alt="Community" border="0"> ---></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
		
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		
		<cfloop query="qry_sponsored_topics">
		
		<cfset this_categoryID = qry_sponsored_topics.categoryID>
		
		<cfquery name="AllCatIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SugID
		FROM Suggestion
		WHERE CategoryID=#this_categoryID#
		GROUP BY SugID
		</cfquery>
		
		
		<tr>
		<td style="color:Black;font-size:11px;padding-left:5px;">#TRIM(qry_sponsored_topics.Name)#</td>
		<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1">#AllCatIdeas.RecordCount#</a></td>
		</tr>
		
		
		<cfif qry_sponsored_topics.CurrentRow NEQ qry_sponsored_topics.RecordCount>
		
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
		
		</table>
		
	
	</td>
	<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	</table>

	
</cfif>


</cfoutput>