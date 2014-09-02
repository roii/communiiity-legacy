<cfquery name="AllBiz" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT bizkidslinkid
FROM bizkidslink
ORDER BY bizkidslinkid
</cfquery>


<cfloop query="AllBiz">
<cfset this_bizkidslinkid = AllBiz.bizkidslinkid>

<cfquery name="AllTransactions" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
SELECT transactionID
FROM bizTransaction 
WHERE bizkidslinkid=#this_bizkidslinkid#
</cfquery>

<cfif AllTransactions.RecordCount>
<cfelse>

    <cfquery name="DeleteBiz" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
    DELETE
    FROM bizkidslink
    WHERE bizkidslinkid=#this_bizkidslinkid#
    </cfquery>

</cfif>

</cfloop>