<cfinclude template="../app_globals.cfm">
<cfset campaignID   = URL.campaignID>
<cfset followstatus = URL.followstatus>
<cfset userid       = URL.userid>
<cfset userip       = URLDecode(URL.userip)> 
<cfset datefollowed = DateFormat(now(), 'YYYY-mm-dd')>

<cfif userid eq 0>
	<cfquery name="getFollowedD" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT * FROM followed_campaigns WHERE userip = '#userip#' and campaignid = #campaignID#  
	</cfquery> 
	
	<cfif #getFollowedD.recordcount# gt 0 and followstatus eq "yes">
		 <cfquery name="updateFollowData" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE FROM followed_campaigns WHERE userip = '#userip#' and campaignid = #campaignID#  
		 </cfquery>
		 <cfset followUnStat = 'unfollow'>
	<cfelse>
	     <cfquery name="updateFollowData" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO followed_campaigns (userid, userip, campaignid, datefollowed) VALUES (#userid#, '#userip#', #campaignID#, '#datefollowed#')  
		 </cfquery>
		 <cfset followUnStat = 'follow'>
	</cfif>

<cfelse>
    <cfquery name="getFollowedD" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT * FROM followed_campaigns WHERE userid = #userid# and campaignid = #campaignID#  
    </cfquery>
	
	<cfif #getFollowedD.recordcount# gt 0 and followstatus eq "yes">
		 <cfquery name="updateFollowData" datasource="#dsn#" username="#request.username#" password="#request.password#">
			DELETE FROM followed_campaigns WHERE userid = #userid# and campaignid = #campaignID#  
		 </cfquery>
		 <cfset followUnStat = 'unfollow'>
	<cfelse>
	     <cfquery name="updateFollowData" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO followed_campaigns (userid, userip, campaignid, datefollowed) VALUES (#userid#, '#userip#', #campaignID#, '#datefollowed#')  
		 </cfquery>
		 <cfset followUnStat = 'follow'>
	</cfif>
</cfif>	

<cfoutput>
   #followUnStat#
</cfoutput>