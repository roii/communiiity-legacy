<cfif IsDefined("session.UserIsAuthenticated") and session.UserIsAuthenticated EQ 'Yes'>
<div>

<cfif IsDefined("FORM.USERID") and FORM.USERID neq ''>
     <cfinclude template="qry_update_profile_pic_process.cfm"> 
	   <cfif updateStatus eq "fail">
	          <cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&upl=0" addtoken="no">
	   <cfelseif updateStatus eq "delete">
	          <cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&cancl=0" addtoken="no">	 	  
	   <cfelse>
	          <!---<cfset fileNameenc = Encrypt(fileName, 'CFMX_COMPAT')>---> 
			  <cfset fileNameenc = toBase64(fileName)>
	          <cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&upl=1&fnm=#fileNameenc#" addtoken="no">
	   </cfif>  
<cfelse>
     <p style="font-size: 16px; font-weight: bold;">
	        You are not authorized to view this page.
	 </p>  
</cfif>	
	 
</div>
<cfelse>
      <p style="font-size: 16px; font-weight: bold;">
	        You are not authorized to view this page.
	  </p>
</cfif>