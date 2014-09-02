<!--- There are duplicate names in the query with different hour rates, so it's better to be filtered in programming ----->

<cfquery name="topprofituser" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
    SELECT top 3 contacts.contactid, contacts.firstname, contacts.lastname, (income1_amount+income2_amount+income3_amount+income4_amount+income5_amount)/(hours/60) as avg_hr
	FROM biztransaction bt,bizkidslink bz, contacts
	WHERE contacts.contactid = bz.kidsid 
	and bt.bizkidslinkid = bz.bizkidslinkid and clientid <> 0 and (hours/60) > 0
	group by contacts.contactid, contacts.firstname, contacts.lastname, (income1_amount+income2_amount+income3_amount+income4_amount+income5_amount)/(hours/60)
	order by avg_hr desc
</cfquery>
