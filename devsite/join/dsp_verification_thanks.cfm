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

//var SName = kidsReg.ScreenName.value; 

/*if (kidsReg.ScreenName.value == "") {
	alert("You must enter your desired Screen Name.");
	kidsReg.ScreenName.focus();
	return;
	} 
	
else if (SName.indexOf(" ")!=-1){
	alert("You cannot use spaces in your Screen Name");
	kidsReg.ScreenName.focus();
	return;
	} */
	
if (kidsReg.FirstName.value == "") {
	alert("You must enter your First Name.");
	kidsReg.FirstName.focus();
	return false;
	} 
	 
else if (kidsReg.LastName.value == "") {
	alert("You must enter your Last Name.");
	kidsReg.LastName.focus();
	return false;
	} 
	
else if (kidsReg.CountryID.selectedIndex == "0") {
	alert("Please select your country.");
	kidsReg.CountryID.focus();
	return false;
	} 
	 
else if (kidsReg.Password.value == "") {
	alert("You must enter your Password.");
	kidsReg.Password.focus();
	return false;
	}	
	
else if (kidsReg.Password.value != kidsReg.ConfirmPassword.value) {
	alert("The two passwords you entered do not match.");
	kidsReg.ConfirmPassword.focus();
	return false;
	} 
	
else if (kidsReg.AcceptTerms.checked == false) {
	alert("You must accept the Terms of Use Agreement.");
	kidsReg.AcceptTerms.focus();
	return false;
	} 

else {
	kidsReg.submit(); //submit form
	return true;
	}
	
}
</script>
 
<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FirstName, LoginName, Password, MobilePhone
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>

<cfoutput>

<form name="kidsReg" action="#request.webroot#/join/act_register_step2.cfm" method="post" class="form-signin" role="form" onsubmit="return validate(kidsReg);">
   <input type="hidden" name="contactID" value="#contactID#">
    
	<strong>#verifycomptext1#</strong> <br />
	<strong>#verifycomptext2#</strong></span><br><br>
	<ol>
	<li>#verifycomptext3#</li> 
	</ol>
	<br><br>
	
   <input type="text" name="FirstName" placeholder="First Name" class="form-control" value="" autofocus>
   <input type="text" name="LastName" class="form-control" placeholder="Last Name" value="" autofocus>
   <select name="CountryID" class="form-control">
		<option value="0">---------------------</option>
		    <cfloop query="allCountries">
			     <cfif CountryID NEQ 152>
			          <option value="#allcountries.countryID#">#TRIM(allcountries.name)#</option>
				 </cfif>
			</cfloop>
   </select>
   <input type="password" name="Password" class="form-control" placeholder="Password" value="" autofocus>
   <input type="password" name="ConfirmPassword" class="form-control" placeholder="Confirm Password" value="" autofocus>
   <input type="checkbox" name="AcceptTerms" class="form-control" value="1">
    #readterms1#<br>
   <a href="#request.webroot#/index.cfm?fuseaction=terms">#readterms2#</a>.<br />#readterms3# 
   <br />
   <button class="btn btn-lg btn-primary btn-block" type="submit" onclick="">Register Now</button>   
</form>

 
</cfoutput>