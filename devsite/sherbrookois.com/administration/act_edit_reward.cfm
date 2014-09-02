<cfparam name="uploadFileError" default="false">


<cfif Trim(form.prizeImage) NEQ ''>
	
	<cftry>
		<cffile action="upload" filefield="Form.prizeImage" destination="#request.fileroot#\images\prize\" nameconflict="overwrite" accept="image/*">

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
country='#INT(form.countryID)#',

<cfif Trim(form.prizeImage) NEQ '' AND uploadFileError EQ 'false'>
	image='thumb_#this_upload_name#',
</cfif>

<cfif IsNumeric("#form.pointsvalue#")>
	pointsvalue=#form.pointsvalue#,
<cfelse>
	pointsvalue=0,
</cfif>

<cfif IsNumeric("#form.quantity#")>
	quantity=#form.quantity#,
<cfelse>
	quantity=0,
</cfif>

<cfif IsNumeric("#form.PromoteOnSide#")>
	PromoteOnSide=#form.PromoteOnSide#,
<cfelse>
	PromoteOnSide=0,
</cfif>

<cfif IsDefined("form.displayOrder") AND IsNumeric("#form.DisplayOrder#")>
	DisplayOrder=#form.DisplayOrder#,
<cfelse>
	DisplayOrder=0,
</cfif>

<cfif IsDefined("form.display") AND form.Display EQ 1>
	Display=1
<cfelse>
	Display=0
</cfif>

WHERE prizepoolid=#form.rewardID#
</cfquery>



<cfif uploadFileError>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Reward details have been saved successfully!\n But image upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_rewards')"></body>

<cfelse>
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Reward details have been saved successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_rewards')"></body>

</cfif>
	

</cfoutput>