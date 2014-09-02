<cfoutput>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td colspan="5" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>INVITATIONS PENDING</strong> (#PendingResults.RecordCount#)</td>
</tr>

<tr>
<td colspan="5" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="5" height="1" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="5" height="12"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="12" border="0"></td>
</tr>
	
<tr>
<td></td>
<td style="color:###TRIM(AllSettings.DkTextColor)#;padding-left:5px;">Name</td>
<td style="color:###TRIM(AllSettings.DkTextColor)#;padding-left:5px;">Last Sent</td>
<td style="color:###TRIM(AllSettings.DkTextColor)#;padding-left:5px;">Email Sent To</td>
<td></td>
</tr>
	
<tr>
<td colspan="5" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr bgcolor="##b4b4b4">
<td height="1" width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
<td height="1" width="140"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1" border="0"></td>
<td height="1" width="120"><img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"></td>
<td height="1" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td height="1" width="80"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="1" border="0"></td>
</tr>
	
<tr>
<td colspan="5" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>
 
<cfloop query="PendingResults">
	
<cfset this_InvitationID=PendingResults.InvitationID>
<cfset this_emailaddress = TRIM(PendingResults.InvitationToEmail)>
	
<tr>
<td width="20" align="center"><input type="checkbox" name="SelectContact" value="1" style="border:0px;"></td>
<td style="padding-left:5px;">

	<table width="100%" cellpadding="1" cellspacing="0" border="0">
			
	<tr>
	<td width="30"><img src="#request.imageroot#/icons/people_grey_sml.gif" width="24" height="20" alt="Pending Invitation" border="0" align="absmiddle"></td>
	<td>#TRIM(PendingResults.InvitationTo_FirstName)# #TRIM(PendingResults.InvitationTo_LastName)#</a></td>
	</tr>
			
	</table>
			
</td>
<td style="padding-left:5px;">#DateFormat(PendingResults.DateLastSent)#</td>
<td style="padding-left:5px;">
            <cfset tmp = find("</title>",#TRIM(PendingResults.InvitationToEmail)#)> 
	<cfif tmp gt 0>		
			<cfset emailD = #Left(TRIM(PendingResults.InvitationToEmail), tmp-1)#>
            [e] <a href="mailto:#emailD#" style="text-decoration:none;color:###TRIM(AllSettings.BoxColour)#" title="#emailD#">#emailD#</a>
    <cfelse>
            [e] <a href="mailto:#TRIM(PendingResults.InvitationToEmail)#" style="text-decoration:none;color:###TRIM(AllSettings.BoxColour)#" title="#TRIM(PendingResults.InvitationToEmail)#">#TRIM(PendingResults.InvitationToEmail)#</a>
    </cfif>			
</td>
<td width="80" align="right"><select name="Invite_#this_InvitationID#" id="Invite_#this_InvitationID#" class="whitefield" onchange="javascript:ActionInviteChange(#this_InvitationID#);">
<option value="0">-- Select Action --
<option value="Resend">- Re-send Invite
<option value="Delete">- Remove Invite
</select></td>
</tr>
	
<tr>
<td colspan="5" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td colspan="5" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="5" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>

</table><br>

</cfoutput>