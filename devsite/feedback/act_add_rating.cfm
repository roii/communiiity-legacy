<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT FeedbackID
FROM Feedback
ORDER BY FeedbackID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newFeedbackID = (lastID.FeedbackID + 1)>
<cfelse>
	<cfset newFeedbackID = 1>
</cfif>



<!--- INSERT NEW RATING --->

<cfquery name="AddFeedback" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Feedback(FeedbackID, ContactID, LinkID, Feedback_type, Feedback_date, Feedback_details, Feedback_rating)
VALUES(#newFeedbackID#, #session.userID#, #form.LinkID#, '#form.Feedback_type#', #createODBCDateTime(localDateTime)#, '#form.Feedback_Details#', #form.Feedback_rating#)
</cfquery>



<!--- CHECK FOR ACTIVITY REWARDS --->

<cfset ExtraDescription = "<BR>Business: #TRIM(form.Business)#">

<!--- PROCESS LOGIN REWARDS --->
<cfset this_activity = 27>
<cfset this_contactID = session.UserID>
<cfset this_relatedDescription = "AddFeedback">
<cfset this_relatedID = "#newFeedbackID#">
		
<cfinclude template="../templates/act_activity_reward_payment.cfm">



<!--- REDIRECT TO RATING PAGE BUSINESS TEMPLATE PAGE TO VIEW RATINGS AND FEEDBACK --->

<cfoutput>


<script language="JavaScript">
alert("You have added your rating and feedback.\n\nYou will now be returned to the business template\nso you can see the overall rating and feedback\nfrom individual members.");
self.location="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=BusinessDetails&bizideaID=#form.LinkID#&documentID=48";
</script>


</cfoutput>