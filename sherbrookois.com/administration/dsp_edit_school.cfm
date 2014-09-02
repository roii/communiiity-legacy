<cfinclude template="../templates/qry_all_countries.cfm">

<!--- GET ALL TEACHERS AND ADMINISTRATORS --->
<cfquery name="AllTeachers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, Lastname, EmailAddress
FROM Contacts
WHERE SchoolID=#SchoolID#
AND ContactTypeID IN (5,6)
ORDER BY FirstName
</cfquery>


<cfoutput>


<script language="JavaScript">
function changeCountry(selectedCID){
 if (selectedCID != "137"){
    hide('Region');
 show('State');
 }
 else {
    show('Region');
 hide('State');
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

function validate(AddSchool) {    

if (AddSchool.SchoolName.value == "") {
alert("You must enter a Name for this school.");
AddSchool.SchoolName.focus();
return;
} 

else if (AddSchool.LoginName.value == "") {
alert("You must enter a LoginName for this school.");
AddSchool.LoginName.focus();
return;
} 

else if (AddSchool.Password.value == "") {
alert("You must enter a Password for this school.");
AddSchool.Password.focus();
return;
} 	

else {
AddSchool.submit(); //submit form
}
}
// -->
</script>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form name="AddSchool" action="#request.webroot#/administration/act_edit_school.cfm" method="post" enctype="multipart/form-data">

<input type="hidden" name="schoolID" value="#schoolID#">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Name</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="SchoolName" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.SchoolName)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Phone</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="Phone" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.Phone)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Email Address</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="ContactEmail" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.ContactEmail)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Website URL</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="Website" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.Website)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Address 1</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="Address1" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.Address1)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Address 2</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="Address2" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.Address2)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" valign="top" width="110"><strong>City/Town</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="City" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.City)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Country</strong></td>
<td style="font-size:11px;color:##444444;"><select name="CountryID" class="whitefield" style="width:300px;" onchange="changeCountry(this.options[this.selectedIndex].value)">
<option value="137" selected>New Zealand
<option value="0">---------------------
<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif SchoolStuff.CountryID EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
<td colspan="2"></td>
</tr>



<tr id="Region">
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Region</strong></td>
<td style="font-size:11px;color:##444444;"><select name="regionID" class="whitefield" style="width:300px;" size=1> 
<option value="0">Select a Region</option>
<cfloop query="allRegion">
	<option value="#regionid#"<cfif SchoolStuff.RegionID EQ regionID> selected</cfif>>#region#</option>
</cfloop>
</select><BR></td>
</tr>

<tr id="State" style="display:none">
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>State/Region</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="State" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.State)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>No. of Students</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="NumberStudents" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.NumberStudents)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>No. of Staf</strong>f</td>
<td style="font-size:11px;color:##444444;"><input type="text" name="NumberStaff" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.NumberStaff)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>No. of Computers</strong></td>
<td style="font-size:11px;color:##444444;"><input type="text" name="NumberComputers" class="whitefield" style="width:300px;" value="#TRIM(SchoolStuff.NumberComputers)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Primary Contact</strong></td>
<td style="font-size:11px;color:##444444;"><select name="PrimaryContact" class="whitefield" style="width:300px;">
<option value="0">-- Please select --
<cfloop query="AllTeachers">
<option value="#AllTeachers.ContactID#"<cfif SchoolStuff.PrimaryContact Eq AllTeachers.ContactID> selected</cfif>>#TRIM(AllTeachers.Firstname)# #TRIM(AllTeachers.Lastname)#
</cfloop></select></td>
</tr>
	
<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Upload Replacement Logo</td>
<td><input type="file" name="LogoFile" class="whitefield" style="width:300px;"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Notes</strong></td>
<td style="font-size:11px;color:##444444;"><textarea name="Notes" class="whitefield" rows="5" style="width:300px;">#TRIM(SchoolStuff.Notes)#</textarea></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td> </td>
<td style="font-size:11px;color:##444444;"><input type="submit" onclick="javascript:validate(AddSchool); return false;" value="UPDATE SCHOOL NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
</tr>

</form>

</table><br><br>


</cfoutput>