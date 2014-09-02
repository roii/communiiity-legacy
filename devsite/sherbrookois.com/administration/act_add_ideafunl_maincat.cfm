<!--- INSERT CATEGORY INFO --->
<cfquery name="AddMainCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO SugMainCategory(
MainCatTitle,
Description,
Active,
DisplayOrder
)
VALUES(
'#form.MainCatTitle#',
'#form.description#',
#form.Active#,

<cfif IsNumeric("#form.DisplayOrder#")>
	#form.DisplayOrder#
<cfelse>
	0
</cfif>

)
</cfquery>

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->	
<cfoutput>

<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    window.opener.document.location = givenURL;
	alert("You have created the new IDEAfunL category.");
	self.close();
}

// -->
</script>

<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug_maincats')"></body>


</cfoutput>