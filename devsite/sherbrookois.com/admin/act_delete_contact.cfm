<cfoutput>


<cfparam name="caller" default="profile">
<cfparam name="completedelete" default="false">


<!--- MARK CONTACT AS DELETED --->

<cfquery name="DeleteContact" datasource="#DSN#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET ContactStatus='Deleted'
WHERE ContactID=#ContactID#
</cfquery>

<!--- GET THE CONTACT NAME --->

<cfquery name="ContactDetails" datasource="#DSN#" username="#request.username#" password="#request.password#">
SELECT FirstName, LastName
FROM Contacts
WHERE ContactID=#ContactID#
</cfquery>


<!--- ADMIN LOG --->

<cfset logdetails = 'Delete Contact - (Contact: #ContactDetails.FirstName# #ContactDetails.LastName#)'>
<cfinclude template="act_adminlog.cfm">



<cfif completedelete EQ 'true'>
         
	<cfquery name="DeleteContact" datasource="#DSN#" username="#request.username#" password="#request.password#">
	DELETE 
	FROM contacts 
	WHERE ContactID=#ContactID#
	</cfquery>

	<cfif caller EQ 'kids'>
	
		<cfquery name="DeleteContactLink" datasource="#DSN#" username="#request.username#" password="#request.password#">
		DELETE 
		FROM kidclientlinks 
		WHERE kidID=#ContactID#
		</cfquery>
		
		<cfquery name="DeleteContactLink" datasource="#DSN#" username="#request.username#" password="#request.password#">
		DELETE
		FROM kidsurvey 
		WHERE kidID=#ContactID#
		</cfquery>
	
	<cfelseif caller EQ 'shopper'>
	
		<cfquery name="DeleteContactLink" datasource="#DSN#" username="#request.username#" password="#request.password#">
		DELETE
		FROM kidclientlinks 
		WHERE clientID=#ContactID#
		</cfquery>
		
		<cfquery name="DeleteContactLink" datasource="#DSN#" username="#request.username#" password="#request.password#">
		DELETE
		FROM kidsurvey 
		WHERE clientID=#ContactID#
		</cfquery>
		
	</cfif>
	

</cfif>

	

<!--- REDIRECT TO THE CALLING PAGE --->
	
<cfif caller EQ 'shopper'>

	<script language="JavaScript">
	<!--
	alert("You have successfully deleted the Shopper.");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_shoppers";
	// -->
	</script>


<cfelseif caller EQ 'kids'>

	<script language="JavaScript">
	<!--
	alert("You have successfully deleted the Kid.");
	self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members";
	// -->
	</script>

	
</cfif>	

	
</cfoutput>