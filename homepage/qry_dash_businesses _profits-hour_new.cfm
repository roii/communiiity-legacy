<cfquery name="Allbizideas" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT * 
FROM bizidea 
RIGHT JOIN bizidea_Type 
ON bizidea.biz_ideatypeID=bizidea_Type.bizideatypeID 
WHERE show = 1 
</cfquery>

<cfset topprofitbiz = QueryNew("biz_idea,avg_hr")>

<cfloop query="Allbizideas">

<cfquery name="bizideabizloop" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT business.bizid
FROM bizkidslink, business
WHERE bizkidslink.bizid=business.Bizid
AND business.bizideaID=#bizideaID#
</cfquery>

	<cfset total_income = 0>
	<cfset total_expense = 0>
	
	<cfset TotalProfit = 0>
	<cfset TotalMins = 0>
	<cfset HourRate = 0>
	
<cfloop query="bizideabizloop">
	<cfquery name="AllTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
	SELECT * 
	FROM bizTransaction 
	WHERE bizTransaction.bizkidslinkid=#bizideabizloop.bizid#
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
	</cfif>
	
	<cfscript>
	newRow = QueryAddRow(topprofitbiz);
	QuerySetCell(topprofitbiz, "biz_idea", "#TRIM(biz_idea)#");
	QuerySetCell(topprofitbiz, "avg_hr","#HourRate#" );
	</cfscript>
</cfloop>	

<cfquery dbtype="query" name="topprofitbiz" maxrows="3" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT * FROM topprofitbiz ORDER BY avg_hr desc
</cfquery>
