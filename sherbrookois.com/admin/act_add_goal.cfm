<cfquery name="Goalmax" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TOP 1 goalID
FROM dbo.Goals
WHERE DefaultGoal = 1
ORDER BY GoalID DESC
</cfquery>

<cfoutput query="Goalmax">
  <cfset max=goalid + 1>
</cfoutput>

<!--- INSERT Goal --->
		
<cfquery name="AddGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Goals(
GoalTypeID,
GoalTitle,
GoalDetails,
DefaultGoal,
GoalOrder
)

VALUES(
#form.goaltypeID#, 
'#form.goaltitle#',
'#form.goaldetails#',
1,
#max#
)
</cfquery>
		

		
	
<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	self.close();
}

// -->
</script>


<cfoutput>

	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_publicGoals')"></body>


</cfoutput>