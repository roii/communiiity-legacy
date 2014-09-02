<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT PrizePoolID
FROM Prize_Pool
ORDER BY PrizePoolID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.PrizePoolID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>


<cfquery name="AddReward" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Prize_pool(PrizePoolID, Name, Description, Country, pointsvalue, PrizeDraw, Reward, DisplayOrder, quantity, PromoteOnSide, Deleted, Display)
VALUES(#newid#, '#TRIM(form.Name)#', '#TRIM(form.description)#', '#INT(form.countryID)#', <cfif IsNumeric("#form.pointsvalue#")>#form.pointsvalue#,<cfelse>0,</cfif> 0, 1, <cfif IsDefined("form.DisplayOrder") AND IsNumeric("#form.DisplayOrder#")>#form.DisplayOrder#,<cfelse>0,</cfif><cfif IsNumeric("#form.Quantity#")>#form.Quantity#,<cfelse>0,</cfif><cfif IsNumeric("#form.PromoteOnSide#")>#form.PromoteOnSide#,<cfelse>0,</cfif> 0, <cfif IsDefined("form.Display") AND form.Display EQ 1>1<cfelse>0</cfif>)
 </cfquery>
 

<cfif Trim(Form.PrizeImage) NEQ ''>
	
	<cftry>
	
		<cffile action="upload" filefield="Form.PrizeImage" destination="#request.fileroot#\images\prize\" nameconflict="overwrite" accept="image/*">
    	
		
		<cfx_image action="resize" file="#request.fileroot#\images\prize\#file.serverfile#" output="#request.fileroot#\images\prize\thumb_#file.serverfile#" quality="100" x="80" y="60">

		<cfquery name="Updateprizepool" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE prize_pool
		SET image = 'thumb_#file.serverfile#'
		WHERE prizepoolid = #newid#
		</cfquery>
		
		<cffile action="delete" file="#request.fileroot#\images\prize\#file.serverfile#">
		
	<cfcatch>
		<cfset uploadFileError = true>
	</cfcatch>
	</cftry>
	
</cfif>	


<cfoutput>

	<script language="JavaScript">
	<!--
	function showParentAndClose(givenURL) {
	   alert("New reward has been added successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_rewards')"></body>
  
</cfoutput>