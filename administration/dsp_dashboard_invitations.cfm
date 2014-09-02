<cfoutput>

<!--- ALL INVITATIONS --->
<cfquery name="AllInvites" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT InvitationID, InvitationToEmail, InvitationTo, InvitationStatus
FROM Invitations
</cfquery>

<cfif AllInvites.RecordCount>
	<cfset invitation_Emails = valueList(AllInvites.InvitationToEmail, "|")>
	<cfset total_EmailInvitations = AllInvites.RecordCount>
<cfelse>
	<cfset invitation_Emails = "">
	<cfset total_EmailInvitations = 0>
</cfif>

<!--- ALL REGISTRATIONS WITH REFERRAL CODE --->
<cfquery name="AllReferrals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, EmailAddress, ReferralCode
FROM Contacts
WHERE ReferralCode <> ''
</cfquery>

<cfset referral_Emails = valueList(AllReferrals.EmailAddress, "|")>
 
<cfset total_VerbalInvitations = 0>
<cfset total_invitations = total_EmailInvitations>


<cfloop query="AllReferrals">

<cfif NOT ListFind(invitation_emails, AllReferrals.EmailAddress, "|")>
	<cfset total_VerbalInvitations = (total_VerbalInvitations + 1)>
	<cfset total_invitations = (total_invitations + 1)>
</cfif>

</cfloop>


<cfset total_successful_invitations = AllReferrals.RecordCount>

<cfloop query="AllInvites">

<cfif AllInvites.InvitationStatus CONTAINS 'Successful' AND NOT ListFind(referral_Emails, AllInvites.InvitationToEmail, "|")>
	<cfset total_successful_invitations = (total_successful_invitations + 1)>
</cfif>

</cfloop>
<cfif total_invitations gt 0>
	<cfset invite_success_rate = (total_Successful_Invitations / total_invitations * 100)>
<cfelse>
	<cfset invite_success_rate = total_Successful_Invitations / 1 >
</cfif>


<!--- ALL INVITATIONS --->
<cfquery name="DR_AllInvites" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT InvitationID, InvitationToEmail, InvitationTo, InvitationStatus
FROM Invitations
WHERE DateFirstSent BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>

<cfif DR_AllInvites.RecordCount>
	<cfset DR_invitation_Emails = valueList(DR_AllInvites.InvitationToEmail, "|")>
	<cfset DR_total_EmailInvitations = DR_AllInvites.RecordCount>
<cfelse>
	<cfset DR_invitation_Emails = "">
	<cfset DR_total_EmailInvitations = 0>
</cfif>

<!--- ALL REGISTRATIONS WITH REFERRAL CODE --->
<cfquery name="DR_AllReferrals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, EmailAddress, ReferralCode
FROM Contacts
WHERE ReferralCode <> ''
AND DateVerified BETWEEN ('#DateFormat(session.Dashboard_StartDate, 'mm/dd/yyyy')# 00:00:01')
AND ('#DateFormat(session.Dashboard_EndDate, 'mm/dd/yyyy')# 23:59:59')
</cfquery>

<cfset DR_referral_Emails = valueList(DR_AllReferrals.EmailAddress, "|")>
 
<cfset DR_total_VerbalInvitations = 0>
<cfset DR_total_invitations = DR_total_EmailInvitations>


<cfloop query="DR_AllReferrals">

<cfif NOT ListFind(DR_invitation_emails, DR_AllReferrals.EmailAddress, "|")>
	<cfset DR_total_VerbalInvitations = (DR_total_VerbalInvitations + 1)>
	<cfset DR_total_invitations = (DR_total_invitations + 1)>
</cfif>

</cfloop>


<cfset DR_total_successful_invitations = DR_AllReferrals.RecordCount>

<cfloop query="DR_AllInvites">

<cfif DR_AllInvites.InvitationStatus CONTAINS 'Successful' AND NOT ListFind(DR_referral_Emails, DR_AllInvites.InvitationToEmail, "|")>
	<cfset DR_total_successful_invitations = (DR_total_successful_invitations + 1)>
</cfif>

</cfloop>

<cfif DR_total_invitations gt 0>
<cfset DR_invite_success_rate = (DR_total_Successful_Invitations / DR_total_invitations * 100)>
<cfelse>
<cfset DR_invite_success_rate = (DR_total_Successful_Invitations / 1)>
</cfif>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>#Invitations#</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/invite-a-friend_sml.jpg" alt="Invitations" border="0"></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr bgcolor="d8d8d8">
	<td style="color:Black;font-size:11px;padding-left:5px;padding-top:4px;">#totalinvite#:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;padding-top:4px;" align="center" width="100">#total_invitations#</td>
	</tr>
	
	<tr bgcolor="d8d8d8" height="20">
	<td style="color:Black;font-size:11px;padding-left:5px;">#totalsuccess#:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#total_Successful_Invitations#</td>
	</tr>
	
	<tr bgcolor="d8d8d8" height="20">
	<td style="color:Black;font-size:11px;padding-left:5px;padding-bottom:4px;">#overallsucrate#:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;padding-bottom:4px;" align="center" width="100">#DecimalFormat(invite_success_rate)#%</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>	
	
		
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">#daterangeinvite#:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DR_total_invitations#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">#daterangesucc#:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DR_total_Successful_Invitations#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">#daterangesucrate#:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#DecimalFormat(DR_invite_success_rate)#%</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>

</cfoutput>