
<!---
<cfquery name="topprofituser" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
    SELECT top 5 contacts.firstname, contacts.lastname,
	(income1_amount+income2_amount+income3_amount+income4_amount+income5_amount)/(hours/60) as avg_hr
	FROM biztransaction bt,bizkidslink bz, contacts
	WHERE contacts.contactid = bz.kidsid 
	and bt.bizkidslinkid = bz.bizkidslinkid and clientid <> 0 and (hours/60) > 0
	group by contacts.firstname, contacts.lastname,(income1_amount+income2_amount+income3_amount+income4_amount+income5_amount)/(hours/60)
	order by avg_hr desc
</cfquery>
--->
<cfquery name="kidslist" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT kidsid,firstname,Screenname,contactid FROM Business, bizKidsLink, contacts WHERE Business.bizID=bizKidsLink.bizID 
AND Business.BizStatus LIKE 'Active' and contacts.contactid=kidsid
group by kidsid,firstname,Screenname,contactid
</cfquery>

<cfset topprofituser = QueryNew("firstname,Screenname,contactid,avg_hr")>

<cfloop query="kidslist">

<cfquery name="Currentbiz" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT bizkidslinkid FROM Business, bizKidsLink WHERE Business.bizID=bizKidsLink.bizID 
AND Business.BizStatus LIKE 'Active' 
and bizKidsLink.kidsid=#kidslist.kidsid# 
</cfquery>

<cfset total_income = 0>
<cfset total_expense = 0>
<cfset TotalProfit = 0>
<cfset TotalMins = 0>
<cfset HourRate = 0>



<cfloop query="Currentbiz">
	<cfquery name="AllTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
	SELECT * FROM bizTransaction WHERE bizkidslinkid=#Currentbiz.bizkidslinkid#
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
	
	<cfset TotalProfit = total_income-total_expense>
	<cfset TotalMins = TotalMins + AllTransaction.hours>
	<cfset HourRate = AllTransaction.hourRate>
	
	</cfloop>
	
</cfloop>

<cfif TotalMins GT 0>
	<cfset TotalMins = TotalMins/60>
</cfif>

<cfif HourRate EQ 0 and TotalMins GT 0 and TotalProfit GT 0>
	<cfset HourRate = TotalProfit/TotalMins>
<cfelse>
	<cfset HourRate = 0>
</cfif>

	<cfscript>
	newRow = QueryAddRow(topprofituser);
	QuerySetCell(topprofituser, "firstname", "#TRIM(kidslist.firstname)#");
	QuerySetCell(topprofituser, "Screenname", "#TRIM(kidslist.Screenname)#");
	QuerySetCell(topprofituser, "contactid", "#TRIM(kidslist.contactid)#");
	QuerySetCell(topprofituser, "avg_hr","#HourRate#" );
	</cfscript>
</cfloop>	

<cfquery dbtype="query" name="topprofituser" maxrows="3" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
select * from topprofituser order by avg_hr desc
</cfquery>
<!---

<cfoutput>
<cfloop query="topprofituser">
#firstname# #lastname# #avg_hr#<br>
</cfloop>
</cfoutput>--->