
<cfparam name="itemid" default="">
<cfif len(question) gt 255>
	Question can not be longer than 255 characters.<p>
	Please use 'BACK' button and correct the problem.
	<cfabort>
</cfif>


<cfif isdefined("itemid")>
	<cfquery  datasource="#datasourceR#" name="CheckItemId">
		select itemid
		from #tablequestions#
		where itemid = #itemid#
	</cfquery>
	<cfif checkitemid.recordcount is 0>
		<cfinsert username="#dbusername#" password="#dbpassword#" datasource="#datasourceW#" tablename="#tablequestions#" formfields="questiontype,question,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation,itemid,datein">
	</cfif>
</cfif>