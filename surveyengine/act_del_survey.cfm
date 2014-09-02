<cfoutput>
<cfparam name="attributes.formid" default="">
<cftransaction action="BEGIN">

<cfquery name="SurveyQs" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  select * from questions where formid = #attributes.formID#
</cfquery>

<cfquery name="SurveyTerms" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  select * from surveyTerms where formid = #attributes.formID#
</cfquery>

<cftry>

<cfloop query = "SurveyQs">
  <cfquery name="ChoicesD" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
     select * from surveychoice where QID = #SurveyQs.id#
  </cfquery>

  <cfif ChoicesD.recordcount>
   <cfloop query="ChoicesD">
     <cfif ChoicesD.image neq ''>
       <cffile action="DELETE" file="#request.fileroot#\surveyengine\images\#ChoicesD.image#">
     </cfif>
   </cfloop>
  </cfif>

  <cfquery name="DeleteChoices" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
     delete from surveychoice where QID = #SurveyQs.id#
  </cfquery>
  <cfquery name="DeleteResponses" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
     delete from surveyresponse where QID = #SurveyQs.id#
  </cfquery>

  <cfif SurveyQs.image neq ''>
     <cffile action="DELETE" file="#request.fileroot#\surveyengine\images\#SurveyQs.image#">
  </cfif>

</cfloop>

<cfif SurveyTerms.recordcount>
  <cfloop query = "SurveyTerms">
     <cfif SurveyTerms.imageLoc NEQ ''>
       <cffile action="DELETE" file="#request.fileroot#\surveyengine\images\#SurveyTerms.imageLoc#">
     </cfif>
  </cfloop>

  <cfquery name="DeleteTerms" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
     delete from surveyTerms where formid = #attributes.formID#
  </cfquery>
</cfif>

<cfcatch>
	<cfset FileDError = true>
</cfcatch>
</cftry>


<cfquery name="DeleteSurvey" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from forms WHERE formid=#attributes.formID#
</cfquery>

<cfquery name="DeleteQ" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from questions WHERE formID=#attributes.formid#
</cfquery>


<cfquery name="DeleteR" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from responses WHERE formID=#attributes.formid#
</cfquery>

<cfquery name="DeleteRelation" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from kids2survey where formid=#attributes.formid#
</cfquery>

</cftransaction>

<script>
alert("The survey has been deleted from the database!");
self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_survey&at=1";
</script>

</cfoutput>