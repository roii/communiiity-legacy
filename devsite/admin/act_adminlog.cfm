<cfif IsDefined("session.AdministratorID")>

<!--- SET NEW LOGID --->
<cfquery name="NextID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
SELECT LogID
FROM AdminLog
ORDER BY LogID DESC
</cfquery>

<cfif #TRIM(NextID.LogID)# NEQ ''>
<cfset nextid = (#NextID.LogID# + 1)>
<cfelse>
<cfset nextid = 1>
</cfif>

<cfquery name="AdminLogDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO AdminLog(LogID,LogDate,Administrator,Details)
VALUES(#nextid#, #localDateTime#, #session.AdministratorID#, '#logdetails#')
</cfquery>


</cfif>