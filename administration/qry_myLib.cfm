<cfparam name="attributes.myLibid" default="0">
<cfparam name="attributes.sortby" default="myLibID">
<cfparam name="attributes.sortorder" default="desc">

<cfquery name="AllmyLib" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM myLib, myLibType
WHERE myLib.myLibtypeID=myLibType.myLibTypeID
ORDER BY #attributes.sortby# #attributes.sortorder#
</cfquery>

<cfquery name="myLibType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM myLibType order by LibType
</cfquery>


<cfif attributes.myLibid NEQ "0">
<cfquery name="CurrentmyLib" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM myLib WHERE myLib.myLibID = #attributes.myLibid#
</cfquery>
</cfif>