<!--- 
{invitee_firstname} {member_firstname} {sitename} {siteurl} {sitelogo}
--->


<!--- GET THE ALERT DETAILS --->
<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertSubject, AlertDetails, AlertFormat
FROM EmailAlerts
WHERE AlertID=4
</cfquery>
	

	
<cfquery name="InviteeDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FirstName, EmailAddress
FROM Contacts
WHERE ContactID=#Invitee_ContactID#
</cfquery>

<cfquery name="MemberDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FirstName, EmailAddress
FROM Contacts
WHERE ContactID=#Member_ContactID#
</cfquery>

		
<!--- REPLACE {member_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(AlertStuff.AlertSubject,  '{member_firstname}',  '#TRIM(MemberDetails.FirstName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(AlertStuff.AlertDetails,  '{member_firstname}',  '#TRIM(MemberDetails.FirstName)#',  "ALL")>

<!--- REPLACE {invitee_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{parent_firstname}',  '#TRIM(InviteeDetails.FirstName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{parent_firstname}',  '#TRIM(InviteeDetails.FirstName)#',  "ALL")>

<!--- REPLACE {sitename} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>



<cfif TRIM(AlertStuff.AlertFormat) EQ 'HTML'>


<!--- REPLACE {siteurl} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{siteurl}',  '<a href="#request.webroot#">#request.webroot#</a>',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '<img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" alt="#TRIM(AllSettings.SiteName)#" border="0">' ,  "ALL")>		

						
<!--- SEND THE HTML EMAIL --->				
<cfmail to="#TRIM(InviteeDetails.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#" Type="HTML">
<!DOCType HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(NewAlertSubject)#</title>
</head>

<body>#TRIM(NewAlertDetails)#</body>
</html>
</cfmail>
			
<cfelse>

<!--- REPLACE {siteurl} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>			

<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '<BR>',  '#chr(13)#' ,  "ALL")>
			
<!--- SEND THE PLAIN EMAIL --->				
<cfmail to="#TRIM(InviteeDetails.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
			
</cfif>
		

