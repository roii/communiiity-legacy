<cfquery name="AddToTrace" datasource="#dsn#" username="mykidsbizcom" password="w29snfc66r">
INSERT INTO ContactTrace(ContactID, TraceDate, TraceIP)
VALUES(#session.UserID#, #CreateODBCDateTime(localdatetime)#, '#cgi.remote_host#')
</cfquery>