<cfoutput>

<cfquery name="StudentIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM Suggestion
WHERE ContactID IN (#AllSchoolKids#)
</cfquery>

<cfif StudentIdeas.RecordCount>

	<cfset allstudentideas = valueList(StudentIdeas.SugID)>

	<!--- GET ALL COMMENTS RECEIVED ON STUDENT IDEAS --->
	<cfquery name="StudentFeedbackReceived" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Count(SugID) AS Total_StudentFeedbackReceived
	FROM SugVote
	WHERE SugID IN (#allstudentideas#)
	</cfquery>

</cfif>


<cfquery name="StudentFeedbackGiven" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM SugVote
WHERE ContactID IN (#AllSchoolKids#)
</cfquery>


<cfquery name="TeacherIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM Suggestion
WHERE ContactID IN (#AllSchoolTeachers#)
</cfquery>

<cfif TeacherIdeas.RecordCount>

	<cfset allTeacherideas = valueList(TeacherIdeas.SugID)>

	<!--- GET ALL COMMENTS RECEIVED ON Teacher IDEAS --->
	<cfquery name="TeacherFeedbackReceived" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Count(SugID) AS Total_TeacherFeedbackReceived
	FROM SugVote
	WHERE SugID IN (#allTeacherideas#)
	</cfquery>

</cfif>


<cfquery name="TeacherFeedbackGiven" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID
FROM SugVote
WHERE ContactID IN (#AllSchoolTeachers#)
</cfquery>
	
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Feedback</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/feedback_sml.jpg" alt="Feedback" border="0"></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Students Feedback Given:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#StudentFeedbackGiven.RecordCount#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Students Feedback Received:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><cfif StudentIdeas.RecordCount>#StudentFeedbackReceived.Total_StudentFeedbackReceived#<cfelse>0</cfif></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Teachers Feedback Given:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#TeacherFeedbackGiven.RecordCount#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Teachers Feedback Received:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100"><cfif TeacherIdeas.RecordCount>#TeacherFeedbackReceived.Total_TeacherFeedbackReceived#<cfelse>0</cfif></td>
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