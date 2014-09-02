 <cfoutput>
 
<script LANGUAGE=JAVASCRIPT TYPE="text/javascript" >
function validateSend(SendInvite) {
 
var email = document.SendInvite.FriendEmail.value;
var at = email.indexOf("@");		
var space = email.indexOf(" ");
var comma = email.indexOf(",");
var dot = email.indexOf(".");
var two_dots = email.indexOf("..");
var length = email.length -1;

if (document.SendInvite.Friend_FirstName.value == "") {
	alert("You must enter your friend's First Name.");
	document.SendInvite.Friend_FirstName.focus();
	return;
	} 
	
else if ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
	alert("Please enter a valid Email Address.");
	document.SendInvite.FriendEmail.focus();
	return;
	}
	
		
else if (document.SendInvite.EmailSubject.value == "") {
	alert ("Please enter a Subject");
	document.SendInvite.EmailSubject.focus();
	return;
	}
	
	 
else {
	SendInvite.submit(); //submit form
	}
	
}
</script>


 <cfquery name="qry_invitation_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM Invitations
WHERE InvitationID=#InvitationID#
</cfquery>

<cfif IsDefined("this_firstname")>

	<cfset display_firstname = "#this_firstname#">
	<cfset display_lastname = "#this_lastname#">
	<cfset display_email = "#this_email#">
	<cfset display_mobile="#this_mobile#">
	
<cfelseif qry_invitation_details.recordcount>
	
	<cfset display_firstname = qry_invitation_details.InvitationTo_FirstName>
	<cfset display_lastname = qry_invitation_details.InvitationTo_LastName>
	<cfset display_email = qry_invitation_details.InvitationToEmail>
	<cfset display_mobile = qry_invitation_details.InvitationTo_Mobile>

<cfelse>
	
	<cfset display_firstname = "">
	<cfset display_lastname = "">
	<cfset display_email = "">
	<cfset display_mobile = "">

</cfif>


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

<!--- REPLACE {member_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{member_firstname}',  '#session.User_FirstName# #session.User_LastName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{member_firstname}',  '#session.User_FirstName# #session.User_LastName#' ,  "ALL")>

<!--- REPLACE {invitee_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{invitee_firstname}',  '#display_firstname#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{invitee_firstname}',  '#display_firstname#' ,  "ALL")>	

<!--- REPLACE {referralcode} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
	
	

<br>	
<table cellSpacing="1" cellPadding="0" bgColor="##b4b4b4" border="0" width="100%">

<tr>
<td>


	<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
	
	<tr>
	<td>
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
		<td></td>
		</tr>
		
		<form name="SendInvite" action="#request.webroot#/contacts/act_resend_invite.cfm" method="post">
		
		<input type="hidden" name="InvitationID" value="#InvitationID#">
		
		
		<tr>
		<td style="color:###TRIM(AllSettings.DkTextColor)#;">Friends First Name</td>
		<td><input type="text" name="Friend_FirstName" class="whitefield" style="width:300px;" value="#TRIM(display_firstname)#"></td>
		</tr>	
		
		<tr>
		<td style="color:###TRIM(AllSettings.DkTextColor)#;">Friends Email</td>
		<td><input type="text" name="FriendEmail" class="whitefield" style="width:300px;" value="#TRIM(display_email)#"></td>
		</tr>	
		
		<!--- IF THE USER HAS A VALID MOBILE --->
		<cfset sender_mobilenumber = rereplace(session.User_Mobile, '[^0-9]+', '', 'all')>
		
		<cfif IsNumeric("#sender_mobilenumber#")>
		
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Friends Mobile</td>
			<td><input type="text" name="FriendMobile" class="whitefield" style="width:300px;" value="#TRIM(display_mobile)#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"></td>
			<td><a href="#request.webroot#/templates/dsp_sms_numbers.cfm" target="smsnum" onclick="fdbackwindow=window.open ('','smsnum','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=350,top=10,left=10')" style="font-size:11px;">How to enter international format SMS numbers</a></td>
			</tr>
		
		</cfif>
		
		<tr>
		<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
		</tr>
		
		<tr>
		<td style="color:###TRIM(AllSettings.DkTextColor)#;">Subject</td>
		<td><input type="text" name="EmailSubject" class="whitefield" style="width:300px;" value="#TRIM(NewAlertSubject)#"></td>
		</tr>
		
		<tr>
		<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
		</tr>
		
		<tr>
		<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Message</td>
		<td>
			<textarea name="Message" rows="25" cols="40">#TRIM(NewAlertDetails)#</textarea>
			<!--- <cf_activedit name="Message" inc="#request.ActiveEditInc#" image="false" width="300" height="350" toolbar="quickfontsize,bold,italic,underline,|,bullets,numbers,table,hyperlink" tabview="no" defaultfont="8pt Verdana">#TRIM(NewAlertDetails)#</cf_activedit> --->
		</td>
		</tr>
		
		<tr>
		<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
		</tr>

		
		<tr>
		<td> </td>
		<td><input type="image" src="#request.imageroot#/send_button.gif" title="RESEND INVITE" onClick="validateSend(SendInvite); return false;"></td>
		</tr>
		</form>
		
		</table>
		
	</td>
	</tr>
	
	</table>

</td>
</tr>

</table>



</cfoutput>