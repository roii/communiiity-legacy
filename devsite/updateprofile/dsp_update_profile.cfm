<cfif IsDefined("session.UserIsAuthenticated") and session.UserIsAuthenticated EQ 'Yes'> 

<script type="text/javascript">
    $(document).ready( function() {
      $('#tab-container').easytabs();
    });
</script> 

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
	   var fileElement = document.getElementById("upload_avtar");
	   var fileExtension = ""; 
	     if (fileElement.value.lastIndexOf(".") > 0) {
            fileExtension = fileElement.value.substring(fileElement.value.lastIndexOf(".") + 1, fileElement.value.length);
         }  
		 document.getElementById('uploadfileExtensionExt').value = fileExtension;		 
		 /*if (fileExtension != "gif" || fileExtension != "jpg" || fileExtension != "jpeg" || fileExtension != "png") { 
			   alert("Required: Please select only jpg, jpeg, gif or png type images"); 
			   document.updateProfileForm.upload_avtar.focus();
			   return false;
		 }
		 else */ 
		 if(document.updateProfileForm.fname.value == "")
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
				  else
				  {
				          return true;
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
<cfset userID = #SESSION.userid#>
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

<cfif IsDefined("URL.fileext") and URL.fileext eq 0> 
        <p style="font-size: 16px; font-weight: bold; color: red;">
	        Please upload only .jpg, .jpeg, .gif and .png format files....
        <p>  
</cfif>

<cfif IsDefined("URL.skilladd") and URL.skilladd eq 1> 
        <p style="font-size: 16px; font-weight: bold; color: red;">
	       Your Skills has been updated successfully...
        <p>  
</cfif>

<cfinclude template="functions.cfm"> 


<cfset browserDetectValue = browserDetect()> 
<cfset isfirefox = #ListContains(browserDetectValue, "Firefox")#>
<cfset ischrome  = #ListContains(browserDetectValue, "Chrome")#> 

<div class="i-management-bar">
	<div class="profileHeader">
		  <div class="i-item i-selected">
		    <a href="/user/profile/#userID#" class="headerAnchor">
		     <cfif ischrome eq 1 OR ischrome eq '1'>
				 <span class="i-icon i-glyph-icon-30-edit" style="margin-top: -27px;">
				    <img src="/images/view-image.jpg" border="0" />
				 </span>
			 <cfelse>
			     <span class="i-icon i-glyph-icon-30-edit">
				    <img src="/images/view-image.jpg" border="0" />
				 </span>
			 </cfif>	 
				 <span class="i-text">View Profile</span>
		    </a>		 
		  </div> 
		  <div class="i-item"> 
					  <span class="i-icon i-glyph-icon-30-view">
						  <img src="/images/edit-image.jpg" border="0" />
					  </span>
					  <span class="i-text">Edit Profile &amp; Settings</span> 
		  </div> 
	</div>
</div>	  
</cfoutput>

<div id="tab-container" class='tab-container'>
	 <ul class='etabs'>
	   <li class='tab'><a href="#tabs1-profile">PROFILE</a></li>
	   <li class='tab'><a href="#tabs1-skills">SKILLS</a></li>
	   <li class='tab'><a href="#tabs1-settings">SETTINGS</a></li> 
	 </ul>
	 <div class='panel-container'>
		<div id="tabs1-profile" style="padding: 20px;"> 
		        <cfinclude template="/updateprofile/tabs1profile.cfm">
		</div>
		<div id="tabs1-skills" style="padding: 20px;"> 
		        <iframe src="/updateprofile/tabs2skills.cfm" frameborder="0" height="600" width="900" scrolling="auto"></iframe>
		</div>
		<div id="tabs1-settings" style="padding: 20px;"> 
		     <!---Settings Tab Coming Soon....... --->
			    <cfinclude template="/updateprofile/tabs3settings.cfm"> 
		</div> 
	 </div>
</div> 

</div>
<cfelse>
      <p style="font-size: 16px; font-weight: bold;">
	        You are not authorized to view this page.
	  </p>
</cfif>