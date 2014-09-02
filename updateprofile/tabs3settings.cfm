<cfoutput>
<div class="i-profile-settings"> 

<div class="i-musty-background i-profile-story">
	  <h3>Update Your Email Address</h3>
	  <cfif IsDefined("URL.suc") and URL.suc neq ''>
	        <span style="color: blue;">Your Email has been updated successfully</span> 
	  </cfif>
	  <script language="javascript">
	      function checkformFy()
		  {  
		       if(document.updateEmail.email.value == '')
			   {
			       alert('Required: Please enter the email address.');
				   document.updateEmail.email.focus();
				   return false;
			   }
			   else
			   {
			       return true;
			   }
		  }
	  </script>
	  <div class="row">
	   <form name="updateEmail" action="/index.cfm?fuseaction=updateprofile&fusesubaction=updateemail" method="post" onsubmit="return checkformFy();">
	    <cfif IsDefined("getUserDetails.ContactID") and getUserDetails.ContactID neq ''>
			 <input type="hidden" name="userID" value="#getUserDetails.ContactID#" size="50" />
			 <input type="hidden" name="adminIDCheck" value="No" /> 
		<cfelse>
			 <input type="hidden" name="userID" value="#getUserDetails.AdministratorID#" size="50" />	
			 <input type="hidden" name="adminIDCheck" value="Yes" /> 
		</cfif>	 
		  <table cellpadding="0" cellspacing="0" border="0" width="100%">
		      <tr>
				<td valign="top">
					  Your Email: <span style="color: red;">*</span>
				</td>
				<td valign="top">
					   <input type="text" id="email" name="email" value="#getUserDetails.EMAILADDRESS#" size="50" />
				</td>
			  </tr>
			  <tr>
			     <td colspan="2">
				       <input type="submit" name="updateEmail" value="Update Email ID" />
				 </td>
			  </tr>
		  </table>
	  </form>	  
	  </div>
</div>

<div class="i-musty-background i-profile-story">
	  <h3>Update Your Password</h3>
	  <div class="row">
	  <cfif IsDefined("URL.cpasserr") and URL.cpasserr eq 1>
	        <span style="color: blue;">You entered the incorrect current password</span> 
	  </cfif>
	  <cfif IsDefined("URL.npasserr") and URL.npasserr eq 1>
	        <span style="color: blue;">Your password and confirm password doesn't match</span> 
	  </cfif>
	  <cfif IsDefined("URL.suc2") and URL.suc2 neq ''>
	        <span style="color: blue;">Your Password has been updated successfully</span> 
	  </cfif>
	   <form name="updatePassword" action="/index.cfm?fuseaction=updateprofile&fusesubaction=updatepassword" method="post">
	     <cfif IsDefined("getUserDetails.ContactID") and getUserDetails.ContactID neq ''>
			 <input type="hidden" name="userID" value="#getUserDetails.ContactID#" size="50" />
			 <input type="hidden" name="adminIDCheck" value="No" /> 
		<cfelse>
			 <input type="hidden" name="userID" value="#getUserDetails.AdministratorID#" size="50" />	
			 <input type="hidden" name="adminIDCheck" value="Yes" /> 
		</cfif>	
		 <table cellpadding="0" cellspacing="0" border="0" width="100%">
		      <tr>
				<td valign="top">
					  Current Password: 
				</td>
				<td valign="top">
					   <input type="password" id="email" name="cpass" value="" size="50" />
				</td>
			  </tr>
			  <tr>
				<td valign="top">
					  New Password: 
				</td>
				<td valign="top">
					   <input type="password" id="email" name="npass" value="" size="50" />
				</td>
			  </tr>
			  <tr>
				<td valign="top">
					  Password Confirmation: 
				</td>
				<td valign="top">
					   <input type="password" id="email" name="ncpass" value="" size="50" />
				</td>
			  </tr>
			  <tr>
			     <td colspan="2">
				       <input type="submit" name="updatePassword" value="Update Password" />
				 </td>
			  </tr>
		  </table>
	  </form>	  
	  </div>
</div>

<!---<div class="i-musty-background i-profile-story">
	  <h3>Your email preferences</h3>
	  <div class="row">
		 ....
	  </div>
</div>--->


<div class="i-musty-background i-profile-story">
	  <h3>Delete Your Account</h3>
	  <div class="row">
		  <strong>So are you sure to delete your account? If yes then please click on the below button:</strong><br />
		  <input type="button" name="delete_account" id="delete_account" value="Delete Your Account" onclick="javascript: window.location = '/index.cfm?fuseaction=updateprofile&fusesubaction=deleteAcct';" />
	  </div>
</div>

</div>
</cfoutput>