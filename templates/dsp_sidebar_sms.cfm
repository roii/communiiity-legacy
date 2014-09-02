<cfoutput>

<cfparam name="user_points" default="0">
<cfparam name="this_mobile" default="">

<cfif session.permission1_view EQ 1 OR session.permission96_add EQ 1>
	
	<cfif IsDefined("session.User_Mobile")>	
		<cfset this_mobile = session.User_Mobile>	
	<cfelse>
		
		<cfquery name="qry_mobile_num" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT MobilePhone
		FROM Contacts
		WHERE ContactID=#session.UserID#
		</cfquery>
		
		<cfif qry_mobile_num.RecordCount>
			<cfset this_mobile = qry_mobile_num.MobilePhone>		
		<cfelse>
			<cfset this_mobile = "">
		</cfif>
		
	</cfif>
	
</cfif>

<script language="JavaScript">
<!--
function IsNumeric(strString)
//  check for valid numeric strings	
{
	var strValidChars = "0123456789";
	var strChar;
	var blnResult = true;

if (strString.length == 0) return false;
	//  test strString consists of valid characters listed above
	for (i = 0; i < strString.length && blnResult == true; i++)
		{
		strChar = strString.charAt(i);
	if (strValidChars.indexOf(strChar) == -1)
		{
		blnResult = false;
		}
	}
return blnResult;
}
// -->

<!--
function confirmTxt() {

<cfif session.permission96_add EQ 1>
	
	<cfif (user_points GTE 20)>
	
		if (document.TxtForm.TxtTo.value == "") {
		alert("You must enter the number you want to send the TXT to.");
		document.TxtForm.TxtTo.focus();
		return;
		}
		
		else if (IsNumeric(document.TxtForm.TxtTo.value) == false) {
		alert("You have not entered a correct number.");
		document.TxtForm.TxtTo.focus();
		return;
		}		
		
		else if (document.TxtForm.TxtMsg.value == "") {
		alert("You must enter a message.");
		document.TxtForm.TxtMsg.focus();
		return;
		}
		
		else {
		
			if(confirm('20 points will be taken out of your points account')) {
			document.TxtForm.submit();		
			}		
		}
		
	<cfelse>		
		alert("Sorry, you don't have enough points\nto send a message right now.");	
	</cfif>

<cfelseif session.permission1_view EQ 1>
	
	if (document.TxtForm.TxtTo.value == "") {
		alert("You must enter the number you want to send the TXT to.");
		document.TxtForm.TxtTo.focus();
		return;
		}
		
		else if (IsNumeric(document.TxtForm.TxtTo.value) == false) {
		alert("You have not entered a correct number.");
		document.TxtForm.TxtTo.focus();
		return;
		}		
		
		else if (document.TxtForm.TxtMsg.value == "") {
		alert("You must enter a message.");
		document.TxtForm.TxtMsg.focus();
		return;
		}
		
		else {		
		document.TxtForm.submit();				
		}		
		
<cfelse>

	alert("Sorry, you do not have permission to send an SMS message.");

</cfif>

}
//-->
</script>

<a name="sms"> </a>
<table width="100%" cellpadding="0" cellspacing="0" style="border:solid 2px ##99CC00;">

<tr>
<td bgcolor="##99CC00" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>SEND SMS/TXT MESSAGES</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>

	
	<table width="150" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td style="font-size:11px;color:black;" colspan="2" background="#request.imageroot#/sms_phone.gif" height="66">For a limited time you<br>
	can <strong>SMS / TXT any<br>mobile on the planet</strong><br>
	for just 20 points!</td>
	</tr>
	
	<tr>
	<td colspan="2" align="center"><hr width="100%" size="1" color="##99CC00"></td>
	</tr>
	
	<form method="post" action="#request.webroot#/templates/act_send_txt.cfm" name="TxtForm" onsubmit="confirmTxt(); return false;">
	
	<tr>
	<td style="font-size:11px;color:black;">To:</td>
	<td style="padding-left:10px;"><input type="text" class="whitefield" name="TxtTo" style="width:110px;height:15px;font-size:10px;"></td>
	</tr>
	
	<tr>
	<td style="font-size:11px;color:black;">From:</td>
	<td style="padding-left:10px;"><input type="text" class="whitefield" name="TxtFrom" style="width:110px;height:15px;font-size:10px;"<cfif IsDefined("this_mobile")> value="#Replace(TRIM(this_mobile), ' ', '', "ALL")#"</cfif>></td>
	</tr>
	
	<tr>
	<td valign="top" style="font-size:11px;color:black;">Msg:</td>
	<td style="padding-left:10px;"><textarea class="whitefield" name="TxtMsg" style="width:110px;font-size:10px;" rows="4" onfocus="document.TxtForm.TxtMsg.value='';">Max length 100 characters.</textarea></td>
	</tr>
	
	<tr>
	<td colspan="2" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<tr>
	<td></td>
	<td style="padding-left:10px;"><input type="submit" style="cursor:hand;background-color:##99CC00;color:black;font-weight:bold;font-size:11px;border:0px;" class="whitefield" value="Send &raquo;"> <input type="button" style="cursor:hand;background-color:##e2e2e2;color:444444;font-size:11px;border:0px;" class="whitefield" value=" Help &raquo; " onclick="fdbackwindow=window.open ('#request.webroot#/templates/dsp_sms_numbers.cfm','smsnum','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=500,height=350,top=10,left=10')"></td>
	</tr>
	
	</form>
	
	</table><br>

</td>
</tr>

</table>

</cfoutput>