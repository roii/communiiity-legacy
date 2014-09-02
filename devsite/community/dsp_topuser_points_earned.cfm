<cfoutput>

<cfquery name="qry_top_users" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="100">
SELECT PointsEarned, PointsAvgMonth, contactID
FROM contacts_benchmarking
ORDER BY PointsEarned DESC
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr>
<td>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<cfif IsDefined("showgraph") and showgraph EQ 1>
		
		<tr>
		<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="20" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="5" style="color:Black;"><strong>TOP 10 USERS - Total Points Earned</strong></td>
		</tr>
		
		<tr>
		<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
		<tr>
		<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br><br>	
		<!--- CREATE GRAPH FOR TOP 10 --->
		<cfchart format="flash" chartHeight="250" chartWidth="800" showxgridlines="yes" showygridlines="yes" showborder="yes" font="Arial" fontsize="10" fontbold="no" fontitalic="no" show3d="no" rotated="no" sortxaxis="no" showlegend="no" showmarkers="no" style="my3p_stats.xml">
		
			<cfchartseries type="bar" seriescolor="##0066CC">
				
				<cfloop query="qry_top_users" startrow="1" endrow="10">
					
					<cfset this_contactID = qry_top_users.contactID>
					<cfset this_earned = qry_top_users.PointsEarned>			
					
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
					<cfchartData item="#this_Name#" value="#this_earned#">
				</cfloop>
				
			</cfchartseries>
		
		</cfchart></td>
		</tr>
	
	</cfif>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="20" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="150" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="20" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" style="color:Black;"><strong>TOP 100 USERS - Total Points Earned</strong></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td><strong>User</strong></td>
	<td align="center"><strong>Joined</strong></td>
	<td align="center"><strong>Pts Earned</strong></td>
	<td align="center"><strong>Avg. Pts Month</strong></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_top_users">
	
	<cfset this_contactID = qry_top_users.contactID>
	<cfset this_earned = qry_top_users.PointsEarned>
	<cfset this_average = qry_top_users.PointsAvgMonth>
	
	<cfquery name="qry_contact_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ScreenName, DateJoined, Firstname
	FROM Contacts
	WHERE ContactID=#this_contactID#
	</cfquery>
	
	<tr>
	<td align="center">#qry_top_users.currentrow#.</td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#"><img src="#request.imageroot#/icons/people_tiny.gif" width="15" height="12" border="0" align="absmiddle" title="View Profile"></a>&nbsp;&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#TRIM(this_ContactID)#" style="color:###TRIM(session.AllSettings_BoxColour)#;" title="View Profile"><strong><cfif TRIM(qry_contact_stuff.ScreenName) NEQ ''>#TRIM(qry_contact_stuff.ScreenName)#<cfelse>#TRIM(qry_contact_stuff.FirstName)#</cfif></a></td>
	<td align="center">#DateFormat(qry_contact_stuff.DateJoined)#</td>
	<td align="center">#this_earned#</td>
	<td align="center">#this_average#</td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	
</td>
</tr>

</table>

</cfoutput>