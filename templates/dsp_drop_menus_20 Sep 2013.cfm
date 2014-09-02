<cfif IsDefined("session.pictureUrl") and #session.pictureUrl# neq ''>
   <cfset pictureUrl = #session.pictureUrl#>
<cfelse>
   <cfset pictureUrl = "">   
</cfif>
<cfif IsDefined("session.User_FullName") and #session.User_FullName# neq ''>
   <cfset name = #session.User_FullName#>
<cfelse>
   <cfif IsDefined("session.User_FirstName") and #session.User_FirstName# neq ''>
       <cfset fname = #session.User_FirstName#>  
	   <cfset lname = #session.User_LastName#> 
	   
	   <!---<cfset fname = REReplace(fname,'<[^>]*>','','all')>
	   <cfset lname = REReplace(lname,'<[^>]*>','','all')>--->
	   
	  <!--- <cfset final1 = ListToArray(fname, ".a0c")>
	   <cfset final2 = ListToArray(lname, ".a0c")> ---> 
	    
       <cfset name  = #session.User_FirstName# & " " & #session.User_LastName#>   
   <cfelse>
       <cfset name = "">   
   </cfif>
</cfif> 
<cfoutput>
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType NEQ 'Administrator'>
		     <cfset userID = #SESSION.userid#>
			 
			 <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
				SELECT profilepic FROM contacts WHERE contactid = #userID#
			 </cfquery> 
						
			 <div class="dropdown">
				<a class="account" >
					 <span style="cursor: pointer; font-size: 14px; line-height: 12px; font-weight: bold;"> 
					       <table>
								<tbody> 
								    <tr>
									    <cfif pictureUrl neq ''>
											 <td valign="top"> 
											    <cfif #session.pictureUrl# eq 0 and #getProfilePic.profilepic# eq ''>
												     <img border="0" src="/images/default_avatar.gif" style="width: 21px; color:##FFFFFF;" alt="No Image" title="No Image">
												<cfelse>
												      <cfif #getProfilePic.profilepic# neq ''>
													        <img border="0" src="/images/profiles/#getProfilePic.profilepic#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
													  <cfelse>
													         <img border="0" src="#session.pictureUrl#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">		
													  </cfif> 
												</cfif> 
											 </td>
											 <td valign="top" style="color: white; font-size: 14px; font-weight: bold;">
													<!---#UCASE(name)#!--->    
													#ReReplace(name,"\b(\w)","\u\1","ALL")#  
											 </td>
										<cfelse>
										     <td>
											          <cfif #getProfilePic.profilepic# neq ''>
													        <img border="0" src="/images/profiles/#getProfilePic.profilepic#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
													  <cfelse>
													         <img border="0" src="/images/default_avatar.gif" style="width: 21px; color:##FFFFFF;" alt="No Image" title="No Image">		
													  </cfif> 
											 </td>
											 <td valign="top" style="color: white; font-size: 14px; font-weight: bold;">
													<!---#UCASE(name)#!--->
													#ReReplace(name,"\b(\w)","\u\1","ALL")#
											 </td> 
										</cfif>	 
								    </tr>
						         </tbody>
							</table>	 
					 </span>
				</a>
				<div class="submenu" style="display: none; "> 
					 <ul class="root"> 
							 <!---<li>
								  <a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92">
										myProfile
								  </a>
							 </li>--->
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=updateprofile&fusesubaction=index">
										Edit Profile
								  </a>
							 </li>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=83">myPoints</a>  
							 </li>
						  <cfif session.permission1_view EQ 1 OR session.permission40_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92">
										myDashboard
								  </a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission64_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#session.UserID#">
										myPersonal Profile
								  </a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission86_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=83">myPoints</a> 
								   <span style="color:black"><b>(<cfif user_points GT 10000>#NumberFormat(user_points, "00,000")#<cfelseif user_points GT 1000>#NumberFormat(user_points, "0,000")#<cfelse>#user_points#</cfif>)</b>
								   </span>
							 </li>
						  </cfif>
						  <cfif session.permission1_add EQ 1 OR session.permission85_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=112">Purchase Points</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_add EQ 1 OR session.permission102_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=95&resource_mode=create_cards"><img src="#request.imageroot#/businesscard_button.gif" width="153" height="38" alt="" border="0"></a>
							 </li>
						  </cfif>
						  <li>
								  <a href="#request.webroot#/act_logout.cfm">Logout</a>
						  </li>
					</ul>
				</div>
			 </div>  
		</cfif> 
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
			 <div class="dropdown">
				<a class="account" style="padding-top: 12px;">
					 <span style="cursor: pointer; font-size: 14px; line-height: 12px; font-weight: bold;">
						 ADMIN TOOLS
					 </span>
				</a>
				<div class="submenu" style="display: none; width: 204px;"> 
					 <ul class="root">
							 <li>
								  <a href="#request.webroot#/act_logout.cfm">Logout</a>
							 </li> 
						  <cfif session.permission1_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=administration">ADMIN DASHBOARD</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_header">
									 Manage Header Section</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_footer">
									 Manage Footer Section</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission94_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_activities">
									 Manage Activity Rewards</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=administrators">
									 Manage Administrators</a>
							 </li>
						  </cfif> 
						  <cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas">
									 Manage Businesses</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission68_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_charities">
									 Manage Charities</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_downloads">
									 Manage Downloads</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission100_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_alerts">
									 Manage Email Alerts</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission2_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug">
									 Manage Ideas</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission2_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug_maincats">
									 Manage Idea Categories</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission57_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat">
									 Manage Idea Topics</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission58_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_stages">
									 Manage Idea Stages</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_idea_moderators">
									 Manage Idea Moderators</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=invite_friend">
									 Manage Invite-a-Friend</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission11_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_goalcats">
									 Manage Goal</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_mylib">
									 Manage Library</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission61_view EQ 1 OR session.permission62_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members">
									 Manage Members</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission88_view EQ 1 OR session.permission90_view EQ 1 OR session.permission92_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney">
									 Manage Money</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission65_view EQ 1 OR session.permission66_view EQ 1 OR session.permission67_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_partners">
									 Manage Partners</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission87_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney&This_ContactID=0&current_account=points">
									 Manage Points</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission88_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=pointspurchases">
									 Manage Points Purchases</a>
							 </li>
						  </cfif>   
						  <cfif session.permission1_view EQ 1 OR session.permission25_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes">
									  Manage Prizes</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_projectgroups">
									  Manage Project Groups</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_promocodes">
									  Manage Promo Codes</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_quotes">
									  Manage Quotes</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission28_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_rewards">
									  Manage Rewards</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission70_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_reward_requests">
									  Manage Reward Requests</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles">
									  Manage Roles/Permissions</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission76_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools">
									  Manage Schools</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission80_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools_toadd">
									  Manage Schools To-Add</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission54_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sections">
									  Manage Sections</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sms_tags">
									  Manage SMS Taglines</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=subscriptions">
									  Manage Subscriptions</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission81_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_surveys">
									  Manage Surveys</a>
							 </li>
						  </cfif> 
						  <cfif session.permission1_view EQ 1 OR session.permission46_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_testimonials">
									  Manage Testimonials</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission83_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=adminaudit">
									  Administration Audit</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission84_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool">
									  Email Tool</a>
							 </li>
						  </cfif>
					</ul>
				</div>
			 </div>    
		</cfif>
</cfoutput>