<cfinclude template="../templates/qry_all_countries.cfm">

<!--- GET ALL STAFF --->
<cfquery name="AllStaff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, Lastname, EmailAddress
FROM Contacts
WHERE OrganisationID=#OrganisationID#
AND ContactStatus = 'Active'
ORDER BY FirstName
</cfquery>

<cfoutput>

<script language="JavaScript">
<!--
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
// -->

<!--
function validate(AddCharity) {

if (AddCharity.Organisation_Name.value == "") {
	alert("You must enter a Name for this charity.");
	AddCharity.Organisation_Name.focus();
	return;
	} 
	
else {
	AddCharity.submit(); //submit form
	}
}
// -->
</script>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form name="AddCharity" action="#request.webroot#/administration/act_edit_charity.cfm" method="post" onsubmit="javascript:validate(AddCharity); return false;" enctype="multipart/form-data">

<input type="hidden" name="organisationID" value="#OrganisationID#">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Charity Name</td>
<td><input type="text" name="Organisation_Name" class="whitefield" style="width:300px;" value="#TRIM(CharityStuff.Organisation_Name)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Logo</td>
<td><input type="file" name="LogoFile" class="whitefield" style="width:300px;"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Phone</td>
<td><input type="text" name="WorkPhone" class="whitefield" style="width:300px;" value="#TRIM(CharityStuff.WorkPhone)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Website URL</td>
<td><input type="text" name="WebsiteURL" class="whitefield" style="width:300px;" value="#TRIM(CharityStuff.WebsiteURL)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Address 1</td>
<td><input type="text" name="Address1" class="whitefield" style="width:300px;" value="#TRIM(CharityStuff.Address1)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Address 2</td>
<td><input type="text" name="Address2" class="whitefield" style="width:300px;" value="#TRIM(CharityStuff.Address2)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">City/Town</td>
<td><input type="text" name="City" class="whitefield" style="width:300px;" value="#TRIM(CharityStuff.City)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Country</td>
<td><select name="CountryID" class="whitefield" style="width:300px;" onchange="changeCountry(this.options[this.selectedIndex].value)">
<option value="137">New Zealand
<option value="0">---------------------
<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif CharityStuff.CountryID EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
<td colspan="2"></td>
</tr>



<tr id="Region">
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Region</td>
<td><select name="regionID" class="whitefield" style="width:300px;" size=1> 
<option value="0">Select a Region</option>
<cfloop query="allRegion">
	<option value="#allRegion.regionid#"<cfif CharityStuff.regionid EQ allRegion.regionid> selected</cfif>>#region#</option>
</cfloop>
</select><BR></td>
</tr>

<tr id="State" style="display:none">
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">State/Region</td>
<td><input type="text" name="State" class="whitefield" style="width:300px;" value="#TRIM(CharityStuff.State)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>



<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110" valign="top">Notes</td>
<td><textarea name="Notes" class="whitefield" rows="5" style="width:300px;">#TRIM(CharityStuff.Notes)#</textarea></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Primary Contact</td>
<td><select name="PrimaryContactID" class="whitefield" style="width:300px;">
<option value="0">-- Please select --
<cfloop query="AllStaff">
<option value="#AllStaff.ContactID#"<cfif CharityStuff.PrimaryContactID EQ AllStaff.ContactID> selected</cfif>>#TRIM(AllStaff.Firstname)# #TRIM(AllStaff.Lastname)#
</cfloop></select></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td> </td>
<td><input type="submit" value="UPDATE CHARITY NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:location='#request.webroot#/administration/dsp_edit_charity_popup.cfm?organisationID=#OrganisationID#';" value="CANCEL >>" class="whitefield"></td>
</tr>

</form>

</table><br><br>



</cfoutput>