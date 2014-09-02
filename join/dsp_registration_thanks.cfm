 <cfoutput>
 
 <cfquery name="ContactDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
 SELECT Password
 FROM Contacts
 WHERE ContactID=#ContactID#
 </cfquery>

<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>THANKS FOR REGISTERING!</strong></td>
<td align="right" width="30" height="20"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>


<tr>
<td colspan="2"><span style="color:###TRIM(AllSettings.DkTextColor)#"><strong>Hi #TRIM(session.User_FirstName)#!</span><br><br>
Your registration for membership to #TRIM(AllSettings.SiteName)# has been verified!</strong></span><br>

Use the following log-in details to access the many features of the website and start earning money!<br><br>
	
	<hr width="300" align="left" size="1" color="e2e2e2">
	
	<table width="200" border="0">
	
	<tr>
	<td>Email:</td>
	<td><strong>#TRIM(session.User_Email)#</strong></td>
	</tr>
	
	<tr>
	<td>Password:</td>
	<td><strong>#TRIM(ContactDetails.Password)#</strong></td>
	</tr>
	
	</table>
	
	<hr width="300" align="left" size="1" color="e2e2e2"><br>
	 We recomend that you change your password regularly and never share it with anyone other than your parents.<br><br><br>

	<span style="font-size:12px;"><strong>Thanks!<br>
	The Team @ #TRIM(AllSettings.SiteName)#</strong></span>
	
	
</td>
</tr>

</table>

</cfoutput>