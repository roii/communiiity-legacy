
	


<!--- update reward --->
	
	<cfquery name="updatereward" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE SmartRewards
	SET RewardDetails='#form.RewardDetails#', 
	IncreasePeriodType='#form.IncreasePeriodType#', 
	IncreasePeriodDays='#form.IncreasePeriodDays#', 
	IncreasePercentage=#form.IncreasePercentage#,
	DisplayOrder=#form.displayOrder#
	WHERE SmartRewardID=#form.SmartRewardID#
	</cfquery>

	


	<cfoutput>
	<cfset logdetails = 'Update Smart Reward'>
	</cfoutput>

	<cfinclude template="act_adminlog.cfm">
	
	
	

<!--- CLOSE THE POP-UP THE REFRESH THE CALLING PAGE --->
	
	
	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	    window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	
	<cfoutput>
	
		<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=kidzbiz&fusesubaction=docs&documentID=26')"></body>
	
	
	</cfoutput>
