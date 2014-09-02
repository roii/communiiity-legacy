<cfparam name="uploadFileError" default="false">

<cfif Trim(#Form.prizeImage#) NEQ ''>
			<cftry>
				<cffile action="upload" filefield="Form.prizeImage" destination="#request.fileroot#\images\prize\" nameconflict="overwrite" accept="image/*">
    				<cfset tImage="Prize_#form.prizeid#.#File.ServerFileExt#">
	    			<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\images\prize\#tImage#" nameconflict="OVERWRITE">
			<cfcatch>
				<cfset uploadFileError = true>
			</cfcatch>
			</cftry>
		</cfif>	
		
<cfoutput>

<cfquery name="UpdateTerm" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE prize
SET 
Name='#TRIM(form.name)#'
,Description='#TRIM(form.description)#'
,external_url='#form.external_url#'
<cfif Trim(#Form.prizeImage#) NEQ ''>,image='#tImage#'</cfif>
WHERE prizeid=#form.prizeid#
</cfquery>



	<cfif #uploadFileError#>
		<script>
			alert("Prize details have been saved successfully!\n But prize image upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
			self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_prize&prizepoolid=#form.prizepoolid#";
		</script>
	<cfelse>
		<script>
			alert("Prize details have been saved successfully!");
			self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_prize&prizepoolid=#form.prizepoolid#";
		</script>
	</cfif>

</cfoutput>