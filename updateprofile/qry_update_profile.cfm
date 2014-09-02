<cfif ListContains(userID, "999")>
      <cfset adminIDArr = ListToArray(userID, "999")>
	  <cfset adminID = adminIDArr[1]>
	  <cfquery name="getUserDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT * FROM Administrator
		 WHERE AdministratorID = #adminID#  
	  </cfquery>  
<cfelse> 
	<cfquery name="getUserDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT * FROM Contacts
		 WHERE ContactID = #userID#  
	</cfquery> 
</cfif> 
 