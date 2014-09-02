<cfoutput>


<cfif form.DistrictID NEQ 0>

	<cfquery name="GetDistrict" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT District
	FROM District
	WHERE DistrictID=#form.DistrictID#
	</cfquery>
	
	<cfset insert_city = GetDistrict.District>

<cfelse>

	<cfset insert_city = form.city>

</cfif>

<cftransaction action="BEGIN">


<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET Address1='#form.address1#',
Address2='#form.address2#',
Address3='#form.address3#',
City='#TRIM(insert_city)#',
CountryID=#form.countryID#,
RegionID=#form.regionid#,
DistrictID=#form.districtid#,
SuburbID=#form.suburbid#
WHERE ContactID=#session.userID#
</cfquery>


</cftransaction>



<script>
alert("Your shipping details have been updated");
self.location="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=90";
</script>


</cfoutput>

