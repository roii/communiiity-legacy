
<cfinclude template="app_locals.cfm">

<!---
<cfif session.UserIsAuthenticated EQ 'no'>

<script>
alert("You must be a myKidsbiz administrator and logged-in to access this part of the website.");
self.location="#request.webroot#/index.cfm?fuseaction=about";
</script>
<cfabort>

</cfif>

--->

<cfswitch expression="#attributes.fusesubaction#">

	<cfcase value="manage_suggestion">
		<cfinclude template="dsp_manageSug.cfm">
	</cfcase>
	
	<cfcase value="manage_sug_category">
		<cfinclude template="dsp_manageSugCategory.cfm">
	</cfcase>
	
	<cfcase value="vote_suggestion">
		<cfinclude template="dsp_votingSug.cfm">	
	</cfcase>
	
	<cfcase value="input_suggestion">
		<cfinclude template="dsp_suggestionboxInputForm.cfm">
	</cfcase>
	
	<cfdefaultcase>
		<cfinclude template="dsp_manageSugCategory.cfm">
	</cfdefaultcase>
	
</cfswitch>