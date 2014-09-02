<cfset this_activity = 19>

<cfquery name="RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Activity
WHERE ActivityID=#this_activity#
</cfquery>

<cfmail server="#application.emailserver#" to="#TRIM(CheckReferralCode.EmailAddress)#" from="#TRIM(AllSettings.EmailAlertFrom)#" subject="#TRIM(form.firstname)# #TRIM(form.Lastname)# has used your referral code to join #TRIM(AllSettings.SiteName)#!">

Hi #TRIM(CheckReferralCode.firstname)#!

#TRIM(form.firstname)# #TRIM(form.Lastname)# has accepted your invitation to join #TRIM(AllSettings.SiteName)#!

You just earned the following rewards for this successful referral!...

<cfif rewarddetails.Entries GT 0>
---------------------------------
#rewarddetails.Entries# Prize-draw entries
---------------------------------
</cfif>
			
<cfif rewarddetails.Points GT 0>
---------------------------------
#rewarddetails.Points# Points
---------------------------------
</cfif>
			
<cfif rewarddetails.Cash GT 0>
---------------------------------
#DollarFormat(rewarddetails.Cash)# Cash
---------------------------------
</cfif>
			
<cfif rewarddetails.Education GT 0>
---------------------------------
#DollarFormat(rewarddetails.Education)# Cash
---------------------------------
</cfif>


Thanks!
The Team @ #TRIM(AllSettings.SiteName)#
#request.webroot#
</cfmail>


