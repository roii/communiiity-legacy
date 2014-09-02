<cfparam name="session.current_account" default="personal">

<cfif IsDefined("DocumentID") AND DocumentID EQ 81>
	<cfset session.current_account="personal">
<cfelseif IsDefined("DocumentID") AND DocumentID EQ 82>
	<cfset session.current_account="education">
<cfelseif IsDefined("DocumentID") AND DocumentID EQ 83>
	<cfset session.current_account="points">
</cfif>

<cfoutput>#session.current_account#</cfoutput>
<cfif session.current_account EQ 'personal'>
	<cfinclude template="dsp_personal_account.cfm">

<cfelseif session.current_account EQ 'education'>
	<cfinclude template="dsp_education_account.cfm">

<cfelseif session.current_account EQ 'points'>
	<cfinclude template="dsp_points_account.cfm">	
		
</cfif>