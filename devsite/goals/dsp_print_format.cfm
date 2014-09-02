<cfoutput>


<!--- GET SPONSORS LOGO --->
<cfquery name="SponsorStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
SELECT Organisations.Organisation_Name, Organisations.LogoFile
FROM SponsorPoints, Organisations
WHERE SponsorPoints.PointsRemaining > 0
AND (SponsorPoints.Activities LIKE '3' OR SponsorPoints.Activities LIKE '3,%' OR SponsorPoints.Activities LIKE '%,3' OR SponsorPoints.Activities LIKE '%,3,%')
AND SponsorPoints.SponsorID=Organisations.OrganisationID
ORDER BY DatePurchased
</cfquery>


<!--- GET CHARITY LOGO --->
<cfquery name="CharityStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
SELECT Organisations.Organisation_Name, Organisations.LogoFile
FROM Contacts, Organisations
WHERE Contacts.ContactID=#session.UserID#
AND Contacts.Charity=Organisations.OrganisationID
</cfquery>


<!--- GET SCHOOL LOGO --->
<cfquery name="SchoolStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
SELECT SchoolName, LogoFile
FROM Schools
WHERE SchoolID=#session.User_SchoolID#
</cfquery>


<cfquery name="CurrentGoals" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT * FROM Goals, GoalKidsLink
WHERE Goals.GoalID IN (#GoalID#)
AND Goals.goalID=GoalKidsLink.goalID
ORDER BY GoalKidsLink.bywhen
</cfquery>

<html>

<head>
<cfinclude template="../templates/styles.cfm">
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" bgcolor="white">
<div align="center">
<br>


<table border="0" cellpadding="0" cellspacing="0" width="95%">

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td width="90%">


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td style="font-size:16px;font-face:Arial;color:black;"><strong>Goals for #session.User_FirstName# #session.User_LastName#</strong></td>
	<td width="150" align="right" class="maincopy"><a href="javascript:window.close();" class="textlinks">Close Window</a> | <a href="javascript:window.print();" class="textlinks">Print page</a></td>
	</tr>
	
	</table>
	

</td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td bgcolor="black" width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%">


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td>Printed:<b> #dateformat(localDateTime, "mmm d, yyyy")#</b></td>
	<td align="center" class="maincopy"></td>
	<td align="right"><!--- <cfif IsDefined("URL.ContactID")>Category:<b> #TRIM(ContactDetails.CatName)#</b></cfif> ---></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%">


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td class="maincopy">

		
		
		<table width="100%" cellpadding="0" cellspacing="1" border="0">

		<tr bgcolor="###TRIM(AllSettings.DkBoxColour)#" height="25">
		<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;" colspan="2"><strong>My Goals Are...</strong></td>
		</tr>
		
		<tr>
		<td colspan="2" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
		</tr>
		
		
		<form name="GoalForm" action="#request.webroot#/goals/act_print_format.cfm" method="post">
		</cfoutput>
		<cfoutput query="CurrentGoals" group="GoalID">
		
		<cfquery name="CatStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT CategoryName, ImageFile
		FROM GoalCats
		WHERE GoalCatID=#CurrentGoals.GoalCatID#
		</cfquery>
		
		<tr>
		<td valign="top" width="90">
		
			<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
					
			<tr>
			<td align="center" valign="center">			
			<cfif fileExists("#request.fileroot#\images\goals\#TRIM(CatStuff.ImageFile)#")>
				<img src="#request.imageroot#/goals/#TRIM(CatStuff.ImageFile)#" width="80" height="60" border="0" alt="#TRIM(CatStuff.CategoryName)#">
			<cfelse>
				<img src="#request.imageroot#/transparent_spc.gif" width="80" height="60" border="0" alt="#TRIM(CatStuff.CategoryName)#">
			</cfif>
			</td>
			</tr>
			
			</table>
		
		</td>
		<td valign="top" style="padding-left:10px;">
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td valign="top" width="100%"><strong><span style="color:###TRIM(AllSettings.DkTextColor)#;">#TRIM(CurrentGoals.GoalTitle)#</span></strong><br>
			#TRIM(CurrentGoals.Goaldetails)#<br>
			
			<cfset this_percentDone = CurrentGoals.PercentDone>
			<cfinclude template="dsp_percent_bar.cfm"></td>
			<td valign="top" width="130">By When: #Dateformat(CurrentGoals.bywhen,"d-mmm-yy")#<br>
			<cfif documentID EQ 38>Updated: #Dateformat(CurrentGoals.lastModified,"d-mmm-yy")#<cfelse>Completed: #Dateformat(CurrentGoals.archiveDate,"d-mmm-yy")#</cfif><br>
			<img src="#request.imageroot#/transparent_spc.gif" width="130" height="1" border="0">
			</td>
			</tr>
			
			
			</table>
		
		
		</td>
		</tr>
		
		<tr>
		<td colspan="2" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="1" bgcolor="b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		</cfoutput>
		
		<cfoutput>
		<tr>
		<td colspan="2" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		
		</table>
	
	</td>
	</tr>
	
	</table>


</td>
</tr>

</table>


<table border="0" cellpadding="0" cellspacing="0" width="95%">

<tr>
<td><cfif IsDefined("SponsorStuff") AND SponsorStuff.RecordCount GT 0><cfif FileExists("#request.fileroot#\images\partners\#TRIM(SponsorStuff.LogoFile)#")><img src="#request.imageroot#/partners/#TRIM(SponsorStuff.LogoFile)#" border="0" title="#TRIM(SponsorStuff.Organisation_Name)#"></cfif></cfif></td>
<td><cfif IsDefined("CharityStuff") AND CharityStuff.RecordCount GT 0><cfif FileExists("#request.fileroot#\images\charity\#TRIM(CharityStuff.LogoFile)#")><img src="#request.imageroot#/charity/#TRIM(CharityStuff.LogoFile)#" border="0" title="#TRIM(CharityStuff.Organisation_Name)#"></cfif></cfif></td>
<td><cfif IsDefined("SchoolStuff") AND SchoolStuff.RecordCount GT 0><cfif FileExists("#request.fileroot#\images\schools\sml_#TRIM(SchoolStuff.LogoFile)#")><img src="#request.imageroot#/schools/sml_#TRIM(SchoolStuff.LogoFile)#" border="0" title="#TRIM(SchoolStuff.SchoolName)#"></cfif></cfif></td>
<td align="right" style="padding-top:2px;"><img src="#request.imageroot#/3Pv_logo_popup.gif" border="0"></td>
</tr>

</table><br>
</div>
</body>

</html>

</cfoutput>