<cfif IsDefined("URL.lang") and URL.lang neq ''>
     <cfset lang = URL.lang>
<cfelse>
     <cfset lang = "fr">
</cfif>

<cfset Session.defaultlang  = #lang#>

<cflocation url="#request.webroot#/index.cfm" addtoken="yes">