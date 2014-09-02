<cfif IsDefined("URL.id") and URL.id neq ''>
       <cfset id = URL.id>
<cfelse>
       <cfset id = 0> 
</cfif>  

<cfif id gt 0> 
	<cfquery name="deleteSliderImage" datasource="#dsn#" username="#request.username#" password="#request.password#">
		 DELETE FROM homepage_slider_images
		  WHERE id = #id#
	</cfquery>
</cfif>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_home_slider_images&delete=done" addtoken="no">