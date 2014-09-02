<!--- 

	DJP - 05Oct11 - removed fields not required for new streamlined signup process.
	
 --->

<cfinclude template="../templates/qry_all_countries.cfm">

<script language="JavaScript">
/*
function validateAge(year_born) {
	var now = new Date();
	var year_now = now.getFullYear();
	var age = year_now-year_born;
	if (age < 16) {
      show('parentL');   
	  show('parentN');   
	  show('parentE');
	}
	else{
	  hide('parentL');
	  hide('parentN');
	  hide('parentE');
	}
} */

function show(targetId){ 
  if (document.getElementById){ 
        target = document.getElementById( targetId ); 
        target.style.display = ""; 
  } 
} 

function hide(targetId){ 
  if (document.getElementById){ 
        target = document.getElementById( targetId ); 
        target.style.display = "none"; 
  } 
}
</script> 

<script type="text/javascript">
function validate(kidsReg) {

var countryID = document.forms["kidsReg"].CountryID.options[document.forms["kidsReg"].CountryID.selectedIndex].value;

var SName = kidsReg.ScreenName.value;

if (kidsReg.ScreenName.value == "") {
	alert("You must enter your desired Screen Name.");
	kidsReg.ScreenName.focus();
	return;
	} 
	
else if (SName.indexOf(" ")!=-1){
	alert("You cannot use spaces in your Screen Name");
	kidsReg.ScreenName.focus();
	return;
	} 
	
else if (kidsReg.FirstName.value == "") {
	alert("You must enter your First Name.");
	kidsReg.FirstName.focus();
	return;
	} 
	 
else if (kidsReg.LastName.value == "") {
	alert("You must enter your Last Name.");
	kidsReg.LastName.focus();
	return;
	} 
	
else if (kidsReg.CountryID.selectedIndex == "0") {
	alert("Please select your country.");
	kidsReg.CountryID.focus();
	return;
	} 
	 
else if (kidsReg.Password.value == "") {
	alert("You must enter your Password.");
	kidsReg.Password.focus();
	return;
	}	
	
else if (kidsReg.Password.value != kidsReg.ConfirmPassword.value) {
	alert("The two passwords you entered do not match.");
	kidsReg.ConfirmPassword.focus();
	return;
	} 
	
else if (kidsReg.AcceptTerms.checked == false) {
	alert("You must accept the Terms of Use Agreement.");
	kidsReg.AcceptTerms.focus();
	return;
	} 

else {
	kidsReg.submit(); //submit form
	}
	
}
</script>
 
<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FirstName, LoginName, Password, MobilePhone
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>

