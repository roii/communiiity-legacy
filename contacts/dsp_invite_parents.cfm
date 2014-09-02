<cfoutput>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="15" height="15"><img src="#request.imageroot#/contacts/invite_parent_tl.gif" width="15" height="15" alt="" border="0"></td>
<td height="15" background="#request.imageroot#/contacts/invite_parent_t.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" alt="" border="0"></td>
<td width="15" height="15"><img src="#request.imageroot#/contacts/invite_parent_tr.gif" width="15" height="15" alt="" border="0"></td>
</tr>


<cfif qry_parent_check.recordcount GT 0>

	<tr>
	<td width="15" background="#request.imageroot#/contacts/invite_parent_l.gif"><img src="#request.imageroot#/transparent_spc.gif" width="15" height="1" alt="" border="0"></td>
	<td bgcolor="##e2e2e2"><img src="#request.imageroot#/contacts/title.gif" width="408" height="36" alt="Invite your parent/guardians to join you on my3P!" border="0"><br>
	
		
		<cfif qry_parent_check.status CONTAINS 'Pending'>
			
			<script type="text/javascript">
			function validateParentInvite(ParentInviteForm) {
			
				if (ParentInviteForm.ParentName.value == "") {
				alert("Please enter your parents name");
				ParentInviteForm.ParentName.focus();
				return;	
				}
				
				else if (ParentInviteForm.ParentName.value == " name...") {
				alert("Please enter your parents name");
				ParentInviteForm.ParentName.focus();
				return;	
				}
				
				else if (ParentInviteForm.ParentEmail.value == "") {
				alert("Please enter your parents email address");
				ParentInviteForm.ParentEmail.focus();
				return;	
				}
				
				else if (ParentInviteForm.ParentEmail.value == " email...") {
				alert("Please enter your parents email address");
				ParentInviteForm.ParentEmail.focus();
				return;	
				}	
			 
				else {
				ParentInviteForm.submit(); //submit form
				}
			
			}
			</script>

		
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="42"><img src="#request.imageroot#/transparent_spc.gif" width="42" height="1" border="0"></td>
			<td style="color:##fd7922;"><strong>INVITE WAS LAST SENT ON... &nbsp; <span style="color:##444444;">#DateFormat(qry_parent_check.DateLastSent, "d mmmm yyyy")#</span> &nbsp; ...WAITING FOR PARENT/GUARDIAN REPLY</strong></td>
			</tr>
			
			
			<form name="ParentInviteForm" action="#request.webroot#/contacts/act_parent_resend.cfm" method="post" onsubmit="validateParentInvite(ParentInviteForm); return false;">
			<input type="hidden" name="ParentInviteID" value="#qry_parent_check.ParentInviteID#">
			<input type="hidden" name="PINNumber" value="#qry_parent_check.PINNumber#">
			<tr>
			<td width="42"><img src="#request.imageroot#/transparent_spc.gif" width="42" height="1" border="0"></td>
			<td style="color:##444444;">The invitation was sent to the person below. You can change the details and resend the<br>invite
			if you want to.<br>
			<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
			<input type="text" class="whitefield" name="ParentName" style="width:100px;color:##001D85;height:20px;" value="#TRIM(qry_parent_check.parentname)#" align="absmiddle"> &nbsp; <input type="text" class="whitefield" name="ParentEmail" style="width:160px;color:##001D85;height:20px;" value="#TRIM(qry_parent_check.EmailAddress)#" align="absmiddle"> &nbsp; <input type="text" class="whitefield" name="ParentPhone" style="width:100px;color:##001D85;height:20px;" value="#TRIM(qry_parent_check.MobileNumber)#" align="absmiddle"> &nbsp; <input type="image" src="#request.imageroot#/contacts/but_resend.gif" align="absmiddle"></td>
			</tr>
			</form>
			
			</table>
		
		<cfelseif qry_parent_check.status CONTAINS 'Activation'>
			
			
			<script type="text/javascript">
			function validateActivate(ActivateForm) {
				if (document.ActivateForm.VerifyInvite[0].checked == false && document.ActivateForm.VerifyInvite[1].checked == false) {
				alert("You must select an option.");
				return;
				}
				
				else {
				ActivateForm.submit();
				}
			
			}
			</script>
			
			
			<!--- GET CONTACT DETAILS --->
			<cfquery name="ParentStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT FirstName, LastName, EmailAddress, MobilePhone
			FROM Contacts
			WHERE ContactID=#qry_parent_check.ParentID#
			</cfquery>
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="42"><img src="#request.imageroot#/transparent_spc.gif" width="42" height="1" border="0"></td>
			<td style="color:##fd7922;"><strong>INVITE ACTIVATED... &nbsp; ...WAITING FOR YOUR VERIFICATION</strong></td>
			</tr>
			
			<tr>
			<td width="42"><img src="#request.imageroot#/transparent_spc.gif" width="42" height="1" border="0"></td>
			<td>
				
				
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td style="color:##444444;" colspan="2">The following person has activated your invitation...
				<hr width="100%" size="1" color="ffffff"></td>
				</tr>
				
				<tr>
				<td style="color:##444444;font-size:11px;" colspan="2">Date: <strong>#DateFormat(qry_parent_check.DateResponded, "d mmm yy")#</strong></td>
				</tr>
				
				<tr>
				<td style="color:##444444;font-size:11px;" colspan="2">Name: <strong>#TRIM(ParentStuff.FirstName)# #TRIM(ParentStuff.LastName)#</strong></td>
				</tr>
				
				<tr>
				<td style="color:##444444;font-size:11px;" colspan="2">Email: <strong>#TRIM(ParentStuff.EmailAddress)#</strong>
				<hr width="100%" size="1" color="ffffff"></td>
				</tr>
				
				<form method="post" action="#request.webroot#/contacts/act_verify_parent.cfm" name="ActivateForm" onsubmit="validateActivate(ActivateForm); return false;">

				<input type="hidden" name="ParentInviteID" value="#qry_parent_check.ParentInviteID#">
				<input type="hidden" name="ParentID" value="#qry_parent_check.ParentID#">
				
				<tr>
				<td><input type="radio" name="VerifyInvite" value="1"></td>
				<td style="color:##444444;font-size:11px;"><strong>VERIFY</strong> - This is my parent/guardian and I want to link them to my account</td>
				</tr>
				
				<tr>
				<td><input type="radio" name="VerifyInvite" value="0"></td>
				<td style="color:##444444;font-size:11px;"><strong>DO NOT VERIFY</strong> - I'm not sure who this is and I don't want to link them to my account</td>
				</tr>
				
				<tr>
				<td style="color:##444444;font-size:11px;" colspan="2"><hr width="100%" size="1" color="ffffff">
				<img src="#request.imageroot#/transparent_spc.gif" width="24" height="1" border="0"><input type="submit" class="whitefield" value="Update Invitation Status &raquo;"><br></td>
				</tr>
				
				</form>
				
				</table>
			
			
			</td>
			</tr>
			
			</table>
			
		</cfif>
	
	</td>
	<td width="15" background="#request.imageroot#/contacts/invite_parent_r.gif"></td>
	</tr>
	
	
