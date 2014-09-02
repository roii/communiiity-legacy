<cfquery name="InviteFriend_ShowWinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE InviteFriendPrizes
SET ShowWinner=1
WHERE DrawID=#DrawID#
</cfquery>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=invite_friend">