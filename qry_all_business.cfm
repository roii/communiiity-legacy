<cfquery name="AllBiz" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT bizkidslinkid
FROM bizkidslink
ORDER BY bizkidslinkid
</cfquery>


<cfloop query="AllBiz">
<cfset this_bizkidslinkid = AllBiz.bizkidslinkid>

<cfquery name="AllTransactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT transactionID
FROM bizTransaction 
WHERE bizkidslinkid=#this_bizkidslinkid#
</cfquery>

<cfif AllTransactions.RecordCount>
<cfelse>

    <cfquery name="DeleteBiz" datasource="#dsn#" username="#request.username#" password="#request.password#">
    DELETE
    FROM bizkidslink
    WHERE bizkidslinkid=#this_bizkidslinkid#
    </cfquery>

</cfif>

</cfloop>