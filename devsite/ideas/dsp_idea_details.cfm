<cfif IsDefined("SugID") AND IsDefined("currentcategory")>

	<cflocation url="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=voteresults&SingleIdea=#SugID#&currentcategory=#currentcategory#">

<cfelse>

	<cflocation url="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentid=75&ideafunl_mode=list">

</cfif>