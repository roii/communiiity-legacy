 <cfoutput>


 <cfif DocumentDetails.PublicView CONTAINS 1>
 
 <cfelse>
 
	 <cfif session.UserIsAuthenticated EQ 'no'>
	 
		 <script>
		alert("You must be a #TRIM(AllSettings.SiteName)# member and logged-in to access this part of the website.test");
		self.location="javascript:history.back();";
		</script>
		<cfabort>
	
	</cfif>
 
 </cfif>
 
 
 <cfinclude template="../templates/qry_contact_details.cfm">
 <cfinclude template="../templates/qry_all_countries.cfm">
 

<cfquery name="AllSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Schools.SchoolID, Schools.SchoolName
FROM Schools
WHERE Schools.CountryID=#ContactDetails.CountryID#
AND Schools.SchoolStatus LIKE 'Active'
ORDER BY SchoolName
</cfquery>

<cfquery name="AllCharities" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT OrganisationID, Organisation_Name
FROM Organisations
WHERE Organisations.Charity=1
AND Organisations.Organisation_Status LIKE '%Active%'
ORDER BY Organisation_Name
</cfquery>
 
 <cfset newdetails = DocumentDetails.details>

<cfset birthday= '1' & ' ' & '#DateFormat(ContactDetails.DateOfBirth, "mmmm")#' & ' ' & '#DateFormat(ContactDetails.DateOfBirth, "yyyy")#'>

<!--- DETERMINE CONTACT TYE FROM AGE --->
<cfset age = datediff('yyyy', birthday, localDateTime)>
 

<script>
function validateProfile(kidsReg) {


var email = kidsReg.EmailAddress.value;
var at = email.indexOf("@");		
var space = email.indexOf(" ");
var comma = email.indexOf(",");
var dot = email.indexOf(".");
var two_dots = email.indexOf("..");
var length = email.length -1;


<cfif TRIM(ContactDetails.Screenname) EQ ''>

	var SName = kidsReg.ScreenName.value;

	if (kidsReg.ScreenName.value == "") {
	alert("You must enter your Screen Name.");
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

<cfelse>

	if (kidsReg.FirstName.value == "") {
	alert("You must enter your First Name.");
	kidsReg.FirstName.focus();
	return;
	} 

</cfif>



else if (kidsReg.LastName.value == "") {
	alert("You must enter your Last Name.");
	kidsReg.LastName.focus();
	return;
	} 

else if (kidsReg.gender.selectedIndex == "0") {
	alert("Please select your gender.");
	kidsReg.gender.focus();
	return;
	}
	

	
else if ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
	alert("Please enter a valid Email Address.");
	kidsReg.EmailAddress.focus();
	return;
	}

else if (kidsReg.EmailAddress.value != kidsReg.ConfirmEmailAddress.value) {
	alert("The two email addresses you entered do not match.");
	kidsReg.ConfirmEmailAddress.focus();
	return;
	} 

else if (kidsReg.CountryID.selectedIndex == "0") {
	alert("Please select your country.");
	kidsReg.CountryID.focus();
	return;
	}
	
<cfif AllSchools.RecordCount>
	else if (kidsReg.SchoolID.selectedIndex == "0") {
		alert("Please select your school.");
		kidsReg.SchoolID.focus();
		return;
		}
</cfif>

<cfif age LTE 16>


var email2 = kidsReg.ParentEmail.value;
var at2 = email2.indexOf("@");		
var space2 = email2.indexOf(" ");
var comma2 = email2.indexOf(",");
var dot2 = email2.indexOf(".");
var two_dots2 = email2.indexOf("..");
var length2 = email2.length -1;
	 
else if (kidsReg.ParentName.value == "") {
	alert("You must enter your Parent/Guardian Name.");
	kidsReg.ParentName.focus();
	return;
	} 
	
else if ((at2 == -1)||(at2 == 0)||(at2 == length2)||(space2 != -1)||(comma2 != -1)||(two_dots2 != -1)||(dot2 == -1)||(dot2 == length2)||(dot2 == 0)) {
	alert("Please enter a valid Parent/Guardian Email Address.");
	kidsReg.ParentEmail.focus();
	return;
	}
	
</cfif>



else if (kidsReg.Charity.selectedIndex == "0") {
	alert("Please select a charity to support.");
	kidsReg.Charity.focus();
	return;
	}
	

else if (kidsReg.Profile_Password.value == "") {
	alert("You must enter your Password.");
	kidsReg.Profile_Password.focus();
	return;
	} 
	
	
else if (kidsReg.Profile_Password.value != kidsReg.ConfirmPassword.value) {
	alert("The two passwords you entered do not match.");
	kidsReg.ConfirmPassword.focus();
	return;
	} 
	
else {
	kidsReg.submit(); //submit form
	}
	
}
</script>
			
