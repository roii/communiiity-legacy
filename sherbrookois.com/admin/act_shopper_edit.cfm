

<cfoutput>

<cfif isdefined('form.receiveEmail')>
  <cfset form.receiveEmail = 1>
<cfelse>
  <cfset form.receiveEmail = 0>
</cfif> 

<cftransaction action="BEGIN">

<!--- UPDATE CONTACT INFO --->

<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET ContactStatus='#form.contactStatus#',
FirstName='#TRIM(form.FirstName)#',
LastName='#TRIM(form.LastName)#',
Gender='#TRIM(form.gender)#',
City='#TRIM(form.city)#',
CountryID=#form.countryID#,
RegionID=#form.regionid#,
DistrictID=#form.districtid#,
SuburbID=#form.suburbid#,
EmailAddress='#TRIM(form.EmailAddress)#',
Password='#TRIM(form.Password)#',
receiveEmail=#TRIM(form.receiveEmail)#
WHERE ContactID=#form.contactID#
</cfquery>

</cftransaction>



	<cfset logdetails = 'Admin: Edit Shopper Profile - (Member: #form.FirstName# #form.LastName#)'>


	<cfinclude template="act_adminlog.cfm">




<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_shoppers')">
	</body>
	
	
</cfoutput>