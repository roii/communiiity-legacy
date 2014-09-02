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
<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	self.close();
}

// -->
</script>



	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_publicGoals')"></body>


</cfoutput>