<cfset newdetails=DocumentDetails.details>

 
<script language="JavaScript">
function changeSchool(selectedSID){
  if (selectedSID != "0" && selectedSID != "9999998"){
     hide('school1');
	  hide('school2');
	  hide('school3');
	  hide('school4');
	  hide('school5');
  }
  else {
      show('school1');
	  show('school2');   
	  show('school3');   
	  show('school4');  
	  show('school5');
  }


}


function changeCountry(selectedCID){
  if (selectedCID != "137"){
     hide('Region');
     hide('District');
     hide('Suburb');
     show('CityTown');
  }
  else {
     show('Region');
     show('District');
     show('Suburb');
     hide('CityTown');
  }


}

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


function changeRegion(region) {
	var arr = Regions[region];
	if (arr == null)
		arr = new Array();
	var opt = document.forms.kidsReg["districtID"].options;
	opt.length = 0;
	opt[0] = new Option("- Select a District -", "0");
	for (var i=0;i<arr.length;i++)
		opt[opt.length] = new Option(arr[i].text, arr[i].value);
}
function changeDistrict(district) {
	var arr = Districts[district];
	if (arr == null)
		arr = new Array();
	var opt = document.forms.kidsReg["suburbID"].options;
	opt.length = 0;
	opt[0] = new Option("- Select a Suburb -", "0");
	for (var i=0;i<arr.length;i++)
		opt[opt.length] = new Option(arr[i].text, arr[i].value);
}


var districts= null;
var Regions = new Array();
var Districts=new Array();
var suburbs = null;

<cfloop query="AllRegion">
    districts= new Array();
	Regions["#regionid#"] = districts;
   <cfquery name="AllDistrict" datasource="#dsn#" username="#request.username#" password="#request.password#">
     SELECT * FROM District where regionid = #AllRegion.regionid# ORDER BY District
   </cfquery>

   <cfloop query="AllDistrict">     
      suburbs= new Array();
        Districts["#districtid#"] = suburbs;
	districts[districts.length] = new Option("#district#", "#districtid#"); 

     <cfquery name="AllSuburb" datasource="#dsn#" username="#request.username#" password="#request.password#">
       SELECT * FROM Suburb where districtid = #AllDistrict.districtid# ORDER BY Suburb
     </cfquery>

     <cfloop query="AllSuburb">
        suburbs[suburbs.length] = new Option("#suburb#","#suburbid#");
     </cfloop> 

   </cfloop>
</cfloop>

</script>



<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(DocumentDetails.Title))#</strong></td>
<td align="right" width="30"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_document_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&documentID=#DocumentID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=550,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit" border="0"></a>&nbsp;<a href="javascript:confirmDocumentDelete('#request.webroot#/admin/act_document_delete.cfm?documentID=#documentID#&fuseaction=#attributes.fuseaction#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete" border="0"></a></cfif></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>


<form name="kidsReg" action="#request.webroot#/profile/act_profile_personal.cfm" method="post" onsubmit="validateProfile(kidsReg); return false;">

<input type="hidden" name="current_RegionID" value="#ContactDetails.RegionID#">
<input type="hidden" name="current_DistrictID" value="#ContactDetails.DistrictID#">
<input type="hidden" name="current_SuburbID" value="#ContactDetails.SuburbID#">
<input type="hidden" name="current_SchoolID" value="#ContactDetails.SchoolID#">
<input type="hidden" name="current_Charity" value="#ContactDetails.Charity#">
<input type="hidden" name="current_City" value="#ContactDetails.City#">

