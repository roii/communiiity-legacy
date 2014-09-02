<cfquery name="UpdateAct" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE activity
SET Name='#TRIM(form.name)#',

<cfif IsNumeric("#form.entries#")>
	Entries=#form.entries#,
<cfelse>
	Entries=0,
</cfif>

<cfif IsNumeric("#form.points#")>
	points=#form.points#,
<cfelse>
	points=0,
</cfif>

<cfif IsNumeric("#form.cash#")>
	cash=#form.cash#,
<cfelse>
	cash=0,
</cfif>

<cfif IsNumeric("#form.education#")>
	education=#form.education#,
<cfelse>
	education=0,
</cfif>

<cfif IsNumeric("#form.displayorder#")>
	displayorder=#form.displayorder#,
<cfelse>
	displayorder=0,
</cfif>


Description='#TRIM(form.description)#'
WHERE activityid=#form.activityid#
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