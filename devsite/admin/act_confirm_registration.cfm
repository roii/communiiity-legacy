<cfquery name="CheckContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FirstName, LastName, EmailAddress, LoginName, Password, EmailConfirmed
FROM Contacts
WHERE EmailAddress LIKE '%#TRIM(emailaddress)#%'
AND ContactID=#contactID#
</cfquery>


<cfif CheckContact.RecordCount>

	<cfif CheckContact.EmailConfirmed EQ 1>
	
		<cfoutput>
	
		<script>
		alert("You have already verified your email address and a reminder\nof your login details has been sent to that address.");
		self.location="#request.webroot#/index.cfm";
		</script>
		
		</cfoutput>
	
	<cfelse>


		<cfquery name="UpdateRecord" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE Contacts
		SET EmailConfirmed=1,
		ContactStatus='Pending'
		WHERE ContactID=#ContactID#
		</cfquery>
			
			
		<cflocation url="#request.webroot#/index.cfm?fuseaction=join&fusesubaction=Step2&contactID=#ContactID#">
	
	
	</cfif>
	

<cfelse>

	<cfoutput>
	
	<script>
	alert("We're sorry but your details do not match any of the current registrations in our system. Please register again.");
	self.location="#request.webroot#/index.cfm";
	</script>
	
	</cfoutput>

</cfif>