<cfelse>

	<script type="text/javascript">
	function validateParentInvite(ParentInviteForm) {
	
		if (ParentInviteForm.ParentName.value == "") {
		alert("Please enter your parents name");
		ParentInviteForm.ParentName.focus();
		return;	
		}
		
		else if (ParentInviteForm.ParentName.value == " name...") {
		alert("Please enter your parents name");
		ParentInviteForm.ParentName.focus();
		return;	
		}
		
		else if (ParentInviteForm.ParentEmail.value == "") {
		alert("Please enter your parents email address");
		ParentInviteForm.ParentEmail.focus();
		return;	
		}
		
		else if (ParentInviteForm.ParentEmail.value == " email...") {
		alert("Please enter your parents email address");
		ParentInviteForm.ParentEmail.focus();
		return;	
		}	
	 
		else {
		ParentInviteForm.submit(); //submit form
		}
	
	}
	</script>
	
	<tr>
	<td width="15" background="#request.imageroot#/contacts/invite_parent_l.gif"><img src="#request.imageroot#/transparent_spc.gif" width="15" height="1" alt="" border="0"></td>
	<td bgcolor="##e2e2e2"><img src="#request.imageroot#/contacts/title.gif" width="408" height="36" alt="Invite your parent/guardians to join you on my3P!" border="0"><br>
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<form name="ParentInviteForm" action="#request.webroot#/contacts/act_parent_invite.cfm" method="post" onsubmit="validateParentInvite(ParentInviteForm); return false;">
		<tr>
		<td width="42"><img src="#request.imageroot#/transparent_spc.gif" width="42" height="1" border="0"></td>
		<td style="color:##444444;">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, 
	totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto.<br>
		<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
		<input type="text" class="whitefield" name="ParentName" style="width:100px;color:##001D85;height:20px;" value=" parent name..." onfocus="javascript:if (document.ParentInviteForm.ParentName.value == ' parent name...') {document.ParentInviteForm.ParentName.value = ''};" align="absmiddle"> &nbsp; <input type="text" class="whitefield" name="ParentEmail" style="width:160px;color:##001D85;height:20px;" value=" parent email..." onfocus="javascript:if (document.ParentInviteForm.ParentEmail.value == ' parent email...') {document.ParentInviteForm.ParentEmail.value = ''};" align="absmiddle"> &nbsp; <input type="text" class="whitefield" name="ParentPhone" style="width:100px;color:##001D85;height:20px;" value=" parent mobile..." onfocus="javascript:if (document.ParentInviteForm.ParentPhone.value == ' parent mobile...') {document.ParentInviteForm.ParentPhone.value = ''};" align="absmiddle"> &nbsp; <input type="image" src="#request.imageroot#/contacts/but_send.gif" align="absmiddle"></td>
		</tr>
		</form>
		
		</table>
		
	
	</td>
	<td width="15" background="#request.imageroot#/contacts/invite_parent_r.gif"></td>
	</tr>

</cfif>





<tr>
<td width="15" height="15"><img src="#request.imageroot#/contacts/invite_parent_bl.gif" width="15" height="15" alt="" border="0"></td>
<td height="15" background="#request.imageroot#/contacts/invite_parent_b.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" alt="" border="0"></td>
<td width="15" height="15"><img src="#request.imageroot#/contacts/invite_parent_br.gif" width="15" height="15" alt="" border="0"></td>
</tr>

</table><br><br>


</cfoutput>