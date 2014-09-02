<cfoutput>


<cfparam name="AttachmentMode" default="No">

<!--- CHECK IF ATTACHMENT INCLUDED --->
<cfif #TRIM(form.Attachment)# NEQ ''>

	
<cftry>
	
	<cffile action="UPLOAD" filefield="form.attachment" destination="#request.fileroot#/mail_attachments" nameconflict="MAKEUNIQUE">
	<cfset AttachmentFileName = #file.serverfile#>
	<cfset AttachmentMode="Yes">

<cfcatch></cfcatch>
</cftry>

</cfif>




</cfoutput>

<cfif form.fromemail NEQ "">
 <cfset fromemail = form.fromemail>
<cfelse>
 <cfset fromemail = session.User_Email>
</cfif>	

<!-----------------------if sending test email----------------------------------------------------------->

<cfif IsDefined("form.sendtest")>


<cfmail server="smtp.gmail.com" username="my3p123@gmail.com" password="password123" port="465" useSSL="true" to="#session.User_Email#" from="#fromemail#" bcc="#form.bcc#" subject="#form.MessageSubject#" type="HTML">
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
<cfif #form.Personalise# EQ "0,1">
Dear Kid<BR><BR>
</cfif>

#form.Message#<br><br>


<cfif #form.LoginDetails# EQ "0,1">
<hr width="100%" size="1" color="e2e2e2">
<strong>YOUR MEMBERSHIP LOGIN DETAILS:</strong><br><br>

<strong>UserName:</strong> Kids LoginName<br>
<strong>Password:</strong> Kids Password<br><br>
</cfif>

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
<cfif #AttachmentMode# EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</body>
</html>
</cfmail>


<SCRIPT>
alert("Your test email has been sent.");
self.location="javascript:history.back(-1);";
</SCRIPT>

<cfabort>
</cfif>


<!--- CHECK FILTER TYPE--->
<cfif #form.filter# EQ 'ALL'>

	<!--- RETRIEVE ALL MEMBERS WITH EMAIL ADDRESSES --->
	
	<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, EmailAddress, LoginName, Password, ContactStatus, receiveEmail
	FROM Contacts
	WHERE EmailAddress <> '' and ContactStatus<>'Deleted' and receiveEmail = 1
	ORDER BY LastName, FirstName
	</cfquery>
	
<cfmail server="smtp.gmail.com" username="my3p123@gmail.com" password="password123" port="465" useSSL="true" query="AllMembers" to="#TRIM(EmailAddress)#" from="#fromemail#" subject="#form.MessageSubject#" type="HTML">
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
<cfif #form.Personalise# EQ "0,1">
Dear #FirstName#<BR><BR>
</cfif>

#form.Message#<br><br>


<cfif #form.LoginDetails# EQ "0,1">
<hr width="100%" size="1" color="e2e2e2">
<strong>YOUR MEMBERSHIP LOGIN DETAILS:</strong><br><br>

<strong>UserName:</strong> #LoginName#<br>
<strong>Password:</strong> #Password#<br><br>
</cfif>

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
<cfif #AttachmentMode# EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</body>
</html>
</cfmail>




<cfelse>


<cfif IsDefined("form.member")>



	<!--- RETRIEVE ALL SELECTED MEMBERS WITH EMAIL ADDRESSES --->
	<cfloop index="ListItem" list="#form.Member#">

		<cfquery name="IndMember" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Contacts
		WHERE ContactID=#ListItem# and receiveEmail = 1 and EmailAddress <> ''
		</cfquery>	
	
	
<cfmail server="smtp.gmail.com" username="my3p123@gmail.com" password="password123" port="465" useSSL="true" query="IndMember" to="#EmailAddress#" from="#fromemail#" bcc="#form.bcc#" subject="#form.MessageSubject#" type="HTML">
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
<cfif #form.Personalise# EQ "0,1">
Dear #FirstName#<BR><BR>
</cfif>

#form.Message#<br><br>


<cfif #form.LoginDetails# EQ "0,1">
<hr width="100%" size="1" color="e2e2e2">
<strong>YOUR MEMBERSHIP LOGIN DETAILS:</strong><br><br>

<strong>UserName:</strong> #LoginName#<br>
<strong>Password:</strong> #Password#<br><br>
</cfif>

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
<cfif #AttachmentMode# EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</body>
</html>

</cfmail>
	

</cfloop>


<cfelse>

	<SCRIPT>
	alert("Please select one or more members from the drop-down list.");
	self.location="javascript:history.back();";
	</SCRIPT>

</cfif>

</cfif>





<SCRIPT>
alert("Your email has been processed.");
self.location="javascript:window.close();";
</SCRIPT>


