<cfoutput>
<cfparam name="attributes.goalid" default="0">
<cfquery name="QueryGoal" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
  select * from Goals WHERE goalid=#attributes.goalid#
</cfquery>

<cftransaction action="BEGIN">
<cfif QueryGoal.recordcount GT 0>
  <cfif QueryGoal.defaultgoal EQ 0>
		<cfquery name="DeleteGoal" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		   delete from Goals WHERE goalid=#attributes.goalid#
		</cfquery>
   </cfif>

	<cfquery name="DeleteGoalLink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
 	    delete from goalkidslink WHERE goalid=#attributes.goalid# and kidsid=#session.userid#
	</cfquery>

</cfif>
</cftransaction>

<script>
alert("Your Goal has been deleted from the database!");
self.location="#request.webroot#/index.cfm?fuseaction=goals&fusesubaction=docs&documentID=38";
</script>

</cfoutput>