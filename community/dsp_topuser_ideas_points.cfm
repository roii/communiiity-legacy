<cfoutput>

<cfquery name="qry_top_users" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="100">
SELECT IdeasSubmitted, IdeasWinner, IdeaPoints, contactID
FROM contacts_benchmarking
ORDER BY IdeaPoints DESC
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr>
<td>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<cfif IsDefined("showgraph") and showgraph EQ 1>
	
		<tr>
		<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="20" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6" style="color:Black;"><strong>TOP 10 USERS - Points Earned for Ideas</strong></td>
		</tr>
		
		<tr>
		<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br><br>	
		<!--- CREATE GRAPH FOR TOP 10 --->
		<cfchart format="flash" chartHeight="200" chartWidth="800" showxgridlines="yes" showygridlines="yes" showborder="yes" font="Arial" fontsize="10" fontbold="no" fontitalic="no" show3d="no" rotated="no" sortxaxis="no" showlegend="no" showmarkers="no" style="my3p_stats.xml">
		
			<cfchartseries type="bar" seriescolor="##0066CC">
				
				<cfloop query="qry_top_users" startrow="1" endrow="10">
					
					<cfset this_contactID = qry_top_users.contactID>
					<cfset this_submitted = qry_top_users.IdeasSubmitted>
					<cfset this_winner = qry_top_users.IdeasWinner>
					<cfset this_points = qry_top_users.IdeaPoints>			
					
					<cfquery name="qry_contact_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT ScreenName, Firstname
					FROM Contacts
					WHERE ContactID=#this_contactID#
					</cfquery>
					
					<cfif TRIM(qry_contact_stuff.ScreenName) NEQ ''>
						<cfset this_Name = TRIM(REPLACE(qry_contact_stuff.ScreenName, " ", "_", "ALL"))>
					<cfelse>
						<cfset this_Name = TRIM(qry_contact_stuff.FirstName)>				
					</cfif>				
					<cfchartData item="#this_Name#" value="#this_points#">
				</cfloop>
				
			</cfchartseries>
		
		</cfchart></td>
		</tr>
	
	
	</cfif>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="20" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="150" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="20" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" style="color:Black;"><strong>TOP 100 USERS - Points Earned for Ideas</strong></td>
	</tr>
	
	<tr>
	<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td><strong>User</strong></td>
	<td align="center"><strong>Joined</strong></td>
	<td align="center"><strong><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=Docs&DocumentID=116&statsmode=User_Ideas_submitted<cfif IsDefined("ShowGraph")>&showgraph=1</cfif>">Ideas Submitted</a></strong></td>
	<td align="center"><strong><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=Docs&DocumentID=116&statsmode=User_Ideas_winner<cfif IsDefined("ShowGraph")>&showgraph=1</cfif>">Winning Ideas</a></strong></td>
	<td align="center"><strong><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=Docs&DocumentID=116&statsmode=User_Ideas_points<cfif IsDefined("ShowGraph")>&showgraph=1</cfif>">Ideas Pts Earned</a></strong></td>
	</tr>
	
	<tr>
	<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_top_users">
	
	<cfset this_contactID = qry_top_users.contactID>
	<cfset this_submitted = qry_top_users.IdeasSubmitted>
	<cfset this_winner = qry_top_users.IdeasWinner>
	<cfset this_points = qry_top_users.IdeaPoints>
	
	<cfquery name="qry_contact_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ScreenName, DateJoined, Firstname
	FROM Contacts
	WHERE ContactID=#this_contactID#
	</cfquery>
				
	<cfif TRIM(qry_contact_stuff.ScreenName) NEQ ''>
		<cfset this_Name = TRIM(qry_contact_stuff.ScreenName)>
	<cfelse>
		<cfset this_Name = TRIM(qry_contact_stuff.FirstName)>				
	</cfif>
	
	<cfset this_Joined = qry_contact_stuff.DateJoined>
	
	<tr>
	<td align="center">#qry_top_users.currentrow#.</td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(this_ContactID)#" style="color:###TRIM(session.AllSettings_BoxColour)#;" title="View Profile"><strong>#TRIM(this_Name)#</strong></a></td>
	<td align="center">#DateFormat(this_Joined)#</td>
	<td align="center">#this_submitted#</td>
	<td align="center">#this_winner#</td>
	<td align="center">#this_points#</td>
	</tr>
	
	<tr>
	<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	
</td>
</tr>

</table>

</cfoutput>