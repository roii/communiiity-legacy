<cfparam name="attributes.wizard" default="on">

<cfquery name="SurveyDetails" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM forms,surveycom where forms.comid = surveycom.surveycomID and formid=#attributes.surveyid#
</cfquery>

<cfquery name="AllTerms" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT 	* FROM 	surveyTerms where formid = #attributes.surveyid#
</cfquery>

<cfquery name="kidsSurveys" datasource="mykidsbiz" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT * FROM forms f,surveycom s,kids2survey ks,contacts c where f.comid = s.surveycomID 
	and f.formid = ks.formid and c.contactid = ks.kidsid and ks.formid = #attributes.surveyid#
	order by f.formID desc
</cfquery>

<cfquery name="kidsSurveys" dbtype="query" username="mykidsbizcomi" password="u+67eNfJ">
   Select distinct firstname, lastname, nocompleted,completed,paid from kidsSurveys
</cfquery>

<cfoutput>
<cfif attributes.wizard eq 'on'>
<TABLE class="reg">
  <TR>
    <TD WIDTH="100%" CLASS="steps">
      <IMG BORDER="0" SRC="#request.webroot#/images/1off.gif" align="absmiddle">&nbsp;   
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_survey&at=1">Add Survey</a>&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp;            
      <IMG BORDER="0" SRC="#request.webroot#/images/2off.gif" align="absmiddle">&nbsp; 
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_term&surveyid=#attributes.surveyID#&at=4">Add Terms</a>&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/3off.gif" align="absmiddle">&nbsp;            
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_Q&surveyid=#attributes.surveyID#&at=5">Add Questions</a> &nbsp;
      <IMG BORDER="0" SRC="#request.webroot#/images/rarrow.gif" align="absmiddle">&nbsp; 
      <IMG BORDER="0" SRC="#request.webroot#/images/4on.gif" align="absmiddle">&nbsp;            
      <a href="#request.webroot#/surveyengine/default.cfm?fuseaction=survey_page&surveyid=#attributes.surveyID#&at=1">Complete Survey</a>
      </TD>           
  </TR>
</table>
</cfif>
 
<br>


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0" width=550>

	<tr>
	<td style="color:white;" width="100%">
         <img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0">
        <strong>SURVEY PAGE</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0">
        </td>
	</tr>
	</table>

	<cfif SurveyDetails.NoNeeded neq 0>
             <cfset done=SurveyDetails.NoDone/SurveyDetails.NoNeeded * 100>
	  <cfelse>
            <cfset done=0>
	  </cfif>
	  <cfset todo=100-done>

	<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0" width=650>

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0" width=650>
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Survey Number</td>
			<td>#SurveyDetails.formid#</td>
			</tr>

			<tr>
			<td style="color:404040;">Title</td>
			<td>#SurveyDetails.title#</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Description</td>
			<td>#SurveyDetails.description#</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Type</td>
			<td><cfif SurveyDetails.online>Online<cfelse>Paper-Based</cfif></td>
			</tr>
			
			<tr>
			<td style="color:404040;">Cost Per Survey</td>
			<td>#dollarformat(SurveyDetails.price)#</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Company</td>
			<td>
			#SurveyDetails.ComName#
			</td>
			</tr>

			<tr>
			<td style="color:404040;">Number Completed</td>
			<td>
			<cfset left=SurveyDetails.NoNeeded-SurveyDetails.NoDone>
			<table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
		          <tr>
			   <td width="50%" align=left>#SurveyDetails.NoDone# Done</td>
			   <td width="50%" align=right>#left# To Go</td>
			  </tr>
			</table>
			<table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0" width="200">
	  		<tr>
	    		<td style="background-color:red" width="#done#%"><cfif done GT 0>&nbsp;</cfif></td>
           		<td style="background-color:green" width="#todo#%"><cfif todo GT 0>&nbsp;</cfif></td>
	  		</tr>
	  		</table>
			</td>
			</tr>

			<tr>
			<td style="color:404040;">Deadline</td>
			<td>#dateformat(SurveyDetails.deadline,"dd/mmm/yyyy")#</td></tr>

			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
				
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>
<br>

<cfif SurveyDetails.online>
<cfelse>
<cfif kidsSurveys.recordcount GT 0>
  <table cellSpacing="1" cellPadding="0" bgColor="e3f4f6" border="0">
	<tr bgColor="a0d8e0">
         <td width="250"><b>Kid</b></td>
         <td width="250"><b>Number Completed</b></td>
	 <td width="250"><b>Status</b></td>
       </tr>
      <cfloop query="kidsSurveys">
       <tr bgColor="e3f4f6">
         <td>#kidsSurveys.firstname# #kidsSurveys.lastname#</td>
	 <td>#kidsSurveys.nocompleted#</td>
	 <td><cfif kidsSurveys.completed eq 0>In Progress<cfelseif kidsSurveys.paid>Paid<cfelse>Pending</cfif></td>
       </tr>
    </cfloop>
</table>	
<cfelse>
<p>There are currently no kids doing this survey</p>
</cfif>
</cfif>

<br>
<span class="header">Terms and Conditions</span>
<cfif AllTerms.recordcount>
<ol>
  <cfloop query="AllTerms">
    <li><cfif Allterms.imageloc neq ''><img src="images/#Allterms.imageLoc#"><br></cfif>#AllTerms.Term#</li>
  </cfloop>
</ol>
<cfelse>
<p>No terms have been added to this survey.</p>
</cfif>
<p>
[<a href="#request.webroot#/surveyengine/dsp_survey_form.cfm?surveyid=#attributes.surveyid#" target="_blank">Preview online form</a>]
[<a href="#request.webroot#/members/dsp_print_survey.cfm?surveyid=#attributes.surveyid#" target="_blank">Preview print version</a>]
[<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=results_page&surveyid=#attributes.surveyid#&at=1">View Results</a>]
[<a href="#request.webroot#/surveyengine/dsp_results_page.cfm?surveyid=#attributes.surveyid#" target="_blank">Print Results</a>]
[<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=email_results&surveyid=#attributes.surveyid#&at=1">Email Results</a>]
[<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_survey&at=1"><cfif attributes.wizard eq 'on'>Save Survey<cfelse>Cancel</cfif></a>]
</p>
</cfoutput>