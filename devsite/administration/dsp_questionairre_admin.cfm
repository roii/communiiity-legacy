<cfoutput>


<script language="JavaScript">
<!--
function confirmQuestionairreDelete(aURL) {
    if(confirm('Are you sure you want to delete this Questionairre?')) {
      location.href = aURL;
    }
  }
//-->
</script>
	
	

<!--- CHECK FOR Questionairres --->
<cfquery name="AllQuestionairres" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM NewQuestionaires
WHERE Deleted=0
ORDER BY Questionaire_startdate
</cfquery>


	
	
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE QUESTIONAIRRE</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
<a href="#request.webroot#/administration/dsp_questionairre_add.cfm?color=#TRIM(AllSettings.BoxColour)#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>CREATE NEW QUESTIONAIRRE >></strong></a><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td style="font-size:12px;">
	
	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
	<tr bgcolor="##e2e2e2">
	<td style="padding-left:5px;" width="90"><img src="#request.imageroot#/transparent_spc.gif" width="90" height="1" border="0"><br><strong>Date</strong></td>
	<td style="padding-left:5px;" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"><br><strong>Title</strong></td>
	<td style="padding-left:5px;" width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"><br><strong>Status</strong></td>
	<td style="padding-left:5px;" width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"> </td>
	</tr>
	
	
	<cfloop query="AllQuestionairres">
	<tr>
	<td style="padding-left:5px;" valign="top">#DateFormat(AllQuestionairres.Questionaire_startdate, "d-mmm-yyyy")#</td>
	<td style="padding-left:5px;" valign="top">#TRIM(AllQuestionairres.Questionaire_Name)#</td>
	<td style="padding-left:5px;" valign="top">#TRIM(AllQuestionairres.Questionaire_status)#</td>
	<td align="right" valign="top" nowrap><a href="#request.webroot#/survey/dsp_report.cfm?QuestionaireID=#AllQuestionairres.QuestionaireID#" target="ReportWin" ONCLICK="fdbackwindow=window.open ('','ReportWin','toolbar=1,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=550,top=10,left=10')" style="color:##444444;text-decoration:none;">Report</a> | 
<a href="#request.webroot#/administration/dsp_questionairre_edit.cfm?QuestionaireID=#AllQuestionairres.QuestionaireID#" target="editDoc" ONCLICK="fdbackwindow=window.open ('','editDoc','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=550,top=10,left=10')" style="color:##444444;text-decoration:none;">Edit</a> | <a 
	href="javascript:confirmQuestionairreDelete('#request.webroot#/administration/act_questionairre_delete.cfm?QuestionaireID=#AllQuestionairres.QuestionaireID#')" style="color:##444444;text-decoration:none;">Del.</a></td>
	</tr>
	
	<tr>
	<td></td>
	<td style="padding-left:5px;color:##444444;" valign="top" colspan="2"><strong><a href="#request.webroot#/index.cfm?fuseaction=survey&this_QuestionaireID=#AllQuestionairres.QuestionaireID#">#request.webroot#/index.cfm?fuseaction=survey&this_QuestionaireID=#AllQuestionairres.QuestionaireID#</a></strong></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="5"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	</cfloop>
	
	
	</table>


</td>
</tr>

</table>

</cfoutput>