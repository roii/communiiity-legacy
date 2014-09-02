<cfparam name="activityid" default="">
<cfparam name="kidsid" default="">
<cfparam name="showconfirm" default="true">

<cfif session.userid neq '' and kidsid eq ''>
  <cfquery name="kidsQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
    select * from contacts where contactid = #session.userid#
  </cfquery>
  <cfif kidsQ.recordcount>
    <cfset kidsid=session.userid>
  </cfif>
</cfif>

<cfquery name="prizeQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from prize_activity,prize_pool where prize_pool.prizepoolid = prize_activity.prizepoolid 
  and activityid = #activityid# and prize_pool.status = 1 and getdate() > prize_pool.start_date
</cfquery>

<!-----------------if activity is voting, kids can enter multiple times-------------
<cfif activityid neq 1>
	<cfquery name="checkentryQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
	  select * from prize_entry where activityid = #activityid# and contactid = #kidsid#
	</cfquery>
<cfelse>
   <cfset checkentryQ.recordcount eq 0>
</cfif>--------->

<cfif prizeQ.recordcount>
<cfquery name="activityQ" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select entries from activity where activityid = #activityid#
</cfquery>
<cfset entries = activityQ.entries>

<cfloop query="prizeQ">
<cfloop from="1" to="#entries#" index="i">
<cfquery name="Add_entry" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO prize_entry(
		contactid,
		prizepoolid,
		activityid
		)
		
		VALUES(
		#kidsid#,
		#prizeQ.prizepoolid#,
		#activityID#
		)
</cfquery>
</cfloop>
</cfloop>
<cfif showconfirm eq 'true'>
	<cfoutput>
	  <script>
		alert("You've successfully entered yourself into the draw!");
	  </script>
	</cfoutput>
</cfif>
</cfif>


