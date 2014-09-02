<cfoutput>
<cfinclude template="inc/html_head.cfm" />
<body id="#$.getTopID()#" class="twoColSR depth#arrayLen($.event('crumbdata'))# #$.createCSSid($.content('menuTitle'))#">
	<cfinclude template="inc/header.cfm" />
	

<!-- Super Container -->
<div class="super-container full-width content" id="section-thirds">
	<!-- 960 Container -->
	<div class="container">  
	</div>
	<!-- /End 960 Container -->

</div>
<!-- /End Super Container -->
<!-- ============================================== -->
	
<!-- Super Container -->
<div class="super-container full-width">

	<!-- 960 Container -->
	<div class="container">
	
		<cfset objects3=trim($.dspObjects(3))>
		<cfset rootPath = #$.createHREF(filename='')#>
		<!-- CONTENT -->
		<br />
		<div class="<cfif len(objects3)>eleven<cfelse>sixteen</cfif> columns content"> 
		
					<cfquery name="ProjectDetails" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDBUsername()#" password="#application.configBean.getDBPassword()#">
						SELECT Projects.*, ProjectCategories.Title as CategoryTitle,ProjectCategories.displayorder
						FROM Projects, ProjectCategories
						WHERE Projects.ProjectID=#URL.projectID#
						AND Projects.ProjectCategoryID=ProjectCategories.ProjectCategoryID
						order by displayorder
				    </cfquery> 
					
					<cfquery name="ProjectComments" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDBUsername()#" password="#application.configBean.getDBPassword()#">
						SELECT Projects.*, ProjectComments.*
						FROM Projects, ProjectComments
						WHERE Projects.ProjectID=#projectID#
						AND Projects.ProjectID=ProjectComments.ProjectID
						order by DateAdded
					</cfquery> 

			<cfset session.captcha = ''>
			<cfoutput> 
				<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script> 
				<script type="text/javascript" >
					$(document).ready(function() { 
					$.ajaxSetup ({
					// Disable caching of ANY AJAX responses.
					cache: false	
					}); 
					  $("##captchaDiv").load("captcha.cfm");     
					  $("##reloadLink").click(function(e) {
						  $("##captchaDiv").load("captcha.cfm");            
						  e.preventDefault();
					  });
					})
				</script> 
				<script type="text/javascript">
						function validate(commentform) { 
							var email = commentform.AuthorEmail.value;
							var at = email.indexOf("@");		
							var space = email.indexOf(" ");
							var comma = email.indexOf(",");
							var dot = email.indexOf(".");
							var two_dots = email.indexOf("..");
							var length = email.length -1; 
							
							var SName = commentform.Author.value; 
							if  ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0))
							 {
								alert("Please enter a valid Email Address.");
								commentform.AuthorEmail.focus();
								return;
							} 
							else if (commentform.Author.value == "") {
								alert("You must enter your Name.");
								commentform.Author.focus();
								return;
							}  
							else {
								commentform.submit(); //submit form
								}
						}
				</script> 
				<table width="100%" cellpadding="0" cellspacing="0" border="0" style="border: none !important;"> 
				<tr> 
				       <td><span style="color: ##FD7922; font-size: 14px; font-weight: bold; padding: 24px;"><b>#TRIM(projectdetails.title)#</b></span><br><br> 
							<table cellpadding="0" cellspacing="0" border="0" width="90%" style="border: none !important;"> 
								<tr>
								     <td colspan="2"><hr size="1" color="##FD7922" style="color: ##FD7922 !important;"></td>
								</tr> 
								<tr>
									 <td width="100" style="padding-right:10px;" align="right"><strong>Category:</strong></td>
									 <td>#TRIM(ProjectDetails.CategoryTitle)#</td>
								</tr> 
								<tr>
								     <td colspan="2"><hr size="1" color="##FD7922" style="color: ##FD7922 !important;"></td>
								</tr> 
								<tr>
									 <td width="100" style="padding-right:10px;" align="right"><strong>Brief:</strong></td>
									 <td>#TRIM(ProjectDetails.IntroText)#</td>
								</tr> 
								<tr>
								     <td colspan="2"><hr size="1" color="##FD7922" style="color: ##FD7922 !important;"></td>
								</tr> 
								<tr>
									 <td width="100" style="padding-right:10px;" align="right"><strong>Status:</strong></td>
									 <td><cfif TRIM(projectdetails.currentstatus) NEQ ''>#TRIM(projectdetails.currentstatus)#<cfelse> &ndash;</cfif></td>
								</tr> 
								<tr>
								     <td colspan="2"><hr size="1" color="##FD7922" style="color: ##FD7922 !important;"></td>
								</tr> 
								<tr>
									 <td width="100" style="padding-right:10px;" align="right"><strong>Priority:</strong></td>
									 <td><cfif TRIM(projectdetails.currentstatus) NEQ ''>#TRIM(projectdetails.priority)#<cfelse> &ndash;</cfif></td>
								</tr> 
								<tr>
								     <td colspan="2"><hr size="1" color="##FD7922" style="color: ##FD7922 !important;"></td>
								</tr> 
								<tr>
								     <td width="100" style="padding-right:10px;" align="right"><strong>Being done by:</strong></td>
								     <td><cfif TRIM(projectdetails.assignedto) NEQ ''>#TRIM(projectdetails.assignedto)#<cfelse> &nbsp;&nbsp;&ndash;</cfif></td>
								</tr> 
								<tr>
								     <td colspan="2"><hr size="1" color="##FD7922" style="color: ##FD7922 !important;"></td>
								</tr> 
					        </table>  
					        <table width="90%" border="0" cellspacing="2" cellpadding="2" style="border: 1px solid ##FD7922;"> 
								<tr bgcolor="">
								      <td align="center" style="background: ##FD7922; color: white;" width="5%"><b>pID</b></td> 
								      <td align="center" style="background: ##FD7922; color: white;" width="25%"><b><cfif projectdetails.paymenttype contains 'money'>Cash<cfelse>Points</cfif> Offered:</b></td>
								      <td align="center" style="background: ##FD7922; color: white;" width="25%"><b>Percent Complete:</b></td>
								</tr> 
								<tr>
								      <td align="center">#trim(url.projectID)#</td> 
									  <td align="center">
										  <cfif TRIM(projectdetails.CreditsOffered) NEQ ''>
											  <cfif projectdetails.paymenttype contains 'money'>                    
											           #TRIM(projectDetails.PaidIn)##DecimalFormat(projectdetails.CreditsOffered)#
											   <cfelse>
											           #INT(projectdetails.CreditsOffered)# pts
											   </cfif>
										  <cfelse>
										       &ndash;
										  </cfif>
									  </td>
								      <td align="center">
									      <cfif IsNumeric("#projectdetails.percentcomplete#")>
										       #projectdetails.percentcomplete#%
										  <cfelse>
										       &ndash;
										  </cfif>
									  </td>
								</tr> 
								<tr bgcolor="" height=2>
								      <td colspan=4 style="background: ##FD7922;">&nbsp;</td>
								</tr> 
					       </table>
						    <br> 
				            #TRIM(projectDetails.details)#<br> 
				      </td>
				   </tr> 
				</table>
				<br><br> 
