<cfoutput>

<!--- STUDENT REG POSITION --->
<cfquery name="StudentReg" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID
FROM Schools
WHERE SchoolStatus LIKE '%Active%'
ORDER BY BM_studentreg DESC
</cfquery>

<cfset studentreg_rankings = valueList(StudentReg.SchoolID)>
<cfset thisschool_studentreg_ranking = ListFind(studentreg_rankings, session.User_SchoolID, ",")>
<cfset thisschool_studentreg_percent = ((thisschool_studentreg_ranking / TotalSchools.recordcount) * 100)>


<!--- STUDENT GOALS POSITION --->
<cfquery name="StudentGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID
FROM Schools
WHERE SchoolStatus LIKE '%Active%'
ORDER BY BM_studentgoals DESC
</cfquery>

<cfset studentgoal_rankings = valueList(StudentGoals.SchoolID)>
<cfset thisschool_studentgoal_ranking = ListFind(studentgoal_rankings, session.User_SchoolID, ",")>
<cfset thisschool_studentgoal_percent = ((thisschool_studentgoal_ranking / TotalSchools.recordcount) * 100)>

<!--- STUDENT IDEAS POSITION --->
<cfquery name="StudentIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID
FROM Schools
WHERE SchoolStatus LIKE '%Active%'
ORDER BY BM_studentideas DESC
</cfquery>

<cfset StudentIdeas_rankings = valueList(StudentIdeas.SchoolID)>
<cfset thisschool_StudentIdeas_ranking = ListFind(StudentIdeas_rankings, session.User_SchoolID, ",")>
<cfset thisschool_StudentIdeas_percent = ((thisschool_StudentIdeas_ranking / TotalSchools.recordcount) * 100)>

<!--- STUDENT FEEDBACK GIVEN POSITION --->
<cfquery name="StudentFeedbackGiven" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID
FROM Schools
WHERE SchoolStatus LIKE '%Active%'
ORDER BY BM_feedback_given DESC
</cfquery>

<cfset StudentFeedbackGiven_rankings = valueList(StudentFeedbackGiven.SchoolID)>
<cfset thisschool_StudentFeedbackGiven_ranking = ListFind(StudentFeedbackGiven_rankings, session.User_SchoolID, ",")>
<cfset thisschool_StudentFeedbackGiven_percent = ((thisschool_StudentFeedbackGiven_ranking / TotalSchools.recordcount) * 100)>


<!--- STUDENT FEEDBACK RECEIVED POSITION --->
<cfquery name="StudentFeedbackReceived" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID
FROM Schools
WHERE SchoolStatus LIKE '%Active%'
ORDER BY BM_feedback_given DESC
</cfquery>

<cfset StudentFeedbackReceived_rankings = valueList(StudentFeedbackReceived.SchoolID)>
<cfset thisschool_StudentFeedbackReceived_ranking = ListFind(StudentFeedbackReceived_rankings, session.User_SchoolID, ",")>
<cfset thisschool_StudentFeedbackReceived_percent = ((thisschool_StudentFeedbackReceived_ranking / TotalSchools.recordcount) * 100)>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Benchmarking with other schools</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/Benchmarking_sml.jpg" alt="Benchmarking" border="0"></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Student Registration %:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="150">Ranked in the top <strong>#ceiling(thisschool_studentreg_percent)#%</strong></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Goals Per Student:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="150">Ranked in the top <strong>#ceiling(thisschool_studentgoal_percent)#%</strong></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Ideas per student:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="150">Ranked in the top <strong>#ceiling(thisschool_StudentIdeas_percent)#%</strong></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Feedback given by students:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="150">Ranked in the top <strong>#ceiling(thisschool_StudentFeedbackGiven_percent)#%</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Feedback received by students:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="150">Ranked in the top <strong>#ceiling(thisschool_StudentFeedbackReceived_percent)#%</td>
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