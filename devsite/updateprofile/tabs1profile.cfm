<cfoutput>  
	 <div class="i-profile-settings"> 
		<form name="updateProfileForm" action="/index.cfm?fuseaction=updateprofile&fusesubaction=update" method="post" onsubmit="return checkform();" enctype="multipart/form-data">	 
			<div class="i-musty-background i-profile-basic">
				<h3>Basic Info</h3>
				  <div class="row">	 
					<cfif IsDefined("getUserDetails.ContactID") and getUserDetails.ContactID neq ''>
						 <input type="hidden" name="userID" value="#getUserDetails.ContactID#" size="50" />
						 <input type="hidden" name="adminIDCheck" value="No" /> 
					<cfelse>
						 <input type="hidden" name="userID" value="#getUserDetails.AdministratorID#" size="50" />	
						 <input type="hidden" name="adminIDCheck" value="Yes" /> 
					</cfif>	 
					<input type="hidden" id="uploadfileExtensionExt" name="uploadfileExtensionExt" value="" /> 
					<input type="hidden" name="filenameToSave" value="#filename#" />
					<table cellpadding="0" cellspacing="0" border="0" width="100%">	
						<tr>
							<td valign="top" colspan="2">&nbsp;
								 
							</td>
						</tr>
						<tr>
							<td valign="top" width="20%">
								  Your First Name: <span style="color: red;">*</span>
							</td>
							<td valign="top" width="80%">
								   <input type="text" name="fname" value="#getUserDetails.FirstName#" size="50" />
							</td>
						</tr>
						<tr>
							<td valign="top" colspan="2">&nbsp;
								 
							</td>
						</tr>
						<tr>
							<td valign="top">
								  Your Last Name: <span style="color: red;">*</span>
							</td>
							<td valign="top">
								   <input type="text" name="lname" value="#getUserDetails.LastName#" size="50" />
							</td>
						</tr>
						<tr>
							<td valign="top" colspan="2">&nbsp;
								 
							</td>
						</tr>  
						<tr>
							<td valign="top">
								  Your Country: <span style="color: red;">*</span>
							</td>
							<td valign="top">
								   <input type="text" name="country" value="#getUserDetails.country#" size="50" />
							</td>
						</tr>
						<tr>
							<td valign="top" colspan="2">&nbsp;
								 
							</td>
						</tr>
						<tr>
							<td valign="top">
								  Postal Code: <span style="color: red;">*</span>
							</td>
							<td valign="top">
								   <input type="text" name="postalcode" value="#getUserDetails.PostalCode#" size="50" maxlength="10" />
							</td>
						</tr>
						<tr>
							<td valign="top" colspan="2">&nbsp;
								 
							</td>
						</tr>
						<tr>
							<td valign="top">
								  Cell ##: <span style="color: red;">*</span>
							</td>
							<td valign="top">
								   <input type="text" name="cellNum" value="#getUserDetails.cellNum#" size="50" />
							</td>
						</tr>  
						<tr>
							<td valign="top" colspan="2">&nbsp;
								 
							</td>
						</tr> 
					</table> 
				  </div>
			</div>	
			<div class="i-musty-background i-profile-story">
				  <h3>Your Story</h3>
				  <div class="row">
					<div class="col-lg-9"> 
					<cfif IsDefined("getUserDetails.LINKEDINHEADLINE") and #getUserDetails.LINKEDINHEADLINE# neq ''>
					      <cfif getUserDetails.individual_tagline neq ''>
							  <cfset LINKEDINHEADLINE = getUserDetails.individual_tagline>
						  <cfelse>
						      <cfset LINKEDINHEADLINE = getUserDetails.LINKEDINHEADLINE>
						  </cfif>	  
					<cfelse>
					      <cfset LINKEDINHEADLINE = getUserDetails.individual_tagline>
					</cfif>
					  <label for="individual_tagline" class="i-block-label">Headlines</label>
					  <input type="text" size="140" name="individual_tagline" id="individual_tagline" value="#LINKEDINHEADLINE#" class="i-text-field" maxlength="140">
			
					  <label for="individual_description_html" class="i-block-label">About Me</label> 
					  <textarea rows="20" name="individual_description_html" maxlength="500" id="individual_description_html" data-fieldlength="500" cols="80" class="char_limited_input i-text-area">#getUserDetails.individual_description_html#</textarea> 
					</div>
				  </div>
			</div>
			<div class="i-musty-background i-profile-photo">
			  <h3>Your Photos</h3>  
					<table cellpadding="0" cellspacing="0" border="0" width="100%"> 
						<tr>
							<td valign="top" width="20%">
								  Profile Image: 
							</td>
							<td valign="top" width="80%"> 
									<cfif ListContains(userID, "999")>
										  <cfset adminIDArr = ListToArray(userID, "999")>
										  <cfset adminID = adminIDArr[1]> 
										  <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
											 SELECT PROFILEPIC, linkedinprofilepic, linkedinuser FROM Administrator WHERE AdministratorID = #adminID#
										  </cfquery> 
									<cfelse>  
										<cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
											SELECT profilepic, linkedinprofilepic, linkedinuser FROM contacts WHERE contactid = #userID#
										</cfquery> 
									</cfif>  
									<cfset filename = getProfilePic.PROFILEPIC>
									
									<cfif IsDefined("session.pictureUrl") and #session.pictureUrl# neq ''>
									   <cfset pictureUrl = #session.pictureUrl#>
									<cfelse>
									   <cfset pictureUrl = "">   
									</cfif> 
								   <cfif #filename# neq ''> 
											<img border="0" src="/images/profiles/#filename#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#"> 
								   <cfelseif #getProfilePic.linkedinprofilepic# neq '' and #getProfilePic.linkedinprofilepic# neq 0>
											<img border="0" src="#getProfilePic.linkedinprofilepic#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
								   <cfelse>
											<cfif #pictureUrl# neq ''>
												  <cfif #pictureUrl# eq '0' or #pictureUrl# eq 0>
														  <img border="0" src="/images/default_avatar.gif" style="color:##FFFFFF;" alt="No Image" title="No Image">
												  <cfelse>
														  <img border="0" src="#session.pictureUrl#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
												  </cfif> 
											<cfelse>
												  <img border="0" src="/images/default_avatar.gif" style="color:##FFFFFF;" alt="No Image" title="No Image">
											</cfif> 		 	
								   </cfif> <br /><br />
								   <input type="file" name="upload_avtar" id="upload_avtar" value="" /><br />  
								   <p style="color: blue;">
									   <strong>Note: *</strong> minimum image size <strong>200x200px</strong>. (<strong>jpg, jpeg, gif or png</strong>)
								   </p>
							</td>
						</tr> 
						<tr>
							<td valign="top" width="100%" colspan="2">&nbsp;
								   
							</td>
						</tr>	
						<!---<tr>
							<td valign="top" width="20%">
								  Avtaar: 
							</td>
							<td valign="top" width="80%">   
								   <cfif ListContains(userID, "999")>
										  <cfset adminIDArr = ListToArray(userID, "999")>
										  <cfset adminID = adminIDArr[1]> 
										  <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
											 SELECT upload_avtar_image FROM Administrator WHERE AdministratorID = #adminID#
										  </cfquery> 
									<cfelse>  
										<cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
											SELECT upload_avtar_image FROM contacts WHERE contactid = #userID#
										</cfquery> 
									</cfif>  
									<cfset filename = getProfilePic.upload_avtar_image>
									 
								   <cfif #filename# neq ''> 
											<img border="0" src="/images/profiles/#filename#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">  
								   <cfelse>
											<img border="0" src="/images/default_avatar.gif" style="color:##FFFFFF;" alt="No Image" title="No Image">		 	
								   </cfif> <br /><br />
								   <input type="file" name="upload_avtar_image" id="upload_avtar_image" value="" /><br />  
								   <p style="color: blue;">
									   <strong>Note: *</strong> max image size <strong>100x100px</strong>. (<strong>jpg, jpeg, gif or png</strong>)
								   </p>
							</td>
						</tr> --->
					</table> 
			</div>	
					<table cellpadding="0" cellspacing="0" border="0" width="100%">
						<tr>
							<td valign="top" colspan="2">
								 <div style="float: right">
									<input type="submit" name="updateprofile" value="Save Profile" />
								 </div>
							</td>
						</tr>
					</table> 
		</form>  
	 </div>  
</cfoutput>