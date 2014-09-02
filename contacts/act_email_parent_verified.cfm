<!--- GET SENDING MEMBERS DETAILS --->
<cfquery name="ContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#this_contactID#
</cfquery>

<cfmail server="#application.emailserver#" to="#(ContactStuff.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(AllSettings.SiteName)# - You have been verified">
Your parent registration has been verified by #session.User_FirstName#.

You can now login using the email address and password you entered on the registration form.

If you have forgotten your password simply enter your email address into the "Forgot Password" form and it will be emailed to you.

Thanks for joining the community.
</cfmail>