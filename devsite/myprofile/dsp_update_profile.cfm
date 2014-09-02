<cfif IsDefined("session.UserIsAuthenticated") and session.UserIsAuthenticated EQ 'Yes'>
<div>
<script language="javascript">   
   function save_profile_pic()
   {
        var requiredFileSizeInBytes = 512000;
         if(document.saveProfilePicForm.upload_avtar.value != "")
		 {
		        var fileName = document.saveProfilePicForm.upload_avtar.value;
				var fileSize = document.getElementById('upload_avtar').files[0].size; 
				var fileType = document.getElementById('upload_avtar').files[0].type; 
 				
				var url = URL.createObjectURL(document.getElementById('upload_avtar').files[0]);
				var img = new Image; 
                img.onload = function() {
					//alert(img.width+" || "+img.height);
				}; 
				img.src = url; 
				if(fileType == "image/gif" || fileType == "image/png" || fileType == "image/jpeg" || fileType == "image/jpg")
				{
				    if(fileSize > requiredFileSizeInBytes)
					{
					    alert("Error! You have uploaded the image of size more than 500 kb.");
						document.saveProfilePicForm.upload_avtar.focus();
						return false;
					}
					else
					{		   			    
					    return true;    
					}	     
				}
				else
				{
				    alert("Error! Please upload only images of .gif, .png, .jpg, .jpeg extensions."); 
			        document.saveProfilePicForm.upload_avtar.focus();
				    return false;
				}	
		 }
		 else
		 {
		         alert("Required! Please Select the profile pic first"); 
				 document.saveProfilePicForm.upload_avtar.focus();
				 return false;
		 }
   }
   
   function cancel_profile_pic()
   { 
        var r = confirm("Are you sure want to cancel the Profile Pic image");
		if (r == true)
		  {
		      document.saveProfilePicForm.submit();
		  }
		else
		  {
		      return true;
		  } 
   }

   function checkform()
   {
       var requiredFileSizeInBytes = 512000;
	  
         if(document.saveProfilePicForm.upload_avtar.value != "")
		 {
		      alert("Error! Please save the Profile Pic first."); 
			  document.saveProfilePicForm.upload_avtar.focus();
			  return false;   
		 }
         else if(document.updateProfileForm.fname.value == "")
		 {
		      alert("Required: Please enter your first name."); 
			  document.updateProfileForm.fname.focus();
			  return false;
		 }
		 else if(document.updateProfileForm.lname.value == "")
		 {
		      alert("Required: Please enter your last name."); 
			  document.updateProfileForm.lname.focus();
			  return false;
		 }
		 else if(document.updateProfileForm.email.value == "")
		 {
		      alert("Required: Please enter your email address."); 
			  document.updateProfileForm.email.focus();
			  return false;
		 }
		 else if(document.updateProfileForm.pass.value != "" || document.updateProfileForm.cpass.value != "")
		 {
		          if(document.updateProfileForm.pass.value != document.updateProfileForm.cpass.value)
				   {
				          alert("Required: Please enter the same password and confirm password."); 
						  document.updateProfileForm.pass.focus();
						  return false;
				   }
		 }
		 else
		 {
		      return true;
		 }  
   } 
</script>

<cfif IsDefined("URL.fnm") and URL.fnm neq ''> 
	  <cfset filename = ToString( ToBinary( URL.fnm ) )> 
<cfelse>
      <cfset filename = ''>
</cfif> 

<cfinclude template="qry_update_profile.cfm"> 
<cfoutput>
<cfif IsDefined("URL.suc") and URL.suc neq ''>
   <cfif URL.suc eq 1>
        <p style="font-size: 16px; font-weight: bold; color: blue;">
	        You have successfully updated your profile details.
        <p>
   <cfelse>	
        <p style="font-size: 16px; font-weight: bold; color: red;">
	        You have entered the email ID that is not available to choose.
        <p>	
   </cfif> 
</cfif>

<cfif IsDefined("URL.cancl") and URL.cancl neq ''>
   <cfif URL.cancl eq 0>
        <p style="font-size: 16px; font-weight: bold; color: blue;">
	        You have cancelled the profile pic image.
        <p> 
   </cfif> 
</cfif>

<form name="saveProfilePicForm" action="/index.cfm?fuseaction=updateprofile&fusesubaction=savepic" method="post" onsubmit="return save_profile_pic();" enctype="multipart/form-data">
<input type="hidden" name="userID" value="#getUserDetails.ContactID#" />
<input type="hidden" name="filenameToCancel" value="#filename#" />
<table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
	    <td valign="top" width="20%">
		      Your Profile Picture: 
		</td>
		<td valign="top" width="80%">
		       <cfset userID = #SESSION.userid#>
		       <cfquery name="getProfilePic" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
				   SELECT profilepic, linkedinprofilepic, linkedinuser FROM contacts WHERE contactid = #userID#
			   </cfquery>  
			    <cfif IsDefined("session.pictureUrl") and #session.pictureUrl# neq ''>
				   <cfset pictureUrl = #session.pictureUrl#>
				<cfelse>
				   <cfset pictureUrl = "">   
				</cfif> 
			   <cfif #filename# neq ''> 
			            <img border="0" src="/images/profiles/#filename#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
			   <cfelseif #getProfilePic.profilepic# neq ''>
			            <img border="0" src="/images/profiles/#getProfilePic.profilepic#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
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
			   <input type="submit" name="save_avtar" id="save_avtar" value="Save Profile Pic" /> &nbsp; 
			   <cfif filename neq ''>
			        <input type="button" name="cancel_avtar" id="cancel_avtar" value="Cancel Profile Pic" onclick="javascript: cancel_profile_pic();" /> <br />
					<p style="color: blue;">
			            <strong>Note: *</strong> Your profile pic will be saved only when you click on "Update Profile" button.
			        </p>
			   </cfif>
			   <p style="color: blue;">
			       <strong>Note: *</strong> max image size <strong>300x300px</strong>. (<strong>jpg, jpeg, gif or png</strong>)
			   </p>
		</td>
	</tr>
</table>
</form>

<form name="updateProfileForm" action="/index.cfm?fuseaction=updateprofile&fusesubaction=update" method="post" onsubmit="return checkform();" enctype="multipart/form-data">
<input type="hidden" name="userID" value="#getUserDetails.ContactID#" size="50" />
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
		      Your Email: <span style="color: red;">*</span>
		</td>
		<td valign="top">
		       <input type="text" id="email" name="email" value="#getUserDetails.EMAILADDRESS#" size="50" />
		</td>
	</tr>
	<tr>
	    <td valign="top" colspan="2">&nbsp;
		     
		</td>
	</tr>
	<tr>
	    <td valign="top">
		      Your Password:
		</td>
		<td valign="top">
		       <input type="password" name="pass" value="" size="50" />
		</td>
	</tr>
	<tr>
	    <td valign="top" colspan="2">&nbsp;
		     
		</td>
	</tr>
	<tr>
	    <td valign="top">
		      Your Confirm Password:
		</td>
		<td valign="top">
		       <input type="password" name="cpass" value="" size="50" />
		</td>
	</tr>
	<tr>
	    <td valign="top" colspan="2">&nbsp;
		     
		</td>
	</tr>
	<tr>
	    <td valign="top" colspan="2">
		     <input type="submit" name="updateprofile" value="Update Profile" />
		</td>
	</tr>
</table>
</form>
</cfoutput>
</div>
<cfelse>
      <p style="font-size: 16px; font-weight: bold;">
	        You are not authorized to view this page.
	  </p>
</cfif>