<cfparam name="uploadFileError" default="false">



<cfif Trim(form.ImageFile) NEQ ''>
	
	<cftry>
		<cffile action="upload" filefield="Form.ImageFile" destination="#request.fileroot#\images\goals\" nameconflict="overwrite" accept="image/*">
		
		<cfset image_upload_name = file.serverfile>
	
	<cfcatch>
		<cfset uploadFileError = true>
	</cfcatch>
	</cftry>

</cfif>	

<!--- IF UPLOAD SUCCESS RESIZE TO THUMB AND REMOVE ORIGINAL --->
<cfif uploadFileError EQ 'false'>

	<cfx_image action="resize" file="#request.fileroot#\images\goals\#image_upload_name#" output="#request.fileroot#\images\goals\thumb_#image_upload_name#" quality="100" x="80" y="60">

	<cffile action="delete" file="#request.fileroot#\images\goals\#image_upload_name#">
	 

</cfif>
		
<cfoutput>


<!--- GENERATE NEW SCHOOL ID --->
	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT GoalCatID
FROM GoalCats
ORDER BY GoalCatID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.GoalCatID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>


<cfquery name="AddGoalCat" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO GoalCats(GoalCatID, CategoryName, DisplayOrder, Deleted<cfif Trim(form.ImageFile) NEQ '' AND uploadFileError EQ 'false'>, ImageFile</cfif>)
VALUES(#newid#, '#TRIM(form.CategoryName)#',<cfif IsDefined("form.displayOrder") AND IsNumeric("#form.DisplayOrder#")>#form.DisplayOrder#,<cfelse>0,</cfif> 0, <cfif Trim(form.ImageFile) NEQ '' AND uploadFileError EQ 'false'>'thumb_#image_upload_name#'</cfif>)
</cfquery>



	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    alert("Goal Category has been saved successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_goalcats')"></body>


</cfoutput>