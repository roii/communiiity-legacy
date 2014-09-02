	<!--- Verified by user --->
	<!--- This routine will approve survey form and prepare it for online distribution --->

		
	<cftry>
	
	<!--- Remove all responses from the form when publishing survey --->
	<cfquery  name="CleanForm" datasource="#datasourceR#">
		delete from #tableresponses#
		where vendorid = #vendorid#
		and formid = #formid#
		and itemid= #itemid#
	</cfquery>
	
	
		<cfcatch type="any">
			<font color="#ff0000" face="arial"><b>There was an error during the deleting process.</b></font><br><br>
		</cfcatch>
	</cftry>