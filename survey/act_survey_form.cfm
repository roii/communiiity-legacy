
<!--- DELETE ANY OLD ANSWERS FOR THIS USER --->
<cfquery name="DeleteOld" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
DELETE
FROM NewSurvey_Answers
WHERE UserID=#form.UserID#
AND QuestionaireID=#form.QuestionaireID#
</cfquery>


<!--- LOOP THROUGH QUESTIONS --->
<cfloop from="1" to="#form.TotalSurveyQuestions#" index="loopcount">
		
	<!--- CREATE NEW ANSWERID --->
	<cfquery name="LastID" datasource="#DSN#" maxrows="1" username="mykidsbiznew" password="u+67eNfJ">
	SELECT AnswerID
	FROM NewSurvey_Answers
	ORDER BY AnswerID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset new_AnswerID = (lastID.AnswerID + 1)>
	<cfelse>
		<cfset new_AnswerID = 1>
	</cfif>

	<cfset this_answer = "form.answer_" & "#loopcount#">
	<cfset this_other = "form.answer_" & "#loopcount#" & "_other">	
	
	<cfif IsDefined("#this_answer#")>
	
		<!--- INSERT ANSWER --->
		<cfquery name="AddAnswer" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		INSERT INTO NewSurvey_Answers(
		AnswerID,
		QuestionaireID,
		QuestionID,
		UserID,
		AnswerDate,
		AnswerDetails
		<cfif IsDefined("#this_other#")>,
			Answer_Other
		</cfif>	
		)
		VALUES(
		#new_AnswerID#,
		#form.QuestionaireID#,
		#Evaluate("form.questionID_" & loopcount)#,
		#form.UserID#,
		#CreateODBCDateTime(localDateTime)#,
		'#Replace(Evaluate("form.answer_" & loopcount), "'", "", "ALL")#'	
		<cfif IsDefined("#this_other#")>,
			'#Replace(Evaluate("form.answer_" & loopcount & "_other"), "'", "", "ALL")#'
		</cfif>	
		)
		</cfquery>	
	
	</cfif>

</cfloop>

<!--- PROCESS REWARDS --->
<cfquery name="QuestionairreStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT *
FROM NewQuestionaires
WHERE QuestionaireID=#form.QuestionaireID#
</cfquery>

<!--- POINTS --->
<cfif IsNumeric("#QuestionairreStuff.Reward_Points#") AND QuestionairreStuff.Reward_Points GT 0>
	
	<!--- CHECK THEY HAVE NOT EARNED FOR THIS SURVEY ALREADY --->
	<cfquery name="CheckExisting" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT transactionID
	FROM contact_transactions
	WHERE ContactID=#session.UserID#
	AND Related_Identifier=#form.QuestionaireID#
	AND Related_description LIKE '%Survey%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfif CheckExisting.RecordCount>
	<cfelse>
		
		<cftransaction action="BEGIN">
		<!--- INSERT THE TRANSACTION --->		
		<cfquery name="AddTransaction" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_description, Transaction_SponsorID, RoyaltyPaid, PointsType)
		VALUES(#form.UserID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #QuestionairreStuff.Reward_Points#, 'Completed Survey - #TRIM(QuestionairreStuff.Questionaire_Name)#', 'Points', #form.QuestionaireID#, 'Survey', 0, 0, 'Earned')
		</cfquery>
		<cftransaction action="COMMIT"/>
		</cftransaction>
	
</cfif>

<!--- CASH --->
<cfif IsNumeric("#QuestionairreStuff.Reward_Cash#") AND QuestionairreStuff.Reward_Cash GT 0>

	<!--- CHECK THEY HAVE NOT EARNED FOR THIS SURVEY ALREADY --->
	<cfquery name="CheckExisting2" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT transactionID
	FROM contact_transactions
	WHERE ContactID=#session.UserID#
	AND Related_Identifier=#form.QuestionaireID#
	AND Related_description LIKE '%Survey%'
	AND Transaction_Account LIKE '%Personal%'
	</cfquery>
	
	<cfif CheckExisting2.RecordCount>
	<cfelse>
		
		<cftransaction action="BEGIN">	
		
		<!--- INSERT THE TRANSACTION --->		
		<cfquery name="AddTransaction" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_description, Transaction_SponsorID, RoyaltyPaid, PointsType)
		VALUES(#form.UserID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #QuestionairreStuff.Reward_Cash#, 'Completed Survey - #TRIM(QuestionairreStuff.Questionaire_Name)#', 'Personal', #form.QuestionaireID#, 'Survey', 0, 0, 'Earned')
		</cfquery>
		<cftransaction action="COMMIT"/>
		</cftransaction>
	
	</cfif>

</cfif>

<!--- EDUCATION --->
<cfif IsNumeric("#QuestionairreStuff.Reward_Education#") AND QuestionairreStuff.Reward_Education GT 0>

	<!--- CHECK THEY HAVE NOT EARNED FOR THIS SURVEY ALREADY --->
	<cfquery name="CheckExisting3" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT transactionID
	FROM contact_transactions
	WHERE ContactID=#session.UserID#
	AND Related_Identifier=#form.QuestionaireID#
	AND Related_description LIKE '%Survey%'
	AND Transaction_Account LIKE '%Education%'
	</cfquery>
	
	<cfif CheckExisting3.RecordCount>
	<cfelse>
		
		<cftransaction action="BEGIN">	
		
		<!--- INSERT THE TRANSACTION --->		
		<cfquery name="AddTransaction" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_description, Transaction_SponsorID, RoyaltyPaid, PointsType)
		VALUES(#form.UserID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #QuestionairreStuff.Reward_Education#, 'Completed Survey - #TRIM(QuestionairreStuff.Questionaire_Name)#', 'Education', #form.QuestionaireID#, 'Survey', 0, 0, 'Earned')
		</cfquery>
		<cftransaction action="COMMIT"/>
		</cftransaction>
	
	</cfif>

</cfif>

<cfif CheckExisting3.RecordCount>
<cfelse>
	<!--- PRIZE ENTRIES --->
	<cfif IsNumeric("#QuestionairreStuff.Reward_PrizeEntries#") AND QuestionairreStuff.Reward_PrizeEntries GT 0>

		<cftransaction action="BEGIN">	
	
		<cfloop from="1" to="#QuestionairreStuff.Reward_PrizeEntries#" index="loopcount">
		
		<cfquery name="NewEntry" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		INSERT INTO Prize_Entry(ContactID, EntryDate)
		VALUES(#form.UserID#, #CreateODBCDateTime(localDateTime)#)
		</cfquery>
		
		</cfloop>
	
		</cftransaction>
	
	</cfif>
</cfif>

<cfoutput>

<script>
alert("Thank you for completing the survey!");
self.location="#request.webroot#/index.cfm?fuseaction=survey&this_QuestionaireID=#form.QuestionaireID#";
</script>

</cfoutput>