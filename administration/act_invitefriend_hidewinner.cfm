<cfquery name="InviteFriend_HideWinner" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE InviteFriendPrizes
SET ShowWinner=0
WHERE DrawID=#DrawID#
</cfquery>

<cflocation url="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=invite_friend">