<cfquery name="topmostprofituser" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
    SELECT top 3 contacts.firstname, contacts.lastname,
	sum(income1_amount+income2_amount+income3_amount+income4_amount+income5_amount) as totalprofit
	FROM biztransaction bt,bizkidslink bz, contacts
	WHERE contacts.contactid = bz.kidsid 
	and bt.bizkidslinkid = bz.bizkidslinkid and clientid <> 0 and hours > 0
	group by contacts.firstname, contacts.lastname
	order by totalprofit desc
</cfquery>
