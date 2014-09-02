<cfoutput>

<cfquery name="qry_category_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM SugCategory
WHERE CategoryID=#TopicID#
</cfquery>
	
<cfquery name="qry_stage_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM idea_topic_settings
WHERE TopicID=#TopicID#
</cfquery>


<script language="JavaScript">
<!--
function confirmCatDelete(aURL) {
    if(confirm('Are you sure you want to delete this Category?')) {
      location.href = aURL;
    }
  }
//-->
</script>
<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)# - Idea Topic Details</title>
<cfinclude template="../templates/styles.cfm">
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">



<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Idea Topic Details</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top" style="padding-left:10px;padding-right:10px;">
<br>


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="50"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="1" border="0"></td>
	<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
	<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
	<td width="100"><img src="#request.imageroot#/transparent_spc.gif" width="100" height="1" border="0"></td>
	<td width="70"><img src="#request.imageroot#/transparent_spc.gif" width="70" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7"><strong>#TRIM(qry_category_details.Name)#</strong><br>
	#TRIM(qry_category_details.Description)#</td>
	</tr>
	
	<tr>
	<td colspan="7" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="cccccc"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>	
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;"><b>Order</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Active</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Add Idea</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Sponsor</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Pts Allocated</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>Pts Remaining</b></td>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" align="center"><b>End Date</b></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="cccccc"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
	</tr>
	
	<cfset this_categoryID = categoryID>
		
	<cfquery name="AllCat_ActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID
	FROM Suggestion
	WHERE CategoryID=#this_categoryID#
	AND Authorise LIKE '%Yes%'
	GROUP BY SugID
	</cfquery>
	
	<cfquery name="AllCat_InActiveIdeas" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT SugID
	FROM Suggestion
	WHERE CategoryID=#this_categoryID#
	AND Authorise LIKE '%No%'
	AND Archived = 0
	GROUP BY SugID
	</cfquery>
	
	
	<cfquery name="SponsorStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisation_Name, LogoFile
	FROM Organisations
	WHERE OrganisationID=#qry_category_details.SponsorID#
	</cfquery>
	
	
	<cfif AllCat_ActiveIdeas.RecordCount>
		<cfset ThisCatideas = valueList(AllCat_ActiveIdeas.SugID)>
	<cfelse>
		<cfset ThisCatideas = "0">		
	</cfif>
	
	<cfif AllCat_InActiveIdeas.RecordCount>
		<cfset ThisCatideas = ListAppend(ThisCatideas, valueList(AllCat_InActiveIdeas.SugID), ",")>
	</cfif>	
	
	<cfquery name="AllPointsEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Count(Transaction_Amount) AS TotalPointsEarned
	FROM contact_transactions
	WHERE (Related_Description LIKE '%AddIdea%'
	OR Related_Description LIKE '%Vote%'
	OR Related_Description LIKE '%VoteComments%'
	OR Related_Description LIKE '%IdeaStage1%'
	OR Related_Description LIKE '%IdeaStage2%'
	OR Related_Description LIKE '%IdeaStage3%'
	OR Related_Description LIKE '%IdeaStage4%'
	OR Related_Description LIKE '%IdeaStage5%')
	AND Related_Identifier IN (#ThisCatideas#)
	AND Transaction_Type LIKE '%Credit%'
	AND Transaction_Account LIKE '%Points%'
	</cfquery>
	
	<cfset this_pointsremaining = INT(qry_category_details.PointsAllocated - AllPointsEarned.TotalPointsEarned)>
	
	<tr>
	<td style="font-size:11px;" valign="top">#DecimalFormat(qry_category_details.DisplayOrder)#</td>
	<td style="font-size:11px;" valign="top" align="center">#YesNoFormat(qry_category_details.Active)#</td>
	<td style="font-size:11px;" valign="top" align="center">#YesNoFormat(qry_category_details.ShowAdd)#</td>
	<td style="font-size:11px;" valign="top" align="center">#TRIM(SponsorStuff.Organisation_Name)#</td>
	<td style="font-size:11px;" valign="top" align="center">#qry_category_details.PointsAllocated#</td>
	<td style="font-size:11px;" valign="top" align="center">#this_pointsremaining#</td>
	<td style="font-size:11px;" valign="top" align="center">#dateFormat(qry_category_details.WhenCategoryEnded)#</td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="cccccc"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;border-top:solid 1px ##e2e2e2;"><strong>Moderators:</strong> <cfloop list="#qry_category_details.Moderators#" delimiters="," index="loopitem"><cfquery name="qry_contact_details" datasource="#dsn#" username="#request.username#" password="#request.password#">SELECT FirstName, LastName FROM Contacts
WHERE ContactID=#loopitem#</cfquery>#qry_contact_details.FirstName# #qry_contact_details.Lastname#,&nbsp;</cfloop></td>
	</tr>
	
	<tr>
	<td colspan="7" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="cccccc"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>