<cfquery name="CheckCode" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName, EmailAddress, LoginName, Password, EmailConfirmed
FROM Contacts
WHERE VerificationCode LIKE '%#TRIM(url.VerificationCode)#%'
AND EmailAddress LIKE '#url.emailaddress#'
</cfquery>

<cfif CheckCode.RecordCount>

	<cfif CheckCode.EmailConfirmed EQ 1>
	
		<cfoutput>
	
		<script type="text/javascript">
		alert("You have already verified your email address and a reminder\nof your login details has been sent to that address.\n\nPlease try using the \"forgot password\" function to retrieve your password.");
		self.location="#request.webroot#/index.cfm";
		</script>
		
		</cfoutput>
	
	<cfelse>

		<cfquery name="UpdateRecord" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE Contacts
		SET EmailConfirmed=1,
		ContactStatus='Pending'
		WHERE ContactID=#CheckCode.ContactID#
		</cfquery>			
			
		<cflocation url="#request.webroot#/index.cfm?fuseaction=join&fusesubaction=Step2&contactID=#CheckCode.ContactID#">
		
	</cfif>

<cfelse>

	<cfoutput>
	
	<script type="text/javascript">
	alert("We're sorry but the verification code and emaill address do not match any of the current registrations in our system.\nPlease check your verification code and email address or re-register.");
	self.location="#request.webroot#/index.cfm?fuseaction=join&fusesubaction=reverify";
	</script>
	
	</cfoutput>

</cfif>