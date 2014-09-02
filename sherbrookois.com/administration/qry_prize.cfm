<cfparam name="attributes.prizeid" default="0">
<cfparam name="attributes.sortby" default="p.Name">
<cfparam name="attributes.sortorder" default="asc">

<cfquery name="AllPrize" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM prize p where prizepoolid = #attributes.prizepoolid# ORDER BY #attributes.sortby# #attributes.sortorder#
</cfquery>

<cfquery name="PrizeActivity" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT * FROM activity order by name
</cfquery>

<cfif attributes.prizeid NEQ "0">
<cfquery name="CurrentPrize" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM prize p WHERE p.prizeid = #attributes.prizeid#
</cfquery>

</cfif>