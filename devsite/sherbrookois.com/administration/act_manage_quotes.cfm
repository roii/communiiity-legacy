<cfparam name="form.startrow" default="0">
<cfparam name="form.endrow" default="0">
<cfparam name="FORM.keywords" default="">

<cfif FORM.keywords neq ''>
	<cfquery name="searchresults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * FROM QuoteOfDay where quoteid > 1 <cfif FORM.keywords neq ''>and (quotedetails like '%#FORM.keywords#%' or quotecredit like '%#FORM.keywords#%')</cfif>
	</cfquery>
	
	<cfloop query="searchresults">
	<cfif isdefined('form.whoseesit_#searchresults.quoteid#')>
		<cfset currentwhoseeit = evaluate('form.whoseesit_#searchresults.quoteid#')>
		<cfquery name="updatequotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  update QuoteOfDay set whoseesit = #currentwhoseeit# where quoteid = #searchresults.quoteid#
		</cfquery>
	</cfif>
	
	<cfif isdefined('form.showhide_#searchresults.quoteid#')>
		<cfset currentshowhide = evaluate('form.showhide_#searchresults.quoteid#')>
		<cfquery name="updateshowhide" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  update QuoteOfDay set display = #currentshowhide# where quoteid = #searchresults.quoteid#
		</cfquery>
	</cfif>
	<cfif isdefined('form.delete_#searchresults.quoteid#')>
		<cfquery name="deletequote" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  delete from QuoteOfDay where quoteid = #searchresults.quoteid#
		</cfquery>
	</cfif>
	</cfloop>
<cfelse>
	<cfset form.startrow = form.startrow + 1>
	<cfset form.endrow = form.endrow + 1>
	<cfloop from="#form.startrow#" to="#form.endrow#" index="i">
	<cfif isdefined('form.whoseesit_#i#')>
		<cfset currentwhoseeit = evaluate('form.whoseesit_#i#')>
		<cfquery name="updatequotes" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  update QuoteOfDay set whoseesit = #currentwhoseeit# where quoteid = #i#
		</cfquery>
	</cfif>
	
	<cfif isdefined('form.showhide_#i#')>
		<cfset currentshowhide = evaluate('form.showhide_#i#')>
		<cfquery name="updateshowhide" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  update QuoteOfDay set display = #currentshowhide# where quoteid = #i#
		</cfquery>
	</cfif>
	<cfif isdefined('form.delete_#i#')>
		<cfquery name="deletequote" datasource="#dsn#" username="#request.username#" password="#request.password#">
		  delete from QuoteOfDay where quoteid = #i#
		</cfquery>
	</cfif>
	</cfloop>
</cfif>

<cfoutput>
<p align="center">
<h4>Changes have been saved successfully!</h4>
<a href="javascript:history.back(-1)">Click here to go back</a>
</p>
</cfoutput>