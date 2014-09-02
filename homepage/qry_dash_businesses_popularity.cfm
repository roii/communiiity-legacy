<cfquery name="toppopularbiz" datasource="#dsn#" username="#request.username#" password="#request.password#" cachedWithin="#CreateTimeSpan(0,0,15,0)#">
SELECT top 3 bizidea.biz_idea, count(biztransaction.bizkidslinkid) AS Total
FROM biztransaction, bizkidslink, Business, bizidea
WHERE biztransaction.bizkidslinkid = bizkidslink.bizkidslinkid 
AND bizkidslink.bizid=Business.bizid
AND Business.bizideaID=bizidea.bizideaID
GROUP BY bizidea.biz_idea
ORDER BY Total DESC
</cfquery>