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


		<!--- INSERT Goal --->
		
		<cfquery name="AddBiz" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
		INSERT INTO surveyCom(
		ComName,
		ComContact,
		Email,
		ComLogo
		)
		
		VALUES(
		'#form.ComName#', 
		'#form.ComContact#',
		'#trim(form.comEmail)#',
		'#companyLogo#'
		)
		</cfquery>
		

	<cfif #uploadFileError#>
		<script>
			alert("Company has been added successfully!\n But company logo upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_com&at=2";
		</script>
	<cfelse>
		<script>
			alert("Company has been added successfully!");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_com&at=2";
		</script>
	</cfif>