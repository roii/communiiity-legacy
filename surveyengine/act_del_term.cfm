<cfoutput>
<cfparam name="attributes.termid" default="">
<cftransaction action="BEGIN">

<!--- UPDATE CONTACT INFO --->
<cfquery name="TDetails" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  select * from surveyTerms WHERE termid=#attributes.termid#
</cfquery>

<cfif TDetails.recordcount GT 0>
  <cfif TDetails.imageLoc NEQ ''>
     <cffile action="DELETE" file="#request.fileroot#\surveyengine\images\#TDetails.imageLoc#">
  </cfif>
</cfif>

<cfquery name="DeleteT" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from surveyTerms WHERE termid=#attributes.termid#
</cfquery>

<!---
<cfquery name="DeleteSurvey" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from kidclientlinks WHERE ClientID=#attributes.clientid# and kidid = #session.userid#
</cfquery>
--->
</cftransaction>

<script>
alert("The term has been deleted from the database!");
self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_term&at=4&surveyID=#attributes.surveyID#";
</script>

</cfoutput>