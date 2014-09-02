<cfoutput>
  
<table border="0" cellpadding="0" cellspacing="0" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>ENTER YOUR VERIFICATION CODE</strong></td>
<td align="right" width="30" height="20"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

<form name="verifyform" action="#request.webroot#/join/act_confirm_code.cfm" method="post">

<tr>
<td colspan="2"><span style="color:###TRIM(AllSettings.DkTextColor)#">Enter the email address you registered with and the verification code you received below...</span><br><br><br>

	<table border="0" cellpadding="10" cellspacing="0" style="border:dotted 1px b4b4b4;">

	<tr>
	<td>	
	
		<table border="0" cellpadding="0" cellspacing="0">
	
		<tr>
		<td style="color:###TRIM(AllSettings.DkTextColor)#" style="padding-right:5px;"><strong>EMAIL ADDRESS:</strong></td>
		<td><input type="text" class="whitefield" name="EmailAddress" style="width:200px;"></td>
		</tr>
		
		<tr>
		<td height="5"> </td>
		</tr>
		
		<tr>
		<td style="color:###TRIM(AllSettings.BoxColour)#" style="padding-right:5px;"><strong>VERIFICATION CODE:</strong></td>
		<td><input type="text" class="whitefield" name="VerificationCode" style="width:200px;"></td>
		</tr>
		
		<tr>
		<td height="5"> </td>
		</tr>
		
		<tr>
		<td></td>
		<td><input type="submit" class="whitefield" value="VERIFY CODE &raquo;"></td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>

</td>
</tr>
</form>

</table>

</cfoutput>