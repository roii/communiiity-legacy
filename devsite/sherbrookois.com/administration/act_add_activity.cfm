<cfquery name="Addprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Activity (Name,
Description, 
entries,
points,
cash,
education,
displayOrder)
VALUES ('#TRIM(Form.Name)#',
'#TRIM(Form.description)#',

<cfif IsNumeric("#form.entries#")>
	#form.entries#,
<cfelse>
	0,
</cfif>

<cfif IsNumeric("#form.points#")>
	#form.points#,
<cfelse>
	0,
</cfif>

<cfif IsNumeric("#form.cash#")>
	#form.cash#,
<cfelse>
	0,
</cfif>

<cfif IsNumeric("#form.education#")>
	#form.education#,
<cfelse>
	0,
</cfif>

<cfif IsNumeric("#form.displayOrder#")>
	#form.displayOrder#
<cfelse>
	0
</cfif> )
 </cfquery>
 
 
 

<cfoutput>
 <script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		alert("Activity details have been saved successfully!");
		self.close();
	}
	
	// -->
	</script>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_activities')"></body>
	
</cfoutput>