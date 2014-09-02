<cfoutput>
 <cfset bywhen = CREATEDATE(form.ByWhen_year, form.ByWhen_month, form.ByWhen_Day)>
<cfset bywhen = DateFormat(bywhen,"mm/dd/yyyy")>

<cftransaction action="BEGIN">

<!--- UPDATE GOAL INFO --->
<cfif form.defaultgoal NEQ "1">
<cfquery name="UpdateGoal" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
UPDATE Goals
SET GoalTitle='#TRIM(form.goaltitle)#',
goaldetails='#TRIM(form.goaldetails)#',
goalcatID=#form.goalcatID#,

<cfif isdefined("form.SendEmails")>
	SendEmails=#form.SendEmails#,
<cfelse>
	SendEmails=0,
</cfif>


<cfif isdefined("form.Frequency_Daily")>
	Frequency=1
<cfelse>
	<cfif isdefined("form.Frequency")>
		Frequency=#form.Frequency#
	<cfelse>
		Frequency=0
	</cfif>
</cfif>

WHERE goalID=#form.goalID#
</cfquery>
</cfif>

<cfquery name="UpdateGoalkidslink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
UPDATE GoalKidsLink
SET bywhen='#bywhen#',
percentdone=#TRIM(form.percentdone)#,
lastModified=#localDateTime#,
archived=#form.archived#
WHERE goalID=#form.goalID#
</cfquery>
</cftransaction>


<!--- PROCESS REWARDS REWARDS --->
<cfset ExtraDescription = "<BR>Goal: #TRIM(form.goaltitle)#">


<!--- PROCESS REWARDS --->
<cfif form.archived EQ 1>
	<cfset this_activity = 7>
<cfelse>
	<cfset this_activity = 4>
</cfif>

<cfset this_contactID = session.UserID>
<cfset this_relatedDescription = "UpdateGoal">
<cfset this_relatedID = "#form.goalID#">

<cfinclude template="../templates/act_activity_reward_payment.cfm">



<script>
alert("The goal details have been updated");
self.location="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentID=38";
</script>

</cfoutput>