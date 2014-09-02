<cfquery name="AddToTrace" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO ContactTrace(ContactID, TraceDate, TraceIP)
VALUES(#session.UserID#, #CreateODBCDateTime(localdatetime)#, '#cgi.remote_host#')
</cfquery>