<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT PrizePoolID
FROM Prize_Pool
ORDER BY PrizePoolID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.PrizePoolID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>


<cfquery name="Addprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
 INSERT INTO Prize(PrizePoolID, Name, Description, external_url, prizepoolid)
 VALUES(#newid#, '#Form.Name#', '#Form.description#', '#Form.external_url#', #Form.prizepoolid#)
 </cfquery>

 
<cfif Trim(Form.PrizeImage) NEQ ''>

	<cftry>
		
		<cffile action="upload" filefield="Form.PrizeImage" destination="#request.fileroot#\images\prize\" nameconflict="overwrite" accept="image/*">
		<cfset tImage="Prize_#Addprize.InsertedPrizeID#.#File.ServerFileExt#">
		
		<cffile action="RENAME" source="#File.serverdirectory#\#File.ServerFile#" destination="#request.fileroot#\images\prize\#tImage#" nameconflict="OVERWRITE">
		
		<cfquery name="Updateprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
		update Prize_Pool 
		set image = '#tImage#' 
		WHERE PrizePoolID = #newID#
		</cfquery>
	
	<cfcatch>
		<cfset uploadFileError = true>
	</cfcatch>
	
	</cftry>

</cfif>	

<cfoutput>
  <script>
	alert("Prize has been added successfully!");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_prize&prizepoolid=#form.prizepoolid#";
  </script>
</cfoutput>