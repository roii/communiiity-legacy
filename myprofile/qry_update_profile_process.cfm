<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE EmailAddress = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(FORM.email)#">
	AND ContactStatus <> 'Deleted'
	AND ContactTypeID IN (1,2,4,6,7)
</cfquery>

<cfif checkuseremail.recordcount lte 0>
    <cfset statustoGo = 1>
<cfelse>
    <cfif checkuseremail.CONTACTID eq #SESSION.userid#>
	      <cfset statustoGo = 1>
	<cfelse>
	      <cfset statustoGo = 0>	  
	</cfif>
</cfif> 

<cfif statustoGo eq 1> 	 
    <cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
    UPDATE Contacts
	 SET FirstName    = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.fname#">,
	     LastName     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.lname#">,
	     EmailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.email#">
		 <cfif IsDefined("FORM.FILENAMETOSAVE") and FORM.FILENAMETOSAVE neq ''>
		  ,profilepic   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.FILENAMETOSAVE#">
		 </cfif>
		 <cfif IsDefined("FORM.pass") and FORM.pass neq ''>
		  ,Password     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.pass#">
		 </cfif>  
	 WHERE ContactID = #FORM.USERID#  
    </cfquery>

	<cfif IsDefined("session.User_FullName") and #session.User_FullName# neq ''>
	   <cfset session.User_FullName = #FORM.fname# & " " & #FORM.lname#>
	<cfelse>
	   <cfif IsDefined("session.User_FirstName") and #session.User_FirstName# neq ''>
		   <cfset session.User_FirstName = #FORM.fname#>   
	   </cfif>
	</cfif> 
    <cfset updateStatus = "success">	
<cfelse>
    <cfset updateStatus = "fail">	  
</cfif> 