<cfparam name="attributes.goalid" default="0">
<cfquery name="AllGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GoalTypes.GoalTypeID, GoalTypes.GoalType,Goals.GoalID, Goals.GoalTitle, Goals.GoalDetails
FROM Goals, GoalTypes
WHERE Goals.GoalTypeID=GoalTypes.GoalTypeID
and Goals.defaultgoal=1
ORDER BY GoalTypes.GoalTypeID, Goals.GoalOrder, Goals.GoalTitle
</cfquery>

<cfquery name="GoalType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM GoalTypes
</cfquery>


<cfif attributes.goalid NEQ "0">
<cfquery name="CurrentGoalsDetail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Goals WHERE goals.goalid = #attributes.goalid#
</cfquery>
</cfif>