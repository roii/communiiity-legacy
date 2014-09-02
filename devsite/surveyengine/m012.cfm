<cfparam name="keyword" default="">
<cfquery  datasource="#DatasourceR#" name="Recordset">
	select *
	from #tableforms#
	where verified = 1
	and library = 1
	and (vendorid = 0 or vendorid = #val(vendorid)#)
	<cfif isdefined("keyword")>
		<cfif len(keyword)>
			and title like '%#keyword#%'		
		</cfif>
	</cfif>
</cfquery>

<cfset columns = "title,datein">