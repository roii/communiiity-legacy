<cfif isdefined("id") is "yes" AND isdefined("question")>
	<cfupdate username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" tablename="#tablequestions#" formfields="id,questiontype,question,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation">
</cfif>