<cfquery name="Allbizideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
select count(*) as total from business where bizstatus = 'active'
</cfquery>

<cfquery name="activeideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT count(*) as total FROM suggestion WHERE Archived=0
</cfquery>

<cfquery name="activegoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
  SELECT count(*) as total FROM Goals, GoalKidsLink WHERE Goals.goalID=GoalKidsLink.goalID AND GoalKidsLink.Archived=0
  AND Goals.defaultGoal=0
</cfquery>

<cfquery name="TotalKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT count(*) as total
FROM Contacts
WHERE Contacts.ContactTypeID IN (1,2)
</cfquery>

<cfquery name="totaltrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT sum(income1_amount+income2_amount+income3_amount+income4_amount+income5_amount) as total FROM bizTransaction
</cfquery>

<cfquery name="totalpoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT sum(Transaction_amount) as total
	FROM Contact_transactions, Contacts
	WHERE Contact_transactions.Transaction_Account = 'Points'
	AND Contact_transactions.ContactID=Contacts.ContactID
</cfquery>	

<cfquery name="totalprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT count(*)	as total FROM prize_pool WHERE status != 1 AND winner is null
</cfquery>

<cfquery name="AllSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT count(*) as total FROM Schools, Countries
WHERE Schools.CountryID=Countries.CountryID
AND Schools.SchoolStatus <> 'deleted'
</cfquery>

<cfquery name="AllSurveys" datasource="mykidsbiz" username="#request.username#" password="#request.password#">
SELECT count(*) as total FROM forms,surveycom where forms.comid = surveycom.surveycomID and online=1 and verified=1
</cfquery>
<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>ADMINISTRATION TOOLS</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td background="#request.imageroot#/sidebar_boxR_bg2.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	
	
	<table width="207" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_activities" style="color:black;">Manage Activity Rewards</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=administrators" style="color:black;">Manage Administrators</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_bizideas" style="color:black;">Manage Businesses</a> <b>(#Allbizideas.total#)</b></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_alerts" style="color:black;">Manage Email Alerts</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_sug" style="color:black;">Manage Ideas</a> <b>(#activeideas.total#)</b></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_SugCat" style="color:black;">Manage Idea Categories</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_stages" style="color:black;">Manage Idea Stages</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_goalcats" style="color:black;">Manage Goal</a> <b>(#activegoals.total#)</b></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_mylib" style="color:black;">Manage Library</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_members" style="color:black;">Manage Members</a> <b>(#TotalKids.total#)</b></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney" style="color:black;">Manage Money</a> <b>(#dollarformat(totaltrans.total)#)</b></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=kidsmoney" style="color:black;">Manage Points</a> <b>(#numberformat(totalpoints.total)#)</b></td>
	</tr>
		
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_prizes" style="color:black;">Manage Prizes</a> <b>(#totalprize.total#)</b></td>
	</tr>
		
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_projectgroups" style="color:black;">Manage Project Groups</a></td>
	</tr>	
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=manage_schools" style="color:black;">Manage Schools</a> <b>(#AllSchools.total#)</b></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=sections" style="color:black;">Manage Sections</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=subscriptions" style="color:black;">Manage Subscriptions</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;color:black;"><a href="#request.webroot#/surveyengine" style="color:black;">Manage Surveys</a> <b>(#AllSurveys.total#)</b></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=adminaudit" style="color:black;">Administration Audit</a></td>
	</tr>
	
	<tr>
	<td width="20" style="color:###AllSettings.BoxColour#;font-size:11px;" align="center"><strong>&raquo;</strong></td>
	<td width="187" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool" style="color:black;">Email Tool</a></td>
	</tr>
	
	</table><br>


</td>
</tr>

</table>


</cfoutput>