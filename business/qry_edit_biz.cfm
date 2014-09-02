<cfparam name="attributes.resid" default="0">

<cfquery name="CurrentRes" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT * FROM kidsFamily
WHERE kidsid=#session.UserID#
ORDER BY kidsfamilyId desc
</cfquery>

<cfif attributes.resid NEQ "0">
  <cfquery name="res" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
    SELECT * FROM kidsFamily where kidsfamilyID=#attributes.resid#
  </cfquery>
</cfif>