<!--- LOOP TAGS --->
<cfloop from="1" to="#form.NumTags#" index="loopitem">

<!--- UPDATE DETAILS --->
<cfquery name="updateTags" datasource="#dsn#">
UPDATE SMS_Taglines
SET TagLine='#Evaluate("form.TagLine_" & loopitem)#',

<cfif form.DefaultTag EQ Evaluate("form.TagID_" & loopitem)>
	DefaultTag=1
<cfelse>
	DefaultTag=0
</cfif>

WHERE TagID = #Evaluate("form.TagID_" & loopitem)#
</cfquery>


</cfloop>



<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sms_tags">