<cfoutput>

<cfquery name="qry_all_users" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="100">
SELECT COUNT(Contacts.ContactID) AS UsersTotal
FROM Contacts
WHERE Contacts.ContactTypeID IN (1,2,4,5,6,7)
AND Contacts.CountryID <> 0
AND Contacts.CountryID <> 152
</cfquery>

<cfset totalmembers = qry_all_users.UsersTotal>

<cfquery name="qry_users_country" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="100">
SELECT COUNT(Contacts.CountryID) AS CountryTotal, Contacts.CountryID, Countries.Name
FROM Contacts, Countries
WHERE Contacts.CountryID=Countries.CountryID
AND Contacts.CountryID <> 0
AND Contacts.CountryID <> 152
AND Contacts.ContactTypeID IN (1,2,4,5,6,7)
GROUP BY Contacts.CountryID, Countries.Name
ORDER BY CountryTotal DESC
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr>
<td>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<!--- <cfif IsDefined("showgraph") and showgraph EQ 1>
		
		<tr>
		<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="20" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3" style="color:Black;"><strong>TOP 10 USER COUNTRIES</strong></td>
		</tr>
		
		<tr>
		<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
	
		<tr>
		<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br><br>	
		<!--- CREATE GRAPH FOR TOP 10 --->
		<cfchart format="flash" chartHeight="200" chartWidth="390" showxgridlines="yes" showygridlines="yes" showborder="yes" font="Arial" fontsize="9" fontbold="no" fontitalic="no" labelformat="percent" labelmask="0.0%" show3d="no" rotated="no" sortxaxis="no" showlegend="no" showmarkers="no" style="my3p_stats.xml">
		
			<cfchartseries type="horizontalbar" seriescolor="##0066CC">
				
				<cfloop query="qry_users_country" startrow="1" endrow="10">
					
					<cfset this_Name = qry_users_country.Name>
					<cfset this_count = qry_users_country.CountryTotal>
					<cfset this_percent = (this_count / totalmembers * 100)> 		
					
					<cfchartData item="#this_Name#" value="#NumberFormat(this_percent, "0.0")#">
				</cfloop>
				
			</cfchartseries>
		
		</cfchart></td>
		</tr>
	
	</cfif> --->
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="20" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="20" border="0"></td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="20" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" style="color:Black;"><strong>TOP 100 USER COUNTRIES</strong></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td><strong>Country</strong></td>
	<td align="center"><strong>Users</strong></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="qry_users_country" startrow="1" endrow="10">
					
	<cfset this_Name = qry_users_country.Name>
	<cfset this_count = qry_users_country.CountryTotal>
	<cfset this_percent = (this_count / totalmembers * 100)>
	<tr>
	<td align="center">#qry_users_country.currentrow#.</td>
	<td>#TRIM(this_Name)#</a></td>
	<td align="center">#NumberFormat(this_percent, "0.0")#%</td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	
</td>
</tr>

</table>

</cfoutput>