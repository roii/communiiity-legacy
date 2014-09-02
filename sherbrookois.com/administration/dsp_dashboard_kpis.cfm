<cfoutput>


<!--- GET ALL INDIVIDUAL MEMBERS WHO HAVE LOGGED IN --->
<cfquery name="AllMemberLogins" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Count(ContactID) AS TotalMembersLoggedIn
FROM Contacts
WHERE LastLogin BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>


<!--- GET ALL LOGINS
<cfquery name="AllLogins" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Count(AccessID) AS TotalLogins
FROM AccessLog
WHERE AccessDate BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>
 --->
 

<!--- GET ALL ACTIVE MEMBERS - EARNED MORE THAN 10 POINTS DURING PERIOD --->
<cfquery name="AllActive" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SUM(Transaction_Amount) AS TotalEarned, ContactID
FROM contact_transactions
WHERE Transaction_Account LIKE '%Points%'
AND Transaction_Type LIKE '%Credit%'
AND Transaction_Date BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
GROUP BY ContactID
</cfquery>

<cfquery name="TotalActiveMembers" dbtype="query">
SELECT Count(ContactID) AS TotalActive
FROM AllActive
WHERE TotalEarned >= 10
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>K.P.I.'s</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/kpi.jpg" alt="KPI's" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Total number of members who logged-in:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllMemberLogins.TotalMembersLoggedIn#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<!--- <tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Total number of log-ins:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllLogins.TotalLogins#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr> --->
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Active Members (earned more than 10pts):</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#TotalActiveMembers.TotalActive#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>