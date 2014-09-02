
	


<!--- UPDATE --->
	
	<cfquery name="DeleteProject" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Projects
	WHERE ProjectID=#ProjectID#
	</cfquery>

	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	<cfif URL.maintask eq 0>
	
		<cfoutput> 
			 <script language="javascript">
				  parent.document.location.href = '#request.webroot#/projects/#URL.campaignID#'+'##tabs1-projects';
			 </script> 
		</cfoutput>
		
	<cfelse>
	   
	    <cfoutput> 
			 <script language="javascript">
				  parent.document.location.href = '#request.webroot#/index.cfm?fuseaction=tasks';
			 </script> 
		</cfoutput> 	
	
	</cfif>
