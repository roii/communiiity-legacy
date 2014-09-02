
<!--- CREATE RANDOM LOGIN NAME AND PASSWORD--->
<cfloop from="1" to="1" index="i">

<cfoutput>
<cfset fn = "form.FirstName#i#">
<cfset firstname=evaluate(fn)>
<cfset ln = "form.LastName#i#">
<cfset lastname=evaluate(ln)>
<cfset id = "form.EmailAddress#i#">
<cfset emailaddress=evaluate(id)>
<cfset Q1Y = "form.Q1#i#">
<cfif isdefined('#Q1Y#')>
  <cfif evaluate(Q1Y) EQ "1">
    <cfset Q1="1">
  <cfelse>
    <cfset Q1="0">	
  </cfif>
</cfif>
<cfset Q2Y = "form.Q2#i#">
<cfif isdefined('#Q2Y#')>
 <cfif evaluate(Q2Y) EQ "1">
   <cfset Q2="1">
  <cfelse>
    <cfset Q2="0">
 </cfif> 
</cfif>
<cfset Q3Y = "form.Q3#i#">
<cfif isdefined('#Q3Y#')>
 <cfif evaluate(Q3Y) EQ "1">
   <cfset Q3="1">
  <cfelse>
    <cfset Q3="0">
 </cfif> 
</cfif>

</cfoutput>

<cfif firstname NEQ '' or lastname NEQ ''>
  <cfif emailaddress EQ ''>
    <cfoutput>
	Please go back and fill out #firstname# #lastname#'s email address first.<br>
	<a href="javascript:history.back(-1)">Go Back!</a>
	</cfoutput>
	<cfabort>
  </cfif>
</cfif>

<cfif emailaddress EQ ''>
  <cfbreak>
</cfif>

<cfset thislogin="mKB_">
<cfset thispassword="">
<cfset chars1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789">
<cfloop  index="indx1" from="1" to="8">
<cfset RNUM = #RANDRANGE(1,36)#>
<cfset thispassword = (thispassword & #MID(CHARS1,RNUM,1)#)>
</cfloop>
<cfloop  index="indx1" from="1" to="8">
<cfset RNUM = #RANDRANGE(1,36)#>
<cfset thislogin = (thislogin & #MID(CHARS1,RNUM,1)#)>
</cfloop>

<cfset thislogin = #TRIM(emailaddress)#>

<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE EmailAddress='#TRIM(emailaddress)#'
AND EmailAddress <>''
</cfquery>

	<cfif #CheckUserEmail.RecordCount# GT 0>
			<cfoutput>
			<script>
			alert("Sorry, a person with this email:#emailaddress# has already done a survey.");
			self.location="#request.webroot#/index.cfm?fuseaction=tasks&projectmode=template&ProjectCategoryID=1&ProjectID=3";
			</script>
			</cfoutput>
			<cfabort>
		<cfelse>
	
		<cftransaction action="BEGIN">
		
		<!--- GENERATE NEW CONTACT ID --->
		
		<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT ContactID
		FROM contacts
		ORDER BY ContactID DESC
		</cfquery>
		
		<cfif #lastid.recordcount# GT 0>
			<cfset newid = (#lastID.ContactID# + 1)>
		<cfelse>
			<cfset newid = 1>
		</cfif>
		<!--- INSERT CONTACT INFO --->
		
		<cfquery name="AddContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO Contacts(
		ContactID,
		ContactType,
		ContactStatus,
		DateJoined,
		FirstName,
		LastName,
		EmailAddress,
		LoginName,
		Password)
		
		VALUES(
		#newid#, 
		'shopper', 
		'pending',
		#CreateODBCDate(localDateTime)#,
		'#TRIM(FirstName)#',
		'#TRIM(LastName)#',
		'#TRIM(emailaddress)#',
		'#TRIM(thislogin)#',
		'#TRIM(thisPassword)#'
		)
		</cfquery>
		
		
		<!--- GENERATE NEW LINK ID --->
		
		<cfquery name="LastLinkID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT KidClientLinkID
		FROM KidClientLinks
		ORDER BY KidClientLinkID DESC
		</cfquery>
		
		<cfif #LastLinkID.recordcount# GT 0>
			<cfset newLinkid = (#LastLinkID.KidClientLinkID# + 1)>
		<cfelse>
			<cfset newLinkid = 1>
		</cfif>
		<!--- INSERT LINK INFO --->
		
		<cfquery name="AddLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO KidClientLinks(
		KidClientLinkID,
		KidID,
		ClientID)
		
		VALUES(
		#newLinkid#,
		#session.UserID#,
		#newid#)
		</cfquery>
		
		<cfquery name="AddSurvey" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO kidsurvey(
			KidID,
			ClientID,
			Q1,
			Q2,
			Q3)
			VALUES(
			#session.UserID#,
			#newid#,
			#Q1#,
			#Q2#,
			#Q3#)
		</cfquery>
			
		</cftransaction>
		
	<!---	<cfoutput>
		<script>
		alert("User: #thislogin# - #thispassword#");
		</script>
		</cfoutput> --->
			
	</cfif>

<cfquery name="kidsdetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
  select * from contacts where contactid = #session.userid#
</cfquery>

<cfmail server="#application.emailserver#" to="#TRIM(emailaddress)#" from="#kidsdetails.emailaddress#" subject="Thanks for completing myKidsBiz Survey!" type="HTML" server="#request.mailserver#">

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


		<hr width="100%" size="1" color="e2e2e2">
		Here is your login:<br>		
		Login Name: #TRIM(thislogin)#<br>
		Password: #TRIM(thisPassword)#<br><br>
		
		<p>
<a href="http://www.mykidsbiz.com/index.cfm?fuseaction=grownups&fusesubaction=invite_thanks&emailaddress=#TRIM(EmailAddress)#&contactid=#newid#"><u>Click this link</u></a>
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
	
<cfoutput>
	<script>
	alert("Congratulations! You have successfully completed this survey\nAn invitation email has been sent to this client");
	self.location="#request.webroot#/index.cfm?fuseaction=tasks&projectmode=template&ProjectCategoryID=1&ProjectID=3";
	</script>
</cfoutput>