<cfparam name="attributes.bizideaid" default="0">

<cfquery name="Allbizideas" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM bizidea, bizidea_Type
WHERE bizidea.biz_ideatypeID=bizidea_Type.bizideatypeID
ORDER BY bizidea.show DESC, BizIdea.bizOrder
</cfquery>

<cfquery name="bizideaType" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM bizidea_Type order by biz_type
</cfquery>


<cfif attributes.bizideaid NEQ "0">
<cfquery name="Currentbizidea" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * FROM bizidea WHERE bizidea.bizideaID = #attributes.bizideaid#
</cfquery>
</cfif>