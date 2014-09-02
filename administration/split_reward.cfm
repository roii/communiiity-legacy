<cfquery name="qry_rewards" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM prize_pool 
WHERE reward=1
AND deleted=0
</cfquery>


<cfloop query="qry_rewards">


<cfif qry_rewards.prizedraw EQ 1>


<cfquery name="AddReward" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO Prize_pool (Name, 
Description, 
Country, 
pointsvalue, 
PrizeDraw, 
Reward, 
DisplayOrder, 
quantity,
image)

VALUES('#TRIM(qry_rewards.Name)#', 
'#TRIM(qry_rewards.description)#', 
'#INT(qry_rewards.country)#', 
#qry_rewards.pointsvalue#,
0, 
1,
#qry_rewards.DisplayOrder#,
1,
'#qry_rewards.image#'
)
</cfquery>



<cfquery name="updatePrize" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Prize_pool
SET Reward=0
WHERE PrizePoolID=#qry_rewards.PrizePoolID#
</cfquery>

</cfif>



</cfloop>