<cfoutput>

<cftransaction action="BEGIN">

<!--- UPDATE GOAL INFO --->
<cfquery name="UpdateGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Goals
SET 
GoalTitle='#TRIM(form.goaltitle)#',
goaldetails='#TRIM(form.goaldetails)#',
goaltypeid=#form.GoalTypeID#,
goalorder=#form.goalorder#
WHERE goalID=#form.goalID#
</cfquery>


</cftransaction>

<script>
alert("Goals details have been updated");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_publicGoals";
</script>

</cfoutput>