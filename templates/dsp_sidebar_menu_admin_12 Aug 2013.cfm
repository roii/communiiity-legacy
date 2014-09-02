<cfoutput>

<table width="170" cellpadding="0" cellspacing="0" style="border:solid 2px ###AllSettings.BoxColour#;">

<tr>
<td bgcolor="###session.AllSettings_BoxColour#" style="color:###TRIM(session.AllSettings_BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>ADMINISTRATION TOOLS</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="170" height="1" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	
	
	<table cellpadding="0" cellspacing="0" border="0" align="center">
	<cfif session.permission1_view EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration" style="color:black;">ADMIN DASHBOARD</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission94_view EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_activities" style="color:black;">Manage Activity Rewards</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=administrators" style="color:black;">Manage Administrators</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission52_view EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas" style="color:black;">Manage Businesses</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission68_view EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_charities" style="color:black;">Manage Charities</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_downloads" style="color:black;">Manage Downloads</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission100_view EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_alerts" style="color:black;">Manage Email Alerts</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission2_edit EQ 1>
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug" style="color:black;">Manage Ideas</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission2_edit EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug_maincats" style="color:black;">Manage Idea Categories</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission57_edit EQ 1>	
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat" style="color:black;">Manage Idea Topics</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission58_edit EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_stages" style="color:black;">Manage Idea Stages</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_idea_moderators" style="color:black;">Manage Idea Moderators</a></td>
		</tr>
	</cfif>	
	
	<cfif session.permission1_view EQ 1>	
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=invite_friend" style="color:black;">Manage Invite-a-Friend</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission11_edit EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_goalcats" style="color:black;">Manage Goal</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_mylib" style="color:black;">Manage Library</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission61_view EQ 1 OR session.permission62_view EQ 1>	
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members" style="color:black;">Manage Members</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission88_view EQ 1 OR session.permission90_view EQ 1 OR session.permission92_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney" style="color:black;">Manage Money</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission65_view EQ 1 OR session.permission66_view EQ 1 OR session.permission67_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_partners" style="color:black;">Manage Partners</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission87_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney&This_ContactID=0&current_account=points" style="color:black;">Manage Points</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission88_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=pointspurchases" style="color:black;">Manage Points Purchases</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission25_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes" style="color:black;">Manage Prizes</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_projectgroups" style="color:black;">Manage Project Groups</a></td>
		</tr>	
	</cfif>
	
	<cfif session.permission1_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_promocodes" style="color:black;">Manage Promo Codes</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_quotes" style="color:black;">Manage Quotes</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission28_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_rewards" style="color:black;">Manage Rewards</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission70_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_reward_requests" style="color:black;">Manage Reward Requests</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles" style="color:black;">Manage Roles/Permissions</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission76_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools" style="color:black;">Manage Schools</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission80_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools_toadd" style="color:black;">Manage Schools To-Add</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission54_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sections" style="color:black;">Manage Sections</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sms_tags" style="color:black;">Manage SMS Taglines</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=subscriptions" style="color:black;">Manage Subscriptions</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission81_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_surveys" style="color:black;">Manage Surveys</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission46_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_testimonials" style="color:black;">Manage Testimonials</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission83_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=adminaudit" style="color:black;">Administration Audit</a></td>
		</tr>
	</cfif>
	
	<cfif session.permission1_view EQ 1 OR session.permission84_view EQ 1>		
		<tr>
		<td width="20" style="color:###session.AllSettings_BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
		<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool" style="color:black;">Email Tool</a></td>
		</tr>
	</cfif>
    
    <tr>
    <td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
    </tr>
	
	</table>


</td>
</tr>

</table>
</cfoutput>