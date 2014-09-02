<cfparam name="uploadFileError" default="false">
<cfparam name="image_upload_name" default="">


<cfif Trim(form.ImageFile) NEQ ''>
	
	<cftry>
		<cffile action="upload" filefield="Form.ImageFile" destination="#request.fileroot#\images\goals\" nameconflict="overwrite" accept="image/*">

		<cfset image_upload_name = file.serverfile>
	
	<cfcatch>
		<cfset uploadFileError = true>
	</cfcatch>
	</cftry>

</cfif>	


<cfif uploadFileError EQ 'false'>

	<cfx_image action="resize" file="#request.fileroot#\images\goals\#image_upload_name#" output="#request.fileroot#\images\goals\thumb_#image_upload_name#" quality="100" x="80" y="60">

	<cffile action="delete" file="#request.fileroot#\images\goals\#image_upload_name#">
	 

</cfif>
		
		
<cfoutput>

<cfquery name="UpdateGoalCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE GoalCats
SET CategoryName='#TRIM(form.CategoryName)#',


<cfif Trim(form.ImageFile) NEQ '' AND uploadFileError EQ 'false' AND image_upload_name NEQ ''>
	ImageFile='thumb_#image_upload_name#',
</cfif>

<cfif IsDefined("form.displayOrder") AND IsNumeric("#form.DisplayOrder#")>
	DisplayOrder=#form.DisplayOrder#
<cfelse>
	DisplayOrder=0
</cfif>

WHERE GoalCatID=#form.GoalCatID#
</cfquery>



	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Goal Category details have been saved successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_goalcats')"></body>


</cfoutput>