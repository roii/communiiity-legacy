
<cfif isdefined("id") and isdefined("question")>
	<cfupdate username="#dbusername#" password="#dbpassword#" datasource="#datasourceW#" tablename="#tablequestions#" 
	formfields="questiontype,question,option1,,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation">
	<cflocation url="surveyadmin.cfm?formid=#formid#">
	<cfabort>
</cfif>

<cfif isdefined("question")>
	<cfinsert username="#dbusername#" password="#dbpassword#" datasource="#datasourceW#" tablename="#tablequestions#" 
	formfields="questiontype,question,option1,,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation">
	<cflocation url="surveyadmin.cfm?formid=#formid#">
	<cfabort>
</cfif>

<cfquery  datasource="#datasourceW#" name="m">
	select *
	from #tablequestions#
	where id = #id#
	and vendorid = #vendorid#
</cfquery>

