<cfoutput>

<cfparam name="session.BenchmarksSet" default="No">

<cfif session.UserIsAuthenticated EQ 'Yes' AND session.UserType EQ 'Administrator' AND IsDefined("this_contact")>
	<cfset this_member = this_contact>
<cfelse>
	<cfset this_member = session.UserID>
</cfif>

<cfquery name="MemberDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#this_member#
</cfquery>


<!--- GET UNAUTHORISED SUGGESTIONS --->
<cfquery name="AllUnAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID, WhenSugMade, suggestion, SugStage, Archived
FROM suggestion
WHERE ContactID=#this_member#
AND Authorise LIKE '%no%'
ORDER BY WhenSugMade DESC
</cfquery>	


<!--- GET AUTHORISED SUGGESTIONS --->
<cfquery name="AllAuthorisedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SugID, WhenSugMade, suggestion, SugStage
FROM suggestion
WHERE ContactID=#this_member#
AND Authorise LIKE '%yes%'
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
WHERE SugStage LIKE '%Draft%'
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
AND GoalKidsLink.KidsID = #this_member#
</cfquery>


<cfquery name="CashIn" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalCashIn
FROM contact_transactions
WHERE ContactID = #this_member#
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
WHERE ContactID = #this_member#
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
WHERE ContactID = #this_member#
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
WHERE ContactID = #this_member#
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
WHERE ContactID = #this_member#
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
WHERE ContactID = #this_member#
AND Transaction_Type LIKE '%debit%'
AND Transaction_Account LIKE '%Points%'
</cfquery>

<cfif IsNumeric("#PointsOut.TotalPointsOut#")>
	<cfset TotalUserPointsOut = INT(PointsOut.TotalPointsOut)>
<cfelse>
	<cfset TotalUserPointsOut = 0>
</cfif>



<cfquery name="AllContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.Categories
FROM Contacts, KidClientLinks
WHERE KidClientLinks.KidID = #this_member#
AND KidClientLinks.ClientID=Contacts.ContactID
AND Contacts.ContactStatus <> 'Deleted'
</cfquery>

<!--- CHECK RATED ALL BUSINESS TEMPLATES --->
<cfset BizTemplates_Rated = 0>

<cfquery name="Allbizideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea 
RIGHT JOIN bizidea_Type 
ON bizidea.biz_ideatypeID=bizidea_Type.bizideatypeID 
WHERE show = 1 
ORDER BY BizIdeaID
</cfquery>

<cfloop query="Allbizideas">

	<cfset this_bizideaID = Allbizideas.bizideaID>
	
	<cfquery name="Feedback_BizTemplates" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FeedbackID
	FROM Feedback
	WHERE ContactID=#this_member#
	AND Feedback_type LIKE '%BusinessTemplate%'
	AND LinkID=#this_bizideaID#
	</cfquery>
	
	<cfif Feedback_BizTemplates.RecordCount>
		<cfset BizTemplates_Rated = (BizTemplates_Rated+1)>
	</cfif>

</cfloop>



<!--- GET AUTHORISED SUGGESTIONS FROM OTHERS --->
<cfquery name="AllUnVotedIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT suggestion.SugID
FROM suggestion
WHERE suggestion.ContactID <> #this_member#
AND suggestion.Authorise LIKE '%yes%'
AND suggestion.Archived=0
AND suggestion.SugStage IN ('Stage 1', 'Stage 2', 'Stage 3')
</cfquery>

<cfset tovoteontotal = 0>
<cfloop query="AllUnVotedIdeas">

<cfquery name="CheckExistingVote" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Vote
FROM SugVote
WHERE SugID=#AllUnVotedIdeas.SugID#
AND ContactID=#this_member#
</cfquery>

<cfif CheckExistingVote.RecordCount EQ 0>
	<cfset tovoteontotal = tovoteontotal+1>
</cfif>

</cfloop>



<!--- CHECK FOR INVITE TODAY --->
<cfquery name="Todayinvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT DateLastSent
FROM Invitations
WHERE InvitationFrom=#this_member#
</cfquery>

<cfset InviteSendToday=0>
<cfloop query="Todayinvite">
<cfif isDate("#Todayinvite.DateLastSent#") AND DateCompare(Todayinvite.DateLastSent,  localdatetime, "d") EQ 0>
	<cfset InviteSendToday=1>
</cfif>

</cfloop>

<!--- CHECK FOR UPDATED GOAL --->
<cfquery name="UpdatedGoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GoalKidsLink.lastModified
FROM Goals, GoalKidsLink
WHERE Goals.GoalID=GoalKidsLink.GoalID
AND GoalKidsLink.KidsID = #this_member#
</cfquery>

<cfset goalupdatedtoday=0>
<cfloop query="UpdatedGoals">
<cfif isDate("#UpdatedGoals.lastModified#") AND DateCompare(UpdatedGoals.lastModified,  localdatetime, "d") EQ 0>
	<cfset goalupdatedtoday=1>
</cfif>

</cfloop>


<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#UCASE(TRIM(MemberDetails.FirstName))#'s #TRIM(allsettings.SiteName)# DASHBOARD</strong></td>
<td align="right" width="30"></td>
</tr>


<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="400" height="15" border="0"></td>
</tr>

</table>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<cfif MemberDetails.RegionID EQ 0 OR MemberDetails.RegionID EQ 0 OR MemberDetails.RegionID EQ 0 OR MemberDetails.SchoolID EQ 0 OR MemberDetails.SchoolID EQ '' OR MemberDetails.Charity EQ 0 OR MemberDetails.Charity EQ '' OR NoIdeas EQ 1 OR AllGoals.RecordCount EQ 0 OR TRIM(MemberDetails.ScreenName) EQ '' OR Allbizideas.RecordCount NEQ BizTemplates_Rated OR tovoteontotal OR goalupdatedtoday EQ 0 OR InviteSendToday EQ 0 OR MemberDetails.PrintBizCards EQ 0 OR Memberdetails.MobilePhone EQ '' OR MemberDetails.VideoTestimonial EQ 0>
<tr>
<td colspan="3"><cfinclude template="dsp_dashboard_thingstodo.cfm"></td>
</tr>
</cfif>

<tr>
<td width="50%" valign="top">
<cfinclude template="dsp_dashboard_goals.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_business.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_ideas.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
<td width="50%" valign="top">
<cfinclude template="dsp_dashboard_prizes.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_community.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0">
<cfinclude template="dsp_dashboard_money.cfm">
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

<cfif session.BenchmarksSet EQ 'No'>
	
	<cfquery name="DeleteOld" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM contacts_benchmarking
	WHERE contactID=#this_member#
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
	VALUES (#this_member#,
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
	
	
	<cfset session.BenchmarksSet EQ 'Yes'>

</cfif>

<tr>
<td colspan="3"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
<cfinclude template="dsp_dashboard_benchmarking.cfm"></td>
</tr>

</table>


</cfoutput>