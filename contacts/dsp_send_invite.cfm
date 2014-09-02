<cfoutput>
 
<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ContactCats
ORDER BY DisplayOrder
</cfquery>

<script LANGUAGE=JAVASCRIPT TYPE="text/javascript" >
function validateSend(SendInvite) {
 
var email = SendInvite.FriendEmail.value;
var at = email.indexOf("@");		
var space = email.indexOf(" ");
var comma = email.indexOf(",");
var dot = email.indexOf(".");
var two_dots = email.indexOf("..");
var length = email.length -1;

if (SendInvite.Friend_FirstName.value == "") {
	alert("You must enter your friend's First Name.");
	SendInvite.Friend_FirstName.focus();
	return;
	} 
	
else if ((at == -1)||(at == 0)||(at == length)||(space != -1)||(comma != -1)||(two_dots != -1)||(dot == -1)||(dot == length)||(dot == 0)) {
	alert("Please enter a valid Email Address.");
	SendInvite.FriendEmail.focus();
	return;
	}	
		
else if (<cfset loopcount=0><cfloop query="AllCats">SendInvite.Categories[#loopcount#].checked == false<cfif INT(loopcount+1) NEQ AllCats.RecordCount> && </cfif><cfset loopcount=loopcount+1></cfloop>) {
	alert ('You didn\'t choose a category!');
	return;
	}
	
	 
else {
	SendInvite.submit(); //submit form
	}
	
}
</script>

<cfif IsDefined("this_contactID")>

	<cfquery name="ContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, LastName, EmailAddress, Categories, mobilePhone
	FROM Contacts
	WHERE ContactID =#this_ContactID#
	</cfquery>
	
	<cfset display_firstname = "#ContactStuff.firstname#">
	<cfset display_lastname = "#ContactStuff.lastname#">
	<cfset display_email = "#ContactStuff.emailAddress#">
	<cfset display_mobile = "#ContactStuff.mobilePhone#">
	
	<cfquery name="LinkStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Categories
	FROM KidClientLinks
	WHERE ClientID =#this_ContactID#
	AND KidID=#session.UserID#
	</cfquery>
	
	<cfif LinkStuff.RecordCount>
		<cfset display_categories = LinkStuff.Categories>
	<cfelseif ContactStuff.Categories NEQ ''>
		<cfset display_categories = ContactStuff.Categories>>
	<cfelse>
		<cfset display_categories = 0>
	</cfif>

<cfelseif IsDefined("this_firstname")>

	<cfset display_firstname = "#this_firstname#">
	<cfset display_lastname = "#this_lastname#">
	<cfset display_email = "#this_email#">
	<cfset display_categories = "#this_categories#">
	<cfset display_mobile = "#this_mobilePhone#">
	
<cfelseif IsDefined("form.FriendName")>
	
	<cfif ListLen(form.FriendName,  " ") GT 1>			
		<cfset loopcount=0>		
		<cfloop list="#form.FriendName#" index="loopitem" delimiters=" ">
			<cfset loopcount=(loopcount+1)>			
			<cfif loopcount EQ 1>
				<cfset display_firstname = loopitem>
			<cfelseif loopcount EQ 2>
				<cfset display_lastname = loopitem>
			</cfif>		
		</cfloop>
		
	<cfelse>
		<cfset display_firstname = form.FriendName>
		<cfset display_lastname = "">
	</cfif>
	
	<cfset display_email = "#form.FriendEmail#">
	<cfset display_mobile = "#form.Friendmobile#">
	<cfset display_categories = "">

<cfelse>
	
	<cfset display_firstname = "">
	<cfset display_lastname = "">
	<cfset display_email = "">
	<cfset display_categories = "">
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

<!--- REPLACE {referralcode} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{referralcode}',  '#session.User_ScreenName#' ,  "ALL")>
	
<!--- REPLACE {invitee_firstname} --->
<cfset NewAlertSubject = ReplaceNoCase(NewAlertSubject,  '{invitee_firstname}',  '#display_FirstName#' ,  "ALL")>
<cfset NewAlertDetails = ReplaceNoCase(NewAlertDetails,  '{invitee_firstname}',  '#display_FirstName#' ,  "ALL")>	
			
		


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
			
			<form name="SendInvite" action="#request.webroot#/contacts/act_send_invite.cfm" method="post">
			
			<cfif IsDefined("form.YourName")>
				<input type="hidden" name="YourName" value="#form.YourName#">
			</cfif>
			
			
			<cfif IsDefined("MessageStuff.InviteMessageID")>
				<input type="hidden" name="InviteMessageID" value="#MessageStuff.InviteMessageID#">
			</cfif>
						
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Friends First Name</td>
			<td><input type="text" name="Friend_FirstName" class="whitefield" style="width:300px;" value="#display_FirstName#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Friends Email</td>
			<td><input type="text" name="FriendEmail" class="whitefield" style="width:300px;" value="#display_email#"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Friends Mobile</td>
			<td><input type="text" name="FriendMobile" class="whitefield" style="width:300px;" value="#display_mobile#"></td>
			</tr>
		
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"></td>
			<td><a href="#request.webroot#/templates/dsp_sms_numbers.cfm" target="smsnum" onclick="fdbackwindow=window.open ('','smsnum','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=350,top=10,left=10')" style="font-size:11px;">How to enter international format SMS numbers</a></td>
			</tr>
			
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>		
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Categories</td>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top"><cfloop query="AllCats"><input type="checkbox" name="Categories" class="whitefield" style="border:0px;" value="#AllCats.ContactCatID#"<cfif ListFind(display_categories, AllCats.ContactCatID, ",")> checked</cfif>> #TRIM(AllCats.CatName)#<br>
			</cfloop></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>	
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Subject</td>
			<td><input type="text" name="EmailSubject" class="whitefield" style="width:300px;" value="#NewAlertSubject#"></td>
			</tr>
		
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Message</td>
			<td>
				<textarea name="Message" rows="25" cols="40">#NewAlertDetails#</textarea>
				<!--- <cf_activedit name="Message" inc="#request.ActiveEditInc#" image="false" width="300" height="350" toolbar="quickfontsize,bold,italic,underline,|,bullets,numbers,table,hyperlink" tabview="no" defaultfont="8pt Verdana">#NewAlertDetails#</cf_activedit> --->
			</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>

			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/send_button.gif" title="SEND INVITE" onClick="validateSend(SendInvite); return false;"></td>
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