<cfquery name="newjoined" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(contactid) as newjoined from Contacts where datediff(day,datejoined,getdate()) <= 30
</cfquery>

<cfquery name="totaljoined" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(contactid) as total from Contacts
</cfquery>
<cfset joinedpc = newjoined.newjoined/totaljoined.total*100>

<cfquery name="newbiz" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(bizid) as newbiz from bizkidsLink where datediff(day,datecreated,getdate()) <= 30
</cfquery>
<cfquery name="totalbiz" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(bizid) as total from bizkidsLink 
</cfquery>
<cfset newbizpc = newbiz.newbiz/totalbiz.total*100>

<cfquery name="newideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(sugid) as newideas from Suggestion where datediff(day,whensugmade,getdate()) <= 30
</cfquery>
<cfquery name="totalideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(sugid) as total from Suggestion
</cfquery>

<cftry>
	<cfset newideapc = newideas.newideas/totalideas.total*100>
<cfcatch>
	<cfset newideapc = 0>
</cfcatch>
</cftry>
<cfquery name="newgoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(goalid) as total from goals where datediff(day,addeddate,getdate()) <= 30
</cfquery>
<cfquery name="totalgoals" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select count(goalid) as total from goals
</cfquery>

<cftry>
	<cfset newgoalpc = newgoals.total/totalgoals.total*100>
<cfcatch>
	<cfset newgoalpc = 0>
</cfcatch>
</cftry>
<cfquery name="newtrans" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select sum(income1_amount) as total from biztransaction where datediff(day,tranDate,getdate()) <= 30
</cfquery>
<cfquery name="newprize" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select sum(pointsvalue) as total from prize_pool where datediff(day,start_date,getdate()) <= 30
</cfquery>
<cfquery name="newpoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT sum(Transaction_amount) as total	FROM Contact_transactions WHERE Contact_transactions.Transaction_Account = 'Points'
	and datediff(day,transaction_date,getdate()) <= 30
</cfquery>
<cfquery name="newentry" datasource="#dsn#" username="#request.username#" password="#request.password#">
	  select prize_entryid from prize_entry where datediff(day,entrydate,getdate()) <= 30
</cfquery>
<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">

<tr>
<td width="33%" bgcolor="###AllSettings.BoxColour#" align="center" style="border-right:solid 1px white;font-size:11px;"><a href="##quickstats" onClick="javascript: SwapView('24', 0);" style="color:black;text-decoration:none;">24hrs</a></td>
<td width="33%" bgcolor="###AllSettings.BoxColour#" align="center" style="border-right:solid 1px white;"><a href="##quickstats" onClick="javascript: SwapView('7', 0);" style="color:black;text-decoration:none;font-size:11px;">7 days</td>
<td width="33%" align="center" style="font-size:11px;color:black;"><strong>30 days</strong></td>
</tr>

</table><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"><br>


<table width="150" cellpadding="0" cellspacing="0" border="0" align="center">
<tr>
<td align="center" colspan="2" style="font-size:11px;color:black;"><strong>GROWTH</strong></td>
</tr>

<tr>
<td colspan="2"><hr wdith="100%" size="1" noshade color="ffffff"></td>
</tr>
<tr>
<td align="right" style="padding-right:5px;font-size:11px;color:black;" width="75">Members:</td>
<td width="75" style="font-size:11px;color:black;"><strong>#decimalformat(joinedpc)#%</strong></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td align="right" style="padding-right:5px;font-size:11px;color:black;" width="75">Businesses:</td>
<td width="75" style="font-size:11px;color:black;"><strong>#decimalformat(newbizpc)#%</strong></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td align="right" style="padding-right:5px;font-size:11px;color:black;" width="75">Ideas:</td>
<td width="75" style="font-size:11px;color:black;"><strong>#decimalformat(newideapc)#%</strong></td>
</tr>
<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td align="right" style="padding-right:5px;font-size:11px;color:black;" width="75">Goals:</td>
<td width="75" style="font-size:11px;color:black;"><strong>#decimalformat(newgoalpc)#%</strong></td>
</tr>
<tr>
<td colspan="2"><hr wdith="100%" size="1" noshade color="ffffff"></td>
</tr>
<tr>
<td colspan="2" align="center" style="font-size:11px;color:black;">Money Earned<br>
<strong>#dollarformat(val(newtrans.total))#</strong></td>
</tr>
<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>
<td colspan="2" align="center" style="font-size:11px;color:black;">Points Earned<br>
<strong>#val(newpoints.total)#</strong></td>
</tr>
<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td colspan="2" align="center" style="font-size:11px;color:black;">Prize Value (NZD)<br>
<strong>#dollarformat(val(newprize.total)/100)#</strong></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td colspan="2" align="center" style="font-size:11px;color:black;">Prize Draw Entries<br>
<strong>#newentry.recordcount#</strong></td>
</tr>


</table>

</cfoutput>