<cfquery name="AllGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GoalTypes.GoalTypeID, Goals.GoalID, Goals.GoalTitle, Goals.goalorder
FROM Goals, GoalTypes
WHERE Goals.GoalTypeID=GoalTypes.GoalTypeID
AND DefaultGoal=1
ORDER BY GoalTypes.GoalTypeID, Goals.GoalOrder, Goals.GoalTitle
</cfquery>

<cfquery name="GoalType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * from goaltypes
</cfquery>
