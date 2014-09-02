<cfif FORM.adminIDCheck eq 'No'>    

<cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
 SET EmailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.email#"> 
 WHERE ContactID = #FORM.USERID#  
</cfquery> 

<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&suc=1##tabs1-settings" addtoken="no">

<cfelse>

<cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Administrator
 SET EmailAddress = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.email#"> 
 WHERE AdministratorID = #FORM.USERID#  
</cfquery> 

<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&suc=1##tabs1-settings" addtoken="no">

</cfif>