<cfoutput>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#verifycomptext1#</strong></td>
<td align="right" width="30" height="20"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<tr>
<td colspan="2"><span style="color:###TRIM(AllSettings.DkTextColor)#"><strong>#verifycomptext2#</strong></span><br><br>
<ol>
<li>#verifycomptext3#</li>
<!--- <li>If you're under 16 we'll also send an email to your parent/guardian notifying them of your registration.</li> --->
<!--- <li>If you have a <strong>PROMOTION</strong> code or a <strong>REFERRAL</strong> code enter it below. If you're unsure which type of code you have just paste it into both fields and we'll check for you! ;-)</li> --->
</ol>
<br><br>
	
	<table cellSpacing="1" cellPadding="0" bgColor="##b4b4b4" border="0" width="100%">

	<tr>
	<td>	
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>		
		
			<table width="100%" cellpadding="2" cellspacing="0" border="0">
			
			<!---<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>--->
			
			<form name="kidsReg" action="#request.webroot#/join/act_register_step2.cfm" method="post">
			<input type="hidden" name="contactID" value="#contactID#">			
			
			<!---<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Screen Name<span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong><br></span></td>
			<td valign="top"><input type="text" name="ScreenName" class="whitefield" style="width:250px;"><br>
			<em>This is how you will be known to other members and can't be changed</em></td>
			</tr>--->
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>			
						
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">
			#firstNameText# <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><input type="text" name="FirstName" class="whitefield" style="width:250px;" value=""></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">
			#lastNameText# <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><input type="text" name="LastName" class="whitefield" style="width:250px;" value=""></td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<!--- <tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Mobile Number</td>
			<td><input type="text" name="MobilePhone" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.MobilePhone)#"> &nbsp; <a href="#request.webroot#/templates/dsp_sms_numbers.cfm" target="smsnum" onclick="fdbackwindow=window.open ('','smsnum','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=350,top=10,left=10')" style="font-size:11px;">How to enter your number</a></td>
			</tr> --->
			
			<!--- <tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr> --->			
			
			<!--- SET DATE RANGES FOR BIRTDATES FOR 9-70 year olds --->
			<!--- <cfset startBirthYear=DateAdd('yyyy',  -5,  localDateTime)> --->

			<!--- <tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Birthday <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><select name="DOB_month" class="whitefield" style="width:90px;">
			<option value="0" selected>---
			<cfloop from="1" to="12" index="monthLoop"><option value="#MonthAsString(monthloop)#">#MonthAsString(monthloop)#</cfloop></select> 
			<select name="DOB_Year" onchange="validateAge(this.options[this.selectedIndex].value)" class="whitefield" style="width:60px;"><option value="0" selected>---<cfloop from="1" to="100" index="LoopCount"><option value="#DateFormat(startBirthYear, "yyyy")#">#DateFormat(startBirthYear, "yyyy")#<cfset startBirthYear=DateAdd('yyyy',  -1,  startBirthYear)></cfloop></select></td>
			</tr> --->
			
			<!--- <tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr> --->
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">#CountryText# <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><select name="CountryID" class="whitefield" style="width:250px;">
			<option value="0">---------------------
			<cfloop query="allCountries"><cfif CountryID NEQ 152><option value="#allcountries.countryID#">#TRIM(allcountries.name)#</cfif></cfloop></select></td>
			</tr>
			
			<!--- <tr id="parentL" style="display:none;">
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr> --->
			
			<!--- <tr id="parentN" style="display:none;">
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Parent/Guardian Name <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><input type="text" name="ParentName" class="whitefield" style="width:250px;"></td>
			</tr> --->
			
			<!--- <tr id="parentE" style="display:none;">
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Parent/Guardian Email <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><input type="text" name="ParentEmail" class="whitefield" style="width:250px;"></td>
			</tr> --->
			
			<!--- <tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr> --->
			
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">#PasswordText# <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><input type="password" name="Password" class="whitefield" style="width:250px;"></td>
			</tr>
			
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">#CpasswordText# <span style="color:###TRIM(AllSettings.BoxColour)#;"><strong>*</strong></span></td>
			<td><input type="password" name="ConfirmPassword" class="whitefield" style="width:250px;"></td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<!--- <td style="color:###TRIM(AllSettings.DkTextColor)#;">Invitation Code</td>
			<td style="font-size:11px;">If you were invited to join by another 3P member,<br>
			enter the code here to get extra points...<br>
			<input type="text" name="ReferralCode" class="whitefield" style="width:250px;">
			</td>
			</tr> --->
			
			<!--- <tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr> --->
			
			<!--- <td style="color:###TRIM(AllSettings.DkTextColor)#;">Promotion Code</td>
			<td style="font-size:11px;">If you have a Promo Code to receive a special offer,<br>
			enter the code here...<br>
			<input type="text" name="PromoCode" class="whitefield" style="width:250px;">
			</td>
			</tr> --->
			
			<!--- <tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr> --->
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">#acceptterms#</td>
			<td valign="top">
			
				<table cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td valign="top"><input type="checkbox" name="AcceptTerms" class="whitefield" style="padding-right:5px;" value="1"></td>
				<td style="padding-left:4px;" valign="top">#readterms1#<br>
				<a href="#request.webroot#/index.cfm?fuseaction=terms">#readterms2#</a>. #readterms3#</td>
				</tr>
				
				</table>				
			
			</td>
			</tr>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>

			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/signup_button.gif" onclick="validate(kidsReg); return false;"></td>
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
<br><br>
</cfoutput>