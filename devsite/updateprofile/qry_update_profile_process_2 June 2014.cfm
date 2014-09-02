<cfif FORM.adminIDCheck eq 'No'>   

		<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT ContactID
			FROM Contacts
			WHERE ContactID = #FORM.userID#
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
				 country      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.country#">,
				 PostalCode   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.postalcode#">,
				 cellNum      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.cellNum#">
				 <!---EmailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.email#">
				 <cfif IsDefined("FORM.FILENAMETOSAVE") and FORM.FILENAMETOSAVE neq ''>
				  ,profilepic   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.FILENAMETOSAVE#">
				 </cfif>
				 <cfif IsDefined("FORM.pass") and FORM.pass neq ''>
				  ,Password     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.pass#">
				 </cfif>--->  
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
		
<cfelse>
        <cfset adminIDArr = ListToArray(FORM.userID, "999")>
	    <cfset adminID = adminIDArr[1]>
        <cfquery name="CheckAdminEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT AdministratorID
			FROM Administrator
			WHERE AdministratorID =  #adminID#
		</cfquery> 
		    <cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Administrator
				 SET FirstName    = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.fname#">,
					 LastName     = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.lname#">,
					 country      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.country#">,
					 PostalCode   = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.postalcode#">,
					 cellNum      = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.cellNum#">					  
				 WHERE AdministratorID = #adminID#  
			</cfquery> 
			<cfif IsDefined("session.User_FullName") and #session.User_FullName# neq ''>
			   <cfset session.User_FullName = #FORM.fname# & " " & #FORM.lname#>
			<cfelse>
			   <cfif IsDefined("session.User_FirstName") and #session.User_FirstName# neq ''>
				   <cfset session.User_FirstName = #FORM.fname#>   
			   </cfif>
			</cfif> 
			<cfset updateStatus = "success"> 
</cfif>		