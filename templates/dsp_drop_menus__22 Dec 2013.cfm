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
	   <cfset final2 = ListToArray(lname, ".a0c")>  ---> 
	    
       <cfset name  = #session.User_FirstName# & " " & #session.User_LastName#>   
   <cfelse>
       <cfset name = "">   
   </cfif>
</cfif> 
<cfoutput>
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType NEQ 'Administrator'>
		
		   <cfif IsDefined("SESSION.userid") and #SESSION.userid# neq ''>
				 <cfset userID = #SESSION.userid#> 
				 <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
					SELECT profilepic, linkedinprofilepic, linkedinuser FROM contacts WHERE contactid = #userID#
				 </cfquery>  
				 <cfset profilePic = #getProfilePic.profilepic#>
				 <cfset linkedinprofilepic = #getProfilePic.linkedinprofilepic#>
				 <cfset linkedinuser = #getProfilePic.linkedinuser#>
		   <cfelse>
		         <cfset profilePic = ""> 
				 <cfset linkedinprofilepic = ''>
				 <cfset linkedinuser = 0>		 
	       </cfif>
		   		 
			 <cfif IsDefined("URL.fnm") and URL.fnm neq ''> 
				  <cfset filename = ToString( ToBinary( URL.fnm ) )> 
			 <cfelse>
				  <cfset filename = ''>
			 </cfif>  
						
			 <div class="dropdown">
				<a class="account" >
					 <span style="cursor: pointer; font-size: 14px; line-height: 12px; font-weight: bold;"> 
					       <table>
								<tbody> 
								    <tr>
									    <cfif pictureUrl neq ''>
											 <td valign="top"> 
											    <cfif #session.pictureUrl# eq 0 and #profilePic# eq ''>
												     <img border="0" src="/images/default_avatar.gif" style="width: 21px; color:##FFFFFF;" alt="No Image" title="No Image">
												<cfelse>
												      <cfif #filename# neq ''>
													        <img border="0" src="/images/profiles/small_#filename#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
												      <cfelseif #profilePic# neq ''>
													        <img border="0" src="/images/profiles/small_#profilePic#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
													  <cfelse>
													         <cfif #session.pictureUrl# eq 0 and #session.pictureUrl# eq '0'>
															      <img border="0" src="/images/default_avatar.gif" style="width: 21px; color:##FFFFFF;" alt="No Image" title="No Image">
															 <cfelse>
													              <img border="0" src="#session.pictureUrl#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">	
															 </cfif>	  	
													  </cfif> 
												</cfif> 
											 </td>
											 <td valign="top" style="color: white; font-size: 14px; font-weight: bold; padding-top: 2px;">
													<!---#UCASE(name)#!--->    
													#ReReplace(name,"\b(\w)","\u\1","ALL")#  
											 </td>
										<cfelse>
										     <td>
											          <cfif #filename# neq ''>
													        <img border="0" src="/images/profiles/small_#filename#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#"> 
											          <cfelseif #profilePic# neq ''>
													        <img border="0" src="/images/profiles/small_#profilePic#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
													  <cfelse>
													       <cfif #linkedinuser# eq 1 and #linkedinprofilepic# neq ''> 
														         <cfif #linkedinprofilepic# eq 0 and #linkedinprofilepic# eq '0'>
															          <img border="0" src="/images/default_avatar.gif" style="width: 21px; color:##FFFFFF;" alt="No Image" title="No Image">
																 <cfelse>
																	  <img border="0" src="#linkedinprofilepic#" style="width: 21px; color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
																 </cfif> 
														   <cfelse>
														         <img border="0" src="/images/default_avatar.gif" style="width: 21px; color:##FFFFFF;" alt="No Image" title="No Image">				 	
														   </cfif>  
													  </cfif> 
											 </td>
											 <td valign="top" style="color: white; font-size: 14px; font-weight: bold; padding-top: 2px;">
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
										 <!---<cfif defaultlang eq "eng">
											  #UCASE(getTranslated('Edit Profile', 'fr|' & defaultlang))#
										 <cfelse>
											  #UCASE(getTranslated('Edit Profile', 'eng|fr'))# 	  
										 </cfif>--->
										 #editprofile#
								  </a>
							 </li>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=83">myPoints</a>  
							 </li>
						  <cfif session.permission1_view EQ 1 OR session.permission40_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92"> 
										 <!---<cfif defaultlang eq "eng">
											  #UCASE(getTranslated('myDashboard', 'fr|' & defaultlang))#
										 <cfelse>
											  #UCASE(getTranslated('myDashboard', 'eng|fr'))# 	  
										 </cfif>--->
										 #myDashboard#
								  </a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission64_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#session.UserID#"> 
										 <!---<cfif defaultlang eq "eng">
											  #UCASE(getTranslated('myPersonal Profile', 'fr|' & defaultlang))#
										 <cfelse>
											  #UCASE(getTranslated('myPersonal Profile', 'eng|fr'))# 	  
										 </cfif>--->
										 #mypersprofile#
								  </a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission86_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=83">#myPoints#</a> 
								   <span style="color:black"><b>(<cfif user_points GT 10000>#NumberFormat(user_points, "00,000")#<cfelseif user_points GT 1000>#NumberFormat(user_points, "0,000")#<cfelse>#user_points#</cfif>)</b>
								   </span>
							 </li>
						  </cfif>
						  <cfif session.permission1_add EQ 1 OR session.permission85_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=money&fusesubaction=docs&documentid=112">
								        <!--- <cfif defaultlang eq "eng">
											  #UCASE(getTranslated('Purchase Points', 'fr|' & defaultlang))#
										 <cfelse>
											  #UCASE(getTranslated('Purchase Points', 'eng|fr'))# 	  
										 </cfif>--->
										 #purchasepts#
										 </a>
							 </li>
						  </cfif>
						  <cfif session.permission1_add EQ 1 OR session.permission102_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=95&resource_mode=create_cards"><img src="#request.imageroot#/businesscard_button.gif" width="153" height="38" alt="" border="0"></a>
							 </li>
						  </cfif>
						  <li>
								  <a href="#request.webroot#/act_logout.cfm">
								         <!---<cfif defaultlang eq "eng">
											  #UCASE(getTranslated('Logout', 'fr|' & defaultlang))#
										 <cfelse>
											  #UCASE(getTranslated('Logout', 'eng|fr'))# 	  
										 </cfif>--->
										 #Logout#
								  </a>
						  </li>
					</ul>
				</div>
			 </div>  
		</cfif> 
		<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
			 <div class="dropdown">
				<a class="account" style="padding-top: 12px;">
					 <span style="cursor: pointer; font-size: 14px; line-height: 12px; font-weight: bold;">
						 #admintools#
					 </span>
				</a>
				<div class="submenu" style="display: none; width: 204px;"> 
					 <ul class="root">
							 <li>
								  <a href="#request.webroot#/act_logout.cfm">#Logout#</a>
							 </li> 
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_site_settings">#sitesettings#</a>
							 </li>
						  <cfif session.permission1_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=administration">#admindash#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								  <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_header">
									 #manheadersec#
								  </a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_footer">
									 #manfootersec#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission94_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_activities">
									 #manactrew#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=administrators">
									 #manadmin#</a>
							 </li>
						  </cfif> 
						  <cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas">
									 #manbusi#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission68_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_charities">
									 #manchar#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_downloads">
									 #mandown#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission100_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_alerts">
									 #manemalerts#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission2_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug">
									 #manageideas#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission2_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug_maincats">
									 #manageideascat#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission57_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat">
									 #manageideastopics#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission58_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_stages">
									 #manageideasstages#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_idea_moderators">
									 #manageideamoder#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=invite_friend">
									 #manageinvitefriend#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission11_edit EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_goalcats">
									 #managegoal#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_mylib">
									 #managelib#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission61_view EQ 1 OR session.permission62_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members">
									 #managememb#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission88_view EQ 1 OR session.permission90_view EQ 1 OR session.permission92_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney">
									 #managemoney#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission65_view EQ 1 OR session.permission66_view EQ 1 OR session.permission67_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_partners">
									 #managepartner#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission87_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney&This_ContactID=0&current_account=points">
									 #managepoints#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission88_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=pointspurchases">
									 #manageptspurch#</a>
							 </li>
						  </cfif>   
						  <cfif session.permission1_view EQ 1 OR session.permission25_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes">
									  #manageprizes#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_projectgroups">
									  #manageprojectgrp#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_categories">
									  #managecategories#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_promocodes">
									  #managepromocodes#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_quotes">
									  #managequotes#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission28_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_rewards">
									  #managerewards#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission70_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_reward_requests">
									  #managerewrequests#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission95_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_roles">
									  #manageRolPerm#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission76_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools">
									  #manageschools#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission80_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools_toadd">
									  #manageschoolstoadd#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission54_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sections">
									  #managesections#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sms_tags">
									  #managesmstaglines#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=subscriptions">
									  #managesubscr#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission81_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_surveys">
									  #managesurveys#</a>
							 </li>
						  </cfif> 
						  <cfif session.permission1_view EQ 1 OR session.permission46_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_testimonials">
									  #managetestimonial#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission83_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=adminaudit">
									  #manageadminaudit#</a>
							 </li>
						  </cfif>
						  <cfif session.permission1_view EQ 1 OR session.permission84_view EQ 1>
							 <li>
								   <a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool">
									  #emailtool#</a>
							 </li>
						  </cfif>
					</ul>
				</div>
			 </div>    
		</cfif>
</cfoutput>