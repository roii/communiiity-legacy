<!---
This is what starts the ball rolling to get authorization from LinkedIn
--->
<cfinclude template="LinkedIn.cfc">
<cfset linkedincfc = CreateObject("component", "LinkedIn").init() />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Untitled Document</title>
</head>

<cfset linkedincfc.getRequestToken() />

<body>

</body>
</html>