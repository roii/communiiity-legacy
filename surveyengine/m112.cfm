	<!--- Verified by user --->
	<!--- This routine will approve survey form and prepare it for online distribution --->
	
	<!--- Select Active (Verified forms) Forms --->
	<cfquery  name="ActiveForms" datasource="#datasourceR#">
		update #tableforms#
		set verified = 0, dateverified = #now()#, verifiedby = #vendorid#
		where formid = #formid#
		<cfif session.accesslevel lt 3>
			and vendorid = #vendorid#
		</cfif>		
	</cfquery>
	
	<cftry>
			<cffile action="delete" file="#publishdir#\#itemid#\default.cfm">
			<cfdirectory action="delete" directory="#publishdir#\#itemid#">
		<cfcatch type="any">
			<font color="#ff0000" face="arial" size="2"><b>Survey folder has been removed</b></font><br><br>
		</cfcatch>
	</cftry>
