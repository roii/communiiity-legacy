<cfoutput>
<cfparam name="attributes.comid" default="">
<cftransaction action="BEGIN">

<!--- UPDATE CONTACT INFO --->
<cfquery name="ComDetails" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  select * from surveyCom WHERE surveyComID=#attributes.ComID#
</cfquery>

<cfif ComDetails.recordcount GT 0>
  <cfif ComDetails.comlogo NEQ ''>
     <cffile action="DELETE" file="#request.fileroot#\surveyengine\images\#ComDetails.comlogo#">
  </cfif>
</cfif>

<cfquery name="DeleteCom" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from surveyCom WHERE surveyComID=#attributes.ComID#
</cfquery>

<!---
<cfquery name="DeleteSurvey" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
  delete from kidclientlinks WHERE ClientID=#attributes.clientid# and kidid = #session.userid#
</cfquery>
--->
</cftransaction>

<script>
alert("The company has been deleted from the database!");
self.location="#request.webroot#/surveyengine/default.cfm?fuseaction=add_com&at=2";
</script>

</cfoutput>