<cfinclude template="../app_globals.cfm">
<cfinclude template="app_locals.cfm">

<cfif IsDefined("session.UserID") AND IsNumeric("#session.UserID#")>

<cfelse>
	<cfset session.UserID=url.userID>
</cfif>

<cfquery name="userDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName, EmailAddress
	FROM Contacts
	WHERE ContactID=#session.UserID#
</cfquery>

<cfoutput>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>www.communiiity.com express interest to do a project</title>
	<script language="javascript" type="text/javascript">
		function limitText(limitField, limitCount, limitNum) {
			if (limitField.value.length > limitNum) {
				limitField.value = limitField.value.substring(0, limitNum);
			} else {
				limitCount.value = limitNum - limitField.value.length;
			}
		}
	</script>
</head>

<body>
<form name="amarForm" method="post" action="#request.webroot#/projects/act_ExpressInterest.cfm">
	Campaign Id:&nbsp;&nbsp;<cfif isdefined("url.CampaignsID")>#trim(url.CampaignsID)#</cfif> <br>
	Campaign Name:&nbsp;&nbsp;<cfif isdefined("url.projectTitle")>#trim(url.projectTitle)#</cfif> <br>
	Your name:&nbsp;&nbsp;<cfif IsDefined("userDetails")>#trim(userDetails.FirstName)#&nbsp;#trim(userDetails.LastName)#</cfif><br>
	Your email id:&nbsp;&nbsp;<cfif IsDefined("userDetails")>#trim(userDetails.EmailAddress)#</cfif><br><br>
	I'd like to do this because...<br>
	(or questions/feedback/comments)<br>
	<textarea cols="40" rows="10" name="limitedtextarea" onKeyDown="limitText(this.form.limitedtextarea,this.form.countdown,200);" 
onKeyUp="limitText(this.form.limitedtextarea,this.form.countdown,200);"></textarea><br>
	<font size="1">(Maximum characters: 200)<br>
	You have <input readonly type="text" name="countdown" size="3" value="200"> characters left.</font><br><br>
	Date I can have it done by is....<br>
	<input name="txtEndDate" type="Text" size="40" maxlength="26"> (enter as 31 dec 2010)<br><br>
	<input type="Hidden" name="CampaignsID" value="#trim(url.CampaignsID)#">
	<input type="Hidden" name="projectTitle" value="#trim(url.projectTitle)#">
	<input type="Hidden" name="memberID" value="#session.UserID#">
	<input type="Hidden" name="memberName" value="#trim(userDetails.FirstName)#&nbsp;#trim(userDetails.LastName)#">
	<input type="Hidden" name="memberEmail" value="#trim(userDetails.EmailAddress)#">
	<input type="Submit" name="Submit" value="Email Interest">
</form>
</body>
</html>
</cfoutput>