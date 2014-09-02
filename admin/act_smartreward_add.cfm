

<!--- GENERATE NEW DOCUMENT ID --->
	
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SmartRewardID
	FROM SmartRewards
	ORDER BY SmartRewardID DESC
	</cfquery>
	
	<cfif #lastid.recordcount# GT 0>
		<cfset newid = (#lastID.SmartRewardID# + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	


<!--- INSERT ARTICLE INFO --->
	
	<cfquery name="AddAdministrator" datasource="#dsn#" username="#request.username#" password="#request.password#">
	INSERT INTO SmartRewards(SmartRewardID, RewardDetails, IncreasePeriodType, IncreasePeriodDays, IncreasePercentage, DisplayOrder)
	VALUES(#newid#, '#form.RewardDetails#', '#form.IncreasePeriodType#', '#form.IncreasePeriodDays#', #form.IncreasePercentage#, #form.displayorder#)
	</cfquery>

	


	<cfoutput>
	<cfset logdetails = 'Add Smart Reward'>
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
