<cfset totalpersurvey = "100">

<cfloop list="21372,21376,21377,21419,21473,21572,21660,21784,21789,22158,22159,22163,22168,22172,22173,22181,22348,22375,22381,22382,22385,22387,22389,22391,22486,22494,22527,22538,22546,22548,22549,22551,22636,22637,22833,22975,23028,23254" index="this_member" delimiters=",">
	
	<cfquery name="MemberTransactions" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
	SELECT TransactionID
	FROM contact_transactions
	WHERE Related_Description LIKE '%Survey%'
	AND Related_Identifier = 3
	AND ContactID = #this_member#
	</cfquery>	
	
	<cfif MemberTransactions.RecordCount GT 1>
		
		<cfset totaltoreverse = ((MemberTransactions.RecordCount * totalpersurvey) - totalpersurvey)>
		<cfoutput>#this_member#: #MemberTransactions.RecordCount# submissions... #totaltoreverse# points to reverse<br></cfoutput>
		
		
		<cfquery name="AddReverseTrans" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		INSERT INTO contact_transactions(ContactID, Transaction_Type, Transaction_Date, Transaction_Description, Transaction_Amount, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
		VALUES(#this_member#, 'Debit', #createODBCDateTime(localdatetime)#, 'Points reversed from multiple survey submissions', #totaltoreverse#, 'Points', 0, 99999, 'PointsReversal', 1, 'Earned')
		</cfquery>
			
	<cfelse>
	
	<cfoutput>#this_member#: #MemberTransactions.RecordCount#<br></cfoutput>
	</cfif>
	
</cfloop>