<tr>
<td colspan="2">

	<cfif TRIM(ContactDetails.Screenname) EQ ''>
		
		<table cellSpacing="1" cellPadding="0" bgcolor="##b4b4b4" border="0" width="500">
	
		<tr>
		<td>
		
			<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
			
			<tr>
			<td>
			
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
				<td width="100%"></td>
				</tr>
				
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Screen Name *</td>
				<td valign="top" style="font-size:11px;"><input type="text" name="ScreenName" class="whitefield" maxlength="15"<cfif TRIM(ContactDetails.Screenname) NEQ ''> value="#TRIM(ContactDetails.Screenname)#" disabled style="width:250px;color:909090;"<cfelse>  style="width:250px;"</cfif>></td>
				</tr>
				
				<tr>
				<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
				</tr>
			
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" valign="top" colspan="2">
				<em>
				<li>This is how you will be known to other members and can't be changed!
				<li>Can be up to 15 characters in length
				</em>
				</td>
				</tr>				
				
				</table>
				
				
			</td>
			</tr>
			
			</table>
		
		</td>
		</tr>
		
		</table><br>
				
	
	</cfif>
		

	
	
	<table cellSpacing="1" cellPadding="0" bgcolor="##b4b4b4" border="0" width="500">

	<tr>
	<td>
	
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
									
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">First Name *</td>
			<td><input type="text" name="FirstName" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.FirstName)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Last Name *</td>
			<td><input type="text" name="LastName" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.LastName)#"></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Gender *</td>
			<td><select name="gender" class="whitefield">
			<option value="0">-- Please select --
			<option value="m"<cfif ContactDetails.Gender EQ 'm'> selected</cfif>>Male
			<option value="f"<cfif ContactDetails.Gender EQ 'f'> selected</cfif>>Female
			</select></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			
			<input type="hidden" name="currentEmail" value="#TRIM(contactdetails.EmailAddress)#">
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Email Address *</td>
			<td><input type="text" name="EmailAddress" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.EmailAddress)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Confirm Email *</td>
			<td><input type="text" name="ConfirmEmailAddress" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.EmailAddress)#"></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<input type="hidden" name="currentMobilePhone" value="#TRIM(contactdetails.mobilePhone)#">
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Mobile Number</td>
			<td><input type="text" name="MobilePhone" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.MobilePhone)#"> &nbsp; <a href="#request.webroot#/templates/dsp_sms_numbers.cfm" target="smsnum" onclick="fdbackwindow=window.open ('','smsnum','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=350,top=10,left=10')" style="font-size:11px;">How to enter your number</a></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr id="CityTown" <cfif ContactDetails.CountryID EQ 137>style="display:none"</cfif>>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">City/Town</td>
			<td><input type="text" name="City" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.City)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Country</td>
			<td><select name="CountryID" class="whitefield" style="width:250px;" onchange="changeCountry(this.options[this.selectedIndex].value)">
			<option value="0"<cfif ContactDetails.CountryID EQ 0> selected</cfif>>-- Please select --
			<option value="0">---------------------
			<option value="137">New Zealand
			<option value="0">---------------------
			<cfloop query="allCountries"><cfif Allcountries.CountryID NEQ 0>
			<option value="#allcountries.countryID#"<cfif ContactDetails.CountryID EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#</cfif></cfloop></select></td>
			</tr>
			
			<tr id="Region" <cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Region</td>
			<td><select name="regionid" class="whitefield" style="width:250px;" onChange="changeRegion(this.options[this.selectedIndex].value)" size=1> 
			<option value="0">Select a Region</option>
			<cfloop query="allRegion">
			<cfif ContactDetails.regionid EQ allRegion.regionid>
				<option value="#regionid#" selected>#region#</option>
			<cfelse>
				<option value="#regionid#">#region#</option>
			</cfif>
			</cfloop>
			</select><BR></td>
			</tr>

			<tr id="District" <cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">District</td>
			<td><SELECT size="1" name="districtID" class="whitefield" style="width:250px;" onchange="changeDistrict(this.options[this.selectedIndex].value)">
			<cfif IsNumeric("#ContactDetails.regionid#") AND ContactDetails.regionid NEQ 0>
			
				<cfquery name="allDistrict" datasource="#dsn#" username="#request.username#" password="#request.password#">
				  select * from district where regionid = #ContactDetails.regionid# order by district
				</cfquery>
				<cfloop query="allDistrict">
				  <cfif ContactDetails.districtid EQ allDistrict.districtid>
				    <option value="#allDistrict.districtid#" selected>#allDistrict.district#</option>
				  <cfelse>
				    <option value="#allDistrict.districtid#">#allDistrict.district#</option>
				  </cfif>
				</cfloop>
			
			<cfelse>
				<OPTION value="0" selected>- Select a Region first -</option>
			</cfif>
			</select>
			</td>
			</tr>

			<tr id="Suburb" <cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Suburb</td>
			<td><select size="1" name="suburbID" class="whitefield" style="width:250px;">
			<cfif IsNumeric("#ContactDetails.districtid#") AND ContactDetails.districtid NEQ 0>
				
				<cfquery name="allSuburb" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT * 
				FROM suburb 
				WHERE districtid = #ContactDetails.districtid#
				ORDER BY suburb
			  </cfquery>
			  
			  <cfloop query="allSuburb">
			  
			  <cfif ContactDetails.suburbid EQ allSuburb.suburbid>
			    <option value="#allSuburb.suburbid#" selected>#allSuburb.suburb#</option>
			  <cfelse>
			    <option value="#allSuburb.suburbid#">#allSuburb.suburb#</option>
			  </cfif>
			  
			  </cfloop>
			  
			<cfelse>
			  <OPTION value="0" selected>- Select a District first -</option>
			</cfif>
			</select>
			 </td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<cfif AllSchools.RecordCount>
			
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">School *</td>
				<td><select name="SchoolID" class="whitefield" style="width:250px;" onchange="changeSchool(this.options[this.selectedIndex].value)">
				<option value="0">-- Please select --
				<option value="9999998">-- MY SCHOOL IS MISSING --
				<option value="9999999"<cfif ContactDetails.SchoolID EQ 9999999> selected</cfif>>-- I DON'T GO TO SCHOOL --
				<cfloop query="AllSchools">
				<option value="#AllSchools.SchoolID#"<cfif ContactDetails.SchoolID EQ AllSchools.SchoolID> selected</cfif>>#TRIM(AllSchools.SchoolName)#</cfloop>
				</select></td>
				</tr>
				
				<cfif ContactDetails.SchoolID EQ 0>
				<tr id="school1" style="display:show;">
				<cfelse>
				<tr id="school1" style="display:none;">
				</cfif>
				<td colspan="2" style="color:black;"><br><strong>If your school is missing from the list above...</strong></td>
				</tr>
				
				<cfif ContactDetails.SchoolID EQ 0>
				<tr id="school2" style="display:show;">
				<cfelse>
				<tr id="school2" style="display:none;">
				</cfif>
				<td colspan="2" style="color:black;"><br></td>
				</tr>
				
				<input type="hidden" name="Current_School_Other" value="#TRIM(contactdetails.School_Other)#">
				<cfif ContactDetails.SchoolID EQ 0>
				<tr id="school3" style="display:show;">
				<cfelse>
				<tr id="school3" style="display:none;">
				</cfif>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Name</td>
				<td><input type="text" name="School_Other" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other)#"></td>
				</tr>
				
				<cfif ContactDetails.SchoolID EQ 0>
				<tr id="school4" style="display:show;">
				<cfelse>
				<tr id="school4" style="display:none;">
				</cfif>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Phone</td>
				<td><input type="text" name="School_Other_Phone" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other_Phone)#"></td>
				</tr>
				
				<cfif ContactDetails.SchoolID EQ 0>
				<tr id="school5" style="display:show;">
				<cfelse>
				<tr id="school5" style="display:none;">
				</cfif>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Address</td>
				<td><input type="text" name="School_other_Address" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_other_Address)#"></td>
				</tr>
			
			<cfelse>
			
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Name</td>
				<td><input type="text" name="School_Other" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other)#"></td>
				</tr>
				
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Phone</td>
				<td><input type="text" name="School_Other_Phone" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other_Phone)#"></td>
				</tr>
				
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Address</td>
				<td><input type="text" name="School_other_Address" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_other_Address)#"></td>
				</tr>
			
			
			</cfif>
			
			
				
				
			
			<cfif age LTE 16>
			
				<tr>
				<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
				</tr>
				
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">Parent/Guardian Name *</td>
				<td><input type="text" name="ParentName" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.ParentsName)#"></td>
				</tr>
				
				<tr>
				<td style="color:###TRIM(AllSettings.DkTextColor)#;">Parent/Guardian Email *</td>
				<td><input type="text" name="ParentEmail" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.ParentsEmail)#"></td>
				</tr>
			
			</cfif>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table><br>
	
	
	<table cellSpacing="1" cellPadding="0" bgcolor="##b4b4b4" border="0" width="500">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Charity *</td>
			<td><select name="Charity" class="whitefield" style="width:250px;">
			<option value="0">-- Select a charity you would like to support --
			<cfloop query="AllCharities">
			<option value="#AllCharities.OrganisationID#"<cfif ContactDetails.Charity EQ AllCharities.OrganisationID> selected</cfif>>#TRIM(AllCharities.Organisation_Name)#</cfloop>
			</select></td>
			</tr>
						
			</table>
			
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table><br>
	
	
	
	<table cellSpacing="1" cellPadding="0" bgcolor="##b4b4b4" border="0" width="500">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Password *</td>
			<td><input type="password" name="Profile_Password" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.password)#" title="#TRIM(contactdetails.password)#"></td>
			</tr>
			
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Confirm Password *</td>
			<td><input type="password" name="ConfirmPassword" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.password)#"></td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td  colspan="2" style="color:###TRIM(AllSettings.DkTextColor)#;">
			<input type="checkbox" name="receiveEmail" <cfif contactdetails.receiveEmail EQ 1>checked</cfif>>
			Yes, I'd like to receive email newsletter from #TRIM(AllSettings.SiteName)#.</td>
			</tr>
			
			<tr>
			<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/update_button.gif"></td>
			</tr>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>


</td>
</tr>
</form>

</table>

</cfoutput>