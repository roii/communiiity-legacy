<!--- GET SENDING MEMBERS DETAILS --->
<cfquery name="ContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#this_contactID#
</cfquery>

<cfmail server="#application.emailserver#" to="alan@my3p.com" cc="roy@my3p.com" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="ALERT - Bogus Parent Activation">
The following person tried to activate a Parent Invitation and was rejected by the member who sent the invite.

-------------------------------------------
MEMBER DETAILS

Name: #session.User_FirstName# #session.User_LastName#
Screen Name: #session.User_ScreenName#
-------------------------------------------


-------------------------------------------
INVITEE DETAILS

Name: #TRIM(ContactStuff.FirstName)# #TRIM(ContactStuff.LastName)#
Email: #TRIM(ContactStuff.EmailAddress)#
Mobile: #TRIM(ContactStuff.MobilePhone)#
IP Address: #TRIM(this_ip)#
-------------------------------------------
</cfmail>