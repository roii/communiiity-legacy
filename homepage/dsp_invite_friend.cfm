<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td bgcolor="###AllSettings.BoxColour#" style="color:###TRIM(AllSettings.BoxTextColour)#;font-size:12px;" align="center" height="20"><strong>INVITE A FRIEND... EARN POINTS!</strong></td>
</tr>

<tr>
<td height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td background="#request.imageroot#/sidebar_boxL_bg.gif"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"><br>

	
	<table width="207" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<cfif session.UserIsAuthenticated EQ 'Yes'>
	<form method="post" action="#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentid=53" name="invite_form">
	<cfelse>
	<form method="post" action="#request.webroot#/homepage/act_send_invite.cfm" name="invite_form">
	</cfif>
	
	<tr>
	<td align="center" colspan="2"><strong>Earn 5 points for every referral!</strong><br>
	<img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
	</tr>
	
	<tr>
	<td align="right" style="padding-right:5px;">Your Name:</td>
	<td><input type="text" name="YourName" style="width:120px;" class="whitefield"<cfif session.UserIsAuthenticated EQ 'Yes'> value="#TRIM(session.User_FirstName)# #TRIM(session.User_LastName)#"</cfif>></td>
	</tr>
	
	<tr>
	<td align="right" style="padding-right:5px;">Friends Name:</td>
	<td><input type="text" name="FriendName" style="width:120px;" class="field"></td>
	</tr>
	
	<tr>
	<td align="right" style="padding-right:5px;">Friends Email:</td>
	<td><input type="text" name="FriendEmail" style="width:120px;" class="field"></td>
	</tr>
	
	<tr>
	<td> </td>
	<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
	<input type="image" src="#request.imageroot#/sidebar_submit.gif"></td>
	</tr>
	
	
	</form>
	
	
	</table><br>


</td>
</tr>

</table>


</cfoutput>