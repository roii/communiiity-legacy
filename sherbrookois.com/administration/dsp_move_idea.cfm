<cfquery name="IdeaStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Suggestion.*, SugCategory.CategoryID, SugCategory.Name, Contacts.FirstName, Contacts.EmailAddress
FROM Suggestion, SugCategory, Contacts
WHERE Suggestion.SugID=#SugID#
AND Suggestion.CategoryID=SugCategory.CategoryID
AND Suggestion.ContactID=Contacts.ContactID
</cfquery>

<cfset this_categoryID = IdeaStuff.CategoryID>
<cfinclude template="../ideas/act_topic_stages.cfm">


<!--- GET DEFAULT EMAIL TEXT --->
<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertSubject, AlertDetails
FROM EmailAlerts
WHERE AlertID=10
</cfquery>


<!--- REPLACE {member_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(AlertStuff.AlertSubject,  '{member_firstname}',  '#TRIM(IdeaStuff.FirstName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(AlertStuff.AlertDetails,  '{member_firstname}',  '#TRIM(IdeaStuff.FirstName)#',  "ALL")>

<!--- REPLACE {sitename} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>

<!--- REPLACE {siteurl} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>

<!--- REPLACE {idea_title} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{idea_title}',  '...#chr(10)##chr(10)#"#TRIM(IdeaStuff.suggestion)#"#chr(10)##chr(10)#...' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{idea_title}',  '...#chr(10)##chr(10)#"#TRIM(IdeaStuff.suggestion)#"#chr(10)##chr(10)#...' ,  "ALL")>		


<cfoutput>

<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Move Idea</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="fffff">

<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Move Idea</strong></span></td>
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
	
	<form method="post" action="#request.webroot#/administration/act_move_idea.cfm">
	<input type="hidden" name="SugID" value="#SugID#">
    <input type="hidden" name="CurrentCategory" value="#this_categoryID#">
	
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
			
	
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="1" checked></td>
			<td style="padding-bottom:5px;">Stage 1 &nbsp; - &nbsp; #thisTopic_Points_Stage_1# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="2"></td>
			<td style="padding-bottom:5px;">Stage 2 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_1 + thisTopic_Points_Stage_2)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="3"></td>
			<td style="padding-bottom:5px;">Stage 3 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_1 + thisTopic_Points_Stage_2 + thisTopic_Points_Stage_3)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4"></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_1 + thisTopic_Points_Stage_2 + thisTopic_Points_Stage_3 + thisTopic_Points_Stage_4)# pts</td>
			</tr>
		
		<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 1'>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="2" checked></td>
			<td style="padding-bottom:5px;">Stage 2 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_2)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="3"></td>
			<td style="padding-bottom:5px;">Stage 3 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_2 + thisTopic_Points_Stage_3)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4"></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_2 + thisTopic_Points_Stage_3 + thisTopic_Points_Stage_4)# pts</td>
			</tr>
		
		<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 2'>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="3" checked></td>
			<td style="padding-bottom:5px;">Stage 3 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_3)# pts</td>
			</tr>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4"></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_3 + thisTopic_Points_Stage_4)# pts</td>
			</tr>
		
		<cfelseif TRIM(IdeaStuff.SugStage) CONTAINS 'Stage 3'>
			
			<tr>
			<td style="padding-bottom:5px;"><input type="radio" name="moveStage" value="4" checked></td>
			<td style="padding-bottom:5px;">Stage 4 &nbsp; - &nbsp; #INT(thisTopic_Points_Stage_4)# pts</td>
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
	<td width="110">Bonus Points</td>
	<td style="padding-left:5px;"><input type="text" class="whitefield" name="Reward" style="width:100px;" value="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Comments</td>
	<td style="padding-left:5px;"><textarea class="whitefield" name="comments" style="width:300px;height:80px;">#TRIM(IdeaStuff.comments)#</textarea></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Email Subject</td>
	<td style="padding-left:5px;"><input type="text" class="whitefield" name="EmailSubject" style="width:300px;" value="#TRIM(NewAlertSubject)#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td width="110" valign="top">Email Message</td>
	<td style="padding-left:5px;"><textarea class="whitefield" name="EmailMessage" style="width:300px;height:120px;">#TRIM(NewAlertDetails)#</textarea></td>
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