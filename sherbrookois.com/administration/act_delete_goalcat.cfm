<cfoutput>
<cfparam name="GoalCatID" default="0">

<cftransaction action="BEGIN">

<!--- GET IMAGE NAME --->
<cfquery name="CatDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from GoalCats WHERE GoalCatID=#GoalCatID#
</cfquery>

<cftry>
<cffile action="DELETE" file="#request.fileroot#\images\goals\#TRIM(CatDetails.imageFile)#">
<cfcatch></cfcatch>
</cftry>

<cfquery name="DeleteCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
  delete from GoalCats WHERE GoalCatID=#GoalCatID#
</cfquery>

</cftransaction>

<script>
alert("You have successfully deleted the Goal Category.");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_goalcats";
</script>

</cfoutput>