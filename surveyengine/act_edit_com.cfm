<cfparam name="uploadFileError" default="false">
<cfparam name="companyLogo" default="">
<cfif Trim(#Form.comLogo#) NEQ ''>
			<cftry>
				<cffile action="upload" filefield="Form.comLogo" destination="#request.fileroot#\surveyengine\images\" nameconflict="overwrite" accept="image/*">
				<cfif #file.FileWasSaved# is 'Yes'>
					<cfset companyLogo ='#file.ServerFile#'>
				</cfif>
			<cfcatch>
				<cfset uploadFileError = true>
			</cfcatch>
			</cftry>
		</cfif>	
		
<cfoutput>

<cfquery name="UpdateCom" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
UPDATE surveyCom
SET 
comName='#TRIM(form.comName)#',
ComContact='#TRIM(form.ComContact)#',
email='#Trim(form.comEmail)#'
<cfif Trim(#Form.comLogo#) NEQ ''>,ComLogo='#companyLogo#'</cfif>
WHERE surveyComID=#form.surveyComID#
</cfquery>



	<cfif #uploadFileError#>
		<script>
			alert("Company details have been saved successfully!\n But company logo upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_com&at=2";
		</script>
	<cfelse>
		<script>
			alert("Company details have been saved successfully!");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_com&at=2";
		</script>
	</cfif>

</cfoutput>