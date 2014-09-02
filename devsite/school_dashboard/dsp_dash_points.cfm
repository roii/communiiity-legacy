<cfoutput>

<!--- GET STUDENT POINTS --->
<cfquery name="StudentPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalStudentPoints
FROM contact_transactions
WHERE Transaction_Type LIKE '%credit%'
AND Transaction_Account LIKE '%points%'
AND ContactID IN (#AllSchoolKids#)
</cfquery>

<cfif IsNumeric("#StudentPoints.TotalStudentPoints#")>
	<cfset TotalStudentPoints = INT(StudentPoints.TotalStudentPoints)>
<cfelse>
	<cfset TotalStudentPoints = 0>
</cfif>


<!--- GET TEACHER POINTS --->
<cfquery name="TeacherPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalTeacherPoints
FROM contact_transactions
WHERE Transaction_Type LIKE '%credit%'
AND Transaction_Account LIKE '%points%'
AND ContactID IN (#AllSchoolTeachers#)
</cfquery>

<cfif IsNumeric("#TeacherPoints.TotalTeacherPoints#")>
	<cfset TotalTeacherPoints = INT(TeacherPoints.TotalTeacherPoints)>
<cfelse>
	<cfset TotalTeacherPoints = 0>
</cfif>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Points</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/points_sml.jpg" alt="Points" border="0"></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Students:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#INT(TotalStudentPoints)#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Teachers:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#TotalTeacherPoints#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Our School:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#INT((TotalStudentPoints+TotalTeacherPoints)/10)#</td>
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