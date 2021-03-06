<cfoutput>

<cfparam name="this_QuestionaireID" default="0">
<cfinclude template="app_locals.cfm">

<!--- GET QUESTIONNAIRE --->
	
<cfquery name="SurveyCheck" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#this_QuestionaireID#
</cfquery>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title><cfif IsDefined("this_metatitle")>#TRIM(this_metatitle)#<cfelse>#TRIM(AllSettings.SiteName)#</cfif></title>

<cfif IsDefined("this_metadescription")>
	<meta name="Description" content="#TRIM(this_metadescription)#">
</cfif>

<cfif IsDefined("this_metakeywords")>
	<meta name="Keywords" content="#TRIM(this_metakeywords)#">
</cfif>


<cfinclude template="../templates/styles.cfm">

</head>

<body leftmargin="5" topmargin="0" rightmargin="5" bottommargin="0" marginwidth="5" marginheight="0" bgcolor="##FFFFFF" text="###AllSettings.TextColour#" stats=1>

<!--BEGINNING OF DEEPMETRIX STATSCRIPT-->
<script language="javascript">
var DMdomain = "";
var DMpage = window.location;
var DMVersion = 86;
var DMsendTo = "//collector.deepmetrix.com/dm.gif?";
var DMsession;
function dmerr(){return true;}window.onerror=dmerr;
var u3k8u6y1j3 = new Date();
if (navigator.userAgent.indexOf('Mac') >= 0 && u3k8u6y1j3.getTimezoneOffset() >= 720){
u3k8u6y1j3.setTime (u3k8u6y1j3.getTime() - 1440*60*1000);}
var u3k8u6y1 = location.protocol+DMsendTo+"v="+DMVersion+"&vst=1";
var u3k8u6 = document.cookie.toString();if(u3k8u6.indexOf("_dmid") == -1)
{DMsession = parseInt( Math.random()*1000000 ) + "_" + u3k8u6y1j3.getTime();
var u3k8 = "";if(DMdomain != ""){u3k8 = "domain="+ DMdomain +";";}
document.cookie = "_dmid=" + DMsession + ";expires=Mon, 31-Dec-2008 00:00:00 GMT;"+u3k8+"path=/;";}
u3k8u6 = document.cookie.toString();if(u3k8u6.indexOf('_dmid') == -1){DMsession = "";}
else{if(u3k8u6.indexOf(';') == -1){u3k8u6 = u3k8u6.replace(/_dm/g, ';_dm');}var u3 = u3k8u6.indexOf("_dmid=") + 6;
var g5b1z7i5z6 = u3k8u6.indexOf(";",u3);if (g5b1z7i5z6 == -1){g5b1z7i5z6 = u3k8u6.length;}
DMsession = unescape(u3k8u6.substring(u3,g5b1z7i5z6));}
u3k8u6y1 += "&id="+DMsession+"&url="+escape(DMpage) + "&ref="+escape(document.referrer)+"&lng=" + 
((!document.all || navigator.userAgent.match('Opera')) ? navigator.language : navigator.userLanguage) + 
"&tz=" + (Math.round(new Date('dec 1, 2002').getTimezoneOffset()/60)*-1);
if(screen){u3k8u6y1 += "&scr=" + escape( screen.width + "x" + screen.height + " " + screen.colorDepth + "bpp" );}
u3k8u6y1 += "&rnd=" + new Date().getTime();if(document.layers){
document.write("<la"+"yer name=\"DMStats\" visibility=hide><img src=\""+u3k8u6y1+"\" height=1 width=1></la"+"yer>");
}else{document.write("<di"+
"v id=\"DMStats\" STYLE=\"position:absolute;visibility:hidden;\"><img src=\""+u3k8u6y1+
"\" height=1 width=1></di"+"v>");}
</script>
<!--END OF DEEPMETRIX STATSCRIPT-->


<div style="width: 100%;">

      <cfinclude template="../templates/header_include.cfm">  
	  
	  <div class="content">
          <cfif browser eq 'Internet Explorer'>
  <div class="container" style="text-align: left;">
<cfelse>
  <div class="container">
