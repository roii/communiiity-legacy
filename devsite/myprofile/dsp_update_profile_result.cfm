<cfif IsDefined("session.UserIsAuthenticated") and session.UserIsAuthenticated EQ 'Yes'>
<div>

<cfif IsDefined("FORM.USERID") and FORM.USERID neq ''>
     <cfinclude template="qry_update_profile_process.cfm"> 
	   <cfif updateStatus eq "fail">
	          <cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&suc=0" addtoken="no">
	   <cfelse>
	          <cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&suc=1" addtoken="no">
	   </cfif> 
	 <!---<cfoutput>
	      <p style="font-size: 16px; font-weight: bold;">
	        You have successfully updated your profile details.
	      </p> 
	 </cfoutput>--->
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