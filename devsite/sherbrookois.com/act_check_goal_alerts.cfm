<!--- CHECK WHEN GOAL REMINDERS LAST SEND --->
<cfquery name="RemindersLastSent" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GoalRemind_LastSent
FROM ScheduledTask_Log
</cfquery>


<!--- IF THE REMINDERS WERE LAST SENT MORE THAN 24hrs AGO --->
<cfif DateCompare(DateAdd('h', 24, RemindersLastSent.GoalRemind_LastSent), localDateTime) EQ -1>


	<!--- GET ALL ACTIVE GOALS WITH EMAIL ALERTS ACTIVATED FOR ACTIVE MEMBERS --->
	<cfquery name="AllActiveGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Goals.GoalID, Goals.GoalTitle, Goals.GoalDetails, Goals.AddedDate, Goals.Frequency, Goals.LastSent, GoalKidsLink.bywhen, GoalKidsLink.percentdone, Contacts.FirstName, Contacts.EmailAddress
	FROM Goals, GoalKidsLink, Contacts
	WHERE Goals.SendEmails=1
	AND Goals.GoalID=GoalKidsLink.Goalid
	AND GoalKidsLink.archived=0
	AND GoalKidsLink.Kidsid=Contacts.ContactID
	AND Contacts.ContactStatus LIKE '%Active%'
	ORDER BY Contacts.EmailAddress
	</cfquery>
	
	
	<!--- LOOP EACH GOAL --->
	<cfloop query="AllActiveGoals">
	
		<cfset this_GoalID = AllActiveGoals.GoalID>
		<cfset this_GoalTitle = AllActiveGoals.GoalTitle>
		<cfset this_GoalDetails = AllActiveGoals.GoalDetails>
		<cfset this_AddedDate = AllActiveGoals.AddedDate>
		<cfset this_Frequency = AllActiveGoals.Frequency>
		<cfset this_LastSent = AllActiveGoals.LastSent>
		<cfset this_bywhen = AllActiveGoals.bywhen>
		<cfset this_percentdone = AllActiveGoals.percentdone>
		<cfset this_FirstName = AllActiveGoals.FirstName>
		<cfset this_EmailAddress = AllActiveGoals.EmailAddress>
		
		
	
		<!--- CHECK IF LAST SENT IS A VALID DATE --->
		<cfif IsDate("#this_LastSent#")>
		
			<!--- ADD FREQUENCY TO LAST SENT TO GET DATE NEXT DUE TO SEND --->
			<cfset next_senddate = DateAdd('d', this_Frequency, this_LastSent)>
			
			<!--- CHECK IF NEXT SEND DATE IS LESS THAN NOW. IF YES SEND --->
			<cfif DateCompare(next_senddate, localDateTime) EQ -1>
			
				<cfinclude template="act_check_goal_send.cfm">
			
			</cfif>
			
			<!--- UPDATE WHEN GOAL REMINDERS LAST SEND --->
			<cfquery name="UpdateGoalLastSent" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE  Goals
			SET LastSent=#createODBCDateTime(localDateTime)#
			WHERE GoalID=#this_goalID#
			</cfquery>
		
		
		<!--- LAST SENT IS NOT A VALID DATE. IT HAS NOT BEEN SENT BEFORE. --->
		<cfelseif IsDate("#this_AddedDate#")>
			
			<!--- ADD FREQUENCY TO ADDED DATE TO GET DATE NEXT DUE TO SEND --->
			<cfset next_senddate = DateAdd('d', this_Frequency, this_AddedDate)>
			
			<!--- CHECK IF NEXT SEND DATE IS LESS THAN NOW. IF YES SEND --->
			<cfif DateCompare(next_senddate, localDateTime) EQ -1>
			
				<cfinclude template="act_check_goal_send.cfm">
			
			</cfif>
			
			<!--- UPDATE WHEN GOAL REMINDERS LAST SEND --->
			<cfquery name="UpdateGoalLastSent" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE  Goals
			SET LastSent=#createODBCDateTime(localDateTime)#
			WHERE GoalID=#this_goalID#
			</cfquery>
			
		<cfelse>
		
			<!--- ADD FREQUENCY TO ADDED DATE TO GET DATE NEXT DUE TO SEND --->
			<cfset next_senddate = DateAdd('d', this_Frequency, localDateTime)>
			
			<!--- CHECK IF NEXT SEND DATE IS LESS THAN NOW. IF YES SEND --->
			<cfif DateCompare(next_senddate, localDateTime) EQ -1>
			
				<cfinclude template="act_check_goal_send.cfm">
			
			</cfif>
			
			<!--- UPDATE WHEN GOAL REMINDERS LAST SEND --->
			<cfquery name="UpdateGoalLastSent" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE  Goals
			SET LastSent=#createODBCDateTime(localDateTime)#
			WHERE GoalID=#this_goalID#
			</cfquery>
		
		</cfif>
		
	</cfloop>
	
	<!--- UPDATE WHEN GOAL REMINDERS LAST SEND --->
	<cfquery name="UpdateLastSent" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE  ScheduledTask_Log
	SET GoalRemind_LastSent=#createODBCDateTime(localDateTime)#
	</cfquery>
	

</cfif>