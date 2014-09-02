<cfparam name="activityid" default="">

<cfquery name="prizeQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_activity,prize
WHERE prize.prizeid = prize_activity.prizeid
AND activityid = #activityid#
AND prize.status = 1
AND getdate() > prize.start_date
</cfquery>


<cfif prizeQ.recordcount>

	<cfif isdefined('session.userid')>
	
		<cfquery name="kidsEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM prize_entry
		WHERE contactid = #session.userid#
		</cfquery>
		
		<cfset kidsEntries = kidsEntries.recordcount>
		
	<cfelse>
	
		<cfset kidsEntries = 0>
		
	</cfif>
	
	<cfquery name="activityQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM activity
	WHERE activityid = #activityid#
	</cfquery>

	<cfoutput>
	<hr size="1" color="e2e2e2"><br>
	
	<STRONG><FONT size=3>#activityQ.description# and #prizeQ.description#</font></strong><br>
	
	<cfif TRIM(prizeQ.image) NEQ '' AND FileExists("#request.fileroot#\images\prize\#TRIM(prizeQ.image)#")>
		
		<cfif TRIM(prizeQ.external_url) NEQ ''>
			<a href="#prizeQ.external_url#" target="_blank"><img src="#request.webroot#/images/prize/#TRIM(prizeQ.image)#" border="0"></a><br><br>
		<cfelse>
			<img src="#request.webroot#/images/prize/#TRIM(prizeQ.image)#"><br><br>
		</cfif>
		
	</cfif>
	
	<cfif kidsEntries GT 0>
		You currently have <span style="color:###TRIM(AllSettings.BoxColour)#;font-size:12px;"><b>#kidsEntries#</b></span> entries into the draw<br><br>
	<cfelse>
		<br>
	</cfif>

	</cfoutput>

</cfif>