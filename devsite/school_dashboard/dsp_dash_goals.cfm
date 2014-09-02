<cfoutput>

<!--- GET ALL GOALS FOR SCHOOL STUDENTS --->
<cfquery name="AllStudentGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Goals.GoalID, GoalKidsLink.bywhen, GoalKidsLink.archived
FROM Goals, GoalKidsLink
WHERE Goals.GoalID=GoalKidsLink.GoalID
AND GoalKidsLink.KidsID IN (#AllSchoolKids#)
</cfquery>

<!--- GET ALL ACTIVE STUDENT GOALS --->
<cfquery name="StudentActiveGoals" dbtype="query">
SELECT GoalID, bywhen
FROM AllStudentGoals
WHERE Archived=0
</cfquery>

<!--- GET ALL OVERDUE STUDENT GOALS --->
<cfset studentoverdue=0>
<cfloop query="StudentActiveGoals">
<cfset thisdate = DateFormat(StudentActiveGoals.bywhen, "yyyymmdd")>
<cfif DateCompare(thisdate, DateFormat(localDateTime, "yyyymmdd")) EQ -1>
	<cfset studentoverdue=studentoverdue+1>
</cfif> 
</cfloop>

<!--- GET ALL COMPLETED STUDENT GOALS --->
<cfquery name="StudentCompleteGoals" dbtype="query">
SELECT GoalID
FROM AllStudentGoals
WHERE Archived=1
</cfquery>

<!--- GET ALL GOALS FOR SCHOOL TEACHERS --->
<cfquery name="AllTeacherGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Goals.GoalID, GoalKidsLink.bywhen, GoalKidsLink.archived
FROM Goals, GoalKidsLink
WHERE Goals.GoalID=GoalKidsLink.GoalID
AND GoalKidsLink.KidsID IN (#AllSchoolTeachers#)
</cfquery>

<!--- GET ALL ACTIVE TEACHER GOALS --->
<cfquery name="TeacherActiveGoals" dbtype="query">
SELECT GoalID, bywhen
FROM AllTeacherGoals
WHERE Archived=0
</cfquery>

<!--- GET ALL OVERDUE TEACHER GOALS --->
<cfset teacheroverdue=0>
<cfloop query="TeacherActiveGoals">
<cfset thisdate = DateFormat(TeacherActiveGoals.bywhen, "yyyymmdd")>
<cfif DateCompare(thisdate, DateFormat(localDateTime, "yyyymmdd")) EQ -1>
	<cfset teacheroverdue=studentoverdue+1>
</cfif> 
</cfloop>

<!--- GET ALL COMPLETED TEACHER GOALS --->
<cfquery name="TeacherCompleteGoals" dbtype="query">
SELECT GoalID
FROM AllTeacherGoals
WHERE Archived=1
</cfquery>


<cfset AveragePerStudent = (AllStudentGoals.RecordCount/Listlen(AllSchoolKids))>
<cfset AveragePerTeacher = (AllTeacherGoals.RecordCount/Listlen(AllSchoolTeachers))>

<cfset totalActiveGoals = (StudentActiveGoals.RecordCount+TeacherActiveGoals.RecordCount)>
<cfset totalOverDueGoals = (StudentOverDue+TeacherOverDue)>
<cfset totalCompleteGoals = (StudentCompleteGoals.RecordCount+TeacherCompleteGoals.RecordCount)>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Goals</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/goals_sml.jpg" alt="Goals" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Avg. Per Student:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#Ceiling(AveragePerStudent)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Avg. Per Teacher:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#Ceiling(AveragePerteacher)#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Active Goals:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#totalActiveGoals#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Overdue Goals:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#totalOverDueGoals#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Completed Goals:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#totalCompleteGoals#</td>
	</tr>
	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>