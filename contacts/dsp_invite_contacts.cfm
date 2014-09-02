<cfoutput> 
 
 <!--- GET CONTACTS --->
 <cfquery name="AllContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
 SELECT ContactID, FirstName, LastName, EmailAddress, MobilePhone
 FROM Contacts
 WHERE ContactID IN (#Invitelist#)
 ORDER BY FirstName 
 </cfquery>
 
 
<!--- GET THE ALERT DETAILS 
{invitee_firstname} {member_firstname} {sitename} {siteurl} {sitelogo}
--->

<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertSubject, AlertDetails, AlertFormat
FROM EmailAlerts
WHERE AlertID=4
</cfquery>


<!--- REPLACE {siteurl} --->
<cfset NewAlertSubject = ReplaceNoCase(AlertStuff.AlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(AlertStuff.AlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>

<!--- REPLACE {sitename} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>	

<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{member_firstname}',  '#session.User_FirstName# #session.User_LastName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{member_firstname}',  '#session.User_FirstName# #session.User_LastName#' ,  "ALL")>	

<!--- REPLACE {referralcode} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
		

<table cellSpacing="0" cellPadding="0" border="0" width="100%">

<form name="SendInvite" action="#request.webroot#/contacts/act_send_contactsinvite.cfm" method="post">
<input type="hidden" name="TotalInvites" value="#AllContacts.RecordCount#">
<tr>
<td>

	<table cellSpacing="0" cellPadding="10" style="border:solid 1px ##b4b4b4;" width="100%">
	
	<tr>
	<td style="color:##000000;"><strong>Tick the contacts you want to send an invitation to...</strong><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
	
		<table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">
		
		<tr bgcolor="##b4b4b4">
		<td width="30" align="center"></td>
		<td width="180" style="padding-left:5px;color:###TRIM(AllSettings.DKTextColor)#;"><b>Name</b></td>
		<td width="170" style="padding-left:5px;color:###TRIM(AllSettings.DKTextColor)#;"><b>Email</b></td>
		<td width="95" style="padding-left:5px;color:###TRIM(AllSettings.DKTextColor)#;"><b>Mobile No.</b></td>
		</tr>
	
		<cfloop query="AllContacts">
		
		<input type="hidden" name="ContactID_#AllContacts.CurrentRow#" value="#Allcontacts.ContactID#">
		
		<tr>
		<td width="30" align="center" valign="top"><input type="checkbox" class="whitefield" name="UseContact_#AllContacts.CurrentRow#" style="border:0px;font-size:11px;" value="1" checked></td>
		<td width="180" style="padding-left:5px;" valign="top"><input type="text" name="FirstName_#AllContacts.CurrentRow#" value="#TRIM(AllContacts.Firstname)#" class="whitefield" style="width:85px;font-size:11px;"> <input type="text" name="LastName_#AllContacts.CurrentRow#" value="#TRIM(AllContacts.Lastname)#" class="whitefield" style="width:85px;font-size:11px;"></td>
		<td width="170" style="padding-left:5px;" valign="top"><input type="text" name="EmailAddress_#AllContacts.CurrentRow#" value="#TRIM(AllContacts.EmailAddress)#" class="whitefield" style="width:165px;font-size:11px;"></td>
		<td width="95" style="padding-left:5px;" valign="top"><input type="text" name="mobilePhone_#AllContacts.CurrentRow#" value="#TRIM(AllContacts.mobilePhone)#" class="whitefield" style="width:90px;font-size:11px;"></td>
		</tr>
		
		</cfloop>
	
		</table>
		
	</td>
	</tr>
	
	<tr>
	<td>	
	
		<table cellpadding="2" cellspacing="1" border="0" width="100%">		
	
		
		
		<tr>
		<td style="color:##000000;padding-right:10px;"><strong>Add a subject line for the invitation email...</strong><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
		<input type="text" name="EmailSubject" class="whitefield" style="width:500px;" value="#NewAlertSubject#"><br></td>
		</tr>
	
		<tr>
		<td colspan="2" height="5"><hr width="100%" size="1" color="##ffffff"></td>
		</tr>
		
		<tr>
		<td style="color:##000000;padding-right:10px;" valign="top"><strong>Review the default message and change it if you want to...</strong><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>
		<textarea name="Message" rows="25" cols="40">#NewAlertDetails#</textarea>
		<!--- <cf_activedit name="Message" inc="#request.ActiveEditInc#" image="false" width="500" height="250" toolbar="quickfontsize,bold,italic,underline,|,bullets,numbers,table,hyperlink" tabview="no" defaultfont="8pt Verdana">#NewAlertDetails#</cf_activedit> --->
		</td>
		</tr>
		
		</table>
		
	</td>
	</tr>
	
	</table><br>
	
	<input type="image" src="#request.imageroot#/send_button.gif" title="SEND INVITE" onClick="validateSend(SendInvite); return false;">

</td>
</tr>

</form>

</table>	

</cfoutput>