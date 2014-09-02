<cfquery name="passwordcheck" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT ContactID, FirstName, LoginName, Password, ContactStatus
FROM Contacts
WHERE EmailAddress='#form.emailaddress#'
</cfquery>


<cfif passwordcheck.recordcount>

	<cfif passwordcheck.ContactStatus CONTAINS 'Active'>
		
		<cfinclude template="alerts/act_alert_05_forgotpassword.cfm">
		
		<script>
		alert("Thanks, your login details have been sent to your email address.");
		self.close();
		</script>
		
	<cfelse>
		
				
		<!--- GET THE ALERT DETAILS --->
		<cfquery name="AlertStuff" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		SELECT AlertSubject, AlertDetails, AlertFormat
		FROM EmailAlerts
		WHERE AlertID=1
		</cfquery>
			
				
		<!--- REPLACE {member_firstname} --->
		<cfset NewAlertSubject = ReplaceNoCase(AlertStuff.AlertSubject,  '{member_firstname}',  '#TRIM(passwordcheck.FirstName)#',  "ALL")>
		<cfset NewAlertDetails = ReplaceNoCase(AlertStuff.AlertDetails,  '{member_firstname}',  '#TRIM(passwordcheck.FirstName)#',  "ALL")>
		
		<!--- REPLACE {sitename} --->
		<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>
		<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>
		
		
		<!--- REPLACE {siteurl} --->
		<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
		<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>
		
		<!--- REPLACE {sitelogo} --->
		<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
		<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>			
		
		<!--- REPLACE {verification_code} --->
		<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{verification_code}', '#request.webroot#/admin/act_confirm_registration.cfm?contactID=#passwordcheck.contactID#&emailaddress=#form.emailaddress#', "ALL")>
		
		<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '<BR>',  '#chr(13)#' ,  "ALL")>
		
		<!--- SEND THE PLAIN EMAIL --->				
<cfmail server="#application.emailserver#" to="#TRIM(form.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
	
		<script>
		alert("Your registration has not been completed. We have sent you a verification email for you to finish the registration process.");
		self.close();
		</script>
	
	</cfif>

	

<cfelse>



	<script>
	alert("Sorry, there is no matching email address in our database.");
	self.close();
	</script>


</cfif>