<cfparam name="currentcategory" default="1">

<cfquery name="qry_current_topic" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM SugCategory
<cfif IsNumeric("#currentcategory#")>
	WHERE CategoryID=#currentcategory#
<cfelse>
	WHERE CategoryID=1
</cfif>
</cfquery>