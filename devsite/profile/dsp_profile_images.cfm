 <cfoutput>
 <cfif DocumentDetails.PublicView CONTAINS 1>
  <cfelse> 
	 <cfif session.UserIsAuthenticated EQ 'no'>
	  <script>
		alert("You must be a #TRIM(AllSettings.SiteName)# member and logged-in to access this part of the website.test");
		self.location="javascript:history.back();";
		</script>
		<cfabort>	
	</cfif> 
 </cfif>

 <cfinclude template="../templates/qry_contact_details.cfm">
  
 <cfset newdetails = DocumentDetails.details>

<cfquery name="ProFileStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM UserProfiles
WHERE UserID=#session.UserID#
</cfquery>    
    
<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MY PROFILE AND IMAGES</strong></td>
<td align="right" width="30"></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>


<form name="profileform" action="#request.webroot#/profile/act_profile_images.cfm" method="post" enctype="multipart/form-data">

<tr>
<td colspan="2">

	<table cellSpacing="1" cellPadding="0" bgcolor="##b4b4b4" border="0" width="100%">
	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="180" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="180" height="1"  border="0"></td>
			<td width="100%"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><strong>About Me</strong></td>
			<td valign="top"><textarea name="profiletext" class="whitefield" style="width:250px" rows="10">#TRIM(ProfileStuff.ProfileText)#</textarea></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
									
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong><cfif fileExists("#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#TRIM(ProfileStuff.ProfilePic1)#")><a href="#request.webroot#/memberprofile/#TRIM(session.User_ScreenName)#/#TRIM(ProfileStuff.ProfilePic1)#" target="_blank"></cfif>Photo 1</a></strong> - Default profile image</td>
			<td><input type="file" name="image1" accept="image/jpeg,image/gif,image/x-png" class="whitefield" style="width:250px;"></td>
			</tr>
									
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong><cfif fileExists("#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#TRIM(ProfileStuff.ProfilePic2)#")><a href="#request.webroot#/memberprofile/#TRIM(session.User_ScreenName)#/#TRIM(ProfileStuff.ProfilePic2)#" target="_blank"></cfif>Photo 2</a></strong></td>
			<td><input type="file" name="image2" accept="image/jpeg,image/gif,image/x-png" class="whitefield" style="width:250px;"></td>
			</tr>
									
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><strong><cfif fileExists("#request.fileroot#\memberprofile\#TRIM(session.User_ScreenName)#\#TRIM(ProfileStuff.ProfilePic3)#")><a href="#request.webroot#/memberprofile/#TRIM(session.User_ScreenName)#/#TRIM(ProfileStuff.ProfilePic3)#" target="_blank"></cfif>Photo 3</a></strong></td>
			<td><input type="file" name="image3" accept="image/jpeg,image/gif,image/x-png" class="whitefield" style="width:250px;"></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"><strong><u>Important Notice:</u></strong><br>
            Uploading inappropriate photos of any kind is against our Terms of Service and WILL result in your membership being cancelled without notice.<br><br>
            <strong><u>What type of photos can I upload?</u></strong><br>
            Images must be in the JPEG, GIF, BITMAP or PNG photo format and a maximum of 1MB in size. If you try and upload a larger file, the upload will fail. If your photo is larger than 1MB you must resize the photo prior to uploading. Most digital cameras include software to do this.<br><br>
            <strong><u>What size photos should I upload?</u></strong><br>
            Images will display best when sized to 160 x 120 pixels, or in a scale of the same proportions... (ie. 320 x 240, 480 x 360.. etc)
            <hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/update_button.gif"></td>
			</tr>
						
			</table>
            
            
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table><br>

</td>
</tr>
</form>

</table>

</cfoutput>