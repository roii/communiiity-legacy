<cfoutput>

<cfif IsDefined("form.goalID")>

	<script>
	window.open ('#request.webroot#/goals/dsp_print_format.cfm?GoalID=#form.GoalID#&documentID=#documentID#','GoalPrintFormat','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10');
	self.location="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#";
	</script>

<cfelse>
	
	<script>
	alert("You need to select some goals to print first!");
	self.location="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#";
	</script>

</cfif>

</cfoutput>