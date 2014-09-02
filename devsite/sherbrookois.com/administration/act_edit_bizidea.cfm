<cfoutput>

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



<cftransaction action="BEGIN">

<!--- UPDATE GOAL INFO --->
<cfquery name="UpdateGoal" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE bizidea
SET 
biz_idea='#TRIM(form.biz_idea)#',
biz_summary='#TRIM(form.biz_summary)#',
min_age='#TRIM(form.min_age)#',
biz_ideatypeid=#form.bizideaTypeID#,
details='#trim(form.details)#',

<cfif IsNumeric("#form.bizOrder#")>
	bizOrder=#form.bizOrder#,
</cfif>

<cfif lowres_upload EQ 'Yes'>
	image_lowres='thumb_#image_upload_name#',
</cfif>

	<!--- 	
<cfif hires_upload EQ 'Yes'>
	image_hires='#hires_imagename#',
</cfif> --->
		
show='#trim(form.show)#'
WHERE bizideaid=#form.bizideaid#
</cfquery>


</cftransaction>


<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		alert("You have updated the business.");
		self.close();
	}
	
	// -->
	</script>
		
		
	<cfif form.fuseaction EQ 'administration'>
		
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas')"></body>
		
	<cfelse>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=business&fusesubaction=BusinessDetails&bizideaID=#form.bizideaid#')"></body>
		
	</cfif>	


</cfoutput>