<cfoutput>

<cfparam name="AnswerCount" default="0">

<cfquery name="SurveyDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#QuestionaireID#
</cfquery>


<cfquery name="QuestionDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestions
WHERE QuestionID=#QuestionID#
</cfquery>


<cfif QuestionDetails.PrimaryQuestionID NEQ 0>

	<cfquery name="PrimaryQuestionDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT *
	FROM NewQuestions
	WHERE QuestionID=#QuestionDetails.PrimaryQuestionID#
	</cfquery>

</cfif>



<cfif IsDefined("Option")>

	<cfquery name="OptionStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT *
	FROM NewQuestionOptions
	WHERE QuestionID=#QuestionID#
	AND Option_order=#option#
	</cfquery>
	
	
</cfif>


<cfquery name="AnswerDetails" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT AnswerDetails, Answer_Other
FROM NewSurvey_Answers
WHERE QuestionaireID=#QuestionaireID#
AND QuestionID=#QuestionID#
</cfquery>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
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

	<title>#TRIM(AllSettings.SiteName)# - Questionairre Report</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="white">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" valign="middle"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Questionnaire Report - Related Comments</strong></span></td>
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
	<td style="padding-left:20px;" class="small_report"><br>
			
						
			
	<span style="font-size:22px;font-family:Arial;"><strong>#TRIM(SurveyDetails.Questionaire_Name)#</strong></span><br>
	<br>
	
	<hr width="100%" size="1" color="##e2e2e2">
	
	<cfif QuestionDetails.PrimaryQuestionID NEQ 0>
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td width="40" valign="top" class="small_report"><strong>Q.#TRIM(PrimaryQuestionDetails.Question_number)#</strong></td>
		<td valign="top" class="small_report"><strong>#TRIM(PrimaryQuestionDetails.Question_Name)#</strong><br><br>
		#TRIM(QuestionDetails.Question_Name)#</td>
		</tr>
		
		<cfif IsDefined("Option")>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"></td>
			</tr>
			
			<tr>
			<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
			<td class="small_report"><strong>OPTION #option#</strong> - #TRIM(OptionStuff.Option_Name)#</td>
			</tr>
			
		</cfif>
		
		</table><br>
	
	<cfelse>
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td width="40" valign="top" class="small_report"><strong>Q.#TRIM(QuestionDetails.Question_number)#</strong></td>
		<td valign="top" class="small_report"><strong>#TRIM(QuestionDetails.Question_Name)#</strong></td>
		</tr>
		
		<cfif IsDefined("Option")>
			
			<tr>
			<td colspan="2"><hr width="100%" size="1" color="##e2e2e2"><br></td>
			</tr>
			
			<tr>
			<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
			<td class="small_report"><strong>OPTION #option#</strong> - #TRIM(OptionStuff.Option_Name)#</td>
			</tr>
			
		</cfif>
		
		</table><br>
	
	</cfif>
	
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<cfloop query="AnswerDetails">
		
		
		<cfif IsDefined("Option")>
			
			<cftry>
			<cfif (ListGetAt(TRIM(AnswerDetails.Answer_other), option, ",") NEQ '-') AND (ListGetAt(TRIM(AnswerDetails.Answer_other), option, ",") NEQ '') AND (ListGetAt(TRIM(AnswerDetails.Answer_other), option, ",") NEQ ' ')>
				
				<cfset answercount = answercount+1>
				
				<tr>
				<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
				<td>
					
					<table width="100%" cellpadding="0" cellspacing="0"<cfif AnswerDetails.currentrow EQ AnswerDetails.recordcount> style="border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;border-left:solid 1px ##e2e2e2;border-right:solid 1px ##e2e2e2;"<cfelse> style="border-top:solid 1px ##e2e2e2;border-left:solid 1px ##e2e2e2;border-right:solid 1px ##e2e2e2;"</cfif>>
					<tr>
					<td width="20" valign="top" class="small_report">#currentrow#.</td>
					<td valign="top" class="small_report">#ListGetAt(TRIM(AnswerDetails.Answer_other), option, ",")#</td>
					</tr>
					</table>
					
				</td>
				<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
				</tr>
			
			</cfif>
			<cfcatch>
			
				<cfif TRIM(AnswerDetails.Answer_other) NEQ '-'>
				<cfset answercount = answercount+1>
				
					<tr>
					<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
					<td>
						
						<table width="100%" cellpadding="0" cellspacing="0"<cfif AnswerDetails.currentrow EQ AnswerDetails.recordcount> style="border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;border-left:solid 1px ##e2e2e2;border-right:solid 1px ##e2e2e2;"<cfelse> style="border-top:solid 1px ##e2e2e2;border-left:solid 1px ##e2e2e2;border-right:solid 1px ##e2e2e2;"</cfif>>
						<tr>
						<td width="20" valign="top" class="small_report">#answercount#.</td>
						<td valign="top" class="small_report">#AnswerDetails.Answer_other#</td>
						</tr>
						</table>
						
					</td>
					<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
					</tr>
					
				</cfif>
				
			</cfcatch>
			</cftry>
			
			
		<cfelse>
		
			<cfif (TRIM(AnswerDetails.Answer_other) NEQ '-') AND (TRIM(AnswerDetails.Answer_other) NEQ '') AND (TRIM(AnswerDetails.Answer_other) NEQ '&nbsp;')>
			<cfset answercount = answercount+1>
				<tr>
				<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
				<td>
					
					<table width="100%" cellpadding="0" cellspacing="0" border="0"<cfif AnswerDetails.currentrow EQ AnswerDetails.recordcount> style="border-top:solid 1px ##e2e2e2;border-bottom:solid 1px ##e2e2e2;border-left:solid 1px ##e2e2e2;border-right:solid 1px ##e2e2e2;"<cfelse> style="border-top:solid 1px ##e2e2e2;border-left:solid 1px ##e2e2e2;border-right:solid 1px ##e2e2e2;"</cfif>>
					<tr>
					<td width="20" valign="top" class="small_report">#answercount#.</td>
					<td valign="top" class="small_report">#AnswerDetails.Answer_other#</td>
					</tr>
					</table>
					
				</td>
				<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
				</tr>
			
			</cfif>
		
		</cfif>
		
		</cfloop>
	
		</table>
		
		
		<cfif answercount EQ 0>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="40"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
			<td>
			
				<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="##e2e2e2">
				<tr>
				<td class="small_report"><em>No comments recorded.</em></td>
				</tr>
				</table>
			
			</td>
			<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
			</tr>
			</table>
		
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
	
	


