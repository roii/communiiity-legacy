<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Suggestion.*, SugCategory.Name, Contacts.FirstName, Contacts.EmailAddress
FROM Suggestion, SugCategory, Contacts
WHERE Suggestion.SugID=#SugID#
AND Suggestion.CategoryID=SugCategory.CategoryID
AND Suggestion.ContactID=Contacts.ContactID
</cfquery>

<!--- GET DEFAULT EMAIL TEXT --->
<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertSubject, AlertDetails
FROM EmailAlerts
WHERE AlertID=10
</cfquery>


<cfset NewAlertDetails = AlertStuff.AlertDetails>

<!--- REPLACE {sitename} --->
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitename}',  '#TRIM(session.AllSettings_SiteName)#',  "ALL")>

<!--- REPLACE {siteurl} --->
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>

<!--- REPLACE {idea_title} --->
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{idea_title}',  '...#chr(10)##chr(10)#"#TRIM(IdeaStuff.suggestion)#"#chr(10)##chr(10)#...' ,  "ALL")>		


<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(session.AllSettings_SiteName)# - Move Idea</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="ffffff">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Move Idea</strong></span></td>
</tr>

<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top" style="padding-right:20px;">
<br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form method="post" action="#request.webroot#/ideas/act_move_idea.cfm">
	
	<input type="hidden" name="SugID" value="#SugID#">
	<input type="hidden" name="currentcategory" value="#currentcategory#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Topic:</td>
	<td>#TRIM(IdeaStuff.Name)#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Idea:</td>
	<td valign="top"><strong>#TRIM(IdeaStuff.suggestion)#</strong><br>
	#TRIM(IdeaStuff.details)#
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Submitted</td>
	<td>#DateFormat(IdeaStuff.WhenSugMade, "d mmm yy")# &nbsp;-&nbsp; #TimeFormat(IdeaStuff.WhenSugMade, "h:mm TT")#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110">Current Stage</td>
	<td>#TRIM(IdeaStuff.SugStage)#</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Move To</td>
	<td>
	
	
	
		<table width="230" cellpadding="0" cellspacing="0" border="0">
			
		<tr>
		<td width="30"><img src="#request.imageroot#/transparent_spc.gif" width="30" height="1" border="0"></td>
		<td width="200"><img src="#request.imageroot#/transparent_spc.gif" width="200" height="1" border="0"></td>
		</tr>
		
		
			
		<tr>
		<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="Returned"></td>
		<td style="padding-bottom:5px;">Returned Ideas</td>
		</tr>
				
		<cfif TRIM(IdeaStuff.SugStage) CONTAINS 'Pending'>
			
			<cfquery name="S1_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=15
			</cfquery>
			
			<cfquery name="S2_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=16
			</cfquery>
			
			<cfquery name="S3_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=17
			</cfquery>
			
			<cfquery name="S4_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=18
			</cfquery>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="1" checked></td>
			<td style="padding-bottom:5px;">Stage 1 &nbsp; - &nbsp; #S1_RewardDetails.Points# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="2"></td>
			<td style="padding-bottom:5px;">Stage 2 &nbsp; - &nbsp; #INT(S1_RewardDetails.Points + S2_RewardDetails.Points)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="3"></td>
			<td style="padding-bottom:5px;">Stage 3 &nbsp; - &nbsp; #INT(S1_RewardDetails.Points + S2_RewardDetails.Points + S3_RewardDetails.Points)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4"></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(S1_RewardDetails.Points + S2_RewardDetails.Points + S3_RewardDetails.Points + S4_RewardDetails.Points)# pts</td>
			</tr>
		
		<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 1'>
			
			<cfquery name="S2_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=16
			</cfquery>
			
			<cfquery name="S3_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=17
			</cfquery>
			
			<cfquery name="S4_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=18
			</cfquery>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="2" checked></td>
			<td style="padding-bottom:5px;">Stage 2 &nbsp; - &nbsp; #INT(S2_RewardDetails.Points)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="3"></td>
			<td style="padding-bottom:5px;">Stage 3 &nbsp; - &nbsp; #INT(S2_RewardDetails.Points + S3_RewardDetails.Points)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4"></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(S2_RewardDetails.Points + S3_RewardDetails.Points + S4_RewardDetails.Points)# pts</td>
			</tr>
		
		<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 2'>
			
			<cfquery name="S3_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=17
			</cfquery>
			
			<cfquery name="S4_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=18
			</cfquery>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="3" checked></td>
			<td style="padding-bottom:5px;">Stage 3 &nbsp; - &nbsp; #INT(S3_RewardDetails.Points)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4"></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(S3_RewardDetails.Points + S4_RewardDetails.Points)# pts</td>
			</tr>
		
		<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 3'>
			
			<cfquery name="S4_RewardDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT *
			FROM Activity
			WHERE ActivityID=18
			</cfquery>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4" checked></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(S4_RewardDetails.Points)# pts</td>
			</tr>		
		
		</cfif>
		
		</table>	
	
	</td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Idea was<br>moved because:<br>
	<span style="font-size:11px;color:666666;">Displayed in email<br>to member as reason (see below)</span></td>
	<td style="padding-left:5px;"><textarea class="whitefield" name="comments" style="width:400px;height:100px;">#TRIM(IdeaStuff.comments)#</textarea></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Email To Member:<br>
	<span style="font-size:11px;color:666666;">Read only... your<br>
	reason will be<br>inserted into the<br>space provided...</span></td>
	<td style="padding-left:5px;"><textarea class="whitefield" readonly name="email" style="width:400px;height:150px;" onClick="javascript:alert('This is a read-only field and cannot be edited');">#TRIM(NewAlertDetails)#</textarea></td>
	</tr>	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top"></td>
	<td style="padding-left:5px;"><input type="submit" value="Move Idea &raquo;" class="whitefield"></td>
	</tr>	
		
	</form>
	
	</table><br><br>
	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>