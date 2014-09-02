<cfparam name="uploadFileError" default="false">

<cfif Trim(#Form.termImage#) NEQ ''>
			<cftry>
				<cffile action="upload" filefield="Form.termImage" destination="#request.fileroot#\surveyengine\images\" nameconflict="overwrite" accept="image/*">
    				<cfset tImage="Term_#form.termid#.#File.ServerFileExt#">
	    			<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\surveyengine\images\#tImage#" nameconflict="OVERWRITE">
			<cfcatch>
				<cfset uploadFileError = true>
			</cfcatch>
			</cftry>
		</cfif>	
		
<cfoutput>

<cfquery name="UpdateTerm" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
UPDATE surveyTerms
SET 
Term='#TRIM(form.term)#'
<cfif Trim(#Form.termImage#) NEQ ''>,imageLoc='#tImage#'</cfif>
WHERE termID=#form.termid#
</cfquery>



	<cfif #uploadFileError#>
		<script>
			alert("Term details have been saved successfully!\n But term image upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_term&at=4&surveyID=#form.surveyID#";
		</script>
	<cfelse>
		<script>
			alert("Term details have been saved successfully!");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_term&at=4&surveyID=#form.surveyID#";
		</script>
	</cfif>

</cfoutput>