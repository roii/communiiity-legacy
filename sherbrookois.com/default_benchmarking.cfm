<cfquery name="MemberDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE ContactTypeID IN (1,2,6)
AND ContactStatus LIKE '%Active%'
AND ContactID > 1000
ORDER BY ContactID
</cfquery>



<cfloop query="MemberDetails">

	<cfset this_contactID = MemberDetails.ContactID>

	
	<!--- GET UNAUTHORISED SUGGESTIONS --->
	<cfquery name="AllUnAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID, WhenSugMade, suggestion, SugStage, Archived
	FROM suggestion
	WHERE ContactID=#this_contactID#
	AND Authorise LIKE '%no%'
	ORDER BY WhenSugMade DESC
	</cfquery>	
	
	
	<!--- GET AUTHORISED SUGGESTIONS --->
	<cfquery name="AllAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID, WhenSugMade, suggestion, SugStage
	FROM suggestion
	WHERE ContactID=#this_contactID#
	AND Authorise = 'yes'
	AND Archived=0
	ORDER BY WhenSugMade DESC
	</cfquery>
	
	
	<cfif AllUnAuthorisedIdeas.recordcount EQ 0 AND AllAuthorisedIdeas.Recordcount EQ 0>
	<cfset NoIdeas=1>
	<cfelse>
	<cfset NoIdeas=0>
	</cfif>
	
	
	<!--- GET DRAFT SUGGESTIONS --->
	<cfquery name="DraftIdeas" dbtype="query">
	SELECT SugID
	FROM AllUnAuthorisedIdeas
	WHERE SugStage='Draft'
	</cfquery>
	
	
	<!--- GET PENDING SUGGESTIONS --->
	<cfquery name="PendingIdeas" dbtype="query">
	SELECT SugID
	FROM AllUnAuthorisedIdeas
	WHERE SugStage LIKE '%Pending%'
	AND Archived=0
	</cfquery>
	
	
	<cfquery name="Stage1Ideas" dbtype="query">
	SELECT SugID
	FROM AllAuthorisedIdeas
	WHERE SugStage LIKE '%Stage 1%'
	</cfquery>
	
	
	<cfquery name="Stage2Ideas" dbtype="query">
	SELECT SugID
	FROM AllAuthorisedIdeas
	WHERE SugStage LIKE '%Stage 2%'
	</cfquery>
	
	<cfquery name="Stage3Ideas" dbtype="query">
	SELECT SugID
	FROM AllAuthorisedIdeas
	WHERE SugStage LIKE '%Stage 3%'
	</cfquery>
	
	<cfquery name="WinningIdeas" dbtype="query">
	SELECT SugID
	FROM AllAuthorisedIdeas
	WHERE SugStage LIKE '%Stage 4%'
	OR SugStage LIKE '%Stage 5%'
	</cfquery>
	
	<cfquery name="BungIdeas" dbtype="query">
	SELECT SugID
	FROM AllUnAuthorisedIdeas
	WHERE Archived=1
	</cfquery>
	
	
	<!--- GET ALL GOALS FOR THIS MEMBER --->
	<cfquery name="AllGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Goals.GoalID, GoalKidsLink.bywhen, GoalKidsLink.archived
	FROM Goals, GoalKidsLink
	WHERE Goals.GoalID=GoalKidsLink.GoalID
	AND GoalKidsLink.KidsID = #this_contactID#
	</cfquery>
	
	
	
	
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
	
	
	
	<!--- GET ALL PRIZES WON BY MEMBER --->
	<cfquery name="AllPrizesWon" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT COUNT(PrizePoolID) AS TotalPrizesWon, SUM(pointsvalue) AS TotalPrizeValue
	FROM Prize_Pool
	WHERE PrizeDraw=1
	AND winner = #this_contactID#
	</cfquery>
	
	<!--- GET ALL PRIZES ENTRIES BY MEMBER --->
	<cfquery name="AllPrizeEntries" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT COUNT(Prize_entryID) AS TotalPrizeEntries
	FROM Prize_Entry
	WHERE ContactID = #this_contactID#
	</cfquery>
	
	<!--- GET ALL REWARDS PURCHASED --->
	<cfquery name="AllRewardsPurchased" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT COUNT(RewardTransactions.RewardTransID) AS TotalRewardsPurchased, SUM(Prize_Pool.pointsvalue) AS TotalRewardValue
	FROM RewardTransactions, Prize_Pool
	WHERE RewardTransactions.ContactID = #this_contactID#
	AND RewardTransactions.RewardID=Prize_Pool.PrizePoolID
	</cfquery>
	
	
	
	<cfquery name="AllContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Contacts.ContactID, Contacts.Categories, Contacts.CountryID
	FROM Contacts, KidClientLinks
	WHERE KidClientLinks.KidID = #this_contactID#
	AND KidClientLinks.ClientID=Contacts.ContactID
	AND Contacts.ContactStatus <> 'Deleted'
	</cfquery>
	
	
	
	
	<cfquery name="CashIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalCashIn
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%personal%'
	</cfquery>
	
	<cfif IsNumeric("#CashIn.TotalCashIn#")>
	<cfset TotalUserCashIn = INT(CashIn.TotalCashIn)>
	<cfelse>
	<cfset TotalUserCashIn = 0>
	</cfif>
	
	
	<cfquery name="CashOut" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalCashOut
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%debit%'
	AND Transaction_Account LIKE '%personal%'
	</cfquery>
	
	<cfif IsNumeric("#CashOut.TotalCashOut#")>
	<cfset TotalUserCashOut = INT(CashOut.TotalCashOut)>
	<cfelse>
	<cfset TotalUserCashOut = 0>
	</cfif>
	
	
	<cfquery name="EducationIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalEducationIn
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%credit%'
	AND Transaction_Account LIKE '%education%'
	</cfquery>
	
	<cfif IsNumeric("#EducationIn.TotalEducationIn#")>
	<cfset TotalUserEducationIn = INT(EducationIn.TotalEducationIn)>
	<cfelse>
	<cfset TotalUserEducationIn = 0>
	</cfif>
	
	
	<cfquery name="EducationOut" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalEducationOut
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%debit%'
	AND Transaction_Account LIKE '%education%'
	</cfquery>
	
	<cfif IsNumeric("#EducationOut.TotalEducationOut#")>
	<cfset TotalUserEducationOut = INT(EducationOut.TotalEducationOut)>
	<cfelse>
	<cfset TotalUserEducationOut = 0>
	</cfif>
	
	
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
	
	
	<cfquery name="PointsOut" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SUM(Transaction_Amount) AS TotalPointsOut
	FROM contact_transactions
	WHERE ContactID = #this_contactID#
	AND Transaction_Type LIKE '%debit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif IsNumeric("#PointsOut.TotalPointsOut#")>
	<cfset TotalUserPointsOut = INT(PointsOut.TotalPointsOut)>
	<cfelse>
	<cfset TotalUserPointsOut = 0>
	</cfif>
	
	
	
	<cfquery name="DeleteOld" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contacts_benchmarking
	WHERE contactID=#this_contactID#
	</cfquery>
	
	
	<cfquery name="insertBenchmarking" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO contacts_benchmarking(contactID,
	goals,
	contacts,
	TotalProfits,
	HrProfits,
	CashEarned,
	PointsEarned,
	PointsSaved,
	IdeasSubmitted,
	FeedbackOnIdeas,
	PrizeDrawEntries)
	VALUES (#this_contactID#,
	#AllContacts.RecordCount#,
	#AllGoals.recordcount#,
	#TotalProfit#,
	#averageProfitPerHour#,
	#TotalUserCashIn#,
	#TotalUserPointsIn#,
	#INT(TotalUserPointsIn-TotalUserPointsOut)#,
	#INT(AllUnAuthorisedIdeas.RecordCount + AllAuthorisedIdeas.RecordCount)#,
	0,
	#AllPrizeEntries.TotalPrizeEntries#)
	</cfquery>
	
	
</cfloop>


<script>
alert("done");
</script>