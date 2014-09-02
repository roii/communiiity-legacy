<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>

<script src="/administration/ckeditor.js"></script>
<script src="/administration/sample.js"></script>
<cfparam name="URL.fuseaction" default="administration">
<cfparam name="URL.fusesubaction" default="">
<cfparam name="URL.secti" default="">
<link href="/administration/sample.css" rel="stylesheet"> 

<cfoutput>
     <cfif URL.secti eq 1>
	        <div style="color: blue;">
			     Your header content is updated
			</div>
	 <cfelseif URL.secti eq 0>
	        <div style="color: blue;">
			     Your footer content is updated
			</div>		
	 </cfif>
<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ###AllSettings.BoxColour#; padding: 10px;"> 
	<tr>
	          <td bgcolor="###session.AllSettings_BoxColour#" style="color:###TRIM(session.AllSettings_BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>Manage Header Section of Site</strong></td>
	</tr>
</cfoutput>	
	<tr>
	    <td> 
		     <cfquery name="getContent" datasource="#dsn#" username="#request.username#" password="#request.password#">
			   SELECT * FROM site_section_contents_data WHERE section_id = 1
			 </cfquery>
 
				<form name="saveHeaderFOrm" action="/administration/save_content.cfm?fuseaction=<cfoutput>#URL.fuseaction#</cfoutput>&fusesubaction=<cfoutput>#URL.fusesubaction#</cfoutput>" method="post">
				   <input type="hidden" name="header" value="1" />
				   <input type="hidden" name="footer" value="0" />
						<p> 
							<textarea cols="80" id="editor1" name="editor1" rows="10"><cfoutput>#getContent.header#</cfoutput></textarea>
							<script> 
								 CKEDITOR.replace( 'editor1', {
									extraPlugins: 'magicline',	// Ensure that magicline plugin, which is required for this sample, is loaded.
									allowedContent: true		// Switch off the ACF, so very complex content created to
																// show magicline's power isn't filtered.
								} ); 
							</script>
						</p>
						<p>
							<input type="button" value="Save »" class="whitefield" style="cursor:hand;background-color:#FD7922;color:black;font-weight:bold;font-size:11px;border:0px; height: 30px; width: 73px;" onclick="javascript: document.saveHeaderFOrm.submit();">
						</p>
					</form>
		</td>
	  </tr>				
</table> 
<cfelse>
      <p style="font-size: 16px; font-weight: bold;">
	        You are not authorized to view this page.
	  </p>
</cfif>