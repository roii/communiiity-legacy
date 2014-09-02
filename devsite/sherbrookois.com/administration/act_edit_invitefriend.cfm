<cfoutput>

<cfquery name="UpdateDraw" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE InviteFriendPrizes
SET winners='#form.winners#',
PointsPerWinner=#form.pointsperwinner#
WHERE DrawID=#form.DrawID#
</cfquery>

<script language="JavaScript">
<!--
function showParentAndClose(givenURL) {
    alert("Invite Friend details have been saved successfully!");
	window.opener.document.location = givenURL;
	self.close();
}
// -->
</script>

<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=invite_friend')"></body>


</cfoutput>