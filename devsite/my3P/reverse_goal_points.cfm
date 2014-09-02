<!--- GET ALL CONTACTID'S FOR UPDATEGOAL --->
<cfquery name="qry_all_members" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT ContactID
FROM contact_transactions
WHERE Related_Description LIKE '%UpdateGoal%'
GROUP BY ContactID
ORDER BY ContactID
</cfquery>

<cfoutput query="qry_all_members">#qry_all_members.ContactID#, </cfoutput>


<cfabort>









<!--- 
<cfoutput>

<cfquery name="CheckReward" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT *
FROM contact_transactions
WHERE Related_Description LIKE '%UpdateGoal%'
ORDER BY Related_Identifier, Transaction_Date
</cfquery>

<cfset total_to_reverse = 0>
<cfloop query="CheckReward">

<cfset this_TransactionID = CheckReward.TransactionID>

<cfif IsDefined("this_goalID") AND this_goalID EQ CheckReward.Related_Identifier>
	
	<cfif DateDiff('h', this_date, CheckReward.Transaction_Date) LT 24>

		<cfset total_to_reverse = (total_to_reverse + CheckReward.Transaction_Amount)>	
	
	</cfif>
	
<cfelseif IsDefined("this_goalID") AND this_goalID NEQ CheckReward.Related_Identifier>	
	
	<!--- IF REVERSE TOTAL GT 0 INSERT REVERSE RECORD --->
	<cfif total_to_reverse GT 0>
		<cfquery name="AddReverseTrans" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
		INSERT INTO contact_transactions(ContactID, Transaction_Type, Transaction_Date, Transaction_Description, Transaction_Amount, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_Description, RoyaltyPaid, PointsType)
		VALUES(#CheckReward.ContactID#, 'Debit', #createODBCDateTime(localdatetime)#, 'Points reversed from multiple goal updates', #total_to_reverse#, 'Points', 0, 99999, 'PointsReversal', 1, 'Earned')
		</cfquery>
	
		<cfset total_to_reverse = 0>
	</cfif>
</cfif>	
	
	
<cfset this_goalID = CheckReward.Related_Identifier>
<cfset this_date = CheckReward.Transaction_Date>


</cfloop>

</cfoutput> --->