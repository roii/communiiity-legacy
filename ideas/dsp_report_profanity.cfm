<cfoutput>


	<script LANGUAGE="JavaScript">
	<!--
	function validate(reportform) {    
	
	if (reportform.Name.value == "") {
		alert("You must enter your Name.");
		reportform.Name.focus();
		return;
		} 
		
	else if (reportform.Email.value == "") {
		alert("You must enter your Email.");
		reportform.Email.focus();
		return;
		} 
		
	else if (reportform.LinkToURL.value == "") {
		alert("You must enter the URL to the bad content.");
		reportform.LinkToURL.focus();
		return;
		} 
		
	else {
		reportform.submit(); //submit form
		}
	}
	// -->
	</script>

	<table width="100%" border="0">
	
	<tr>
	<td valign="top">If you see any objectionable material in the <strong>IDEAfunL</strong> please report it to us using the form below for a reward.</td>
	</tr>
	
	</table>


	<form method="post" action="#request.webroot#/ideas/act_report_profanity.cfm" name="reportform">
	
	<cfif IsDefined("session.UerID")>
		<input type="hidden" name="UserID" value="#session.UserID#">
	</cfif>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Your Name</td>
	<td class="normal" valign="top"><input class="whitefield" style="width:300px;" name="Name"<cfif session.UserIsAuthenticated EQ 1> value="#session.User_FirstName# #session.User_LastName#"</cfif>></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Your Email</td>
	<td class="normal" valign="top"><input class="whitefield" style="width:300px;" name="Email"<cfif session.UserIsAuthenticated EQ 1> value="#session.User_Email#"</cfif>></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Link to the idea,<br>or the title of the idea,<br>containing bad content</td>
	<td class="normal" valign="top"><textarea class="whitefield" name="LinkToURL" rows="4" style="width:300px;"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" valign="top" width="150">Details</td>
	<td class="normal" valign="top"><textarea class="whitefield" name="Details" rows="4" style="width:300px;"></textarea></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td></td>
	<td><input type="submit" class="whitefield" value="SEND NOW >>>" onclick="validate(reportform); return false;"></td>
	</tr>
	
	
	
	</table>
	</form>
		
		
	

</cfoutput>
	
	


