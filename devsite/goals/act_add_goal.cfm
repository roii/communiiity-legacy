<cftry>

	<cfset bywhen = CREATEDATE(form.ByWhen_year, form.ByWhen_month, form.ByWhen_Day)>
	<cfset bywhen = DateFormat(bywhen,"mm/dd/yyyy")>

<cfcatch>

	<script>
	alert("The date you entered was not a valid date.");
	history.back(-1);
	</script>
	<cfabort>

</cfcatch>
</cftry>


		<!--- INSERT Goal --->
		<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT GoalID
		FROM goals
		ORDER BY GoalID DESC
		</cfquery>
		
		<cfif lastid.recordcount>
			<cfset newid = lastID.GoalID+1>
		<cfelse>
			<cfset newid = 1>
		</cfif>
				
		<cfquery name="AddGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO Goals(
		GoalTypeID,
		GoalTitle,
		GoalCatID,
		GoalDetails,
		SendEmails,
		Frequency,
		DefaultGoal,
		addedDate
		)
		
		VALUES(
		1,
		'#form.goaltitle#',
		#form.GoalCatID#,
		'#form.goaldetails#',
		
		<cfif IsDefined("form.SendEmails")>
			#form.SendEmails#,
		<cfelse>
			0,
		</cfif>
		
		<cfif isdefined("form.Frequency_Daily")>
			1
		<cfelse>
			<cfif isdefined("form.Frequency")>
				#form.Frequency#
			<cfelse>
				0
			</cfif>
		</cfif>
		,
		0,
		#createODBCDateTime(localDateTime)#
		)
		</cfquery>
		
		
		<cfquery name="AddKidsGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO GoalkidsLink(
		GoalID,
		KidsID,
		bywhen,
		percentDone,
		Archived
		)		
		VALUES(
		#newid#, 
		#session.UserID#,
		'#bywhen#',
		#form.percentdone#,
		0
		)
		</cfquery>
		
		
		<cfset ExtraDescription = "<BR>Goal: #TRIM(form.goaltitle)#">

		<!--- PROCESS LOGIN REWARDS --->
		<cfset this_activity = 3>
		<cfset this_contactID = session.UserID>
		<cfset this_relatedDescription = "AddGoal">
		<cfset this_relatedID = "#newid#">
		
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
		
<cflocation url="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentid=38">