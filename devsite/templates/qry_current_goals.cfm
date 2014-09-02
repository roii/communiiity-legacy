<cfparam name="attributes.goalid" default="0">

<cfquery name="CurrentPublicGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Goals, GoalKidsLink,GoalTypes
WHERE GoalKidsLink.kidsid=#session.UserID#
AND Goals.goaltypeid=GoalTypes.Goaltypeid
AND Goals.goalID=GoalKidsLink.goalID
AND GoalKidsLink.Archived=0
AND Goals.defaultGoal=1
ORDER BY goals.goaltypeid,goals.goalorder desc
</cfquery>

<cfquery name="CurrentPrivateGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Goals, GoalKidsLink
WHERE GoalKidsLink.kidsid=#session.UserID#
AND Goals.goalID=GoalKidsLink.goalID
AND GoalKidsLink.Archived=0
AND Goals.defaultGoal=0
ORDER BY GoalKidsLink.bywhen
</cfquery>

<cfquery name="archivedGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Goals, GoalKidsLink
WHERE GoalKidsLink.kidsid=#session.UserID#
AND Goals.goalID=GoalKidsLink.goalID
AND GoalKidsLink.Archived=1
ORDER BY goals.goalid desc
</cfquery>

<cfif attributes.goalid NEQ "0">
<cfquery name="CurrentGoalsDetail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Goals, GoalKidsLink WHERE goals.goalID=GoalKidsLink.goalID and goals.goalid = #attributes.goalid#
</cfquery>
</cfif>