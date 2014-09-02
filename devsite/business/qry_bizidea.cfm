<cfparam name="attributes.bizideaid" default="0">
<cfparam name="attributes.sortby" default="biz_Type">
<cfparam name="attributes.sortorder" default="asc">

<cfquery name="Allbizideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea, bizidea_Type
WHERE bizidea.biz_ideatypeID=bizidea_Type.bizideatypeID 
AND bizidea.show = 1 
ORDER BY #attributes.sortby# #attributes.sortorder#
</cfquery>

<cfquery name="bizideaType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea_Type 
ORDER BY biz_type
</cfquery>


<cfif attributes.bizideaid NEQ "0">

<cfquery name="Currentbizidea" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea, bizidea_Type
WHERE bizidea.biz_ideatypeID=bizidea_Type.bizideatypeID 

<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
<cfelse>
AND show = 1
</cfif>

AND bizidea.bizideaID = #attributes.bizideaid#
</cfquery>

<cfquery name="bizidea_Sections" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea_sections
WHERE bizideaID = #attributes.bizideaid#

<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
AND Deleted = 0
<cfelse>
AND Released = 1
AND Deleted = 0
</cfif>

ORDER BY DisplayOrder
</cfquery>

</cfif> 