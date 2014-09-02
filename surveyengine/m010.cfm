<cfquery  datasource="#datasourceW#" name="Recordset">
	select openquestion as Responses, itemid, ip, datein
	from #tableresponses#
	where formid = #formid#
	and questionid = #id#
	order by datein desc
</cfquery>

<cfset columns = "Responses,itemid,ip,datein">