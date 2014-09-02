<cfparam name="uploadFileError" default="false">

		<!--- INSERT Goal --->
		
		<cfquery name="Addterm" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
		INSERT INTO surveyTerms(
		Term,
		formid
		)
		
		VALUES(
		'#form.Term#', 
		#form.surveyid#
		)
		SELECT InsertedTermID = @@IDENTITY;
		</cfquery>

		<cfquery name="addedtermID" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
          select top 1 termid from surveyTerms order by termid desc
		</cfquery>
		
		<cfset addedtermid=addedtermID.termid>

		<cfif Trim(#Form.termImage#) NEQ ''>
			<cftry>
				<cffile action="upload" filefield="Form.termImage" destination="#request.fileroot#\surveyengine\images\" nameconflict="overwrite" accept="image/*">
    				<cfset tImage="Term_#addedtermid#.#File.ServerFileExt#">
	    			<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\surveyengine\images\#tImage#" nameconflict="OVERWRITE">
				<cfquery name="Updateterm" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
				  update surveyterms set imageLoc = '#tImage#' where termid = #addedtermid#
				</cfquery>
			<cfcatch>
				<cfset uploadFileError = true>
			</cfcatch>
			</cftry>
		</cfif>	

		
<cfoutput>
	<cfif #uploadFileError#>
		<script>
			alert("Term has been added successfully!\n But term image upload failed \n Either the path of the image was incorrect \n or upload was not an image file.");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_term&at=4&surveyid=#form.surveyid#";
		</script>
	<cfelseif form.wizard eq 'on'>
		<script>
			alert("Term has been added successfully!");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_term&at=4&surveyid=#form.surveyid#&wizard=on";
		</script>
	<cfelse>
		<script>
			alert("Term has been added successfully!");
			self.location="http://www.my3p.com/surveyengine/default.cfm?fuseaction=add_term&at=4&surveyid=#form.surveyid#";
		</script>
	</cfif>
</cfoutput>	