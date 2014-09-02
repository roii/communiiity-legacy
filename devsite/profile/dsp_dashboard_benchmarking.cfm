<cfoutput>

<!--- GOALS POSITION --->
<cfquery name="Benchmark_Goals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY goals DESC
</cfquery>

<cfset goal_rankings = valueList(Benchmark_Goals.ContactID)>
<cfset this_goal_ranking = ListFind(goal_rankings, session.UserID, ",")>
<cfset this_goal_percent = ((this_goal_ranking / Benchmark_Goals.recordcount) * 100)>


<!--- CONTACTS POSITION --->
<cfquery name="Benchmark_Contacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY contacts DESC
</cfquery>

<cfset contact_rankings = valueList(Benchmark_Contacts.ContactID)>
<cfset this_contact_ranking = ListFind(contact_rankings, session.UserID, ",")>
<cfset this_contact_percent = ((this_contact_ranking / Benchmark_Contacts.recordcount) * 100)>


<!--- PROFIT POSITION --->
<cfquery name="Benchmark_Profit" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY TotalProfits DESC
</cfquery>

<cfset profit_rankings = valueList(Benchmark_Profit.ContactID)>
<cfset this_profit_ranking = ListFind(profit_rankings, session.UserID, ",")>
<cfset this_profit_percent = ((this_profit_ranking / Benchmark_Profit.recordcount) * 100)>


<!--- PROFIT HR POSITION --->
<cfquery name="Benchmark_HrProfit" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY HrProfits DESC
</cfquery>

<cfset Hrprofit_rankings = valueList(Benchmark_HrProfit.ContactID)>
<cfset this_Hrprofit_ranking = ListFind(Hrprofit_rankings, session.UserID, ",")>
<cfset this_Hrprofit_percent = ((this_Hrprofit_ranking / Benchmark_HrProfit.recordcount) * 100)>


<!--- CASH POSITION --->
<cfquery name="Benchmark_Cash" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY CashEarned DESC
</cfquery>

<cfset Cash_rankings = valueList(Benchmark_Cash.ContactID)>
<cfset this_Cash_ranking = ListFind(Cash_rankings, session.UserID, ",")>
<cfset this_Cash_percent = ((this_Cash_ranking / Benchmark_Cash.recordcount) * 100)>


<!--- POINTS EARNED POSITION --->
<cfquery name="Benchmark_PointsEarned" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY PointsEarned DESC
</cfquery>

<cfset PointsEarned_rankings = valueList(Benchmark_PointsEarned.ContactID)>
<cfset this_PointsEarned_ranking = ListFind(PointsEarned_rankings, session.UserID, ",")>
<cfset this_PointsEarned_percent = ((this_PointsEarned_ranking / Benchmark_PointsEarned.recordcount) * 100)>


<!--- POINTS SAVED POSITION --->
<cfquery name="Benchmark_PointsSaved" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY PointsEarned DESC
</cfquery>

<cfset PointsSaved_rankings = valueList(Benchmark_PointsSaved.ContactID)>
<cfset this_PointsSaved_ranking = ListFind(PointsSaved_rankings, session.UserID, ",")>
<cfset this_PointsSaved_percent = ((this_PointsSaved_ranking / Benchmark_PointsSaved.recordcount) * 100)>


<!--- IDEAS POSITION --->
<cfquery name="Benchmark_Ideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY IdeasSubmitted DESC
</cfquery>

<cfset Ideas_rankings = valueList(Benchmark_Ideas.ContactID)>
<cfset this_Ideas_ranking = ListFind(Ideas_rankings, session.UserID, ",")>
<cfset this_Ideas_percent = ((this_Ideas_ranking / Benchmark_Ideas.recordcount) * 100)>


<!--- PRIZES POSITION --->
<cfquery name="Benchmark_Prizes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM contacts_benchmarking
ORDER BY PrizeDrawEntries DESC
</cfquery>

<cfset Prizes_rankings = valueList(Benchmark_Prizes.ContactID)>
<cfset this_Prizes_ranking = ListFind(Prizes_rankings, session.UserID, ",")>
<cfset this_Prizes_percent = ((this_Prizes_ranking / Benchmark_Prizes.recordcount) * 100)>



<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Benchmarking - how am I doing compared to others?</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/Benchmarking_sml.jpg" alt="Benchmarking" border="0"></td>
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



	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Goal Setting:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_goal_percent)#%</strong></td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Size of Contacts Network:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_contact_percent)#%</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Business Profits:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_profit_percent)#%</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Avg Profit p/hr:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_Hrprofit_percent)#%</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Cash Earned:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_Cash_percent)#%</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Points Earned:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_PointsEarned_percent)#%</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Points Saved:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_PointsSaved_percent)#%</td>
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
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Ideas Submitted:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_Ideas_percent)#%</td>
	</tr><!--- 
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Feedback on my ideas:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145"></td>
	</tr> --->
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Prize draw entries:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" width="145">Ranked in the top &nbsp;&nbsp;&nbsp;<strong>#Ceiling(this_Prizes_percent)#%</td>
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