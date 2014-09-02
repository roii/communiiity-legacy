
	<cfoutput>
	
	<cfparam name="attributes.goalid" default="0">
	
	<cfquery name="QueryGoal" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	  select * 
	  from Goals 
	  WHERE goalid=#attributes.goalid#
	</cfquery>	
	
	
	<cftransaction action="BEGIN">
	
	<cfif QueryGoal.recordcount GT 0>
	
		<cfquery name="UpdateGoalLink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		Update GoalKidslink 
		SET Archived = 1,
		ArchiveDate = #localDateTime#
		WHERE goalid=#attributes.goalid#
		</cfquery>
	
	</cfif>
	
	</cftransaction>
	
	
	<!--- PROCESS REWARDS REWARDS --->
	<cfset ExtraDescription = "<BR>Goal: #TRIM(QueryGoal.goaltitle)#">
	
	<cfset this_activity = 7>
	<cfset this_contactID = session.UserID>
	<cfset this_relatedDescription = "CompleteGoal">
	<cfset this_relatedID = "#attributes.goalid#">
			
	<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	
	<script>
	alert("This goal is now marked as done!");
	self.location="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentID=38";
	</script>
	
	</cfoutput>
