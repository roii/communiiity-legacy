<cfparam name="attributes.activityid" default="0">
<cfparam name="attributes.sortby" default="a.Name">
<cfparam name="attributes.sortorder" default="asc">

<cfquery name="AllAct" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM activity a ORDER BY #attributes.sortby# #attributes.sortorder#
</cfquery>

<cfif attributes.activityid NEQ "0">
<cfquery name="CurrentAct" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM activity a WHERE a.activityid = #attributes.activityid#
</cfquery>
</cfif>