Express interest to work on this project.  
<br> <br> 
<table width="90%" border="0" cellspacing="2" cellpadding="2" style="border: none !important;">
	<tr bgcolor="">
		<td colspan="2" style="font-weight: bold; font-size: 16px; background: ##FD7922; color: white;" ><b>Comments</b></td>
	</tr> 
<cfif ProjectComments.RecordCount>
    <cfloop query="ProjectComments"> 
		<tr>
			<td style="text-align:left;">Comment By: #trim(ProjectComments.Author)#</td>
			<td style="text-align:right;">Comment Added: #trim(ProjectComments.DateAdded)#</td>
		</tr>
		<tr>
			<td colspan="2">#TRIM(ProjectComments.Comment)#
			</td>
		</tr> 
		<tr>
			<td colspan="2"><hr />
			</td>
		</tr>
	</cfloop>
<cfelse>
	    <tr>
		    <td colspan="2">No comments yet!</td>
		</tr>
</cfif> 
</table>
<br><br> 
<h3>Leave a Comment</h3>
<form action="#rootPath#/index.cfm?fuseaction=projects&fusesubaction=insertcomment" method="post" name="commentform"> 
Name: <br /><input name="Author" type="text" style="height: 20px; width: 290px" /><br />
Email (won't be displayed): <br /><input name="AuthorEmail" type="text" style="height: 20px; width: 290px" /><br />
Comment: <br /><textarea name="Comment" cols="50" rows="5"></textarea><br />
<script type="text/javascript"
   src="https://www.google.com/recaptcha/api/challenge?k=6LfCrMUSAAAAAMdzh5S8w0UaKZAqg0tcD0Pa9vZJ">
</script> 
<noscript>
   <iframe src="https://www.google.com/recaptcha/api/noscript?k=6LfCrMUSAAAAAMdzh5S8w0UaKZAqg0tcD0Pa9vZJ"
       height="300" width="500" frameborder="0"></iframe><br>
   <textarea name="recaptcha_challenge_field" rows="3" cols="40"></textarea>
   <input type="hidden" name="recaptcha_response_field" value="manual_challenge">
</noscript> 
<input type="hidden" name="ProjectID" value="#TRIM(ProjectDetails.ProjectID)#"/>
<input type="hidden" name="documentID" value="#url.documentID#" />
<input type="hidden" name="projectmode" value="template" />
<input type="hidden" name="ProjectCategoryID" value="#url.ProjectCategoryID#" />
<input type="submit" value="add comment" onClick="validate(commentform); return false;" style="height: 30px; width: 90px; margin-top: 12px;" /> 
</form>
<hr style="color: ##FD7922 !important;" />	 
</cfoutput> 
			
		</div>
		<!-- /CONTENT -->
				
		<cfif len(objects3)>
		<!-- SIDEBAR -->
		<div class="five columns sidebar">
			#$.dspObjects(3)#
		</div>
		<!-- /SIDEBAR -->
		</cfif>

		
	</div>
	<!-- /End 960 Container -->
		
</div>
<!-- /End Super Container -->
	
	<cfinclude template="inc/footer.cfm" />
</body>
</html>
</cfoutput>
