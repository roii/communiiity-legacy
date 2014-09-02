<cfoutput>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<link rel="shortcut icon" href="/favicon.ico" type="image/x-icon">
<link rel="icon" href="/favicon.ico" type="image/x-icon"> 
<title>#TRIM(session.AllSettings_SiteName)#</title>
<cfinclude template="/templates/styles.cfm">
</head>

<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###TRIM(session.AllSettings_TextColour)#">

<div style="width: 100%;">

      <cfinclude template="/templates/dsp_topbar.cfm"> 
	  
	  <script language="javascript"> 
	     function remSpaces(i)
		 {
		     if(i.value.length>0)
			 {
			    i.value = i.value.replace(/^\s+|\s+$/g, '');
			 } 
		 } 
	  
	     function checkform()
		 {
		      document.getElementById('emailMsgID').innerHTML = "";
			  document.getElementById('emailMsgID').style.display = "none";
		      if(document.signupStep2.firstName.value == "")
			  {
			        alert('Required: Please enter the First Name.');
					document.signupStep2.firstName.focus();
					return false;
			  }
			  else if(document.signupStep2.lastName.value == "")
			  {
			        alert('Required: Please enter the Last Name.');
					document.signupStep2.lastName.focus();
					return false; 
			  }
			  else if(document.signupStep2.email.value == "")
			  {
			        alert('Required: Please enter the Email Address.');
					document.signupStep2.email.focus();
					return false;
			  }
			  else if(document.signupStep2.password.value == "")
			  {
			        alert('Required: Please enter the Password.');
					document.signupStep2.password.focus();
					return false;
			  }
			  else if(document.signupStep2.conf_password.value == "")
			  {
			        alert('Required: Please enter the Confirm Password.');
					document.signupStep2.conf_password.focus();
					return false; 
			  }
			  else if(document.signupStep2.password.value != "" && document.signupStep2.conf_password.value != "")
			  {
			        if(document.signupStep2.password.value != document.signupStep2.conf_password.value)
					{
					     alert('Required: Please enter the same value for Password and Confirm Password.');
						 document.signupStep2.conf_password.focus();
						 return false;
					} 
					else
					{ 
					     startAjax();
					     return false;
					}
			  }
			  else
			  { 
			       startAjax();
				   return false;
			  }
		 }
		 
	     function startAjax()
		 {  
		       var xmlhttp;
			   var emailID = document.getElementById('mail_signup').value; 
			   
			   document.getElementById('loadingMsgID').style.display = "";
			   document.getElementById('loadingMsgID').innerHTML = '<img src="/images/loadingImage.gif" border="0" />';
			   
				  if (window.XMLHttpRequest)
				  {  // code for IE7+, Firefox, Chrome, Opera, Safari
				     xmlhttp = new XMLHttpRequest();
				  }
				  else
				  {  // code for IE6, IE5
				     xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
				  }
				     xmlhttp.onreadystatechange = function()
					  {
						  if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
						  {
							  var resp = xmlhttp.responseText;
							   if(resp == 0 || resp == "0")
							   { 
							       document.getElementById('emailMsgID').innerHTML = "";
							       document.getElementById('emailMsgID').style.display = "none";
								   document.getElementById('loadingMsgID').innerHTML = '';
								   document.getElementById('loadingMsgID').style.display = "none";
							       document.signupStep2.submit();
							   }
							   else
							   {
							       document.getElementById('loadingMsgID').innerHTML = '';
								   document.getElementById('loadingMsgID').style.display = "none";
							       document.getElementById('emailMsgID').style.display = "";
								   document.getElementById('emailMsgID').innerHTML = "Email ID is already existed. Please enter the another one."; 
							   } 
						  }
					  }
				xmlhttp.open("GET","/checkEmailAddress.cfm?emailID="+emailID,true);
				xmlhttp.send();
				return false; 
		 }  
	  </script> 
	  
	  <div class="content">
          <div class="container">
			    <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
					<tr> 
					<td width="*" style="padding-left:5px;padding-right:5px;" colspan="3"> 
					    <cfif IsDefined("URL.cid") and URL.cid neq ''>
						     <cfset strDecodedString = URLDecode(URL.cid)>
							 <cfset dataArray = ListToArray(strDecodedString)> 
							   
							   <cfset id = #dataArray[1]#>
							   <cfset firstName = #dataArray[2]#>
							   <cfset lastName  = #dataArray[3]#>
							   <cfset headline  = #dataArray[4]#>
							   <cfset publicProfileUrl = #dataArray[5]#>
							   <cfset email = #dataArray[6]#>
							   <cfset pictureUrl = #dataArray[7]#>
							   
							   <cfset FullName = #firstName# & ' ' & #lastName#>
							   <cfset ScreenName = #firstName# & ' ' & #lastName#>
							
							<div style="width: 505px; margin: 35px auto 0;">   
							   <form name="signupStep2" id="itc_form_3" method="post" action="/saveandredirect.cfm" onSubmit="return checkform();">
							   
							       <input type="hidden" name="linkedinID" value="#id#" />
								   <input type="hidden" name="linkedinfirstName" value="#firstName#" />
								   <input type="hidden" name="linkedinlastName" value="#lastName#" />
								   <input type="hidden" name="linkedinHeadline" value="#headline#" />
								   <input type="hidden" name="linkedinPublicURL" value="#publicProfileUrl#" />
								   <input type="hidden" name="linkedinEmail" value="#email#" />
								   <input type="hidden" name="pictureUrl" value="#pictureUrl#" />
								   <input type="hidden" name="ScreenName" value="#ScreenName#" />
								   
									<fieldset class="account-crowdsourcing">
										<h1 class="gray gray-note">Account information <i>All fields required</i></h1>
										<div class="field user_name require">
										       <div class="field-heading">
											        <table cellpadding="0" cellspacing="0" border="0" width="100%">
													     <tr>
														      <td valign="top">
															       <cfif pictureUrl eq 0 or pictureUrl eq '0'>
																         <img border="0" src="#pictureUrl#" alt="No Image" title="No Image">
																   <cfelse>
																         <img border="0" src="#pictureUrl#" alt="#firstName# #lastName#" title="#firstName# #lastName#">
																   </cfif> 
															  </td>
															  <td valign="top">
															       Full Name: &nbsp; #FullName# <br />
																   Profile Headline: &nbsp; #headline# <br />
																   Public Profile URL: &nbsp; <a href="#publicProfileUrl#">click here</a>
															  </td>
														 </tr>
													</table>   
											   </div> 
									    </div>
										<div class="field user_name require">
										       <div class="field-heading">
											          <label class="big gray" for="user_name">First Name</label>
													  <span class="field-note"></span>
											   </div>
											   <input type="text" tabindex="100" size="60" value="#firstName#" id="firstName" class="textFields" name="firstName" onKeyUp="remSpaces(this);" onKeyDown="remSpaces(this);" onKeyPress="remSpaces(this);">
									    </div>    
										<div class="field user_name require">
										       <div class="field-heading">
											          <label class="big gray" for="user_name">Last Name</label>
													  <span class="field-note"></span>
											   </div>
											   <input type="text" tabindex="100" size="60" value="#lastName#" id="lastName" class="textFields" name="lastName" onKeyUp="remSpaces(this);" onKeyDown="remSpaces(this);" onKeyPress="remSpaces(this);">
									    </div> 
										<div class="field mail require">
										       <div class="field-heading">
											          <label class="big gray" for="mail">Email</label>
													  <span class="field-note"></span>
											   </div>
											   <span id="emailMsgID" style="display: none; color: red; padding-left: 10px;"></span>
											   <input type="text" tabindex="102" size="60" value="#email#" id="mail_signup" name="email" class="textFields" onKeyUp="remSpaces(this);" onKeyDown="remSpaces(this);" onKeyPress="remSpaces(this);">
									    </div> 
										<div class="field mail require">
										       <div class="field-heading">
											          <label class="big gray" for="mail">Password</label>
													  <span class="field-note"></span>
											   </div>
											   <input type="password" tabindex="104" size="60" value="" id="password" name="password" class="textFields" onKeyUp="remSpaces(this);" onKeyDown="remSpaces(this);" onKeyPress="remSpaces(this);">
									    </div>
										<div class="field mail require">
										       <div class="field-heading">
											          <label class="big gray" for="mail">Confirm Password</label>
													  <span class="field-note"></span>
											   </div>
											   <input type="password" tabindex="106" size="60" value="" id="conf_password" name="conf_password" class="textFields" onKeyUp="remSpaces(this);" onKeyDown="remSpaces(this);" onKeyPress="remSpaces(this);">
									    </div>
							        </fieldset>	
									<table cellpadding="0" cellspacing="0" border="0" width="100%">
									     <tr>
										       <td valign="top" width="15%">
											       <input type="submit" value="Sign up" class="btn rb">
											   </td>
											   <td valign="top" width="85%">
											       <span id="loadingMsgID" style="display: none;"></span>
											   </td>
										 </tr>
									</table>   
                             </form> 
						   </div>	 
					  <cfelse>
						     <p style="font-size: 16px; font-weight: bold;">
									You are not authorized to view this page.
							 </p>   
					  </cfif>   
					</td> 
					</tr>	
		        </table>
	      </div>
	  </div>	  		   
	  
	  <cfinclude template="/templates/footer_include.cfm">
	  
</div>

 
<!---<div align="center">
<cfinclude template="../templates/dsp_partners.cfm">
</div>--->

</body>
</html>

</cfoutput>