<cfif form.PhotoUpload NEQ ''>
	
	<cftry>
	<cffile action="UPLOAD" filefield="PhotoUpload" destination="#request.fileroot#\images\alantest\" nameconflict="OVERWRITE">


	

	<cfset photo_upload_name = File.ServerFile>

	<cfcatch>
	
<!--- CLOSE THE HOUR-GLASS WINDOW --->	
	
		<script language="JavaScript">
		<!--
		{
		winHandle = window.open('','hourglass');
		winHandle.close();
		}
		// -->
		</script>
		
	
		<script>
		alert("There was a problem uploading the photo.\nPlease try again or contact your site administrator.")
		self.location="javascript:history.back();";
		</script>
		
		<cfabort>
	
	</cfcatch>	
	
	</cftry>

</cfif>


<cfif photo_upload_name NEQ ''>

	<cfx_image action="resize" file="#request.fileroot#\images\alantest\#photo_upload_name#" width="200" output="#request.fileroot#\images\alantest_thumb\#photo_upload_name#"> 



		

</cfif>	<br><br><br>


<cfoutput>
<img src="#request.imageroot#/alantest_thumb/#photo_upload_name#"><br><br>
<img src="#request.imageroot#/alantest/#photo_upload_name#"><br><br>
<img src="#request.imageroot#/alantest_full/#photo_upload_name#"><br><br>
</cfoutput>