<cfoutput>


<!--- GET TOPICS SPONSORED BY THIS SPONSOR --->
<cfquery name="qry_sponsored_topics" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryID, Name
FROM SugCategory
WHERE SponsorID=#organisationID#
AND Active = 1
</cfquery>


<cfif qry_sponsored_topics.recordcount>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td align="center" height="20">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(session.AllSettings_BoxColour)#;" valign="bottom"><strong>IDEAfunL Topics &amp; Ideas</strong></td>
		<td align="right" valign="bottom"><!--- <img src="#request.imageroot#/SiteIcons/Community_sml.jpg" alt="Community" border="0"> ---></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	<tr>
	<td height="3" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>
		
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
		</tr>
			
		<cfloop query="qry_sponsored_topics">
		
		<cfset this_categoryID = qry_sponsored_topics.categoryID>
		
		
		<tr>
		<td valign="top">

			<table cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td valign="top" style="color:###TRIM(session.AllSettings_BoxColour)#;font-family:Webdings;padding-right:5px;">4</td>
			<td valign="top"><a href="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&currentcategory=#this_categoryID#&IdeaFunL_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">#TRIM(qry_sponsored_topics.Name)#</a></td>
			</tr>
			</table>



		</td>
		</tr>
		
		
		<cfif qry_sponsored_topics.CurrentRow NEQ qry_sponsored_topics.RecordCount>
		
			<tr>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
			</tr>
			
			<tr>
			<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
			</tr>
			
			<tr>
			<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
			</tr>
		
		</cfif>
		
		</cfloop>
		
		</table>
		
	
	</td>
	</tr>
	
	</table>

	
</cfif>


</cfoutput>