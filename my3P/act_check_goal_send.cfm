<!--- 
{member_firstname} {goal_title} {goal_details} {percent_done} {sitename} {siteurl} {sitelogo}
--->


<!--- GET THE ALERT DETAILS --->
<cfquery name="AlertStuff" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT AlertSubject, AlertDetails, AlertFormat
FROM EmailAlerts
WHERE AlertID=12
</cfquery>


<!--- REPLACE {member_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(AlertStuff.AlertSubject,  '{member_firstname}',  '#TRIM(this_FirstName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(AlertStuff.AlertDetails,  '{member_firstname}',  '#TRIM(this_FirstName)#',  "ALL")>

<!--- REPLACE {goal_title} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{goal_title}',  '#TRIM(this_GoalTitle)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{goal_title}',  '#TRIM(this_GoalTitle)#',  "ALL")>

<!--- REPLACE {goal_details} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{goal_details}',  '#TRIM(this_GoalDetails)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{goal_details}',  '#TRIM(this_GoalDetails)#',  "ALL")>

<!--- REPLACE {percent_done} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{percent_done}',  '#TRIM(this_percentdone)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{percent_done}',  '#TRIM(this_percentdone)#',  "ALL")>



<!--- REPLACE {bywhen} --->

<cfif IsDate("#this_bywhen#")>
	<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{bywhen}',  '#DateFormat(this_bywhen, "d-mmm-yyyy")#',  "ALL")>
	<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{bywhen}',  '#DateFormat(this_bywhen, "d-mmm-yyyy")#',  "ALL")>
<cfelse>
	<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{bywhen}',  '',  "ALL")>
	<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{bywhen}',  '',  "ALL")>
</cfif>



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
<cfmail to="#TRIM(this_EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#" Type="HTML">
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
<cfmail to="#TRIM(this_EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(NewAlertSubject)#">#TRIM(NewAlertDetails)#</cfmail>
			
</cfif>
		

