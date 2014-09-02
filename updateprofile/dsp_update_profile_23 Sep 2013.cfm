<cfif IsDefined("session.UserIsAuthenticated") and session.UserIsAuthenticated EQ 'Yes'>
<div>
<script language="javascript">
   function checkform()
   {
      var requiredFileSizeInBytes = 1048576;
	  
         if(document.updateProfileForm.upload_avtar.value != "")
		 {
		        var fileName = document.updateProfileForm.upload_avtar.value;
				var fileSize = document.getElementById('upload_avtar').files[0].size; 
				var fileType = document.getElementById('upload_avtar').files[0].type; 
				if(fileType == "image/gif" || fileType == "image/png" || fileType == "image/jpeg" || fileType == "image/jpg")
				{
				    if(fileSize > requiredFileSizeInBytes)
					{
					    alert("Error! You have uploaded the image of size more than 1 MB.");
						document.updateProfileForm.upload_avtar.focus();
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
			        document.updateProfileForm.upload_avtar.focus();
				    return false;
				}	
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
<form name="updateProfileForm" action="/index.cfm?fuseaction=updateprofile&fusesubaction=update" method="post" onsubmit="return checkform();" enctype="multipart/form-data">
<input type="hidden" name="userID" value="#getUserDetails.ContactID#" size="50" />
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
			   <cfif #getProfilePic.profilepic# neq ''>
			            <img border="0" src="/images/profiles/#getProfilePic.profilepic#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
			   <cfelseif #getProfilePic.linkedinprofilepic# neq '' and #getProfilePic.linkedinprofilepic# neq 0>
			            <img border="0" src="#getProfilePic.linkedinprofilepic#" style="color:##FFFFFF;" alt="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#" title="#ReReplace(session.User_FirstName,'\b(\w)','\u\1','ALL')# #ReReplace(session.User_LastName,'\b(\w)','\u\1','ALL')#">
			   <cfelse>
			            <img border="0" src="/images/default_avatar.gif" style="color:##FFFFFF;" alt="No Image" title="No Image">				 	
			   </cfif> <br /><br />
			   <input type="file" name="upload_avtar" id="upload_avtar" value="" />
			   <p style="color: blue;">
			       <strong>Note: *</strong> Please upload images only of .jpg, .jpeg, .gif and .png extensions and <strong>size</strong> must be less than or equal to <strong><u>1 MB</u></strong>.
			   </p>
		</td>
	</tr>
	<tr>
	    <td valign="top" colspan="2">&nbsp;
		     
		</td>
	</tr>
    <tr>
	    <td valign="top">
		      Your First Name: <span style="color: red;">*</span>
		</td>
		<td valign="top">
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
		       <input type="text" name="email" value="#getUserDetails.EMAILADDRESS#" size="50" />
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