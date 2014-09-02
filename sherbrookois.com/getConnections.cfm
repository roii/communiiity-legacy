<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<body>
<!---
update with your data
you can only run this once u have the persons token and secret.
<cfquery name="x" datasource="#application.settings.dsn#">
select [linkedInToken], [linkedInTokenSecret] from tbl_user where id = 5
</cfquery>--->

<cfinvoke component="LinkedIn" method="getConnections" authToken="#x.linkedInToken#" authTokenSecret="#x.linkedInTokenSecret#" returnvariable="c" />
<cfdump var="#c#">
</body>
</html>