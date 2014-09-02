 <cfoutput>




 <cfif DocumentDetails.PublicView CONTAINS 1>
 
 <cfelse>
 
	 <cfif session.UserIsAuthenticated EQ 'no'>
	 
		 <script>
		alert("You must be a #TRIM(AllSettings.SiteName)# member and logged-in to access this part of the website.");
		self.location="javascript:history.back();";
		</script>
		<cfabort>
	
	</cfif>
 
 </cfif>
 
 
 <cfinclude template="../templates/qry_contact_details.cfm">
 <cfinclude template="../templates/qry_all_countries.cfm">
 

 <cfset newdetails = DocumentDetails.details>


<script>
function validateProfile(kidsReg) {
 
	

if (kidsReg.Address1.value == "") {
	alert("You must enter your Street Address.");
	kidsReg.Address1.focus();
	return;
	} 

else if (kidsReg.City.value == "") {
	alert("You must enter your Town or City.");
	kidsReg.City.focus();
	return;
	} 
	
else {
	kidsReg.submit(); //submit form
	}
	
}
</script>
			

 
 
 
<cfset newdetails=DocumentDetails.details>


 
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


<form name="kidsReg" action="#request.webroot#/profile/act_shipping_details.cfm" method="post" onsubmit="validateProfile(kidsReg); return false;">


<tr>
<td colspan="2">

	
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
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Shipping Address</td>
			<td><input type="text" name="Address1" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.Address1)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"></td>
			<td><input type="text" name="Address2" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.Address2)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"></td>
			<td><input type="text" name="Address3" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.Address3)#"></td>
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
			<option value="137">New Zealand
			<option value="0">---------------------
			<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif ContactDetails.CountryID EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select></td>
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
				  select * 
				  from district 
				  where regionid = #ContactDetails.regionid# 
				  order by district
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