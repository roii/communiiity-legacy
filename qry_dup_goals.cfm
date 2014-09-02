<!--- GET ALL GOALS WITH SAME TITLE --->
<cfquery name="CurrentPrivateGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Goals.GoalTitle, Goals.GoalID, GoalKidsLink.Kidsid
FROM Goals, GoalKidsLink
WHERE Goals.goalID=GoalKidsLink.goalID
AND GoalKidsLink.Archived=0
GROUP BY Goals.GoalTitle, Goals.GoalID, GoalKidsLink.Kidsid
ORDER BY Goals.GoalTitle, Goals.GoalID, GoalKidsLink.Kidsid
</cfquery>


<cfloop query="CurrentPrivateGoals">

<cfset this_goalID = CurrentPrivateGoals.GoalID>
<cfset this_Title = CurrentPrivateGoals.GoalTitle>
<cfset this_Kidsid = CurrentPrivateGoals.Kidsid>

<cfquery name="DupGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Goals.GoalID
FROM Goals, GoalKidsLink
WHERE Goals.goalID <> #this_goalID#
AND Goals.GoalTitle LIKE '%#this_Title#%'
AND Goals.goalID=GoalKidsLink.goalID
AND GoalKidsLink.Kidsid=#this_Kidsid#
AND GoalKidsLink.Archived=0
</cfquery>

<cfif DupGoal.RecordCount>

<cfquery name="DeleteDupGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM Goals
WHERE goalID IN (#ValueList(DupGoal.GoalID)#)
</cfquery>

<cfquery name="DeleteDupGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
DELETE
FROM GoalKidsLink
WHERE goalID IN (#ValueList(DupGoal.GoalID)#)
</cfquery>

</cfif>

</cfloop>
