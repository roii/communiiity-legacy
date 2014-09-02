<!--- GET TEACHER DETAILS --->
<cfquery name="TeacherStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>


<cfoutput>

<script>
function validateProfile(TeacherReg) {
 
var email = TeacherReg.EmailAddress.value;
var at = email.indexOf("@");		
var space = email.indexOf(" ");
var comma = email.indexOf(",");
var dot = email.indexOf(".");
var two_dots = email.indexOf("..");
var length = email.length -1;

	

if (TeacherReg.FirstName.value == "") {
	alert("You must enter your First Name.");
	TeacherReg.FirstName.focus();
	return;
	} 

else if (TeacherReg.LastName.value == "") {
	alert("You must enter your Last Name.");
	TeacherReg.LastName.focus();
	return;
	} 

	
else if ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
	alert("Please enter a valid Email Address.");
	TeacherReg.EmailAddress.focus();
	return;
	}


else if (TeacherReg.Profile_Password.value == "") {
	alert("You must enter your Password.");
	TeacherReg.Profile_Password.focus();
	return;
	} 
	
	
else if (TeacherReg.Profile_Password.value != TeacherReg.ConfirmPassword.value) {
	alert("The two passwords you entered do not match.");
	TeacherReg.ConfirmPassword.focus();
	return;
	} 
	
else {
	TeacherReg.submit(); //submit form
	}
	
}
</script>
			
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form name="TeacherReg" action="#request.webroot#/administration/act_edit_teacher.cfm" method="post">

<input type="hidden" name="schoolID" value="#schoolID#">
<input type="hidden" name="ContactID" value="#ContactID#">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>First Name</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="FirstName" class="whitefield" style="width:300px;" value="#TRIM(TeacherStuff.FirstName)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Last Name</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="LastName" class="whitefield" style="width:300px;" value="#TRIM(TeacherStuff.LastName)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Email Address</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="EmailAddress" class="whitefield" style="width:300px;" value="#TRIM(TeacherStuff.EmailAddress)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Password</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="Profile_Password" class="whitefield" style="width:300px;" value="#TRIM(TeacherStuff.Password)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Confirm Password</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="ConfirmPassword" class="whitefield" style="width:300px;" value="#TRIM(TeacherStuff.Password)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td> </td>
<td style="font-size:11px;color:##444444;"><input type="submit" onclick="javascript:validateProfile(TeacherReg); return false;" value="UPDATE NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
</tr>

</form>

</table><br><br>


</cfoutput>