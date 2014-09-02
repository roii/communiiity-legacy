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
function validate(AddPartner) {

if (AddPartner.Organisation_Name.value == "") {
	alert("You must enter a Name for this Partner.");
	AddPartner.Organisation_Name.focus();
	return;
	} 
	
else {
	AddPartner.submit(); //submit form
	}
}
// -->
</script>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form name="AddPartner" action="#request.webroot#/administration/act_edit_partner.cfm" method="post" onsubmit="javascript:validate(AddPartner); return false;" enctype="multipart/form-data">

<input type="hidden" name="organisationID" value="#OrganisationID#">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Partner Name</td>
<td><input type="text" name="Organisation_Name" class="whitefield" style="width:300px;" value="#TRIM(PartnerStuff.Organisation_Name)#"></td>
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
<td><input type="text" name="WorkPhone" class="whitefield" style="width:300px;" value="#TRIM(PartnerStuff.WorkPhone)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Website URL</td>
<td><input type="text" name="WebsiteURL" class="whitefield" style="width:300px;" value="#TRIM(PartnerStuff.WebsiteURL)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Address 1</td>
<td><input type="text" name="Address1" class="whitefield" style="width:300px;" value="#TRIM(PartnerStuff.Address1)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Address 2</td>
<td><input type="text" name="Address2" class="whitefield" style="width:300px;" value="#TRIM(PartnerStuff.Address2)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">City/Town</td>
<td><input type="text" name="City" class="whitefield" style="width:300px;" value="#TRIM(PartnerStuff.City)#"></td>
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
<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif PartnerStuff.CountryID EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select></td>
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
	<option value="#allRegion.regionid#"<cfif PartnerStuff.regionid EQ allRegion.regionid> selected</cfif>>#region#</option>
</cfloop>
</select><BR></td>
</tr>

<tr id="State" style="display:none">
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">State/Region</td>
<td><input type="text" name="State" class="whitefield" style="width:300px;" value="#TRIM(PartnerStuff.State)#"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>



<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110" valign="top">Notes</td>
<td><textarea name="Notes" class="whitefield" rows="5" style="width:300px;">#TRIM(PartnerStuff.Notes)#</textarea></td>
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
<option value="#AllStaff.ContactID#"<cfif PartnerStuff.PrimaryContactID EQ AllStaff.ContactID> selected</cfif>>#TRIM(AllStaff.Firstname)# #TRIM(AllStaff.Lastname)#
</cfloop></select></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;" width="110">Partner Status</td>
<td><select name="Organisation_Status" class="whitefield" style="width:300px;">
<option value="Active" <cfif PartnerStuff.Organisation_Status EQ 'Active'> selected</cfif>>Active
<option value="Inactive" <cfif PartnerStuff.Organisation_Status EQ 'Inactive'> selected</cfif>>Inactive
</select></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td> </td>
<td><input type="submit" value="UPDATE PARTNER NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:location='#request.webroot#/administration/dsp_edit_Partner_popup.cfm?organisationID=#OrganisationID#';" value="CANCEL >>" class="whitefield"></td>
</tr>

</form>

</table><br><br>



</cfoutput>