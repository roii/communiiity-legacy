<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(session.AllSettings_BoxColour)#;" valign="bottom"><strong>#TRIM(PartnerStuff.Organisation_Name)# Community Partnerships</strong></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" bgcolor="###TRIM(session.AllSettings_BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="170" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(session.AllSettings_DKTextColor)#;padding-left:5px;"><strong>#TransactionHistory.RecordCount# Members</strong> benefited so far</td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(session.AllSettings_DKTextColor)#;padding-left:5px;"><strong>#Listlen(SchoolList)# Schools</strong> benefited so far</td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:###TRIM(session.AllSettings_DKTextColor)#;padding-left:5px;"><strong>#Listlen(CharityList)# Charities</strong> benefited so far</td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>

	</table>
	


</td>
</tr>

</table><br>

</cfoutput>