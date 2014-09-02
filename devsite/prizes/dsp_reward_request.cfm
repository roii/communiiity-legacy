<cfoutput>

<cfquery name="rewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE PrizePoolID=#rewardID#
</cfquery>

 <cfinclude template="../templates/qry_all_countries.cfm">

<cfquery name="TransactionHistory" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contact_transactions.*, Contacts.FirstName, Contacts.LastName
FROM Contact_transactions, Contacts
WHERE Contact_transactions.Transaction_Account = 'Points'
AND Contact_transactions.ContactID=Contacts.ContactID

<cfif session.UserIsAuthenticated EQ 'Yes'>
AND Contacts.ContactID=#session.UserID#
</cfif>
</cfquery>

<cfset thistotal=0>

<cfloop query="TransactionHistory">


<cfif IsNumeric("#TransactionHistory.Transaction_amount#")>
	<cfif TRIM(TransactionHistory.Transaction_Type) EQ 'Debit'>
		<cfset thistotal=(thisTotal - TransactionHistory.Transaction_amount)>
	<cfelse>
		<cfset thistotal=(thisTotal + TransactionHistory.Transaction_amount)>
	</cfif>
</cfif>

</cfloop>


<!--- 
if (RewardRequest.Address1.value == "") { 
	alert("You must enter your Shipping Address.");
	RewardRequest.Address1.focus();
	return;
	} 
	
else {
	RewardRequest.submit(); //submit form
	} --->

<script>
function validateProfile(RewardRequest) {
alert('The Request Reward system is currently unavailable.\nPlease refer to the Site Announcements section for details.');
}
</script>


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


<cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Address1, Address2, Address3, City, RegionID, DistrictID, SuburbID, CountryID
FROM Contacts
WHERE ContactID=#session.UserID#
</cfquery>

<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<tr>
<td style="font-size:12px;color:###TRIM(AllSettings.TextColour)#;">


	<hr width="100%" size="1" color="##b4b4b4">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="90" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="1"  border="0"></td>
	<td width="20" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1"  border="0"></td>
	<td width="100%" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="300" height="1"  border="0"></td>
	</tr>
		
	<form method="post" action="#request.webroot#/prizes/act_reward_request.cfm" name="RewardRequest" onsubmit="javascript:validateProfile(RewardRequest); return false;">
	<input type="hidden" name="RewardID" value="#RewardID#">
	<tr bgcolor="white">
	<td valign="top">
	
		<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
		
		<tr>
		<td align="center" valign="center">			
		<cfif FileExists("#request.fileroot#\images\prize\#TRIM(rewardDetails.image)#")>
			<img src="#request.imageroot#/prize/#TRIM(rewardDetails.image)#" border="0" width="80" height="60">
		<cfelse>
			<img src="#request.imageroot#/prize_placeholder.gif" width="80" height="60" border="0">
		</cfif>
		</td>
		</tr>
		
		</table>
	
	
	</td>
	<td valign="top"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" alt="" border="0"></td>
	<td valign="top">
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td valign="top"><span style="color:###TRIM(AllSettings.DkTextColor)#;font-size:12px;"><strong>#TRIM(rewardDetails.description)#</strong></span><br>
		This reward will cost you <strong>#rewardDetails.PointsValue# pts</strong> leaving you a balance of <strong>#INT(thistotal-rewardDetails.PointsValue)# pts</strong></td>
		<td valign="top" align="right"></td>
		</tr>
		
		</table>
	
	<hr width="100%" size="1" color="##b4b4b4">
	
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td width="140" height="20"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="20"  border="0"></td>
		<td></td>
		</tr>
		
		
		<tr>
		<td colspan="2" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>Please confirm your shipping address:</strong>
		<hr width="100%" size="1" color="##b4b4b4"></td>
		</tr>
		
		<tr>
		<td>Shipping Address</td>
		<td><input type="text" name="Address1" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.Address1)#"></td>
		</tr>
		
		<tr>
		<td></td>
		<td><input type="text" name="Address2" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.Address2)#"></td>
		</tr>
		
		<tr>
		<td></td>
		<td><input type="text" name="Address3" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.Address3)#"></td>
		</tr>
		
		
		<tr>
		<td colspan="2"  height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
		</tr>
		
		<tr id="CityTown" <cfif ContactDetails.CountryID EQ 137>style="display:none"</cfif>>
		<td>City/Town</td>
		<td><input type="text" name="City" class="whitefield" style="width:250px;" value="#TRIM(contactdetails.City)#"></td>
		</tr>
		
		<tr>
		<td>Country</td>
		<td><select name="CountryID" class="whitefield" style="width:250px;" onchange="changeCountry(this.options[this.selectedIndex].value)">
		<option value="137">New Zealand
		<option value="0">---------------------
		<cfloop query="allCountries"><option value="#allcountries.countryID#"<cfif ContactDetails.CountryID EQ allcountries.countryID> selected</cfif>>#TRIM(allcountries.name)#</cfloop></select></td>
		</tr>
		
		<tr id="Region" <cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
		<td>Region</td>
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
		<td>District</td>
		<td><SELECT size="1" name="districtID" class="whitefield" style="width:250px;" onchange="changeDistrict(this.options[this.selectedIndex].value)">
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
		</select>
		</td>
		</tr>
		
		<tr id="Suburb" <cfif ContactDetails.CountryID NEQ 137>style="display:none"</cfif>>
		<td>Suburb</td>
		<td><select size="1" name="suburbID" class="whitefield" style="width:250px;">
		<cfif ContactDetails.districtid NEQ 0>
		
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
		<td><input type="image" src="#request.imageroot#/rewardrequest_butt.gif" title="Send Reward Request"></td>
		</tr>
		
		</table>
	
	
	
	</td>
	</tr>
	
	</form>
	
	
	
	</table>
	
</td>
</tr>

</table>


</cfoutput>