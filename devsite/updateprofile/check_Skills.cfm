<cfinclude template="../app_globals.cfm">
<cfif IsDefined("form.SELECTTEXTID") and #form.SELECTTEXTID# neq ''>
	 <cfset SELECTTEXTID = #form.SELECTTEXTID#>
<cfelse>
	 <cfset SELECTTEXTID = ''>
</cfif>  
<cfquery name="checkforUSerSkills" datasource="#dsn#" username="#request.username#" password="#request.password#"> 
	 SELECT * FROM allmanageskills WHERE skillName = '#SELECTTEXTID#'
</cfquery> 
<cfif checkforUSerSkills.recordcount gt 0><cfoutput>Found</cfoutput><cfelse><cfoutput>Not Found</cfoutput></cfif>