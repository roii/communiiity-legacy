<cfif IsDefined("URL.emailID") and #URL.emailID# neq ''>
    <cfset email = #URL.emailID#>
<cfelse>
    <cfset email = "">	
</cfif>

<cfif email neq ''>
 
     <cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID
		FROM Contacts
		WHERE EmailAddress = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(email))#">
		AND ContactStatus <> 'Deleted'
		AND ContactTypeID IN (1,2,4,6,7)
     </cfquery>
	 
	 <cfoutput>
	    #checkuseremail.recordcount#
	 </cfoutput>

<cfelse>

     <cfoutput>
	     Please enter your email ID to continue further...
	 </cfoutput>

</cfif>