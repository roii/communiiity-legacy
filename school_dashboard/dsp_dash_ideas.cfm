<cfoutput>

<!--- GET ALL STUDENT IDEAS --->
<cfquery name="StudentIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT COUNT(sugID) AS TotalStudentIdeas
FROM Suggestion
WHERE ContactID IN (#AllSchoolKids#)
</cfquery>

<!--- GET ALL TEACHER IDEAS --->
<cfquery name="TeacherIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT COUNT(sugID) AS TotalTeacherIdeas
FROM Suggestion
WHERE ContactID IN (#AllSchoolTeachers#)
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Ideas</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/ideafunl_sml.jpg" alt="Feedback" border="0"></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Students Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#StudentIdeas.TotalStudentIdeas#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Teachers Ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#TeacherIdeas.TotalTeacherIdeas#</td>
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
	<td style="color:##b4b4b4;font-size:11px;padding-left:5px;">Parents Ideas:</td>
	<td style="color:##b4b4b4;font-size:11px;padding-right:5px;" align="center" width="100">?</td>
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