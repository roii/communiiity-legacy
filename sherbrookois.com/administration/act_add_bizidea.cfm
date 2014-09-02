<cfset lowres_upload = "no">
<cfset hires_upload = "no">

<cftry>
	<cffile action="upload" filefield="Form.lowres_image" destination="#request.fileroot#\images\business\" nameconflict="overwrite" accept="image/*">
	
	<cfset lowres_upload = "yes">
	<cfset image_upload_name = file.serverfile>
	
	<cfx_image action="resize" file="#request.fileroot#\images\business\#image_upload_name#" output="#request.fileroot#\images\business\thumb_#image_upload_name#" quality="100" x="80" y="60">

	<cffile action="delete" file="#request.fileroot#\images\business\#image_upload_name#">
	
	
	
<cfcatch></cfcatch>
</cftry>


<!--- 
<cftry>
	<cffile action="upload" filefield="Form.hires_image" destination="#request.fileroot#\images\business\" nameconflict="overwrite" accept="image/*">
	<cfset hires_upload = "yes">
	<cfset hires_imagename = file.serverfile>
<cfcatch></cfcatch>
</cftry> --->



<!--- INSERT Business --->
		
		<cfquery name="Addbizidea" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO bizidea(
		biz_ideatypeid,
		biz_idea,
		biz_summary,
		min_age,
		show,
		
		<cfif lowres_upload EQ 'Yes'>
			image_lowres,
		</cfif>
		
		<!--- <cfif hires_upload EQ 'Yes'>
			image_hires,
		</cfif> --->
		
		bizorder
		)
		
		VALUES(
		#form.bizideaTypeID#, 
		'#form.biz_idea#',
		'#form.biz_summary#',
		'#form.min_age#',
		'#form.show#',
		
		<cfif lowres_upload EQ 'Yes'>
			'thumb_#image_upload_name#',
		</cfif>
		
		<!--- <cfif hires_upload EQ 'Yes'>
			'#hires_imagename#',
		</cfif> --->
		
		<cfif IsNumeric("#form.bizOrder#")>
			#form.bizOrder#
		<cfelse>
			0
		</cfif>
		)
		</cfquery>
		

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<cfoutput>
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		alert("You have add a new business.");
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas')"></body>


	</cfoutput>