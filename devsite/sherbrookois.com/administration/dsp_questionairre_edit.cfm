<cfoutput>


<cfparam name="session.Edit_QuestionaireID" default="0">
<cfif IsDefined("QuestionaireID")>
	<cfset session.Edit_QuestionaireID=QuestionaireID>
</cfif>



<cfparam name="session.details_editmode" default="closed">
<cfif IsDefined("details_editmode")>
	<cfset session.details_editmode=details_editmode>
</cfif>



<cfparam name="session.current_section" default="0">
<cfif IsDefined("current_section")>
	<cfset session.current_section=current_section>
</cfif>

<cfparam name="session.current_section_mode" default="view">
<cfif IsDefined("current_section_mode")>
	<cfset session.current_section_mode=current_section_mode>
</cfif>



<cfparam name="session.current_question" default="0">
<cfif IsDefined("current_question")>
	<cfset session.current_question=current_question>
</cfif>

<cfparam name="session.current_question_mode" default="view">
<cfif IsDefined("current_question_mode")>
	<cfset session.current_question_mode=current_question_mode>
</cfif>



<cfparam name="session.current_subquestion" default="0">
<cfif IsDefined("current_subquestion")>
	<cfset session.current_subquestion=current_subquestion>
</cfif>

<cfparam name="session.current_subquestion_mode" default="view">
<cfif IsDefined("current_subquestion_mode")>
	<cfset session.current_subquestion_mode=current_subquestion_mode>
</cfif>







<!--- GET BASIC QUESTIONAIRRE STUFF --->
<cfquery name="QuestionairreStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#session.Edit_QuestionaireID#
</cfquery>



<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Edit Questionairre</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="white">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="###TRIM(AllSettings.BoxColour)#" valign="middle"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Questionnaire Editor</strong></span></td>
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
	<td style="width:10px;"></td>
	<td class="normal" valign="top">
	
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		
		<tr>
		<td class="normal" valign="top"><span style="font-size:14px;"><strong>#TRIM(QuestionairreStuff.Questionaire_Name)#</strong></span><br><br></td>
		</tr>
		
		<cfinclude template="dsp_questionairre_edit_details.cfm">
		
		<tr>
		<td><br><br></td>
		</tr>
		
		
		<cfinclude template="dsp_questionairre_edit_sections.cfm">
		
		
			
		</table>
	
	
	
	</td>
	<td style="width:10px;"></td>
	</tr>
	
		
	</table>
		
		
	
	
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>
	
	


