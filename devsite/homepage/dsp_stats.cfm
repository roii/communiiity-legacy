<cfoutput>


<cfquery name="qry_top_users_avg" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="100">
SELECT PointsEarned, PointsAvgMonth, contactID
FROM contacts_benchmarking
ORDER BY PointsAvgMonth DESC
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(session.AllSettings_BoxColour)#;" valign="bottom"><a name="dashBiz"><img src="#request.imageroot#/stats_title.gif" width="117" height="23" alt="" border="0"></a></td>
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
<td align="center">

	<!--- CREATE GRAPH FOR TOP 5 --->
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="250" style="padding-top:8px;">
	
		<table width="200" cellpadding="0" cellspacing="0" style="border:solid 1px ##b4b4b4;">
	
		<tr>
		<td style="font-size:11px;color:##444444;" align="center"><strong>Top 10 Users</strong><br>Avg. Points p/mnth<br>
		<cfchart format="flash" chartHeight="200" chartWidth="200">	
		<cfchartseries type="bar" seriescolor="004080">			
			<cfloop query="qry_top_users_avg" startrow="1" endrow="10">				
				<cfset this_contactID = qry_top_users_avg.contactID>
				<cfset this_earned = qry_top_users_avg.PointsEarned>
				<cfset this_average = qry_top_users_avg.PointsAvgMonth>		
				<cfquery name="qry_contact_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT ScreenName, DateJoined, Firstname
				FROM Contacts
				WHERE ContactID=#this_contactID#
				</cfquery>
				<cfif IsNumeric("#this_average#")>
                <cfchartData item="" value="#this_average#">
                <cfelse>
                <cfchartData item="" value="0">                
                </cfif>
			</cfloop>			
		</cfchartseries>	
	</cfchart>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<cfloop query="qry_top_users_avg" startrow="1" endrow="10"><cfset this_average = qry_top_users_avg.PointsAvgMonth><cfset this_contactID = qry_top_users_avg.contactID><cfquery name="qry_contact_stuff" datasource="#dsn#" username="#request.username#" password="#request.password#">SELECT ScreenName, DateJoined, Firstname FROM Contacts WHERE ContactID=#this_contactID#</cfquery>
	<td width="11"><img src="#request.imageroot#/stats_people_icon.gif" width="11" height="9" alt="#TRIM(qry_contact_stuff.ScreenName)# - #this_average#pts per month" border="0"></td>
	<td width="4"><img src="#request.imageroot#/transparent_spc.gif" width="4" height="1" border="0"></td>
	</cfloop>
	<td width="4"><img src="#request.imageroot#/transparent_spc.gif" width="4" height="1" border="0"></td>
	</tr>
	
	</table>
	
	</td>
	</tr>
	
	</table>
	
	</td>	
	<td valign="top" style="padding-top:8px;"><span style="color:###TRIM(session.AllSettings_BoxColour)#;font-size:14px;"><strong>Top 100 Users</strong></span>
	<ul>
	<li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=User_Points_Earned&showgraph=1">Total Points Earned</a></li><li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=User_Points_Average&showgraph=1">Average Points Per Month</a></li>
	<li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=user_ideas_submitted&showgraph=1">Total Ideas Submitted</a></li>
	<li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=user_ideas_winner&showgraph=1">Total Winning Ideas Submitted</a></li>
	<li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=user_ideas_points&showgraph=1">Points Earned from Ideas</a></li>
	<!--- <li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=User_Goals">By Goals</a></li>
	<li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=User_Contacts">By Contacts</a></li>
	<li style="color:###TRIM(session.AllSettings_BoxColour)#;"><a href="#request.webroot#/index.cfm?fuseaction=community&fusesubaction=docs&documentID=116&statsmode=User_Business">By Businesses</a></li> ---></ul></td>	
	</tr>
	</table>

</td>
<td width="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>


</table>

</cfoutput>