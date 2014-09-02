<cfif isdefined("formid")>
	<cftransaction>
	<cfquery  username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="Remove0">
		delete from #tablequestions#
		where formid = #formid#
		and vendorid = #vendorid#
	</cfquery>
	<cfquery  username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="Remove1">
		delete from #tableresponses#
		where formid = #formid# 
		and vendorid = #vendorid#
	</cfquery>
	<cfquery  username="#dbusername#" password="#dbpassword#" datasource="#datasourceR#" name="Remove2">
		delete from #tableforms#
		where formid = #formid# 
		and vendorid = #vendorid#
	</cfquery>
	</cftransaction>

	<!--- Log Transaction --->
<!--- 	<cffile action="APPEND" file="#logdir#/#formid#" output="Survey: #formid#, has been removed on: #now()#, by: #vendorid#"> --->

</cfif>
