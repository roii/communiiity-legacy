<cfparam name="uploadFileError" default="false">

<cfset draw_date = CREATEDATE(#mid(form.draw_date,7,4)#,#mid(form.draw_date,4,2)#,#mid(form.draw_date,1,2)#)>

<cfset draw_date = DateFormat(#draw_date#,"mm/dd/yyyy")>

<cfset start_date = CREATEDATE(#mid(form.start_date,7,4)#,#mid(form.start_date,4,2)#,#mid(form.start_date,1,2)#)>

<cfset start_date = DateFormat(#start_date#,"mm/dd/yyyy")>



<cfif Trim(form.prizeImage) NEQ ''>
	
	<cftry>
		<cffile action="upload" filefield="Form.prizeImage" destination="#request.fileroot#\images\prize\" nameconflict="makeunique" accept="image/*">

		<cfset this_upload_name = file.serverfile>
		
		<cfx_image action="resize" file="#request.fileroot#\images\prize\#this_upload_name#" output="#request.fileroot#\images\prize\thumb_#this_upload_name#" quality="100" x="80" y="60">

		<cffile action="delete" file="#request.fileroot#\images\prize\#file.serverfile#">
		
	<cfcatch>
		<cfset uploadFileError = true>
	</cfcatch>
	</cftry>

</cfif>	
		
		
		
<cfoutput>

<cfquery name="UpdatePP" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE prize_pool
SET Name='#TRIM(form.name)#',
Description='#TRIM(form.description)#',
draw_date='#draw_date#',
start_date='#start_date#',
country='#INT(form.countryID)#',

<cfif Trim(form.prizeImage) NEQ '' AND uploadFileError EQ 'false'>
	image='thumb_#this_upload_name#',
</cfif>

<cfif IsNumeric("#form.pointsvalue#")>
	pointsvalue=#form.pointsvalue#,
<cfelse>
	pointsvalue=0,
</cfif>

<cfif IsDefined("form.inviteFriend") AND form.inviteFriend EQ 1>
	inviteFriend=1,
<cfelse>
	inviteFriend=0,
</cfif>

<cfif IsDefined("form.displayOrder") AND IsNumeric("#form.DisplayOrder#")>
	DisplayOrder=#form.DisplayOrder#
<cfelse>
	DisplayOrder=0
</cfif>

WHERE prizepoolid=#form.prizepoolid#
</cfquery>



<cfif uploadFileError>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Prize pool details have been saved successfully!\n But prize image upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes')"></body>

<cfelse>
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Prize pool details have been saved successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes')"></body>

</cfif>
	

</cfoutput>