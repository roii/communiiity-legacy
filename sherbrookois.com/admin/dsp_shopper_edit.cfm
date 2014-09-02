

<cfoutput>


<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>


<cfinclude template="../templates/qry_all_countries.cfm">



<script language="JavaScript">

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

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>MyKidsBiz - Edit Shopper</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Shopper</strong></span></td>
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
		
		
			<form method="post" action="#request.webroot#/admin/act_shopper_edit.cfm">
			<input type="hidden" name="contactID" value="#contactID#">
			
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>Current Status</td>
			<td><select name="ContactStatus" class="whitefield" style="width:250px; border-color:a0d8e0;">
			<option value="Active"<cfif #TRIM(ContactDetails.ContactStatus)# EQ 'active'> selected</cfif>> Active
			<option value="Pending"<cfif #TRIM(ContactDetails.ContactStatus)# EQ 'Pending'> selected</cfif>> Pending
			<option value="Deleted"<cfif #TRIM(ContactDetails.ContactStatus)# EQ 'Deleted'> selected</cfif>> Deleted
			</select></td>
			</tr>
			
			<tr>
			<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td >First Name</td>
			<td><input type="text" name="FirstName" class="whitefield" style="width:250px; " value="#ContactDetails.FirstName#"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td >Last Name</td>
			<td><input type="text" name="LastName" class="whitefield" style="width:250px; " value="#ContactDetails.LastName#"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td  height="5"> </td>
			<td> </td>
			</tr>
			
			<tr>
			<td></td>
			<td >Gender</td>
			<td><input type="radio" name="Gender" class="small" value="m"<cfif #contactdetails.gender# EQ 'm'> checked</cfif>> M &nbsp; <input type="radio" name="Gender" class="small" value="f"<cfif #contactdetails.gender# EQ 'f'> checked</cfif>> F</td>
			</tr>
			
			<tr>
			<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td >Email Address</td>
			<td><input type="text" name="EmailAddress" class="whitefield" style="width:250px; " value="#ContactDetails.EmailAddress#"></td>
			</tr>
			
			
			<tr>
			<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			<tr id="CityTown" <cfif ContactDetails.CountryID EQ 137>style="display:none"</cfif>>
			<td style="color:404040;">City/Town</td>
			<td><input type="text" name="City" class="whitefield" style="width:250px; border-color:a0d8e0;" value="#TRIM(contactdetails.City)#"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>Country</td>
			<td>
			<select name="CountryID" class="whitefield" style="width:250px; " onchange="changeCountry(this.options[this.selectedIndex].value)">
			<option value="137">New Zealand
			<option value="0">---------------------
			<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif #contactDetails.CountryID# EQ #allcountries.countryID#> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select>
			</td>
			</tr>
			
			<tr id="Region"<cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
			<td width="10"><img src="http://www.mykidsbiz.com/images/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>Region</td>
			 <td>
			  <SELECT name="regionid" class="whitefield" style="width:250px; border-color:a0d8e0;" onChange="changeRegion(this.options[this.selectedIndex].value)" size=1> 
                            <option value="0">Select a Region</option>
				<cfloop query="allRegion">
				  <cfif ContactDetails.regionid EQ allRegion.regionid>
                                    <option value="#regionid#" selected>#region#</option>
				  <cfelse>
                                    <option value="#regionid#">#region#</option>
				  </cfif>
				</cfloop>
			   </select><BR>
                        </td>
			</tr>

			<tr id="District"<cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
			<td width="10"><img src="http://www.mykidsbiz.com/images/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>District</td>
                        <td>
			<SELECT size="1" name="districtID" class="whitefield" style="width:250px; border-color:a0d8e0;" onchange="changeDistrict(this.options[this.selectedIndex].value)">
			<cfif ContactDetails.regionid NEQ 0>
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

			</td>
			</tr>

			<tr id="Suburb" <cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
			<td width="10"><img src="http://www.mykidsbiz.com/images/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>Suburb</td>
                        <td>
			<SELECT size="1" name="suburbID" class="whitefield" style="width:250px; border-color:a0d8e0;">
			<cfif ContactDetails.districtid NEQ 0>
			  <cfquery name="allSuburb" datasource="#dsn#" username="#request.username#" password="#request.password#">
			    select * from suburb where districtid = #ContactDetails.districtid# order by suburb
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
			 </td>
			</tr>

			<tr>
			<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
			</tr>
	
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td >Login Name</td>
			<td><input type="text" name="ScreenName" class="whitefield" style="width:250px; " value="#contactdetails.LoginName#"></td>
			</tr>
			
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td >Password</td>
			<td><input type="text" name="Password" class="whitefield" style="width:250px; " value="#contactdetails.password#"></td>
			</tr>
		
			
			<tr>
			<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td style="color:404040;" colspan="2">
			<input type="checkbox" name="receiveEmail" value="1" <cfif contactdetails.receiveEmail EQ 1>checked</cfif>>
			Yes, I'd like to receive email newsletter from mykidsbiz.</td>
			</tr>
			
			<tr>
			<td colspan="6"  height="5"><hr width="100%" size="1" color="white"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td > </td>
			<td><input type="submit" class="whitefield" style="" value="UPDATE NOW"> <input type="button" class="whitefield" value="CANCEL" onclick="window.close();"></td>
			</tr>
	
	
	</form>	
	</table><br><br>
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>