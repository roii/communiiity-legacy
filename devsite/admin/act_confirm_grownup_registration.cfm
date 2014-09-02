<cfquery name="CheckContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FirstName, LastName, EmailAddress, LoginName, Password
FROM Contacts
WHERE EmailAddress='#TRIM(emailaddress)#'
AND ContactID=#contactID#
</cfquery>


<cfif #CheckContact.RecordCount# GT 0>


<cfquery name="UpdateRecord" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET EmailConfirmed=1,
ContactStatus='Active'
WHERE ContactID=#ContactID#
</cfquery>
	
	
<cfmail server="#application.emailserver#" to="#TRIM(CheckContact.EmailAddress)#" from="info@mykidsbiz.com" subject="Your Registration has been verified!" type="HTML">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>MyKidsBiz.com</title>

<style>

.introduction
{
   FONT-SIZE: 12px;
   COLOR: Black;
   FONT-FAMILY: Arial, Verdana, Tahoma, Trebuchet MS;
   FONT-DECORATION: NONE;
LINE-HEIGHT: 170%;
}


.normal
{
   FONT-SIZE: 11px;
   COLOR: Black;
   FONT-FAMILY: Arial, Verdana, Tahoma, Trebuchet MS;
   FONT-DECORATION: NONE;
LINE-HEIGHT: 150%;
}

</style>


</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0">


<tr>
<td width="100%" valign="top">


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td>

	<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
	
	<tr>
	<td width="300" valign="top" bgcolor="white"><a href="http://www.mykidsbiz.com"><img src="#request.imageroot#/logo.gif" width="300" height="67" border="0" alt="MyKidzBiz.com"></a></td>
	</tr>
	
	</table>
	
</td>
</tr>

</table>

</td>
<!--- BLACK STRIP --->
</tr>



<tr>
<td width="100%" valign="top">

<table width="100%" border="0" cellspacing="0" cellpadding="0" valign="top">
	
<tr>
<td>


	<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
	<td class="normal"><br>

		
		<table width="100%" cellpaddinig="10" border="0">
	
		<tr>
		<td width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1"  border="0"></td>
		<td class="normal"><span style="font-size:12px;"><strong>Hi #CheckContact.firstname#! Your registration with MyKidsBiz.com has been verified!</strong></span><br><br>
		Use the following log-in details to access your account and start shopping!.<br><br>
	
		<hr width="100%" size="1" color="e2e2e2">
		
		<table width="200" border="0">
		
		<tr>
		<td class="normal" style="color:444444; font-size:10px;">Login Name:</td>
		<td style="color:444444; font-size:10px;"><strong>#TRIM(CheckContact.LoginName)#</strong></td>
		</tr>
		
		<tr>
		<td class="normal" style="color:444444; font-size:10px;">Password:</td>
		<td style="color:444444; font-size:10px;"><strong>#TRIM(CheckContact.Password)#</strong></td>
		</tr>
		
		</table>
		
		<hr width="100%" size="1" color="e2e2e2"><br>
		 We recomend that you change your password regularly and never share it with anyone.<br><br><br>

		<span style="font-size:12px;"><strong>Thanks!<br>
		The Team @ MyKidsBiz</strong></span>
		
		</td>
		</tr>
		
		</table>
		
	
	</td>
	</tr>
	
	</table>
		
	
</td>
</tr>
	
</table>


</td>
</tr>

</table>

</body>
</html>	
</cfmail>

	
<cflocation url="#request.webroot#/index.cfm?fuseaction=grownups&fusesubaction=registration_thanks&contactID=#ContactID#">

<cfelse>

<cfoutput><script>
alert("We're sorry but your details do not match any of the current registrations in our system. Please register again.");
self.location="#request.webroot#/index.cfm";
</script></cfoutput>

</cfif>