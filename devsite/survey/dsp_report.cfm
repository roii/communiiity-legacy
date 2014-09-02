<cfoutput>


<cfparam name="ReportMode" default="Overall">


<CFQUERY NAME="SurveyDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#QuestionaireID#
</CFQUERY>


<!--- GET QUESTIONAIRE SECTIONS --->
<cfquery name="qry_QuestionaireSections" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaireSections
WHERE QuestionaireID=#QuestionaireID#
AND Deleted=0
ORDER BY QuestionaireSection_number
</cfquery>


<!--- TOTAL RESPONDERS --->
<cfquery name="TotalAnswers" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT UserID
FROM NewSurvey_Answers
WHERE QuestionaireID=#QuestionaireID#
GROUP BY UserID
ORDER BY UserID
</cfquery>

<cfset all_users = valuelist(TotalAnswers.UserID)>
<cfset TotalResponders = TotalAnswers.RecordCount>




<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Questionairre Report</title>
<cfinclude template="../templates/styles.cfm">
<style>

.small_report
{
	font-size: 11px;
	color: Black;
	font-family: Arial;
	font-decoration: NONE;
	line-height: 130%;
}	
</style>
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="white">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" valign="middle"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Questionnaire Report</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" style="height:1px;"></td>
</tr>

<tr>
<td bgcolor="##000000" style="width:40px;" align="center"></td>
<td style="width:1px;" bgcolor="white"></td>
<td valign="top">
<br>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<tr>
	<td style="padding-left:20px;" class="small_report">
			
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<form method="post" action="dsp_report.cfm">
			<input type="hidden" name="QuestionaireID" value="#QuestionaireID#">
			<tr>
			<td style="color:Gray;" class="small_report"><strong>Report Type:</strong> &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="reportMode" value="Overall" style="border:solid 0px white;"<cfif IsDefined("reportMode") AND ReportMode EQ 'Overall'> checked</cfif>> Overall Report &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="reportMode" style="border:solid 0px white;" value="Individual"<cfif IsDefined("reportMode") AND ReportMode EQ 'Individual'> checked</cfif>> Individual Report &nbsp;&nbsp;&nbsp;&nbsp; <input type="submit" value=">>" style="border:solid 0px white;cursor:hand;">
			</td>
			</tr>
			</form>
			
			</table>
			
	<hr width="100%" size="1" color="##e2e2e2"><br><br>
			
	<span style="font-size:22px;font-family:Arial;"><strong>#TRIM(SurveyDetails.Questionaire_Name)#</strong></span><br>
	<br>
	
	

		
		
	<cfif ReportMode EQ 'Overall'>
		<cfinclude template="dsp_report_overall.cfm">
		
	<cfelseif ReportMode EQ 'Individual'>
		<cfinclude template="dsp_report_individual.cfm">
		
	</cfif>
		
		
		
	</td>
	</tr>
	
	</table>
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


