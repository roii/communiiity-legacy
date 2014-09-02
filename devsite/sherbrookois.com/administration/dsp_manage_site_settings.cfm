<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator'>

	<cfquery name="getSiteWidthSize" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT siteWidthSize FROM Settings WHERE ParserURL LIKE '%#cgi.http_host#%' 
	</cfquery>
	
<cfoutput>

<cfif IsDefined("URL.suc") and URL.suc eq 1>
	<div style="color: blue; font-weight: bold; padding-bottom: 5px;">
		 Your site settings has been updated
	</div> 		
</cfif>
      
<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ###AllSettings.BoxColour#; padding: 10px;"> 
	<tr>
	          <td bgcolor="###session.AllSettings_BoxColour#" style="color:###TRIM(session.AllSettings_BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>Manage Site Settings</strong></td>
	</tr> 
	<tr>
	    <td> 
				<form name="saveSettingsForm" action="/administration/save_settings.cfm?fuseaction=<cfoutput>#URL.fuseaction#</cfoutput>&fusesubaction=<cfoutput>#URL.fusesubaction#</cfoutput>" method="post">
				   <input type="hidden" name="header" value="1" />
				   <input type="hidden" name="footer" value="0" />
				        <table width="100%" cellpadding="0" cellspacing="0" border="0"> 
						     <tr>
							      <td>
								       Site Content Width: &nbsp;
								  </td>
								  <td style="padding-top: 15px;"> 
								       <input type="text" name="siteWidthSize" id="siteWidthSize" value="#getSiteWidthSize.siteWidthSize#" />
									    <br />
										 <span style="color: red;">
											  <strong>Note: *</strong> Please enter number like 1000px, 2000px and 3000px etc in above box of site content width.
										 </span>
								  </td> 
							 </tr>
						</table> 
						<p>
							<input type="button" value="Save Settings »" class="whitefield" style="cursor:hand;background-color:###AllSettings.BoxColour#;color:###TRIM(session.AllSettings_BoxTextColour)#;font-weight:bold;font-size:11px;border:0px; height: 30px; width: 113px;" onclick="javascript: document.saveSettingsForm.submit();">
						</p>
			    </form>
		</td>
	  </tr>				
</table>

</cfoutput>
 
<cfelse>
      <p style="font-size: 16px; font-weight: bold;">
	        You are not authorized to view this page.
	  </p>
</cfif>