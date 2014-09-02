<cfoutput>

<cfset birthday= '1' & ' ' & '#form.DOB_Month#' & ' ' & '#DOB_Year#'>
<cfif isdefined("form.receiveEmail")>
  <cfset form.receiveEmail = 1>
<cfelse>
  <cfset form.receiveEmail = 0>
</cfif>

<cftransaction action="BEGIN">

<!--- UPDATE CONTACT INFO --->

<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET ContactStatus='#form.contactStatus#',
ScreenName='#TRIM(form.ScreenName)#',
FirstName='#TRIM(form.FirstName)#',
LastName='#TRIM(form.LastName)#',

<cfif IsDefined("form.gender")>
	Gender='#TRIM(form.gender)#',
</cfif>

City='#TRIM(form.city)#',
CountryID=#form.countryID#,
RegionID=#form.regionid#,
DistrictID=#form.districtid#,
SuburbID=#form.suburbid#,
EmailAddress='#TRIM(form.EmailAddress)#',
MobilePhone='#TRIM(form.MobilePhone)#',
Password='#TRIM(form.Password)#',
DateOfBirth=#CreateODBCDate(Birthday)#,
ParentsName='#TRIM(form.ParentsName)#',
ParentsEmail='#TRIM(form.ParentsEmail)#',
receiveEmail=#TRIM(form.receiveEmail)#,

<cfif IsDefined("form.SchoolID")>
	SchoolID=#form.SchoolID#,
<cfelse>
	SchoolID=0,
</cfif>

<cfif IsDefined("form.School_Other")>
	School_Other='#form.School_Other#',
<cfelse>
	School_Other='',
</cfif>

<cfif IsDefined("form.School_Other_Phone")>
	School_Other_Phone='#form.School_Other_Phone#',
<cfelse>
	School_Other_Phone='',
</cfif>

<cfif IsDefined("form.School_Other_Address")>
	School_Other_Address='#form.School_Other_Address#'
<cfelse>
	School_Other_Address=''
</cfif>

WHERE ContactID=#form.contactID#
</cfquery>

<cfif form.acctno NEQ ''>

 <cfset encrypted = encrypt(form.acctno, "kidskids")>

<cfquery name="BankAcctQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from bankacct where kidsid = #form.contactID#
</cfquery>

<cfif BankAcctQ.recordcount GT 0>
  <cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
    UPDATE bankacct SET
      acctname = '#form.acctname#',
      acctno = '#encrypted#',
      branch = '#form.branch#' 
      where kidsid = #form.contactID#
  </cfquery>

<cfelse>
 <cfquery name="InsertBankAcct" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO bankacct(
		KidsID,
		acctname,
		acctno,
		branch
		)		
		VALUES(
		#form.contactID#,
		'#form.acctname#',
		'#encrypted#',
		'#form.branch#'
		)
 </cfquery>
 </cfif>
</cfif>
</cftransaction>



<cfif isDefined("form.RoleID")>

	<!--- REMOVE CURRENT ROLES --->
	<cfquery name="DeleteCurrent" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM ContactRoles
	WHERE ContactID=#form.ContactID#
	</cfquery>
	
	<!--- ADD SELECTED ROLES --->
	<cfloop index="ThisRole" list="#form.RoleID#" delimiters=",">
	
		<cfquery name="AddContactRole" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO ContactRoles (ContactID, RoleID)
		VALUES (#form.ContactID#, #ThisRole#)
		</cfquery>
	
	</cfloop>

</cfif>


<cfset logdetails = 'Admin: Edit Kids Profile - (Member: #form.FirstName# #form.LastName#)'>

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
	
	<cfif form.caller NEQ ''>
	  <cfset caller = form.caller>
	<cfelse>
	  <cfset caller = "manage_members">
	</cfif>
	
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=#caller#')">
	</body>
	
	
</cfoutput>