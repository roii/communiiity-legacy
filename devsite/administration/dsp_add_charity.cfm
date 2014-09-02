<cfinclude template="../templates/qry_all_countries.cfm">

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<cfinclude template="../templates/set_language.cfm">
	<title>#TRIM(AllSettings.SiteName)# - #addacharity#</title>
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
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>#addacharity#</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
		
	<script language="JavaScript">
	<!--
	function validate(AddCharity) {    
		
	var email = AddCharity.EmailAddress.value;
	var at = email.indexOf("@");		
	var space = email.indexOf(" ");
	var comma = email.indexOf(",");
	var dot = email.indexOf(".");
	var two_dots = email.indexOf("..");
	var length = email.length -1;


	if (AddCharity.Organisation_Name.value == "") {
		alert("#charitynamelaert#.");
		AddCharity.Organisation_Name.focus();
		return;
		} 
		
	else if (AddCharity.FirstName.value == "") {
		alert("#pricontfnamelaert#.");
		AddCharity.FirstName.focus();
		return;
		}
		
	else if (AddCharity.LastName.value == "") {
		alert("#pricontlnamelaert#.");
		AddCharity.LastName.focus();
		return;
		}
		
	else if ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
		alert("#validemailalert#.");
		AddCharity.EmailAddress.focus();
		return;
		}
		
	else if (AddCharity.Password.value == "") {
		alert("#pricontactpassalert#.");
		AddCharity.Password.focus();
		return;
		}
		
	else {
		AddCharity.submit(); //submit form
		}
	}
	// -->
	</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="AddCharity" action="#request.webroot#/administration/act_add_charity.cfm" method="post" onSubmit="javascript:validate(AddCharity); return false;">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><br><hr width="100%" size="1" color="silver">
	<strong>#charitydetails#</strong>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#charityname#</td>
	<td><input type="text" name="Organisation_Name" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#Phone#</td>
	<td><input type="text" name="WorkPhone" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#weburl#</td>
	<td><input type="text" name="Website" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#address1#</td>
	<td><input type="text" name="Address1" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#address2#</td>
	<td><input type="text" name="Address2" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#citytown#</td>
	<td><input type="text" name="City" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#CountryText#</td>
	<td><select name="CountryID" class="whitefield" style="width:300px;" onChange="changeCountry(this.options[this.selectedIndex].value)">
	<option value="137" selected>New Zealand
	<option value="0">---------------------
	<cfloop query="allCountries"><option value="#allcountries.countryID#">#TRIM(allcountries.name)#</cfloop></select></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
	<td colspan="2"></td>
	</tr>
	
	
	
	<tr id="Region">
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#Region#</td>
	<td><select name="regionID" class="whitefield" style="width:300px;" size=1> 
	<option value="0">#selregion#</option>
	<cfloop query="allRegion">
		<option value="#regionid#">#region#</option>
	</cfloop>
	</select><BR></td>
	</tr>
	
	<tr id="State" style="display:none">
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#streg#</td>
	<td><input type="text" name="State" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110" valign="top">#Notes#</td>
	<td><textarea name="Notes" class="whitefield" rows="5" style="width:300px;"></textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><br><hr width="100%" size="1" color="silver">
	<strong>#primarycontact#</strong>
	<hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#firstNameText#</td>
	<td><input type="text" name="FirstName" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#lastNameText#</td>
	<td><input type="text" name="LastName" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#emailaddress#</td>
	<td><input type="text" name="EmailAddress" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:11px;" width="110">#PasswordText#</td>
	<td><input type="text" name="Password" class="whitefield" style="width:300px;"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" value="#addcharitynow# >>" class="whitefield"> &nbsp; <input type="button" onClick="javascript:window.close();" value="#cancelbttn# >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>