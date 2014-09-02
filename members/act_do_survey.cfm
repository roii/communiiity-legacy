<cfquery name="surveyDetails" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
   SELECT * FROM forms where formid = #attributes.surveyid#
</cfquery>

<cfif surveyDetails.Online>
  <cflocation url="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=27&surveyid=#attributes.surveyid#">
<cfabort>  
</cfif>

<cfquery name="insertedAlready" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
   SELECT * FROM kids2survey where kidsid=#session.userid# and formid = #attributes.surveyid#
</cfquery>

<cfoutput>
<cfif insertedAlready.recordcount>
  <script>
   alert("Survey has already been added to your list!");
   self.location="http://www.mykidsbiz.com/kidzbiz/dsp_survey_list.cfm";
  </script>
  <cfabort>
</cfif>

		<cfquery name="Addkids2survey" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO kids2survey(
		kidsid,
		formid,
		nocompleted,
		paid,
		completed
		)
		
		VALUES(
		#session.userid#, 
		#form.surveyid#,
		0,
		0,
		0
		)
		</cfquery>

<cfquery name="AllTerms" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
   SELECT * FROM surveyTerms where formid = #attributes.surveyid#
</cfquery>


<h3>Survey has been added to your list successfully!</h3>

<cfif AllTerms.recordcount>
<h4>You have agreed to the following terms and conditions</h4>
<cfloop query="AllTerms">	
	<ul>
	 <li>#Term#
	</ul>
</cfloop>			
</cfif>
<p></p>
<table width="500" cellpadding="0" cellspacing="0" border="0">
<tr><td>
<a href="#request.webroot#/kidzbiz/dsp_print_survey.cfm?surveyid=#attributes.surveyid#" target="_blank"><u>Print Survey</u></a> </td>
<td><a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=article&documentid=35&articleID=27&surveyid=#attributes.surveyid#"><u>Enter Survey</u></a></td>
<td><a href="#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentID=35"><u>Back</u></a></td>
</tr>
</table>

</cfoutput>	