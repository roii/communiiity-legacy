<cfset this_activity = 19>

<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Activity
WHERE ActivityID=#this_activity#
</cfquery>

<cfquery name="ReferredBy" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, EmailAddress
FROM Contacts
WHERE ContactID=#ReferDetails.InvitationFrom#
</cfquery>

<cfmail server="#application.emailserver#" to="#TRIM(ReferredBy.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(ContactStuff.firstname)# #TRIM(ContactStuff.Lastname)# has accepted your invitation to join #TRIM(AllSettings.SiteName)#!">

Hi #TRIM(ReferredBy.firstname)#!#chr(10)##chr(10)#

#TRIM(ContactStuff.firstname)# #TRIM(ContactStuff.Lastname)# has accepted your invitation to join #TRIM(AllSettings.SiteName)#!#chr(10)##chr(10)#


You just earned the following rewards for this successful invitation!...#chr(10)##chr(10)#

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

Thanks!#chr(10)#
The Team @ #TRIM(AllSettings.SiteName)##chr(10)#
#request.webroot#
</cfmail>


