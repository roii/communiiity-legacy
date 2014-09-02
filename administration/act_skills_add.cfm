<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT id
		FROM allmanageskills
		WHERE skillName = '#trim(FORM.SKILLNAME)#'
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset skillID = #lastID.id#>
	<cfelse>
		<cfset skillID = 0>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->

    <cfif skillID gt 0> 
	        <cfoutput> 
			     <cflocation addtoken="no" url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=dspSkillsAdd&dup=1">
			</cfoutput>
	<cfelse>
	        <cfquery name="AddAdministrator" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO allmanageskills(skillName, skillKeyword)
				 VALUES
				('#trim(FORM.SKILLNAME)#', '#trim(FORM.SKILLKEYWORD)#')
			</cfquery>
			<cfoutput> 
			     <cflocation addtoken="no" url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manageskills&suc=1">
			</cfoutput>
	</cfif>  