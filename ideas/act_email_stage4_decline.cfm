<cfmail server="#application.emailserver#" to="#TRIM(IdeaStuff.emailAddress)#" from="theTeam@my3p.com" subject="Your Idea needs clarification to move to Stage 4" type="HTML">
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
	<td width="300" valign="top" bgcolor="white"><a href="#request.webroot#"><img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" width="169" height="86" alt="#TRIM(AllSettings.SiteName)#" border="0"></a></td>
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
		<td class="normal"><span style="font-size:12px;"><strong>Hi #IdeaStuff.firstname#!</strong></span><br><br>
		
		You're idea "<strong>#TRIM(IdeaStuff.Suggestion)#</strong>" needs more clarification before it can move to the next stage. We encourage you to use the feedback given to clarify your idea &amp; then submit again. Good Luck!<br><br>


		Below is your feedback so far.<br><br> 
 		
		<table width="350" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td valign="top" width="100" style="font-size:11px;"><strong>Who</strong></td>
		<td valign="top" width="50" style="font-size:11px;"><strong>Vote</strong></td>
		<td valign="top" width="200" style="font-size:11px;"><strong>Comments</strong></td>
		</tr>
		
		<tr>
		<td colspan="3"><hr width="350" size="1" color="e2e2e2"></td>
		</tr>
		
		<cfloop query="TotalVotes">
			
		<cfquery name="VoteBy" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT FirstName
		FROM Contacts
		WHERE ContactID=#TotalVotes.ContactID#
		</cfquery>
		
		<tr>
		<td valign="top" width="100" style="font-size:11px;">#TRIM(VoteBy.Firstname)#</td>
		<td valign="top" width="50" style="font-size:11px;"><cfif TotalVotes.Vote GTE 3>YES<cfelse>NO</cfif></td>
		<td valign="top" width="200" style="font-size:11px;">#TRIM(TotalVotes.comments)#</td>
		</tr>
		
		</cfloop>
		
		
		</table><br><br>
		
		
		<a href="mailto:#TRIM(AllSettings.EmailAlertFrom)#">#TRIM(AllSettings.EmailAlertFrom)#</a></strong>
		</span>
		
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