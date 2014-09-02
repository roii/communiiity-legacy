<cfoutput>

<cfif type EQ 'member'>

	<cfset this_title = "Invitation">
	<cfset this_subject="my3P.com - Invitation Reversed">
	<cfset this_emailaddress="#TRIM(CheckInvitation.EmailAddress)#">

</cfif>




<!DOCTYPE HTML Public "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>#TRIM(AllSettings.SiteName)# - #this_title# <cfif type EQ 'member'>Membership</cfif></title>
<cfinclude template="../templates/styles.cfm">

</head>

<body leftmargin="0" topmargin="0" rightmargin="0" bottommargin="0" marginwidth="0" marginheight="0" bgcolor="e2e2e2">


<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">

<tr height="40">
<td bgcolor="##444444" width="40" align="center" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" border="0"></td>
<td width="1" bgcolor="white" valign="top" height="40"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="middle" valign="top" height="40" bgcolor="###TRIM(AllSettings.BoxColour)#"><span style="color:white; font-size:14px; font-family:verdana;">&nbsp;&nbsp;<strong>Send Reverse Notification - #this_title#</strong></span></td>
</tr>


<tr>
<td colspan="3" bgcolor="white" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td bgcolor="##b4b4b4" width="40" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="40" height="1" border="0"></td>
<td width="1" bgcolor="white"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td valign="top">
<br>

	
		
<script language="JavaScript">
function validateReverse(ReverseForm) {    

if (ReverseForm.reason.value == "") {
	alert("You must enter the reason for this reversal.");
	ReverseForm.suggestion.focus();
	return;
	} 
	
else {
	ReverseForm.submit();
	}
}
</script>


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form name="ReverseForm" action="#request.webroot#/administration/act_reverse_reason.cfm" method="post">
	
	<input type="hidden" name="SendTo_Email" value="#this_emailaddress#">
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110" valign="top">Subject</td>
	<td><input name="subject" type="text" class="whitefield" style="font-size:11px;width:300px;" value="#this_subject#"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td class="normal" width="110" valign="top">Reason</td>
	<td>
	
<textarea name="reason" class="whitefield" rows="15" style="font-size:11px;width:400px;">
The following invitation you submitted has been removed from my3P.com
------------------------------------------------------------------------------------------
Name: #TRIM(memberstuff.FirstName)# #TRIM(memberstuff.LastName)#
------------------------------------------------------------------------------------------#chr(10)#

The reason why we removed the invitation is...
------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------#chr(10)#
Any points and rewards you received for this invitation 
have been reversed from your account.
</textarea></td>
</tr>
	
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td colspan="2"><hr width="100%" size="1" color="silver"></td>
	</tr>	
		
	<tr>
	<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
	<td> </td>
	<td><input type="submit" onclick="javascript:validateReverse(ReverseForm); return false;" value="UPDATE REASON >>" class="whitefield"> &nbsp; <input type="button" onclick="javascript:window.close();" value="CANCEL >>" class="whitefield"></td>
	</tr>
	
	</form>
	
	</table><br><br>


	
</td>
</tr>

</table>

</body>
</html>

</cfoutput>