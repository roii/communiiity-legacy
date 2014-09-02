<cfinclude template="qry_activity.cfm">
<cfoutput>
 
<br>


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0" width=550>

	<tr>
	<td style="color:white;" width="100%">
         <img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0">
        <strong>PRIZE PAGE</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0">
        </td>
	</tr>
	</table>

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
			<td>#CurrentPrize.prizeid#</td>
			</tr>

			<tr>
			<td style="color:404040;">Name</td>
			<td>#CurrentPrize.name#</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Description</td>
			<td>#CurrentPrize.description#</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Status</td>
			<td><cfif CurrentPrize.status>Open<cfelse>Closed</cfif></td>
			</tr>

			<tr>
			<td style="color:404040;">Company</td>
			<td>
			#SurveyDetails.ComName#
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
[<a href="#request.webroot#/surveyengine/dsp_survey_form.cfm?prizeid=#attributes.prizeid#" target="_blank">Preview online form</a>]
[<a href="#request.webroot#/kidzbiz/dsp_print_survey.cfm?prizeid=#attributes.prizeid#" target="_blank">Preview print version</a>]
[<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=results_page&prizeid=#attributes.prizeid#&at=1">View Results</a>]
[<a href="#request.webroot#/surveyengine/dsp_results_page.cfm?prizeid=#attributes.prizeid#" target="_blank">Print Results</a>]
[<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=email_results&prizeid=#attributes.prizeid#&at=1">Email Results</a>]
[<a href="#request.webroot#/surveyengine/default.cfm?fuseaction=add_survey&at=1"><cfif attributes.wizard eq 'on'>Save Survey<cfelse>Cancel</cfif></a>]
</p>
</cfoutput>