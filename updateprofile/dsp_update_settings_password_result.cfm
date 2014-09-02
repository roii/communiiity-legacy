<cfoutput>

<cfif FORM.adminIDCheck eq 'No'>    

<cfquery name="getUserDetailsD" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Contacts 
 WHERE ContactID = #FORM.USERID#  
</cfquery>


<cfif getUserDetailsD.Password neq FORM.cpass>
	<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&cpasserr=1##tabs1-settings" addtoken="no">
	<cfabort>
</cfif>

<cfif FORM.npass neq FORM.ncpass>
	<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&npasserr=1##tabs1-settings" addtoken="no">
	<cfabort>
</cfif>


<cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
 SET Password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.npass#"> 
 WHERE ContactID = #FORM.USERID#  
</cfquery> 

<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&suc2=1##tabs1-settings" addtoken="no">

<cfelse>

<cfquery name="getUserDetailsD" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM Administrator 
 WHERE AdministratorID = #FORM.USERID#  
</cfquery>   

<cfif getUserDetailsD.Password neq FORM.cpass>
	<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&cpasserr=1##tabs1-settings" addtoken="no">
	<cfabort>
</cfif>

<cfif FORM.npass neq FORM.ncpass>
	<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&npasserr=1##tabs1-settings" addtoken="no">
	<cfabort>
</cfif>


<cfquery name="updateUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Administrator
 SET Password = <cfqueryparam cfsqltype="cf_sql_varchar" value="#FORM.npass#"> 
 WHERE AdministratorID = #FORM.USERID#  
</cfquery> 

<cflocation url="/index.cfm?fuseaction=updateprofile&fusesubaction=index&suc2=1##tabs1-settings" addtoken="no">

</cfif>
</cfoutput>