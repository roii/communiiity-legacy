<cfoutput>

<cfif IsDefined("form.countryID") AND form.countryID EQ '137'>
	
	<cfquery name="CityStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT District
	FROM District
	WHERE DistrictID=#form.DistrictID#
	</cfquery>
	
	<cfif CityStuff.recordcount>
		<cfset insert_city = Replace(CityStuff.District, 'District', '', "ALL")>
	<cfelse>
		<cfset insert_city = ''>
	</cfif>	

<cfelse>	
	<cfset insert_city = form.city>
</cfif>

<cftransaction action="BEGIN">

<cftry>

	<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET FirstName='#TRIM(form.FirstName)#',
	LastName='#TRIM(form.LastName)#',
	CountryID=#form.countryID#,
	RegionID=#form.regionid#,
	DistrictID=#form.districtid#,
	SuburbID=#form.suburbid#,
	City='#insert_city#',
	EmailAddress='#TRIM(form.EmailAddress)#',
	Address1='#form.Address1#',
	Address2='#form.Address2#',
	Address3='#form.Address3#',
	MobilePhone='#form.MobilePhone#',
	WorkPhone='#form.WorkPhone#',
	HomePhone='#form.HomePhone#',
	
	<cfif IsDefined("form.Categories")>
		Categories='#form.Categories#'
	<cfelse>
		Categories=''
	</cfif>
	
	WHERE ContactID=#form.ContactID#
	</cfquery>
	
	<cftransaction action="commit">

<cfcatch>
	<cftransaction action="rollback">
</cfcatch>

</cftry>

</cftransaction>

<script type="text/javascript">
alert("The record has been updated");
self.location="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=44";
</script>

</cfoutput>

