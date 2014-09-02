
<cfparam name="attributes.caller" default="">

<cfoutput>


<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>

<cfquery name="ContactGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ContactGoals
WHERE ContactID=#ContactID#
</cfquery>

<cfset currentgoals=valuelist(ContactGoals.GoalID, ",")>

<cfquery name="AllSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Schools.SchoolID, Schools.SchoolName
FROM Schools
WHERE Schools.CountryID=#ContactDetails.CountryID#
AND Schools.SchoolStatus LIKE 'Active'
ORDER BY SchoolName
</cfquery>

<cfinclude template="../templates/qry_all_countries.cfm">



<!--- SET DATE RANGES FOR BIRTDATES FOR 9-19 year olds --->
<cfset startBirthYear=DateAdd('yyyy',  -70,  localDateTime)>
<cfset endBirthYear=DateAdd('yyyy',  -5,  localDateTime)>



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
	<title>#TRIM(AllSettings.SiteName)# - Edit Kid</title>
<cfinclude template="../templates/styles.cfm">
	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Edit Kid</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top"><br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
	<form method="post" action="#request.webroot#/admin/act_kid_edit.cfm">
	<input type="hidden" name="contactID" value="#contactID#">
	<input type="hidden" name="caller" value="#attributes.caller#">
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Current Status</td>
	<td><select name="ContactStatus" class="whitefield" style="width:250px; border-color:a0d8e0;">
	<option value="Active"<cfif TRIM(ContactDetails.ContactStatus) EQ 'active'> selected</cfif>> Active
	<option value="Pending"<cfif TRIM(ContactDetails.ContactStatus) EQ 'Pending'> selected</cfif>> Pending
	<option value="Deleted"<cfif TRIM(ContactDetails.ContactStatus) EQ 'Deleted'> selected</cfif>> Deleted
	</select></td>
	</tr>

	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Verification Code</td>
	<td><span style="color:##333333;font-size:11px;">#TRIM(ContactDetails.VerificationCode)#</span>
	</td>
	</tr>

	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td >Screen Name</td>
	<td><input type="text" class="whitefield" name="ScreenName" style="width:250px; " value="#ContactDetails.Screenname#"></td>
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
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr>
	<td></td>
	<td >Gender</td>
	<td><input type="radio" name="Gender" class="small" value="m"<cfif TRIM(contactdetails.gender) CONTAINS 'm'> checked</cfif>> Boy &nbsp; <input type="radio" name="Gender" class="small" value="f"<cfif TRIM(contactdetails.gender) CONTAINS 'f'> checked</cfif>> Girl</td>
	</tr>
	
	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td >Birthday</td>
	<td><select name="DOB_month" class="whitefield" style="width:90px; "><cfloop from="1" to="12" index="monthLoop"><option value="#MonthAsString(monthloop)#"<cfif DateFormat(contactDetails.DateOfBirth, "mmmm") EQ MonthAsString(monthloop)> selected</cfif>>#MonthAsString(monthloop)#</cfloop></select> <select name="DOB_Year" class="whitefield" style="width:60px; "><cfloop from="#DateFormat(startBirthYear, 'yyyy')#" to="#DateFormat(endBirthYear, 'yyyy')#" index="yearLoop"><option value="#yearloop#"<cfif DateFormat(contactDetails.DateOfBirth, "yyyy") EQ yearloop> selected</cfif>>#yearloop#</cfloop></select></td>
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
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td >Mobile Phone</td>
	<td><input type="text" name="MobilePhone" class="whitefield" style="width:250px; " value="#TRIM(ContactDetails.MobilePhone)#"></td>
	</tr>	
	
	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr id="CityTown" <cfif ContactDetails.CountryID EQ 137>style="display:none"</cfif>>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="color:404040;">City/Town</td>
	<td><input type="text" name="City" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.City)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Country</td>
	<td>
	<select name="CountryID" class="whitefield" style="width:250px; " onchange="changeCountry(this.options[this.selectedIndex].value)">
	<option value="137">New Zealand
	<option value="0">---------------------
	<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif contactDetails.CountryID EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select>
	</td>
	</tr>
	
	<tr id="Region"<cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
	<td width="10"><img src="http://www.#TRIM(AllSettings.SiteName)#.com/images/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Region</td>
	<td><select name="regionid" class="whitefield" style="width:250px; border-color:a0d8e0;" onChange="changeRegion(this.options[this.selectedIndex].value)" size=1>
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
	
	<tr id="District"<cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
	<td width="10"><img src="http://www.#TRIM(AllSettings.SiteName)#.com/images/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>District</td>
	<td><select size="1" name="districtID" class="whitefield" style="width:250px; border-color:a0d8e0;" onchange="changeDistrict(this.options[this.selectedIndex].value)">
	<cfif ContactDetails.regionid NEQ 0 AND ContactDetails.RegionID NEQ ''>
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
	</select></td>
	</tr>
	
	<tr id="Suburb" <cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
	<td width="10"><img src="http://www.#TRIM(AllSettings.SiteName)#.com/images/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>Suburb</td>
	<td><SELECT size="1" name="suburbID" class="whitefield" style="width:250px; border-color:a0d8e0;">
	<cfif ContactDetails.districtid NEQ 0 AND ContactDetails.districtid NEQ ''>
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
	</select> </td>
	</tr>
	
	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	
	<cfif AllSchools.RecordCount>
	
		<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td>School</td>
		<td><select name="SchoolID" class="whitefield" style="width:250px;">
		<option value="0">--- MY SCHOOL IS MISSING ---
		<option value="9999999"<cfif ContactDetails.SchoolID EQ 9999999> selected</cfif>>--- I DON'T GO TO SCHOOL ---
		<cfloop query="AllSchools">
		<option value="#AllSchools.SchoolID#"<cfif ContactDetails.SchoolID EQ AllSchools.SchoolID> selected</cfif>>#TRIM(AllSchools.SchoolName)#</cfloop>
		</select></td>
		</tr>
		
		
		<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td colspan="2"><br><strong>If school is missing from list...</strong></td>
		</tr>
		
		<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td>School Name</td>
		<td><input type="text" name="School_Other" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other)#"></td>
		</tr>
		
		<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td>School Phone</td>
		<td><input type="text" name="School_Other_Phone" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other_Phone)#"></td>
		</tr>
		
		<tr>
		<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
		<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Address</td>
		<td><input type="text" name="School_other_Address" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_other_Address)#"></td>
		</tr>
	
	<cfelse>
	
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>School Name</td>
			<td><input type="text" name="School_Other" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other)#"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td>School Phone</td>
			<td><input type="text" name="School_Other_Phone" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_Other_Phone)#"></td>
			</tr>
			
			<tr>
			<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">School Address</td>
			<td><input type="text" name="School_other_Address" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.School_other_Address)#"></td>
			</tr>
	
	</cfif>
	
	
	
	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td >Parent/Guardian Name</td>
	<td><input type="text" name="ParentsName" class="whitefield" style="width:250px; " value="#contactdetails.ParentsName#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td >Parent/Guardian Email</td>
	<td><input type="text" name="ParentsEmail" class="whitefield" style="width:250px; " value="#contactdetails.ParentsEmail#"></td>
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
	
	
	<cfparam name="decrypted" default="">
	
	<cfquery name="bankdetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	select * from bankacct where kidsid = #ContactID#
	</cfquery>
	
	<cfif bankdetails.recordcount GT 0>
	<cfif bankdetails.Acctno NEQ "">
	<CFSET decrypted = decrypt("#bankdetails.acctno#", "kidskids")>
	</cfif>
	</cfif>
	
	
	<tr title="It is very important that you get your account number correct, or else you will lose your money">
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="color:404040;">Account Name</td>
	<td><input type="text" name="acctname" class="whitefield" style="width:250px;" value="#TRIM(bankdetails.acctname)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="color:404040;">Account Number</td>
	<td><input type="text" title="It is very important that you get your account number correct, or else you will lose your money" name="acctno" class="whitefield" style="width:250px;" value="#TRIM(decrypted)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="color:404040;">Bank Name & Branch</td>
	<td><input type="text" name="branch" class="whitefield" style="width:250px;" value="#TRIM(bankdetails.branch)#"></td>
	</tr>
	
	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="color:404040;" colspan="2">
	<input type="checkbox" name="receiveEmail" value="1" <cfif contactdetails.receiveEmail EQ 1>checked</cfif>>
	Yes, I'd like to receive email newsletter from #TRIM(AllSettings.SiteName)#.</td>
	</tr>
	
	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td > </td>
	<td><input type="submit" class="whitefield" style="" value="UPDATE NOW"> <input type="button" class="whitefield" value="CANCEL" onclick="window.close();"></td>
	</tr>
	

	</form>	
	
	<tr>
	<td colspan="3"  height="5"><hr width="100%" size="1" color="white"></td>
	</tr>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2" style="font-size:14px;"><strong>Kids Notes</strong><span style="font-size:11px;">&nbsp;&nbsp; <a href="#request.webroot#/admin/dsp_add_note.cfm?contactID=#contactID#" target="addnote" onclick="fdbackwindow=window.open ('','addnote','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=350,top=10,left=10')">Add a Note</a></span></td>
	</tr>
	
	
	
	<cfquery name="notedetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	select * from kidsnote,administrator where kidsid = #ContactID# and administrator.emailaddress = kidsnote.admin
	order by dateadded desc
	</cfquery>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="white">
	
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td><b>Date</b></td>
		<td><b>Time</b></td>
		<td><b>Note</b></td>
		<td><b>Added By</b></td>
		<td><b>Last Edit</b></td>
		<td><b>Edit</b></td>
		<td><b>Delete</b></td>
		</tr>		
		
		<cfloop query="notedetails">
		<tr>
		<td>#dateformat(dateadded,"dd/mmm/yy")#</td>
		<td>#timeformat(dateadded,"HH:MM")#</td>
		<td>#note#</td>
		<td>#firstname# #lastname#</td>
		<td><cfif lastedit NEQ ''>#lastedit#</cfif></td>
		<td><a href="dsp_edit_note.cfm?noteid=#noteid#&contactid=#contactid#">edit</a></td>
		<td><a href="act_delete_note.cfm?noteid=#noteid#&kidsid=#contactid#" onclick="return confirm('Are you sure you want to delete this note?')">delete</a></td>
		</tr>
		</cfloop>
		
		</table>
		
		
	</td>
	</tr>
	
	</table><br><br>

	
</td>
</tr>

</table>



</body>
</html>

</cfoutput>