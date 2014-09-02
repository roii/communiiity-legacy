<cfset session.captcha = ''>
<cfoutput>

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
<script type="text/javascript" > 
 function confirmProjectDelete(aURL) {  
	    if(confirm('Are you sure you want to delete this Task?')) {
	      document.location.href = aURL;
	    }
  }
</script>
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
<cfif session.UserType EQ 'Administrator'>
    <cfset allowTasks = 1>
<cfelse>
    <cfset allowTasks = 0> 
</cfif> 

<!--- <cfif  session.UserIsAuthenticated EQ 'no'>
 
 <script>
alert("You must be a #TRIM(AllSettings.SiteName)# member and logged-in to access this part of the website.");
self.location="javascript:history.back();";
</script>
<cfabort>

</cfif>
 ---> 
 
<table width="100%" cellpadding="0" cellspacing="0" border="0">



<tr> 
<td>
      
	    <cfquery name="projectRelatedData" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT * FROM campaigns
			WHERE CampaignsID = #projectdetails.RELATED_CAMPAIGN#
		</cfquery> 
		
		<table cellpadding="0" cellspacing="0" border="0" width="90%">
		   <tr>
		        <td>
				    <p>
						 <span style="padding-left: 15px;">
							 <span style="font-size: 18px; font-weight: bold; color:###TRIM(AllSettings.DkTextColor)#; font-weight: bold;">PROJECT:</span>  
							 <span style="font-size:14px; color:###TRIM(AllSettings.DkTextColor)#; font-weight: bold;">#projectRelatedData.Title#</span>
						 </span>	  
						 <br />
						 <span style="padding-left: 35px;">
							 <span style="font-size: 18px; font-weight: bold; color:###TRIM(AllSettings.DkTextColor)#; font-weight: bold;">TASK:</span>  
							 <span style="font-size:14px; color:###TRIM(AllSettings.DkTextColor)#; font-weight: bold;">#TRIM(projectdetails.title)#</span>
						 </span>	  
					 </p>
				</td>
				<td>
						<cfif IsDefined("URL.maintask") and URL.maintask neq ''>
							<cfset maintask = URL.maintask>
						<cfelse>
							<cfset maintask = 1>		
						</cfif>	 
						<cfif allowTasks eq 1 OR (IsDefined("SESSION.userid") and #SESSION.userid# eq #ProjectDetails.PROJECT_OWNER#)>	 
							  <a href="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=editTask&documentID=#URL.documentID#&projectmode=template&ProjectCategoryID=0&ProjectID=#TRIM(URL.ProjectID)#&campaignID=#URL.campaignID#&maintask=#maintask#" style="text-decoration: none;">
								  <img src="#request.webroot#/icons/Edit-icon.png" height="20" width="20" alt="Edit this Project" border="0">
							  </a> 
							  <cfif IsDefined("URL.campaignID") and URL.campaignID neq ''>
								  <a href="javascript:confirmProjectDelete('#request.webroot#/admin/act_cashproject_delete_from_Project.cfm?campaignID=#URL.campaignID#&projectID=#TRIM(URL.ProjectID)#&documentID=#URL.documentID#&maintask=#maintask#')" style="text-decoration: none;"><img width="20" border="0" height="20" alt="Delete this Project" src="#request.webroot#/icons/delete.png"></a>
							  </cfif>
							  <br /> 	  
						</cfif>
				</td>
		   </tr>
		</table>
		
			  
	<table cellpadding="0" cellspacing="0" border="0" width="90%" style="padding-left: 45px;">
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="60" style="/*padding-right:10px;*/color:###TRIM(AllSettings.DkTextColor)#; text-align: left;" align="right"><strong>#category#:</strong></td>
	<td>#TRIM(ProjectDetails.CategoryTitle)#</td>
	</tr>
	
	<!---<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#brief#:</strong></td>
	<td>#TRIM(ProjectDetails.IntroText)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#status#:</strong></td>
	<td><cfif TRIM(projectdetails.currentstatus) NEQ ''>#TRIM(projectdetails.currentstatus)#<cfelse> &ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#priority#:</strong></td>
	<td><cfif TRIM(projectdetails.currentstatus) NEQ ''>#TRIM(projectdetails.priority)#<cfelse> &ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#beingdone#:</strong></td>
	<td><cfif TRIM(projectdetails.assignedto) NEQ ''>#TRIM(projectdetails.assignedto)#<cfelse> &nbsp;&nbsp;&ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#location#:</strong></td>
	<td><cfif TRIM(projectdetails.location) NEQ ''>#TRIM(projectdetails.location)#<cfelse>&nbsp;&nbsp;&ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#by#:</strong></td>
	<td><cfif TRIM(projectdetails.addedBy) NEQ ''>#TRIM(projectdetails.addedBy)#<cfelse>&nbsp;&nbsp;&ndash;</cfif></td>
	</tr>
	
	<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>
		<tr>
		<td colspan="2"><hr size="1" color="##b4b4b4"></td>
		</tr>
		
		<tr>
		<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#projorder#:</strong></td>
		<td><cfif TRIM(projectdetails.project_order) NEQ ''>#TRIM(projectdetails.project_order)#<cfelse>&nbsp;&nbsp;&ndash;</cfif></td>
		</tr>
	</cfif>
	
	<cfset this_percentDone = projectdetails.PercentComplete>    
	<cfif this_percentDone neq '' and this_percentDone gt 0>	
		<tr>
		<td colspan="2"><hr size="1" color="##b4b4b4"></td>
		</tr>
		
		<tr>
		<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>#percentcomp#:</strong></td>
		<td> 
	           <cfinclude template="dsp_percent_bar_proj_details.cfm"> 
		</td>
		</tr>  
	 </cfif>
	 
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>--->
	
	</table> 
	
	<div style="background: none repeat scroll 0 0 ##7F7F7F; color: ##FFFFFF; float: left; padding: 4px 13px 4px 5px; width: 100%;">
	     <div style="width: 100%; float: left;">
		 
		    <span style="display: block; padding: 5px;">
				<span style="padding-right: 10px; padding-left: 5px;">
				   <b>#tID#</b>
				</span>
				<span style="border-right: 1px solid white;">
				   &nbsp;
				</span>  
				<span style="padding-right: 10px; padding-left: 15px;">
				   <b>Create Date:</b>
				</span>
				<span style="border-right: 1px solid white;">
				   &nbsp;
				</span>  
				<span style="padding-right: 10px; padding-left: 5px;">
				   <b>Points:</b>
				</span>
				<span style="border-right: 1px solid white;">
				   &nbsp;
				</span>  
				<span style="padding-right: 10px; padding-left: 35px; padding-right: 20px;">
				   <b>Status</b>
				</span>
				<span style="border-right: 1px solid white;">
				   &nbsp;
				</span>  
				<span style="padding-right: 10px; padding-left: 5px;">
				   <b>by who:</b>
				</span>
				<span style="border-right: 1px solid white;">
				   &nbsp;
				</span>  
				<span style="padding-right: 10px; padding-left: 5px;">
				   <b>start date:</b>
				</span>
				<span style="border-right: 1px solid white;">
				   &nbsp;
				</span>  
				<span style="padding-right: 10px; padding-left: 20px;">
				   <b>% done:</b>
				</span>
				<span style="border-right: 1px solid white;">
				   &nbsp;
				</span>  
				<span style="padding-right: 10px; padding-left: 20px;">
				   <b>finish date:</b>
				</span>
				<span style="">
				   &nbsp;
				</span> 
			</span>
			
		 </div>
		 <div style="width: 100%; float: left; background: white; color: black; padding: 4px;"> 
						<table width="100%" border="0" cellspacing="2" cellpadding="2" style="">
						     <tr style="background: none repeat scroll 0 0 ##FFFFFF; color: black;">
								<td style="width: 4%;">#trim(url.projectID)#</td> 
								<td style="width: 10%; text-align: center;">&nbsp;</td> 
								<td style="width: 7%; text-align: center;">
									<cfif IsDefined("projectdetails.CreditsOffered") and TRIM(projectdetails.CreditsOffered) NEQ ''>
										<cfif projectdetails.paymenttype contains 'money'>
										   #TRIM(projectDetails.PaidIn)##DecimalFormat(projectdetails.CreditsOffered)#
										<cfelse>
										   #projectdetails.CreditsOffered# pts
										</cfif>
									<cfelse>
										&ndash;
									</cfif>
								</td>
								<td style="width: 11%; text-align: center;">#projectdetails.CurrentStatus#</td> 
								<td style="width: 8%; text-align: center;">#projectdetails.AssignedTo#</td> 
								<td style="width: 8%; text-align: center;">&nbsp;</td> 
								<td style="width: 8%; text-align: center;"><cfif IsNumeric("#projectdetails.percentcomplete#")>#projectdetails.percentcomplete#%<cfelse>&ndash;</cfif></td>
								<td style="width: 8%; text-align: center;">&nbsp;</td> 
								<td style="width: 36%; text-align: center;" colspan="2">&nbsp;</td> 
							  </tr>
						</table> 
		 </div>
	</div>
	
 
	<!---<table width="90%" border="0" cellspacing="2" cellpadding="2" style="background: none repeat scroll 0 0 ##7F7F7F; border: 1px solid ##7F7F7F; color: ##FFFFFF;">
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
		<td align="center" style="color:###TRIM(AllSettings.DkBoxTextColour)#;" width="auto"><b>#tID#</b></td> 
		<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="auto"><b>Create Date:</b></td>
		<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="auto"><b>Points:</b></td>
		<td align="center" style="color:###TRIM(AllSettings.DkBoxTextColour)#;" width="auto"><b>Status</b></td> 
		<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="auto"><b>by who:</b></td>
		<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="auto"><b>start date:</b></td>
		<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="auto"><b>% done:</b></td>
		<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="auto"><b>finish date:</b></td>
	</tr> 
	
	<tr style="background: none repeat scroll 0 0 ##FFFFFF; color: black;">
		<td align="center">#trim(url.projectID)#</td> 
		<td align="center">&nbsp;</td> 
		<td align="center">
			<cfif IsDefined("projectdetails.CreditsOffered") and TRIM(projectdetails.CreditsOffered) NEQ ''>
				<cfif projectdetails.paymenttype contains 'money'>
				   #TRIM(projectDetails.PaidIn)##DecimalFormat(projectdetails.CreditsOffered)#
				<cfelse>
				   #projectdetails.CreditsOffered# pts
				</cfif>
			<cfelse>
				&ndash;
			</cfif>
		</td>
		<td align="center">#projectdetails.CurrentStatus#</td> 
		<td align="center">#projectdetails.AssignedTo#</td> 
		<td align="center">&nbsp;</td> 
		<td align="center"><cfif IsNumeric("#projectdetails.percentcomplete#")>#projectdetails.percentcomplete#%<cfelse>&ndash;</cfif></td>
		<td align="center">&nbsp;</td> 
	</tr>
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height=2>
	    <td colspan=8> </td>
	</tr>
	
	</table>--->
	
	<br><br>
	
	
	#TRIM(projectDetails.details)#<br>
	
	
</td>
</tr>


</table>



<!---
#expresstext#

<cfif session.UserIsAuthenticated EQ 'no'>
	 #clickherehotlinklogin#
<cfelse>
	<a href="##" onclick="javascript:window.open('#request.webroot#/tasks/dsp_ExpressInterest.cfm?projectID=#trim(url.projectID)#&projectTitle=#TRIM(projectdetails.title)#&userID=#session.UserID#','popup','width=500,height=800');">#clickherehotlink#</a>.

</cfif>

<br><br>--->

<table width="90%" border="0" cellspacing="2" cellpadding="2">
<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
<td colspan="2" style="color:###TRIM(AllSettings.DkBoxTextColour)#;" ><b>#comments#</b></td>
</tr>

<cfif ProjectComments.RecordCount>
<cfloop query="ProjectComments">
    
<tr>
	<td style="text-align:left;">#commentby#: #trim(ProjectComments.Author)#</td>
	<td style="text-align:right;">#commentadd#: #trim(ProjectComments.DateAdded)#</td>
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
	<td colspan="2">#nocommentsyet#</td>
	</tr>


</cfif>


</table><br><br>


<h3>#leavecomments#</h3>
<form action="#request.webroot#/index.cfm?fuseaction=tasks&fusesubaction=insertcomment" method="post" name="commentform">

<cfif maintask eq 1>
    <input name="fromProject" type="hidden" value="1" />
<cfelse>
    <input name="fromProject" type="hidden" value="0" />	
</cfif>

<cfif IsDefined("URL.campaignID") and URL.campaignID neq ''>
     <input name="projectBackID" type="hidden" value="#URL.campaignID#" />
<cfelse> 
     <input name="projectBackID" type="hidden" value="0" />	 
</cfif>

#name#: <br /><input name="Author" type="text" /><br />
#emailtext#: <br /><input name="AuthorEmail" type="text" /><br />
#commenttitle#: <br /><textarea name="Comment" cols="50" rows="5"></textarea><br />
<!---Enter Text Below:<br />
<input type="text" name="captcha"><br />
<div id="captchaDiv"></div>
Can't read? <a href="" id="reloadLink">Reload</a><br />
<script type="text/javascript"
   src="https://www.google.com/recaptcha/api/challenge?k=6LfCrMUSAAAAAMdzh5S8w0UaKZAqg0tcD0Pa9vZJ">
</script>

<noscript>sss
   <iframe src="https://www.google.com/recaptcha/api/noscript?k=6LfCrMUSAAAAAMdzh5S8w0UaKZAqg0tcD0Pa9vZJ"
       height="300" width="500" frameborder="0"></iframe><br>
   <textarea name="recaptcha_challenge_field" rows="3" cols="40">
   </textarea>
   <input type="hidden" name="recaptcha_response_field"
       value="manual_challenge">
</noscript>---->

<input type="hidden" name="ProjectID" value="#TRIM(ProjectDetails.ProjectID)#"/>
<input type="hidden" name="documentID" value="#url.documentID#" />
<input type="hidden" name="projectmode" value="#url.projectmode#" />
<input type="hidden" name="ProjectCategoryID" value="#url.ProjectCategoryID#" />
<input type="submit" value="#addcommenttitle#" onclick="validate(commentform); return false;" />

</form>
<hr />	
    
</cfoutput>