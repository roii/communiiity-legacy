<cfparam name="attributes.mylibTypeid" default="0">

<cfquery name="mylibType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM mylibType order by libtype
</cfquery>


<cfif attributes.mylibTypeid NEQ "0">
<cfquery name="CurrentmylibType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM mylibtype WHERE mylibtypeID = #attributes.mylibTypeid#
</cfquery>
</cfif>