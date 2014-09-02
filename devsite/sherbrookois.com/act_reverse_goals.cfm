<cfloop list="17885, 18328, 18329, 18331, 18332, 18359, 18363, 18369, 18370, 18372, 18375, 18410, 18567, 18568, 18570, 18623, 18630, 18631, 18648, 18649, 18659, 18661, 18675, 18724, 18731, 18790, 18791, 18801, 18916, 18933, 18937, 19597, 19635, 19636, 19637, 19638, 19694, 19800, 19801, 19809, 20387, 20479, 20594, 20924, 21087, 21322, 21329, 21370, 21376, 21419, 21473, 21572, 21789, 22528, 23219, 23249, 23254" index="member" delimiters=",">

<cfquery name="qry_all_relatedID" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Related_Identifier
FROM contact_transactions
WHERE ContactID=#member#
AND Related_Description LIKE '%UpdateGoal%'
GROUP BY Related_Identifier
ORDER BY Related_Identifier
</cfquery>

<cfoutput query="qry_all_relatedID">#qry_all_relatedID.Related_Identifier#, </cfoutput>

</cfloop>