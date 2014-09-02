<cfquery name="emaillist" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select contactid,firstname,loginname,password,lastname,emailaddress,kidid from kidsurvey,contacts
  where contacts.contactid = kidsurvey.clientid and emailaddress <> '' and contacts.contactstatus='pending'
</cfquery>
<cfabort>

<p><cfoutput>#emaillist.recordcount#</cfoutput> </p>
<cfoutput query="emaillist">
  #firstname# #lastname# #emailaddress#<br>
</cfoutput>

<cfloop query="emaillist">

<cfquery name="kidsdetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from contacts where contactid = #emaillist.kidid#
</cfquery>

<cfmail server="#application.emailserver#" to="#TRIM(emailaddress)#" from="#trim(kidsdetails.emailaddress)#" subject="Thanks for completing myKidsBiz Survey!" type="HTML">

<html>
<head>
<title>myKidsBiz.com</title>

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
<table width="750px" border="0" cellspacing="0" cellpadding="0">


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
		<td class="normal"><span style="font-size:12px;"><strong><p>Hi #TRIM(FirstName)#!</p>
                Thanks for completing myKidsBiz Survey!</strong></span><br>

		<p>I am really excited about myKidsBiz and having you as a special client.
I have made an account just for you, so you can keep track of what I'm
doing and also buy top products from my ecoCatalogue.  By logging in and
confirming your details you will already be helping me achieve my goals.
How? I get $1 for each of my clients that confirms they did the survey,
simple as that!</p>

		<p>
<a href="http://www.mykidsbiz.com/index.cfm?fuseaction=grownups&fusesubaction=survey_thanks&emailaddress=#TRIM(emaillist.EmailAddress)#&contactid=#emaillist.contactid#">Click this link</a>

 to confirm you did the survey and I will receive a dollar,  pretty cool eh!</p>
		

		<span style="font-size:12px;"><strong>Seeya soon!<br>
		#kidsdetails.firstname# #kidsdetails.lastname#
		</strong></span>
		
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
</cfloop>