<cfquery  datasource="#datasourceW#" name="Recordset">
	select itemid, count(id) as answers, ip, datein
	from #tableresponses#
	where formid = #formid#
	group by itemid, Ip, datein
	order by DATEDIFF(mi, datein, getdate())  desc
	<!--- order by datein desc --->
</cfquery>

<cfset columns = "itemid,answers,ip,datein">