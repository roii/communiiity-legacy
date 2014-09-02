<cfparam name="fusesubaction" default="index">
<cfparam name="attributes.fusesubaction" default="index">
<cfparam name="MyIdeasMode" default="list">

<cfif NOT IsDefined("DocumentID")>
	<cflocation url="#request.webroot#/index.cfm?fuseaction=ideas&fusesubaction=docs&documentID=75&MainCatID=All">
</cfif>


<cfparam name="session.srch_category" default="ALL">
<cfif isDefined("srch_category")>
	<cfset session.srch_category = srch_category>
</cfif>

<cfparam name="session.srch_period" default="ALL">
<cfif isDefined("srch_period")>
	<cfset session.srch_period = srch_period>
</cfif>

<cfparam name="session.srch_stage" default="ALL">
<cfif isDefined("srch_stage")>
	<cfset session.srch_stage = srch_stage>
</cfif>

<cfparam name="session.srch_keywords" default="">
<cfif isDefined("srch_keywords") AND srch_keywords NEQ 'Keywords...'>
	<cfset session.srch_keywords = srch_keywords>
</cfif>

<cfparam name="session.CriticalVotes" default="0">

<cfparam name="session.currentcategory" default="0">

<cfif isdefined("currentcategory")>	
	<cflock Type="exclusive" scope="session" timeout="10">
		<cfset session.currentcategory = currentcategory>
	</cflock>
</cfif>