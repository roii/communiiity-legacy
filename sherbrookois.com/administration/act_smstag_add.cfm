<!--- GENERATE NEW TAG ID --->	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT TagID
FROM SMS_Taglines
ORDER BY TagID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.TagID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>

		
<cfquery name="addTag" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO SMS_Taglines(
TagID,
TagType,
TagLine,
DefaultTag,
SponsorID
)
VALUES(
#newID#,
'normal',
'#form.TagLine#',
0,
0
)
 </cfquery>

 

<cfoutput>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("You have added the new SMS Tag-line");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sms_tags')"></body>
  
</cfoutput>