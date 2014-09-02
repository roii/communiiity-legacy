<cfparam name="attributes.bizideaTypeid" default="0">

<cfquery name="bizideaType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM bizidea_Type order by biz_type
</cfquery>


<cfif attributes.bizideaTypeid NEQ "0">
<cfquery name="CurrentbizideaType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM bizidea_type WHERE bizidea_type.bizideatypeID = #attributes.bizideaTypeid#
</cfquery>
</cfif>