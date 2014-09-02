	<!--- Verified by user --->
	<!--- This routine will approve survey form and prepare it for online distribution --->

		
	<cftry>
	
	<!--- Remove all responses from the form when publishing survey --->
	<cfquery  name="CleanForm" datasource="#datasourceR#">
		delete from #tableresponses#
		where vendorid = #vendorid#
		and formid = #formid#
	</cfquery>
	
	<!--- Remove all responses from the form when publishing survey --->
	<cfquery  name="GetHeaderFooterInfo" datasource="#datasourceR#">
		select * from #tableforms#
		where vendorid = #val(vendorid)#
		and formid = #formid#
	</cfquery>	
	
	<!--- Select Active (Verified forms) Forms --->
	<cfquery  name="ActiveForms" datasource="#datasourceR#">
		update #tableforms#
		set verified = 1, dateverified = #now()#, verifiedby = #vendorid#
		where formid = #formid#
		<cfif session.accesslevel lt 3>
			and vendorid = #vendorid#
		</cfif>
	</cfquery>

	
	<cfdirectory action="create" directory="#publishdir#\#itemid#">
	
	<!--- This object will generate Survey file in the Survey Directory --->
	<cffile action="WRITE" file="#publishdir#\#itemid#\default.cfm" output="<cfset formid =""#formid#""><cfparam name=""tablequestions"" default=""#tablequestions#""><cfparam name=""setupdir"" default=""#setupdir#""><cfparam name=""vendorid"" default=""#vendorid#"">">
	
	<cffile action="APPEND" file="#publishdir#\#itemid#\default.cfm" output="#GetHeaderFooterInfo.header#">
	
	<cfinclude template="m113.cfm">

	<cffile action="APPEND" file="#publishdir#\#itemid#\default.cfm" output="<br>#GetHeaderFooterInfo.footer#">
		<cfcatch type="any">
			<font color="#ff0000" face="arial"><b>There was an error during the publishing process.<br>Please check M111.cfm object.<br>Your directory settings are incorrect.</b></font><br><br>
		</cfcatch>
	</cftry>