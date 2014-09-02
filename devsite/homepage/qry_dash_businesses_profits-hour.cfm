<cfquery name="topprofitbiz" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT top 3 bizidea.biz_idea,(biztransaction.income1_amount+biztransaction.income2_amount+biztransaction.income3_amount+biztransaction.income4_amount+biztransaction.income5_amount)/(biztransaction.hours/60) as avg_hr
FROM biztransaction, bizkidslink, Business, bizidea
WHERE biztransaction.bizkidslinkid = bizkidslink.bizkidslinkid 
AND biztransaction.clientid <> 0 
AND (biztransaction.hours/60) > 0
AND bizkidslink.bizid=Business.bizid
AND Business.bizideaID=bizidea.bizideaID
GROUP BY bizidea.biz_idea,(biztransaction.income1_amount+biztransaction.income2_amount+biztransaction.income3_amount+biztransaction.income4_amount+biztransaction.income5_amount)/(biztransaction.hours/60)
ORDER BY avg_hr desc
</cfquery>