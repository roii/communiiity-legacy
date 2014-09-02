<cfoutput>

	<cfquery name="AllOrgTypes" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT *
	FROM Questionnaire_OrganisationTypes
	WHERE Active=1
	ORDER BY OrgType
	</cfquery>
	
	<cfquery name="AllRoles" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT RoleID, RoleName
	FROM Questionairre_Roles
	ORDER BY RoleID
	</cfquery>
	
	<SCRIPT LANGUAGE="JavaScript">
	<!--
	function validate(Questionaire_Form) {    
	
	if (Questionaire_Form.Firstname.value == "") {
		alert("You must enter your First Name.");
		Questionaire_Form.Firstname.focus();
		return;
		} 
		
	else if (Questionaire_Form.Surname.value == "") {
		alert("You must enter your Surname.");
		Questionaire_Form.Surname.focus();
		return;
		}
		
	else if (Questionaire_Form.Email.value == "") {
		alert("You must enter your Email Address.");
		Questionaire_Form.Email.focus();
		return;
		}
		
	else if (Questionaire_Form.Email.value != Questionaire_Form.ConfirmEmail.value) {
		alert("The two email addresses you entered do not match.");
		Questionaire_Form.ConfirmEmail.focus();
		return;
		}
		
	else if (Questionaire_Form.BusinessTitle.value == "") {
		alert("You must enter your Business Title.");
		Questionaire_Form.BusinessTitle.focus();
		return;
		}
		
	else if (Questionaire_Form.Organisation.value == "") {
		alert("You must enter your Organisation Name.");
		Questionaire_Form.Organisation.focus();
		return;
		}
		
		
	else {
		Questionaire_Form.submit(); //submit form
		}
	}
	// -->
	</script>

	<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="e2e2e2">
	
	<tr>
	<td>
	
		
		<table width="100%" cellpadding="10" cellspacing="0" border="0" bgcolor="white">
	
		<tr>
		<td>
	
			
			<table border="0" cellpadding="0" cellspacing="2" width="100%">	
			
			<tr>
			<td colspan="2">
			
				<strong>Please register your details.</strong>
				
				<hr width="350" align="left" size="1" color="e2e2e2">
			
				<table width="350" border="0">
				
				<form method="post" action="#request.webroot#/survey/act_register.cfm" name="Questionaire_Form" onsubmit="validate(Questionaire_Form); return false;">
				
				<tr>
				<td>Title:</td>
				<td><select class="whitefield" align="absmiddle" style="width:200px;" name="Title">
				<option value="Mr"> Mr
				<option value="Mrs"> Mrs
				<option value="Ms"> Ms
				<option value="Miss"> Miss
				<option value="Dr"> Dr
				<option value="Sir"> Sir
				<option value="Lady"> Lady				
				</select> *</td>
				</tr>
				
				<tr>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="10" border="0"></td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="10" border="0"></td>
				</tr>
				
				<tr>
				<td>First name:</td>
				<td><input type="text" class="whitefield" align="absmiddle" style="width:200px;" name="Firstname"> *</td>
				</tr>
				
				<tr>
				<td>Last name:</td>
				<td><input type="text" class="whitefield" align="absmiddle" style="width:200px;" name="Surname"> *</td>
				</tr>
				
				<tr>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="10" border="0"></td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="10" border="0"></td>
				</tr>
				
				<tr>
				<td>Email Address:</td>
				<td><input type="text" class="whitefield" align="absmiddle" style="width:200px;" name="Email"> *</td>
				</tr>
				
				<tr>
				<td>Confirm Email:</td>
				<td><input type="text" class="whitefield" align="absmiddle" style="width:200px;" name="ConfirmEmail"> *</td>
				</tr>
				
				<tr>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="10" border="0"></td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="10" border="0"></td>
				</tr>
				
				<tr>
				<td>Role:</td>
				<td><select class="whitefield" align="absmiddle" style="width:200px;" name="RoleID">
				<cfloop query="AllRoles">
				<option value="#AllRoles.RoleID#"> #TRIM(AllRoles.RoleName)#
				</cfloop>			
				</select> *</td>
				</tr>
				
				<tr>
				<td>Business Title:</td>
				<td><input type="text" class="whitefield" align="absmiddle" style="width:200px;" name="BusinessTitle"> *</td>
				</tr>
				
				<tr>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="10" border="0"></td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="10" border="0"></td>
				</tr>
				
				<tr>
				<td>Organisation:</td>
				<td><input type="text" class="whitefield" align="absmiddle" style="width:200px;" name="Organisation"> *</td>
				</tr>
				
				<tr>
				<td>Type:</td>
				<td><select class="whitefield" align="absmiddle" style="width:200px;" name="OrgTypeID">
				<cfloop query="AllOrgTypes">
				<option value="#AllOrgTypes.OrgTypeID#"> #TRIM(AllOrgTypes.OrgType)#
				</cfloop>			
				</select> *</td>
				</tr>
				
				<tr>
				<td>Healthcare Provider:</td>
				<td><input type="radio" class="whitefield" name="HealthcareProvider" style="border:0px;" value="1" checked> Yes &nbsp;&nbsp;&nbsp; <input type="radio" class="whitefield" name="HealthcareProvider" style="border:0px;" value="0"> No</td>
				</tr>
				
				<tr>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="10" border="0"></td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="10" border="0"></td>
				</tr>
				
				<tr>
				<td>OK to contact?</td>
				<td><input type="radio" class="whitefield" name="OKToContact" style="border:0px;" value="1" checked> Yes &nbsp;&nbsp;&nbsp; <input type="radio" class="whitefield" name="OKToContact" style="border:0px;" value="0"> No</td>
				</tr>
				
				<tr>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="100" height="10" border="0"></td>
				<td><img src="#request.imageroot#/transparent_spc.gif" width="250" height="10" border="0"></td>
				</tr>
				
				<tr>
				<td> </td>
				<td><input type="submit" class="whitefield" align="absmiddle" value="CONTINUE >>"></td>
				</tr>
				
				</form>
				
				</table>
				
			
			</td>
			</tr>
			
			</table>
		
			
		</td>
		</tr>
		
		</table>
	
	
	</td>
	</tr>
	
	</table>


</cfoutput>