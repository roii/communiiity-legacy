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
      
	<span style="font-size:14px;color:###TRIM(AllSettings.DkTextColor)#"><b>#TRIM(projectdetails.title)#</b></span><br><br>
	
<cfif allowTasks eq 1>	
	<a href="#request.webroot#/admin/dsp_cashproject_edit.cfm?projectID=#TRIM(URL.ProjectID)#&documentID=#URL.documentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=550,top=10,left=10')" style="color:red; text-decoration:none;">
				 <img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0">
	</a>
</cfif>

	<table cellpadding="0" cellspacing="0" border="0" width="90%">
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Category:</strong></td>
	<td>#TRIM(ProjectDetails.CategoryTitle)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Brief:</strong></td>
	<td>#TRIM(ProjectDetails.IntroText)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Status:</strong></td>
	<td><cfif TRIM(projectdetails.currentstatus) NEQ ''>#TRIM(projectdetails.currentstatus)#<cfelse> &ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Priority:</strong></td>
	<td><cfif TRIM(projectdetails.currentstatus) NEQ ''>#TRIM(projectdetails.priority)#<cfelse> &ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	<tr>
	<td width="100" style="padding-right:10px;color:###TRIM(AllSettings.DkTextColor)#" align="right"><strong>Being done by:</strong></td>
	<td><cfif TRIM(projectdetails.assignedto) NEQ ''>#TRIM(projectdetails.assignedto)#<cfelse> &nbsp;&nbsp;&ndash;</cfif></td>
	</tr>
	
	<tr>
	<td colspan="2"><hr size="1" color="##b4b4b4"></td>
	</tr>
	
	</table>


	<br><br>
	<table width="90%" border="0" cellspacing="2" cellpadding="2">
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
	<td align="center" style="color:###TRIM(AllSettings.DkBoxTextColour)#;" width="5%"><b>pID</b></td>
	<!--- <td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b>Minimum Age:</b></td>
	<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b>Estimated Time:</b></td> --->
	<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b><cfif projectdetails.paymenttype contains 'money'>Cash<cfelse>Points</cfif> Offered:</b></td>
	<td align="center" style="color:###TRIM(AllSettings.BoxTextColour)#;" width="25%"><b>Percent Complete:</b></td>
	</tr>
	
	<tr>
	<td align="center">#trim(url.projectID)#</td>
	<!--- <td align="center"><cfif TRIM(projectdetails.AgeLong) NEQ ''>#projectdetails.AgeLong#<cfelse>&ndash;</cfif></td>
	<td align="center"><cfif TRIM(projectdetails.MaxTime) NEQ ''>#projectdetails.MaxTime#<cfelse>&ndash;</cfif></td> --->
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
	<td align="center"><cfif IsNumeric("#projectdetails.percentcomplete#")>#projectdetails.percentcomplete#%<cfelse>&ndash;</cfif></td>
	</tr>
	
	<tr bgcolor="###TRIM(AllSettings.BoxColour)#" height=2>
	<td colspan=4> </td>
	</tr>
	
	</table><br><br>
	
	
	#TRIM(projectDetails.details)#<br>
	
	
</td>
</tr>


</table><br><br>




Express interest to work on this project.

<cfif  session.UserIsAuthenticated EQ 'no'>
	 Click here (hotlink available to logged in members only).
<cfelse>
	<a href="##" onclick="javascript:window.open('#request.webroot#/projects/dsp_ExpressInterest.cfm?projectID=#trim(url.projectID)#&projectTitle=#TRIM(projectdetails.title)#&userID=#session.UserID#','popup','width=500,height=800');">Click here</a>.

</cfif>

<br><br>

<table width="90%" border="0" cellspacing="2" cellpadding="2">
<tr bgcolor="###TRIM(AllSettings.BoxColour)#">
<td colspan="2" style="color:###TRIM(AllSettings.DkBoxTextColour)#;" ><b>Comments</b></td>
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


</table><br><br>


<h3>Leave a Comment</h3>
<form action="#request.webroot#/index.cfm?fuseaction=projects&fusesubaction=insertcomment" method="post" name="commentform">

Name: <br /><input name="Author" type="text" /><br />
Email (won't be displayed): <br /><input name="AuthorEmail" type="text" /><br />
Comment: <br /><textarea name="Comment" cols="50" rows="5"></textarea><br />
<!---Enter Text Below:<br />
<input type="text" name="captcha"><br />
<div id="captchaDiv"></div>
Can't read? <a href="" id="reloadLink">Reload</a><br />---->
<script type="text/javascript"
   src="https://www.google.com/recaptcha/api/challenge?k=6LfCrMUSAAAAAMdzh5S8w0UaKZAqg0tcD0Pa9vZJ">
</script>

<noscript>
   <iframe src="https://www.google.com/recaptcha/api/noscript?k=6LfCrMUSAAAAAMdzh5S8w0UaKZAqg0tcD0Pa9vZJ"
       height="300" width="500" frameborder="0"></iframe><br>
   <textarea name="recaptcha_challenge_field" rows="3" cols="40">
   </textarea>
   <input type="hidden" name="recaptcha_response_field"
       value="manual_challenge">
</noscript>

<input type="hidden" name="ProjectID" value="#TRIM(ProjectDetails.ProjectID)#"/>
<input type="hidden" name="documentID" value="#url.documentID#" />
<input type="hidden" name="projectmode" value="#url.projectmode#" />
<input type="hidden" name="ProjectCategoryID" value="#url.ProjectCategoryID#" />
<input type="submit" value="add comment" onclick="validate(commentform); return false;" />

</form>
<hr />	
    
</cfoutput>