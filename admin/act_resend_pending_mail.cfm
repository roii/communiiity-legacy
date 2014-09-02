
<cfif form.fromemail NEQ "">
 <cfset fromemail = form.fromemail>
<cfelse>
 <cfset fromemail = session.User_Email>
</cfif>	

<cfif form.Filter IS 'ALL'>

<!--- RETRIEVE ALL PENDING MEMBERS WITH EMAIL ADDRESSES --->
	
<cfquery name="All_Members_Pending" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ContactType, ContactStatus, FirstName, LastName, EmailAddress
FROM Contacts
WHERE ContactStatus <> 'Deleted' and ContactStatus  = 'Pending' and EmailAddress <> '' 
ORDER BY ContactType, LastName, FirstName
</cfquery>

<cfmail server="#application.emailserver#" query="All_Members_Pending" to="#TRIM(EmailAddress)#" from="#fromemail#" subject="#form.MessageSubject#" type="HTML">
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
	<td width="300" valign="top" bgcolor="white"><a href="http://www.mykidsbiz.com"><img src="#request.imageroot#/logo.gif" border="0" alt="MyKidzBiz.com"></a></td>
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
		<td class="normal">

Hi #FirstName#<BR><BR>

#form.Message#<br><br>


<hr width="100%" size="1" color="e2e2e2">

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

<!-- <!--- UPDATE CONTACT LIST, CHANGING THE CONTACTSTATUS TO ACTIVE, THIS IS EMAILS THAT ARE PENDING--->
	<cfquery name="UpdateContactStatusToActive," datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactStatus = 'Active'
	WHERE contactID = #All_Members_Pending.contactID#
	</cfquery> -->
	
</cfmail>

<cfelseif form.Filter IS 'kids'>

<cfquery name="All_Kids_Pending" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName, EmailAddress
FROM Contacts
WHERE ContactType='kid' AND ContactStatus = 'pending'
ORDER BY LastName, FirstName
</cfquery>


<cfmail server="#application.emailserver#" query="All_Kids_Pending" to="#TRIM(EmailAddress)#" from="#fromemail#" subject="#form.MessageSubject#" type="HTML">
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
	<td width="300" valign="top" bgcolor="white"><a href="http://www.mykidsbiz.com"><img src="#request.imageroot#/logo.gif" border="0" alt="MyKidzBiz.com"></a></td>
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
		<td class="normal">

Hi #FirstName#<BR><BR>

#form.Message#<br><br>


<hr width="100%" size="1" color="e2e2e2">

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

<!-- <!--- UPDATE CONTACT LIST, CHANGING THE CONTACTSTATUS TO ACTIVE, THIS IS EMAILS THAT ARE PENDING--->
	<cfquery name="UpdateContactStatusToActive," datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactStatus = 'Active'
	WHERE contactID = #All_kids_Pending.contactID#
	</cfquery>
	 -->
</cfmail>

<cfelseif form.Filter IS 'shooper'>

<cfquery name="All_Shoppers_Pending" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName, EmailAddress
FROM Contacts
WHERE ContactType='shooper' AND ContactStatus = 'pending'
ORDER BY LastName, FirstName
</cfquery>

<cfmail server="#application.emailserver#" query="All_Shoppers_Pending" to="#TRIM(EmailAddress)#" from="#fromemail#" subject="#form.MessageSubject#" type="HTML">
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
	<td width="300" valign="top" bgcolor="white"><a href="http://www.mykidsbiz.com"><img src="#request.imageroot#/logo.gif" border="0" alt="MyKidzBiz.com"></a></td>
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
		<td class="normal">

Hi #FirstName#<BR><BR>

#form.Message#<br><br>


<hr width="100%" size="1" color="e2e2e2">

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

<!-- <!--- UPDATE CONTACT LIST, CHANGING THE CONTACTSTATUS TO ACTIVE, THIS IS EMAILS THAT ARE PENDING--->
	<cfquery name="UpdateContactStatusToActive," datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactStatus = 'Active'
	WHERE contactID = #All_Shoppers_Pending.contactID#
	</cfquery> -->
	
</cfmail>

<cfelse>

<cfif IsDefined("form.member")>



	<!--- RETRIEVE ALL SELECTED MEMBERS WITH EMAIL ADDRESSES --->
	<cfloop index="ListItem" list="#form.Member#">

		<cfquery name="IndMember" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Contacts
		WHERE ContactID=#ListItem# and ContactStatus  = 'Pending' and EmailAddress <> ''
		</cfquery>	
	
	
<cfmail server="#application.emailserver#" query="IndMember" to="#EmailAddress#" from="#fromemail#" subject="#form.MessageSubject#" type="HTML">
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
	<td width="300" valign="top" bgcolor="white"><a href="http://www.mykidsbiz.com"><img src="#request.imageroot#/logo.gif" border="0" alt="MyKidzBiz.com"></a></td>
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
		<td class="normal">

#form.Message#<br><br>

<hr width="100%" size="1" color="e2e2e2">

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

<!-- <!--- UPDATE CONTACT LIST, CHANGING THE CONTACTSTATUS TO ACTIVE, THIS IS EMAILS THAT ARE PENDING--->
	<cfquery name="UpdateContactStatusToActive," datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactStatus = 'Active'
	WHERE contactID = #IndMember.contactID#
	</cfquery> -->

</cfmail>
	

</cfloop>

</cfif>

</cfif>



<SCRIPT>
alert("The pending email has been processed.");
self.location="javascript:window.close();";
</SCRIPT>


