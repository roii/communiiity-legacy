<cfoutput>
<cfquery name="SurveyDetails" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM forms,surveycom where forms.comid = surveycom.surveycomID and formid=#attributes.surveyid#
</cfquery>

<cfmail to="#trim(form.comEmail)#" from="#trim(form.fromEmail)#" subject="#trim(form.subject)#" type="HTML">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>Survey Results Report</title>

<style>

.introduction
{
   FONT-SIZE: 12px;
   COLOR: Black;
   FONT-FAMILY: Arial, Verdana, Tahoma, Trebuchet MS;
   FONT-DECORATION: NONE;
LINE-HEIGHT: 170%;
}


.normal
{
   FONT-SIZE: 11px;
   COLOR: Black;
   FONT-FAMILY: Arial, Verdana, Tahoma, Trebuchet MS;
   FONT-DECORATION: NONE;
LINE-HEIGHT: 150%;
}

</style>


</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


<tr>
<td width="100%" valign="top">


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
	
	<tr>
	<td width="300" valign="top" bgcolor="white"><a href="http://www.my3p.com"><img src="#request.imageroot#/logo.gif" border="0" alt="MyKidzBiz.com"></a></td>
	</tr>
	
	</table>
	
</td>
</tr>

</table>

</td>
<!--- BLACK STRIP --->
</tr>



<tr>
<td width="100%" valign="top">

<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
	
<tr>
<td>


	<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
	<td class="normal"><br>

		
		<table width="100%" cellpaddinig="10" border="0">
	
		<tr>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1"  border="0"></td>
		<td class="normal">
<cfif #SurveyDetails.comContact# neq ''>
Dear #SurveyDetails.comContact#<BR><BR>
</cfif>

Thank you for doing survey with myKidsBiz, click on the following link to view your #SurveyDetails.title# survey results<br><br>
<a href="http://www.my3p.com/surveyengine/dsp_results_page.cfm?surveyid=#form.surveyid#" target="_blank">View Survey Results</a>
<hr width="100%" size="1" color="e2e2e2">

		<span style="font-size:12px;"><strong>Regards<br>
		The Team @ MyKidsBiz</strong></span>
		
		</td>
		</tr>
		
		</table>
		
	
	</td>
	</tr>
	
	</table>
		
	
</td>
</tr>
	
</table>


</td>
</tr>

</table>

	

</cfmail>

<script>
	alert("Survey results email has been sent successfully!");
	self.location="http://www.my3p.com/surveyengine/default.cfm?survey_page&surveyid=#form.surveyid#&at=1";
</script>
</cfoutput>	