
<cfquery name="BizStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea 
WHERE bizidea.bizideaID = #BizIdeaID#
</cfquery>

<cfquery name="activekids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT bizkidslink.bizkidslinkid, Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress
FROM Business, bizKidsLink, Contacts
WHERE Business.BizIdeaID=#BizIdeaID#
AND Business.bizID=bizKidsLink.bizID 
AND bizKidsLink.KidsID=Contacts.ContactID
GROUP BY bizkidslink.bizkidslinkid, Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.EmailAddress
ORDER BY FirstName
</cfquery>  
	

<cfoutput>


<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - Business Idea - Active Members</title>
<cfinclude template="../templates/styles.cfm">

	
</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">





<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Business Idea - Active Members</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td style="font-size:12px;"><strong>#TRIM(BizStuff.biz_idea)#</strong></td>
	<td style="font-size:12px;" align="center"><strong>Profit</strong></td>
	<td style="font-size:12px;" align="center"><strong>Time</strong></td>
	<td style="font-size:12px;" align="center"><strong>Avg</strong></td>
	<td align="right"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool&ExportList=#ValueList(activekids.contactID)#" target="mymainwindow">Email All Members</a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	
	
	<cfloop query="activekids">
	
	<cfset total_income = 0>
	<cfset total_expense = 0>
	
	<cfset TotalProfit = 0>
	<cfset TotalMins = 0>
	
	
	<cfquery name="AllTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT * 
	FROM bizTransaction 
	WHERE bizTransaction.bizkidslinkid=#activekids.bizkidslinkid#
	</cfquery>
	
	<cfloop query="AllTransaction">
	
	<cfif IsNumeric("#AllTransaction.Income1_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income1_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income2_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income2_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income3_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income3_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income4_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income4_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.Income5_amount#")>
		<cfset total_income=(total_income+AllTransaction.Income5_amount)>
	</cfif>
	
	
	<cfif IsNumeric("#AllTransaction.expense1_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense1_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense2_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense2_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense3_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense3_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense4_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense4_amount)>
	</cfif>
	
	<cfif IsNumeric("#AllTransaction.expense5_amount#")>
		<cfset total_expense=(total_expense+AllTransaction.expense5_amount)>
	</cfif>
	
	
	<cfset TotalProfit = (total_income - total_expense)>	
	<cfset TotalMins = (TotalMins + AllTransaction.hours)>
	
	</cfloop>
	
	<cfif TotalMins GT 0>
		<cfset display_hour = INT(TotalMins/60)>
		<cfset display_minutes = TotalMins MOD 60>
		<cfset TotalMins = (TotalMins / 60)>
	<cfelse>
		<cfset display_hour = 0>
		<cfset display_minutes = 0>
		<cfset TotalMins = 0>	
	</cfif>
	
	<cfif TotalMins GT 0 and TotalProfit GT 0>
		<cfset HourRate = (TotalProfit / TotalMins)>
	<cfelse>
		<cfset HourRate = 0>	
	</cfif>
	
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td>#TRIM(activekids.FirstName)# #TRIM(activekids.LastName)#<br>
	<a href="mailto:#TRIM(activekids.emailaddress)#">#TRIM(activekids.emailaddress)#</a></td>
	<td align="center"><a href="#request.webroot#/administration/dsp_biz_kids_transactions.cfm?bizkidslinkid=#activekids.bizkidslinkid#">#DollarFormat(TotalProfit)#</a></td>
	<td align="center">#display_hour#:#numberFormat(display_minutes, "00")#</td>
	<td align="center">Avg. #DollarFormat(HourRate)# p/hr</td>
	<td></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="5"><hr width="100%" size="1" color="silver"></td>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>