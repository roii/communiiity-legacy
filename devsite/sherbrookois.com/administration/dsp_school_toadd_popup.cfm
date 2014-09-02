<cfinclude template="../templates/qry_all_countries.cfm">

<cfquery name="AllSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID, SchoolName
FROM Schools
WHERE Schools.SchoolStatus LIKE '%Active%'
ORDER BY SchoolName
</cfquery>

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Add School</title>
<cfinclude template="../templates/styles.cfm">
	
	

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
</script>

	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Add School</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="MoveSchool" action="#request.webroot#/administration/act_school_exists.cfm" method="post">
	<input type="hidden" name="ContactID" value="#ContactID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><strong>THE SCHOOL EXISTS ALREADY</strong> - Select below
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Select:</td>
	<td><select class="whitefield" name="SchoolID" style="width:300px;">
	<cfloop query="AllSchools">
	<option value="#AllSchools.SchoolID#">#TRIM(AllSchools.SchoolName)#
	</cfloop>
	</select> <input type="submit" class="whitefield" value="UPDATE NOW >>"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	</form>
	
	</table><br><br>
	
		

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="AddSchool" action="#request.webroot#/administration/act_school_toadd.cfm" method="post" enctype="multipart/form-data">
	<input type="hidden" name="ContactID" value="#ContactID#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><strong>THE SCHOOL DOES NOT EXIST</strong> - Create New School below<br>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">School Name</td>
	<td><input type="text" name="SchoolName" class="whitefield" style="width:300px;" value="#SchoolName#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Phone</td>
	<td><input type="text" name="Phone" class="whitefield" style="width:300px;" value="#Phone#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Website URL</td>
	<td><input type="text" name="Website" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Address 1</td>
	<td><input type="text" name="Address1" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Address 2</td>
	<td><input type="text" name="Address2" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" valign="top" width="110">City/Town</td>
	<td><input type="text" name="City" class="whitefield" style="width:300px;" value="#City#"></td>
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
	<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif ThisCountryID EQ allCountries.CountryID> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
	<td colspan="2"></td>
	</tr>
	
	
	
	<tr id="Region" style="display:none">
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Region</td>
	<td><select name="regionID" class="whitefield" style="width:300px;" size=1> 
	<option value="0">Select a Region</option>
	<cfloop query="allRegion">
		<option value="#regionid#">#region#</option>
	</cfloop>
	</select><BR></td>
	</tr>
	
	<tr id="State">
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">State/Region</td>
	<td><input type="text" name="State" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Number of Students</td>
	<td><input type="text" name="NumberStudents" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Number of Staff</td>
	<td><input type="text" name="NumberStaff" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Number of Computers</td>
	<td><input type="text" name="NumberComputers" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">Upload Logo</td>
	<td><input type="file" name="LogoFile" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110" valign="top">Notes</td>
	<td><textarea name="Notes" class="whitefield" rows="5" style="width:300px;"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" onclick="javascript:validate(AddSchool); return false;" value="ADD SCHOOL NOW >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>