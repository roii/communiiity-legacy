<!--- GET ALL MEMBER COUNT --->
<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT COUNT(ContactID) AS TotalMembers
FROM Contacts
WHERE ContactTypeID IN (1,2,4,6,7)
AND ContactStatus LIKE '%Active%'
</cfquery>

<cfset thiscount = (AllMembers.TotalMembers / 4)>

<cfset thisstart = 1>
<cfset thisend = thiscount>

<cfquery name="MemberDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ReferralCode, DateJoined
FROM Contacts
WHERE ContactTypeID IN (1,2,4,6,7)
AND ContactStatus LIKE '%Active%'
ORDER BY ContactID
</cfquery>

<cfloop query="MemberDetails" startrow="#thisstart#" endrow="#thisend#">

	<cfset this_contactID = MemberDetails.ContactID>
	<cfset this_ReferralCode = MemberDetails.ReferralCode>
	<cfset this_DateJoined = MemberDetails.DateJoined>
		
	<!--- GET ALL ACTIVE GOALS FOR THIS MEMBER --->
	<cfquery name="qry_all_goals" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Goals.GoalID, GoalKidsLink.archived
	FROM Goals, GoalKidsLink
	WHERE Goals.GoalID=GoalKidsLink.GoalID
	AND GoalKidsLink.KidsID = #this_contactID#
	</cfquery>
	
	<cfif qry_all_goals.RecordCount>
		<cfset Goals_Total = qry_all_goals.RecordCount>
	<cfelse>
		<cfset Goals_Total = 0>	
	</cfif>
		
	<!--- GET ALL COMPLETE GOALS FOR THIS MEMBER --->
	<cfquery name="qry_complete_goals" dbtype="query">
	SELECT Count(GoalID) AS TotalCompleteGoals
	FROM qry_all_goals
	WHERE archived=1
	</cfquery>
	
	<cfif qry_complete_goals.RecordCount>
		<cfset Goals_Total_Complete = qry_complete_goals.RecordCount>
	<cfelse>
		<cfset Goals_Total_Complete = 0>	
	</cfif>
		
	<!--- GET ALL IDEAS --->
	<cfquery name="qry_all_ideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT sugID, archived, SugStage
	FROM suggestion
	WHERE ContactID=#this_contactID#
	</cfquery>
	
	<!--- GET WINNER IDEAS --->
	<cfquery name="AllAuthorisedIdeas" dbtype="query">
	SELECT Count(SugID) AS Total_Ideas_Authorised
	FROM qry_all_ideas
	WHERE archived <> 1
	AND (SugStage LIKE '%Stage 4%' OR SugStage LIKE '%Stage 5%')
	</cfquery>
	
	<cfif IsDefined("AllAuthorisedIdeas.Total_Ideas_Authorised") AND Isnumeric("#AllAuthorisedIdeas.Total_Ideas_Authorised#")>
		<cfset allWinIdeas=AllAuthorisedIdeas.Total_Ideas_Authorised>
	<cfelse>
		<cfset allWinIdeas=0>
	</cfif>
	
	<!--- GET ALL BUSINESSES --->
	<cfquery name="AllBusinesses" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT bizkidslinkid
	FROM bizkidslink
	WHERE kidsid = #this_contactID#
	</cfquery>
		
	<cfset totalincome=0>
	<cfset totalexpenses=0>
	<cfset totalMinutes=0>
	
	<cfloop query="AllBusinesses">
	
	<cfset this_bizkidslinkid = AllBusinesses.bizkidslinkid>
	
	<!--- GET ALL TRANSACTIONS --->
	<cfquery name="AllTransactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(income1_amount+income2_amount+income3_amount+income4_amount+income5_amount) AS TotalBizIncome, SUM(expense1_amount+expense2_amount+expense3_amount+expense4_amount+expense5_amount) AS TotalBizExpense, SUM(hours) AS TotalBizHours
	FROM bizTransaction
	WHERE bizkidslinkid=#this_bizkidslinkid#
	</cfquery>
	
	<cfif AllTransactions.RecordCount>
	
		<cfif AllTransactions.TotalBizIncome NEQ ''>
			<cfset totalincome = (totalincome+AllTransactions.TotalBizIncome)>
		</cfif>
		
		<cfif AllTransactions.TotalBizExpense NEQ ''>
			<cfset totalexpenses = (totalexpenses+AllTransactions.TotalBizExpense)>
		</cfif>
		
		<cfif AllTransactions.TotalBizHours NEQ ''>
			<cfset totalMinutes = (totalMinutes+AllTransactions.TotalBizHours)>
		</cfif>
		
	</cfif>	
	
	</cfloop>	
	
	<cfset TotalProfit = totalincome - totalexpenses>	
	<cfset TotalHours = INT(totalMinutes / 60)>
	<cfset DisplayMinutes = (totalMinutes MOD 60)>
	
	<cfif totalProfit NEQ 0 AND totalProfit NEQ '' AND TotalHours NEQ 0 AND TotalHours NEQ ''>
		<cfset averageProfitPerHour = (totalProfit/TotalHours)>
	<cfelse>
		<cfset averageProfitPerHour = 0>
	</cfif>	
	
	<cfquery name="AllContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Count(Contacts.ContactID) AS TotalContacts
	FROM Contacts, KidClientLinks
	WHERE KidClientLinks.KidID = #this_contactID#
	AND KidClientLinks.ClientID=Contacts.ContactID
	AND Contacts.ContactStatus <> 'Deleted'
	</cfquery>	
	
	<cfquery name="AllInvites" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Count(Contacts.ContactID) AS TotalSuccessFulInvites
	FROM Contacts
	WHERE ReferralCode LIKE '%#this_referralCode#%'
	</cfquery>	
	
	<cfquery name="PointsIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalPointsIn
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsIn.TotalPointsIn#")>
		<cfset TotalUserPointsIn = INT(PointsIn.TotalPointsIn)>
	<cfelse>
		<cfset TotalUserPointsIn = 0>
	</cfif>	
	
	<cfif IsDate("#this_DateJoined#") AND DateCompare(this_DateJoined, "1-Nov-2005") EQ -1>
		<cfset pointsStartMonth = "1-Nov-2005">
	<cfelseif IsDate("#this_DateJoined#")>
		<cfset pointsStartMonth = MemberDetails.DateJoined>
	<cfelse>
		<cfset pointsStartMonth = "1-Nov-2005">
	</cfif>	
	
	<cfset MemberMonths = DateDiff('m', pointsstartmonth, localdatetime)>
	
	<cfif MemberMonths LT 1>
		<cfset MemberMonths = 1>
	</cfif>	
	
	<cfif IsNumeric("#TotalUserPointsIn#") AND TotalUserPointsIn GT 0>
		<cfset avgPointsMonth = (TotalUserPointsIn / MemberMonths)>
	 <cfelse>
	 	<cfset avgPointsMonth = 0>
	 </cfif>	 
	 
	 <!--- POINTS FROM IDEAS --->
	 <cfquery name="qry_idea_points" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalIdeaPoints
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%Points%'
	AND Related_Description LIKE '%Idea%'
	</cfquery>
	
	<cfif IsDefined("qry_idea_points.TotalIdeaPoints") AND IsNumeric("#qry_idea_points.TotalIdeaPoints#")>
		<cfset IdeaPoints = qry_idea_points.TotalIdeaPoints>
	<cfelse>
		<cfset IdeaPoints = 0>
	</cfif>
	
	<cfquery name="DeleteOld" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contacts_benchmarking
	WHERE contactID=#this_contactID#
	</cfquery>
	
	
	<cfquery name="insertBenchmarking" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO contacts_benchmarking(contactID,
	goals,
	goals_complete,
	contacts,
	InvitesSuccessful,
	TotalProfits,
	TotalHours,
	HrProfits,
	PointsEarned,
	PointsAvgMonth,
	IdeasSubmitted,
	IdeasWinner,
	IdeaPoints)	
	VALUES(#this_contactID#,
	#Goals_Total#,
	#Goals_Total_Complete#,
	#AllContacts.TotalContacts#,
	#AllInvites.TotalSuccessFulInvites#,
	#TotalProfit#,
	#TotalHours#,
	#averageProfitPerHour#,
	#TotalUserPointsIn#,
	#avgPointsMonth#,
	#qry_all_ideas.RecordCount#,
	#allWinIdeas#,
	#IdeaPoints#)
	</cfquery>
	
	
</cfloop>


<script>
alert("done");
</script>