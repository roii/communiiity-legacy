<cfset startd = CREATEDATE(#mid(form.start_date,7,4)#,#mid(form.start_date,4,2)#,#mid(form.start_date,1,2)#)>
<cfset startd = DateFormat(#startd#,"mm/dd/yyyy")>
<cfset endd = CREATEDATE(#mid(form.draw_date,7,4)#,#mid(form.draw_date,4,2)#,#mid(form.draw_date,1,2)#)>
<cfset endd = DateFormat(#endd#,"mm/dd/yyyy")>
		
<!--- GENERATE NEW ORGANISATION ID --->	
<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT PrizePoolID
FROM Prize_pool
ORDER BY PrizePoolID DESC
</cfquery>

<cfif lastid.recordcount>
	<cfset newid = (lastID.PrizePoolID + 1)>
<cfelse>
	<cfset newid = 1>
</cfif>
		
		
<cfquery name="Addprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Prize_pool(PrizePoolID, Name, Description, Country, start_date, draw_date, pointsvalue, PrizeDraw, Reward, DisplayOrder, InviteFriend, Deleted, PromoteOnSide, Daily500, ShowWinner, PointsPaid)
VALUES(#newid#, '#TRIM(form.Name)#', '#TRIM(form.description)#', '#INT(form.countryID)#', '#startd#', '#endd#', <cfif IsNumeric("#form.pointsvalue#")>#form.pointsvalue#,<cfelse>0,</cfif> 1, 0, <cfif IsDefined("form.DisplayOrder") AND IsNumeric("#form.DisplayOrder#")>#form.DisplayOrder#,<cfelse>0,</cfif><cfif IsDefined("form.InviteFriend") AND form.InviteFriend EQ 1>1<cfelse>0</cfif>, 0, 0, 0, 0, 0)
 </cfquery>

<cfquery name="addedprizepoolid" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TOP 1 prizepoolid 
FROM Prize_pool 
ORDER BY prizepoolid desc
</cfquery>
 

<cfif Trim(Form.PrizeImage) NEQ ''>
	
	<cftry>
	
		<cffile action="upload" filefield="Form.PrizeImage" destination="#request.fileroot#\images\prize\" nameconflict="makeunique" accept="image/*">
    	
		
		<cfx_image action="resize" file="#request.fileroot#\images\prize\#file.serverfile#" output="#request.fileroot#\images\prize\thumb_#file.serverfile#" quality="100" x="80" y="60">

		<cfquery name="Updateprizepool" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE prize_pool
		SET image = 'thumb_#file.serverfile#'
		WHERE prizepoolid = #addedprizepoolid.prizepoolid#
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
	   alert("New prize has been added successfully!");
		window.opener.document.location = givenURL;
		self.close();
	}
	
	// -->
	</script>
	
	<body onload="showParentAndClose('#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes')"></body>
  
</cfoutput>