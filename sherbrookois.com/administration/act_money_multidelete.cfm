<cfloop from="1" to="#form.Numrecs#" index="loopcount">

<cfif IsDefined("form.DeleteTrans_#loopcount#") AND Evaluate("form.DeleteTrans_" & loopcount) EQ 1>

	
	
	<!--- GET TRANSACTION POINTS --->
	<cfquery name="TransPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Contact_transactions
	WHERE TransactionID=#Evaluate("form.TransactionID_" & loopcount)#
	</cfquery>
	
	
	<!--- IF POINTS ALLOCATED THEN REVERSE BACK TO SPONSOR --->
	<cfif TransPoints.Transaction_Account CONTAINS 'Points'>
	
		
		<!--- GET SPONSOR POINTS BALANCE --->
		<cfquery name="CurrentSponsorPoints" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT *
		FROM SponsorPoints
		WHERE SponsorID=#TransPoints.Transaction_SponsorID#
		ORDER BY DatePurchased DESC
		</cfquery>
		
		<cfif CurrentSponsorPoints.RecordCount>
		
			<cfset insert_points = (CurrentSponsorPoints.PointsRemaining+TransPoints.Transaction_Amount)>
			
			<cfquery name="UpdateSponsorPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE SponsorPoints
			SET PointsRemaining=#insert_points#
			WHERE SponsorPointsID=#CurrentSponsorPoints.SponsorPointsID#
			</cfquery>
		
		</cfif>
		
	
	</cfif>

	
	
	<!--- DELETE THE TRANSACTION --->
	<cfquery name="DeleteTrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
	DELETE
	FROM Contact_transactions
	WHERE TransactionID=#Evaluate("form.TransactionID_" & loopcount)#	
	</cfquery>



</cfif>


</cfloop>




<cfoutput>

<script>
alert("You have deleted all the checked transactions.");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney<cfif IsDefined("This_ContactID")>&This_ContactID=#This_ContactID#</cfif>";
</script>

</cfoutput>