<!--- GET ALL SCHOOLS --->
<cfquery name="AllActiveSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID, NumberStudents
FROM Schools
WHERE schoolstatus LIKE '%Active%'
ORDER BY Schools.SchoolID
</cfquery>


<!--- LOOP EACH SCHOOL --->
<cfloop query="AllActiveSchools">

	<cfset this_SchoolID = AllActiveSchools.SchoolID>
	
	<cfif IsNumeric("#AllActiveSchools.NumberStudents#")>
		<cfset this_TotalStudents = AllActiveSchools.NumberStudents>
	<cfelse>
		<cfset this_TotalStudents = 0>
	</cfif>	
	
	<!--- GENERATE THE PERCENT OF TOTAL STUDENTS ENROLLED IN my3p --->	
	<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, ParentsEmail
	FROM Contacts
	WHERE SchoolID=#this_SchoolID#
	AND ContactTypeID=1
	</cfquery>

	<cfset AllSchoolKids = valueList(AllKids.ContactID)>
	
	<cfif AllKids.RecordCount>
	
		<cftry>
			<cfset BM_studentreg = (AllKids.RecordCount / this_TotalStudents) * 100>
		<cfcatch>
			<cfset BM_studentreg = 0>
		</cfcatch>
		</cftry>
		
		<!--- GENERATE AVERAGE GOALS PER STUDENT --->		
		<cfquery name="AllStudentGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Goals.GoalID, GoalKidsLink.bywhen, GoalKidsLink.archived
		FROM Goals, GoalKidsLink
		WHERE Goals.GoalID=GoalKidsLink.GoalID
		AND GoalKidsLink.KidsID IN (#AllSchoolKids#)
		</cfquery>
		
		<cftry>
			<cfset BM_studentgoals = (AllStudentGoals.RecordCount / Listlen(AllSchoolKids))>
		<cfcatch>
			<cfset BM_studentgoals = 0>
		</cfcatch>
		</cftry>
				
		<!--- GENERATE AVERAGE IDEAS PER STUDENT --->		
		<cfquery name="StudentIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT COUNT(sugID) AS TotalStudentIdeas
		FROM Suggestion
		WHERE ContactID IN (#AllSchoolKids#)
		</cfquery>
		
		<cftry>
			<cfset BM_studentideas = (StudentIdeas.TotalStudentIdeas / Listlen(AllSchoolKids))>
		<cfcatch>
			<cfset BM_studentideas = 0>
		</cfcatch>
		</cftry>
		
	<cfelse>
	
		<cfset BM_studentreg = 0>
		<cfset BM_studentgoals = 0>
		<cfset BM_studentideas = 0>
		
	</cfif>
	
	<!--- UPDATE SCHOOL BENCHMARKS --->
	<cfquery name="UpdateSchool" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Schools
	SET BM_studentreg=#BM_studentreg#,
	BM_studentgoals=#BM_studentgoals#,
	BM_studentideas=#BM_studentideas#
	WHERE SchoolID=#this_SchoolID#
	</cfquery>
	
</cfloop>


<!--- UPDATE WHEN GOAL REMINDERS LAST SEND --->
<cfquery name="UpdateSchoolBenchmarking" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE  ScheduledTask_Log
SET School_Benchmarking=#createODBCDateTime(localDateTime)#
</cfquery>
