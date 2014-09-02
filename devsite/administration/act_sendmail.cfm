<cfoutput>


<cfparam name="AttachmentMode" default="No">

<!--- CHECK IF ATTACHMENT INCLUDED --->
<cfif TRIM(form.Attachment) NEQ ''>

	
<cftry>
	
	<cffile action="UPLOAD" filefield="form.attachment" destination="#request.fileroot#/mail_attachments" nameconflict="MAKEUNIQUE">
	<cfset AttachmentFileName = file.serverfile>
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

<cfif form.Format EQ 'HTML'>
<cfmail server="#application.emailserver#" to="#session.User_Email#" from="#fromemail#" bcc="#form.bcc#" subject="#form.MessageSubject#" type="HTML">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)#</title>

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
	<td width="300" valign="top" bgcolor="white"><a href="#request.webroot#/"><img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" alt="#TRIM(AllSettings.SiteName)#" border="0"></a></td>
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
<cfif IsDefined("form.Personalise") AND form.Personalise CONTAINS 1>
Hi Kid<BR><BR>
</cfif>

#form.Message#<br><br>

<cfif IsDefined("form.LoginDetails") AND form.LoginDetails CONTAINS 1>
<hr width="100%" size="1" color="e2e2e2">
<strong>Your Password to Login:</strong> Kids Password<br><br>
</cfif>

<hr width="100%" size="1" color="e2e2e2">

		
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
<cfif AttachmentMode EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</body>
</html>
</cfmail>
<cfelse>
<cfmail server="#application.emailserver#" to="#session.User_Email#" from="#fromemail#" bcc="#form.bcc#" subject="#form.MessageSubject#">
<cfif IsDefined("form.Personalise") AND form.Personalise CONTAINS 1>
Hi Kid
</cfif>

#form.Message#
<cfif IsDefined("form.LoginDetails") AND form.LoginDetails CONTAINS 1>
#chr(10)#
Your Password to Login: Kids Password
</cfif>

<cfif AttachmentMode EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</cfmail>

</cfif>

<SCRIPT>
alert("Your test email has been sent.");
self.location="javascript:history.back(-1);";
</SCRIPT>

<cfabort>
</cfif>


<!--- CHECK FILTER TYPE--->
<cfif form.filter EQ 'ALL'>

<!--- RETRIEVE ALL MEMBERS WITH EMAIL ADDRESSES --->

<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT FirstName, EmailAddress, LoginName, Password, ContactStatus, receiveEmail
FROM Contacts
WHERE EmailAddress <> '' and ContactStatus<>'Deleted' and receiveEmail = 1
ORDER BY LastName, FirstName
</cfquery>

<cfif form.Format EQ 'HTML'>
<cfmail server="#application.emailserver#" query="AllMembers" to="#TRIM(EmailAddress)#" from="#fromemail#" subject="#form.MessageSubject#" type="HTML">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)#</title>

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
	<td width="300" valign="top" bgcolor="white"><a href="#request.webroot#/"><img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" alt="#TRIM(AllSettings.SiteName)#" border="0"></a></td>
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
<cfif IsDefined("form.Personalise") AND form.Personalise CONTAINS 1>
Hi #FirstName#<BR><BR>
</cfif>

#form.Message#<br><br>


<cfif IsDefined("form.LoginDetails") AND form.LoginDetails CONTAINS 1>
<hr width="100%" size="1" color="e2e2e2">
<strong>Your Password to Login:</strong> #Password#
</cfif>

<hr width="100%" size="1" color="e2e2e2">

		
		
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
<cfif AttachmentMode EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</body>
</html>
</cfmail>
<cfelse>
<cftry>
<cfmail server="#application.emailserver#" query="AllMembers" to="#TRIM(EmailAddress)#" from="#fromemail#" subject="#form.MessageSubject#">
<cfif IsDefined("form.Personalise") AND form.Personalise CONTAINS 1>Hi #FirstName#</cfif>
#form.Message#
<cfif IsDefined("form.LoginDetails") AND form.LoginDetails CONTAINS 1>Your Password to Login: #Password#</cfif>
<cfif AttachmentMode EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</cfmail>
<cfcatch></cfcatch>
</cftry>
</cfif>



<cfelse>


<cfif IsDefined("form.member")>



<!--- RETRIEVE ALL SELECTED MEMBERS WITH EMAIL ADDRESSES --->
<cfloop index="ListItem" list="#form.Member#">

<cfquery name="IndMember" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Contacts
WHERE ContactID=#ListItem# and receiveEmail = 1 and EmailAddress <> ''
</cfquery>	

<cfif form.Format EQ 'HTML'>
<cfmail server="#application.emailserver#" query="IndMember" to="#EmailAddress#" from="#fromemail#" bcc="#form.bcc#" subject="#form.MessageSubject#" type="HTML">
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>#TRIM(AllSettings.SiteName)#</title>

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
	<td width="300" valign="top" bgcolor="white"><a href="#request.webroot#/"><img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" alt="#TRIM(AllSettings.SiteName)#" border="0"></a></td>
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
		<cfif IsDefined("form.Personalise") AND form.Personalise CONTAINS 1>
		Hi #FirstName#<BR><BR>
		</cfif>

#form.Message#<br><br>


<cfif IsDefined("form.LoginDetails") AND form.LoginDetails CONTAINS 1>
<hr width="100%" size="1" color="e2e2e2">
<strong>Your Password to Login:</strong> #Password#<br><br>
</cfif>
		
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
<cfif AttachmentMode EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</body>
</html>
</cfmail>

<cfelse>
<cftry>
<cfmail server="#application.emailserver#" query="IndMember" to="#EmailAddress#" from="#fromemail#" bcc="#form.bcc#" subject="#form.MessageSubject#">
<cfif IsDefined("form.Personalise") AND form.Personalise CONTAINS 1>Hi #FirstName#</cfif>
#form.Message#
<cfif IsDefined("form.LoginDetails") AND form.LoginDetails CONTAINS 1>Your Password to Login: #Password#</cfif>

<cfif AttachmentMode EQ 'Yes'>
<cfmailparam file="#request.fileroot#/mail_attachments/#AttachmentFileName#">
</cfif>
</cfmail>
<cfcatch></cfcatch>
</cftry>
</cfif>

</cfloop>


<cfelse>

	<SCRIPT>
	alert("Please select one or more members from the drop-down list.");
	self.location="javascript:history.back(-1);";
	</SCRIPT>

</cfif>

</cfif>





<cfoutput>

<SCRIPT>
alert("Your email has been processed.");
self.location="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool";
</SCRIPT>

</cfoutput>


