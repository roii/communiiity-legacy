<cfquery name="Clients" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT * from contacts,Kidsurvey,kidclientlinks where contacts.contactid = Kidsurvey.clientid
  and kidclientlinks.clientid = contacts.contactid
  and Kidsurvey.kidid = #form.kidid#
  order by clientstageid desc
</cfquery>

<cfoutput query="Clients">
<cfset survey = "form.pay#surveyid#">
<cfif isdefined('#survey#')>
  <cfif evaluate(survey) EQ "1">
   <cfquery name="updatePay" datasource="#dsn#" username="#request.username#" password="#request.password#">
     Update kidsurvey set paid = 1 where surveyid = #surveyid#
   </cfquery>
  </cfif>
</cfif>
</cfoutput>

<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=survey_report&kids_sortby=#form.kids_sortby#&sortorder=#form.sortorder#')">
	</body>
	
	
	</cfoutput>