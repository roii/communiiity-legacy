<cfquery name="UpdateIdeaCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE 	SugMainCategory
SET MainCatTitle = '#trim(Form.MainCatTitle)#',
description ='#trim(form.description)#',
Active=#form.Active#,

<cfif IsNumeric("#form.DisplayOrder#")>
	DisplayOrder=#form.DisplayOrder#
<cfelse>
	DisplayOrder=0
</cfif>

WHERE MainCatID = #Form.MainCatID#				
</cfquery>

<cfoutput>


<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	alert("You have updated the IDEAfunL Category.");
	self.close();
}

// -->
</script>

<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug_maincats')"></body>


</cfoutput>