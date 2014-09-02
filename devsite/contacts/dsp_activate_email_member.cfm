<cfset this_activity = 22>

<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Activity
WHERE ActivityID=#this_activity#
</cfquery>

<cfmail server="#application.emailserver#" to="#TRIM(ContactStuff.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="Your #TRIM(AllSettings.SiteName)# Account Details">

Hi #TRIM(ContactStuff.firstname)#!#chr(10)##chr(10)#

You have successfully activated your membership to #TRIM(AllSettings.SiteName)# and earned the following rewards...#chr(10)##chr(10)#

<cfif rewarddetails.Entries GT 0>
---------------------------------#chr(10)#
#rewarddetails.Entries# Prize-draw entries#chr(10)#
---------------------------------#chr(10)#
</cfif>
			
<cfif rewarddetails.Points GT 0>
---------------------------------#chr(10)#
#rewarddetails.Points# Points#chr(10)#
---------------------------------#chr(10)#
</cfif>
			
<cfif rewarddetails.Cash GT 0>
---------------------------------#chr(10)#
#DollarFormat(rewarddetails.Cash)# Cash#chr(10)#
---------------------------------#chr(10)#
</cfif>
			
<cfif rewarddetails.Education GT 0>
---------------------------------#chr(10)#
#DollarFormat(rewarddetails.Education)# Cash#chr(10)#
---------------------------------#chr(10)#
</cfif>
#chr(10)#
			
Use the following log-in details to access the many features of the website and start earning money!#chr(10)##chr(10)#
---------------------------------#chr(10)#
Email: #TRIM(ContactStuff.EmailAddress)##chr(10)#
---------------------------------#chr(10)#
Password: #TRIM(thispassword)##chr(10)#
---------------------------------#chr(10)#
#chr(10)#

We recomend that you change your password regularly and never share it with anyone other than your parents.#chr(10)#

Thanks!#chr(10)#
The Team @ #TRIM(AllSettings.SiteName)##chr(10)#
#request.webroot#
</cfmail>