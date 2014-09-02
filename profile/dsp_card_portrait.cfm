<cfoutput>

<table width="200" height="360" cellpadding="5" cellspacing="0" style="border:solid 1px b4b4b4;" align="center">

<tr>
<td valign="top">
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<tr>
	<td valign="top" align="center"><img src="#request.imageroot#/transparent_spc.gif" width="190" height="20" border="0"><br>
	
	<img src="#request.imageroot#/#TRIM(AllSettings.Logo_file)#" alt="#TRIM(AllSettings.SiteName)#" border="0" width="169" height="86"><br><br>

	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="40" border="0"><br>
	
	
	<span style="font-size:14px;color:black;"><strong>#TRIM(session.User_FirstName)# #TRIM(session.User_LastName)#</strong></span><br>
	<span style="font-size:11px;color:black;">#TRIM(session.User_Email)#</span><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"><br>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
	<td height="1" bgcolor="b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	<tr>
	<td height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	</tr>
	</table>

	<span style="font-size:11px;color:black;"><strong>Referral Code:</strong><br> #session.User_ScreenName#</span><br>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr>
	<tr>
	<td height="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	</tr>
	<td height="1" bgcolor="b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	</table>
	
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="40" border="0"><br>
	</td>
	</tr>
	
	</table>


</td>
</tr>	

<tr>
<td valign="bottom">

	
	
	<table cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td align="center" valign="bottom" height="100%" style="font-size:12px;color:black;">h t t p : / / w w w . m y 3 p . c o m</td>
	</tr>
	
	</table>
	
</td>
</tr>

</table>

</cfoutput>