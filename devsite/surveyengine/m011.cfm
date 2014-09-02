	<!--- Pull all survey Information --->
	
	<!--- Select Active (Verified forms) Forms --->
	<cfquery username="#dbusername#" password="#dbpassword#" name="ActiveForms" datasource="#datasourceR#">
		select *
		from #tableforms#
		where verified = 1
		<!---and library = 0
		and vendorid = #vendorid# --->
	</cfquery>
	
	<!--- Select Not Active Not Verified --->
	<cfquery username="#dbusername#" password="#dbpassword#" name="NotActiveForms" datasource="#datasourceR#">
		select *
		from #tableforms#
		where verified = 0
		<!---and library = 0		
		and vendorid = #vendorid#--->
	</cfquery>

