<cfoutput>

<!--- SELECT ALL ORG CONTACTS --->
		
		<cfquery name="AllContacts" datasource="#OrganisationDSN#">
		SELECT ContactID, ContactFirstName, ContactLastName, ContactJobtitle, ContactEmailAddress, ContactTelephone, ContactFax, GuestLogin
		FROM OrganisationContacts
		WHERE OrganisationID=#OrganisationID#
		ORDER BY ContactLastName, ContactFirstName
		</cfquery>
	
	
	
	
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function validate(AddForm) {    
	
		var email = AddForm.ContactEmailAddress.value;
		var at = email.indexOf("@");		
		var space = email.indexOf(" ");
		var comma = email.indexOf(",");
		var dot = email.indexOf(".");
		var two_dots = email.indexOf("..");
		var length = email.length -1;
		var badchar1 = email.indexOf("<");
		var badchar2 = email.indexOf(">");
		var badchar3 = email.indexOf("'");
		var badchar4 = email.indexOf('"');
		
		
		if (AddForm.ContactFirstName.value == "") {
		alert("You must enter a First Name.");
		AddForm.ContactFirstName.focus();
		return;
		} 
		
	else if (AddForm.ContactLastName.value == "") {
		alert("You must enter a Last Name.");
		AddForm.ContactLastName.focus();
		return;
		} 
		
	else if ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)||(badchar1 != -1)||(badchar2 != -1)||(badchar3 != -1)||(badchar4 != -1)) {
		alert("Please enter a valid Email Address.");
		AddForm.ContactEmailAddress.focus();
		return;
		}
		
	else if (AddForm.Password.value == "") {
		alert("You must enter a Password.");
		AddForm.Password.focus();
		return;
		} 
		
	else {
		AddForm.submit(); //submit form
		}
	}
	// -->
	
	
	<!--
	function confirmDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Organisation Contact?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<form method="post" action="act_contact_add.cfm" name="AddForm">
		<input type="hidden" name="OrganisationID" value="#OrganisationID#">
		
		<tr bgcolor="silver">
		<td width="25"><img src="#request.imageroot#/profile_arrows.gif" width="19" height="19" border="0"></td>
		<td><strong>A D D &nbsp; A &nbsp; C O N T A C T</strong></td>
		</tr>
		
		<tr>
		<td width="25"><img src="#request.imageroot#/transparent_spc.gif" width="25" height="1" border="0"></td>
		<td><br>
		
		
			<table width="100%" cellpadding="1" cellspacing="1" border="0">
			
			<tr>
			<td width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
			<td></td>
			<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
			<td width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
			<td></td>
			</tr>
			
			<tr>
			<td>First Name <font color="red">*</font></td>
			<td><input type="text" size="28" class="whitefield" name="ContactFirstName"></td>
			<td> </td>
			<td>Telephone</td>
			<td><input type="text" size="28" class="whitefield" name="ContactTelephone"></td>
			</tr>
			
			<tr>
			<td>Last Name <font color="red">*</font></td>
			<td><input type="text" size="28" class="whitefield" name="ContactLastName"></td>
			<td> </td>
			<td>Facsimile</td>
			<td><input type="text" size="28" class="whitefield" name="ContactFax"></td>
			</tr>
			
			<tr>
			<td>Job Title</td>
			<td><input type="text" size="28" class="whitefield" name="ContactJobtitle"></td>
			<td> </td>
			<td> </td>
			<td> </td>
			</tr>
			
			<tr>
			<td>Password <font color="red">*</font></td>
			<td><input type="password" size="28" class="whitefield" name="Password"></td>
			<td> </td>
			<td>Email Address <font color="red">*</font></td>
			<td><input type="text" size="28" class="whitefield" name="ContactEmailAddress"></td>
			</tr>
			
			
	
			<tr>
			<td colspan="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			<tr>
			<td><strong>Receive e-Bulletin Newsletter</strong></td>
			<td><input type="radio" class="small" name="ReceiveBulletin" value="1" checked> Yes &nbsp; <input type="radio" class="small" name="ReceiveBulletin" value="0"> No</td>
			<td> </td>
			<td> </td>
			<td> </td>
			</tr>
			
			<tr>
			<td colspan="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			<tr>
			<td>Primary Contact</td>
			<td><input type="radio" class="small" name="PrimaryContact" value="1"> Yes &nbsp; <input type="radio" class="small" name="PrimaryContact" value="0" checked> No</td>
			<td> </td>
			<td> </td>
			<td> </td>
			</tr>
			
			<tr>
			<td>Edit Profile Details</td>
			<td><input type="radio" class="small" name="AccessOrgProfile" value="1"> Yes &nbsp; <input type="radio" class="small" name="AccessOrgProfile" value="0" checked> No</td>
			<td> </td>
			<td> </td>
			<td> </td>
			</tr>
			
			<tr>
			<td colspan="5"><hr width="100%" size="1" color="e2e2e2"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td colspan="4"><br><input type="submit" class="whitefield" value="ADD CONTACT >>" onclick="validate(AddForm); return false;"> <input type="button" class="whitefield" value="CANCEL >>" onclick="javascript:location='dsp_organisation_edit.cfm?organisationID=#organisationID#';">&nbsp;&nbsp;</td>
			</tr>
			
			</table><br><br>
		
		</td>
		</tr>
		</form>
		
		
		<tr bgcolor="silver">
		<td width="25"><img src="#request.imageroot#/profile_arrows.gif" width="19" height="19" border="0"></td>
		<td><strong>C U R R E N T &nbsp; C O N T A C T S</strong></td>
		</tr>
		
		<tr>
		<td width="25"><img src="#request.imageroot#/transparent_spc.gif" width="25" height="1" border="0"></td>
		<td><br>
		
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<cfloop query="AllContacts">
			<tr>
			<td valign="top">#AllContacts.ContactLastName#, #AllContacts.ContactFirstName#<br>
			<span style="color:gray;">#AllContacts.ContactJobtitle#</span></td>
			<td valign="top"><a href="mailto:#AllContacts.ContactEmailAddress#">#AllContacts.ContactEmailAddress#</a></td>
			<td align="right"><a href="dsp_organisation_edit.cfm?organisationID=#organisationID#&ContactID=#AllContacts.ContactID#&editmode=contactedit"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Contact" border="0"></a>&nbsp;<cfif #AllContacts.GuestLogin# NEQ 1><a href="javascript:confirmDelete('act_delete_contact.cfm?organisationID=#organisationID#&contactID=#allContacts.ContactID#&caller=admin')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="" border="0"></a><cfelse><a href="#request.webroot#/admin/dsp_guestlogin_script.cfm?ContactID=#AllContacts.ContactID#" target="guestscript" ONCLICK="fdbackwindow=window.open ('','guestscript','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=15,left=15')"><img src="#request.imageroot#/but_link_icon.gif" width="10" height="10" alt="Get Login Script" border="0"></a></cfif></td>
			</tr>
			
			<tr>
			<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
			</tr>
			</cfloop>
			
			</table>
		
		
		
		
		</td>
		</tr>
		
		
		</table><br><br><br>
		
	</cfoutput>