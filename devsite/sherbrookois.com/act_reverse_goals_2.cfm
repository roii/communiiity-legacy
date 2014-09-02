<cfloop list="19658, 33844, 33846, 18984, 16805, 16806, 19845, 33866, 27910, 27911, 27912, 27913, 27914, 27915, 33823, 27908" index="goal" delimiters=",">

	<cfquery name="qry_all_updates" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Transaction_Date, ContactID, Transaction_Amount
	FROM contact_transactions
	WHERE Related_Identifier=#goal#
	AND Related_Description LIKE '%UpdateGoal%'
	ORDER BY Transaction_Date
	</cfquery>
	

	<cfquery name="qry_contact_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, FirstName, LastName, ScreenName
	FROM Contacts
	WHERE ContactID=#qry_all_updates.ContactID#
	</cfquery>
	
	<cfquery name="qry_goal_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT GoalTitle
	FROM Goals
	WHERE GoalID=#goal#
	</cfquery>
	
	<cfif fileExists("#request.fileroot#\goal_reversals\#NumberFormat(qry_all_updates.ContactID, '000000')#_#REReplace(qry_contact_details.ScreenName, '[[:punct:]]', '', 'ALL')#.txt")>		
		<cffile action="append" file="#request.fileroot#\goal_reversals\#NumberFormat(qry_all_updates.ContactID, '000000')#_#REReplace(qry_contact_details.ScreenName, '[[:punct:]]', '', 'ALL')#.txt" output="-------------------------------------------------#chr(13)##chr(10)#:: GoalID: #Goal# - Title: #TRIM(qry_goal_details.GoalTitle)##chr(13)##chr(10)#-------------------------------------------------">	
	<cfelse>
		<cffile action="write" file="#request.fileroot#\goal_reversals\#NumberFormat(qry_all_updates.ContactID, '000000')#_#REReplace(qry_contact_details.ScreenName, '[[:punct:]]', '', 'ALL')#.txt" output="#DateFormat(localdatetime, 'dddd, d mmmm yyyy')##chr(13)##chr(10)#MY3P.COM POINTS AUDIT - GOAL UPDATES#chr(13)##chr(10)#-------------------------------------------------#chr(13)##chr(10)#Goals updated more than once in 24hrs should have#chr(13)##chr(10)#only received 1pt.#chr(13)##chr(10)#-------------------------------------------------#chr(13)##chr(10)#The following list shows the update history for#chr(13)##chr(10)#each of your goals. Any extra points earned for#chr(13)##chr(10)#updating a goal more than once in 24hrs have#chr(13)##chr(10)#been calculated and recovered in a points#chr(13)##chr(10)#reversal transaction.#chr(13)##chr(10)##chr(13)##chr(10)##chr(13)##chr(10)#-------------------------------------------------#chr(13)##chr(10)#:: GoalID: #Goal# - #TRIM(qry_goal_details.GoalTitle)##chr(13)##chr(10)#-------------------------------------------------">
	</cfif>
	
	<cfset total_to_reverse = 0>
	
	<cfoutput query="qry_all_updates">
	
	<cfif IsDefined("this_DT") AND this_DT NEQ ''>
		<cfif DateDiff('h', this_DT, qry_all_updates.Transaction_Date) LT 24>
			<cfset total_to_reverse = (total_to_reverse + qry_all_updates.Transaction_Amount)>
			<cffile action="append" file="#request.fileroot#\goal_reversals\#NumberFormat(qry_all_updates.ContactID, '000000')#_#REReplace(qry_contact_details.ScreenName, '[[:punct:]]', '', 'ALL')#.txt" output=":: Updated: #DateFormat(qry_all_updates.Transaction_Date)# #TimeFormat(qry_all_updates.Transaction_Date, 'HH:MM:SS')# - [REVERSED]">
			<cfset this_DT = qry_all_updates.Transaction_Date>
		<cfelse>
			<cffile action="append" file="#request.fileroot#\goal_reversals\#NumberFormat(qry_all_updates.ContactID, '000000')#_#REReplace(qry_contact_details.ScreenName, '[[:punct:]]', '', 'ALL')#.txt" output=":: Updated: #DateFormat(qry_all_updates.Transaction_Date)# #TimeFormat(qry_all_updates.Transaction_Date, 'HH:MM:SS')#">
			<cfset this_DT = qry_all_updates.Transaction_Date>
		</cfif>
	<cfelse>
		<cffile action="append" file="#request.fileroot#\goal_reversals\#NumberFormat(qry_all_updates.ContactID, '000000')#_#REReplace(qry_contact_details.ScreenName, '[[:punct:]]', '', 'ALL')#.txt" output=":: Updated: #DateFormat(qry_all_updates.Transaction_Date)# #TimeFormat(qry_all_updates.Transaction_Date, 'HH:MM:SS')#">
		<cfset this_DT = qry_all_updates.Transaction_Date>
	</cfif>
	
	</cfoutput>
	
	<cffile action="append" file="#request.fileroot#\goal_reversals\#NumberFormat(qry_all_updates.ContactID, '000000')#_#REReplace(qry_contact_details.ScreenName, '[[:punct:]]', '', 'ALL')#.txt" output=":: GOAL POINTS REVERSED: #total_to_reverse##chr(10)##chr(10)#">
	
	<!--- IF REVERSE TOTAL GT 0 INSERT REVERSE RECORD --->
	<cfif total_to_reverse GT 0>
		<cfquery name="AddReverseTrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO contact_transactions(ContactID, Transaction_Type, Transaction_Date, Transaction_Description, Transaction_Amount, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
		VALUES(#qry_all_updates.ContactID#, 'Debit', #createODBCDateTime(localdatetime)#, 'Points reversed from multiple goal updates', #total_to_reverse#, 'Points', 0, 99999, 'PointsReversal', 1, 'Earned')
		</cfquery>
	</cfif>
	
	<cfset this_DT = ''>

</cfloop>
