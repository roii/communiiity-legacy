<!--- Remove Question from the table --->
<cfif isdefined("formid") and isdefined("id") and isdefined("d")>
	<cfquery  datasource="#datasourceW#" name="RemoveQuestion">
		delete from #tablequestions#
		where id = #id# and formid = #formid#
		and vendorid = #val(vendorid)#
	</cfquery>
</cfif>

<!--- Copy Question in the table --->
<cfif isdefined("formid") and isdefined("id") and isdefined("c")>
	<cfquery  datasource="#datasourceW#" name="CopyQuestion">
		insert into #tablequestions# (questiontype,question,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation,itemid,datein)
		select questiontype,question,option1,option2,option3,option4,option5,option6,option7,option8,option9,option10,formid,vendorid,validation,itemid,datein
		from #tablequestions#
		where id = #id# and formid = #formid# 
		and vendorid = #val(vendorid)#
	</cfquery>
	<cflocation url="default.cfm?formid=#formid#&obj=002">
</cfif>

<!--- Select Questions from the table for the Editor template --->
<cfquery  name="GetForm" datasource="#datasourceR#">
	select *
	from #tablequestions#
	where formid = #formid#
	and vendorid = #val(vendorid)#
	order by id
</cfquery>