</cfif> 
		      <table width="100%" cellpadding="0" cellspacing="0" border="0">
			       <!--- MAIN LAYOUT - Leftside column, main column, rightside column ---> 
					<tr> 
						<td width="170" valign="top">
							<cfinclude template="../templates/dsp_internal_Lsidebar.cfm">
						</td> 
						<td width="*" valign="top" style="padding-left:10px;padding-right:10px;" colspan="2"> 
						     <table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="459" height="8" border="0"></td>
	</tr>
	
	<tr>
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	
	<td width="100%" style="padding-left:10px;padding-right:10px;">


<cfif session.UserIsAuthenticated EQ 'yes'>

	<table border="0" cellpadding="0" cellspacing="0" width="100%">

	
	
	
	<tr>
	<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(SectionDetails.Title))#</strong></td>
	<td align="right" width="30" height="20"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" onClick="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
	</tr>
	
	<cfif (TRIM(sectiondetails.details) NEQ '') AND (sectiondetails.details NEQ '<P>&nbsp;</P>')>
		
		
		<tr>
		<td colspan="2">#TRIM(sectiondetails.details)#</td>
		</tr>
	
	</cfif>
	
	
	</table>

	<cfif SurveyCheck.RecordCount>
	
		<cfset this_QuestionaireID = SurveyCheck.QuestionaireID>
	
		<!--- CHECK IF THIS USER HAS COMPLETED THE SURVEY ALREADY --->
		
		<cfquery name="UserCompleted" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT AnswerID
		FROM NewSurvey_Answers
		WHERE QuestionaireID=#this_QuestionaireID#
		AND UserID=#session.UserID#
		</cfquery>
	
		
		<cfif UserCompleted.RecordCount>
			<span style="font-size:14px;color:Black;"><strong>#TRIM(SurveyCheck.Questionaire_Name)#</strong></span><br><br>
			<strong>Thank you for completing this survey. Below are the answers you submitted.</strong><br><br>
			
			<cfinclude template="dsp_survey_answers.cfm">
			
			
		<cfelse>
			<cfinclude template="dsp_survey_form.cfm">
		</cfif>
		
	
	

	<cfelse>

		<br>
		<span style="font-size:14px;"><strong>The questionnaire you're looking for has either finished or been removed.</strong></span>

		<cfabort>

	</cfif>
	
	
	
<cfelse>


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(SectionDetails.Title))#</strong></td>
	<td align="right" width="30" height="20"><cfif (session.UserIsAuthenticated EQ 'yes') AND (session.UserType EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" onClick="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a></cfif></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><cfif SurveyCheck.recordCount><span style="font-size:14px;color:##333333;"><strong>#TRIM(SurveyCheck.Questionaire_Name)#</strong></span><br><br><cfif TRIM(SurveyCheck.Questionaire_details) NEQ ''>#TRIM(SurveyCheck.Questionaire_details)#<br><br></cfif></cfif>

		<table cellpadding="20" cellspacing="0" style="border:solid 1px black;">
		
		<tr>
		<td><span style="color:black;">You must be a #TRIM(AllSettings.SiteName)# member and logged-in to start this survey!<br>
		<a href="#request.webroot#/index.cfm?fuseaction=login" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>Login</strong></a> or <a href="#request.webroot#/index.cfm?fuseaction=join" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>register</strong></a> now!</span></td>
		</tr>
		
		</table>



	</td>
	</tr>
	
	
	</table><br>
	

</cfif>
</td>	
	<td width="1" background="#request.imageroot#/dots_vertical.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>	
	</tr>
	
	</table>	      
						</td> 
						<!---<cfif session.UserIsAuthenticated AND session.UserType EQ 'Administrator'>
							<td width="0"></td>
						<cfelse>
							<td width="170" valign="top" align="right">
								<cfinclude template="../templates/dsp_internal_Rsidebar.cfm">	
							</td>
						</cfif>--->
					</tr>  
			  </table>		
	      </div>
	  </div>	  		   
	  
	  <cfinclude template="../templates/footer_include.cfm">
	  
</div>

<cfinclude template="../templates/dsp_partners.cfm">

</body>
</html>

</cfoutput>