<cfoutput>

<script language="JavaScript">
<!--
function confirmInvitationDelete(aURL) {
    if(confirm('Are you sure you want to delete this Invitation?')) {
      location.href = aURL;
    }
  }
//-->
</script>


<!--- IF THIS IS THE PAGE AFTER THE CONTACTS IMPORT --->
<cfif isDefined("InviteMode") AND Invitemode EQ "Contacts" AND IsDefined("InviteList")>
	<cfinclude template="dsp_invite_contacts.cfm">
	

<cfelseif isDefined("InviteMode") AND Invitemode EQ "SendConfirm">
	<cfinclude template="dsp_send_confirm.cfm">
		
	
<cfelse>

	<!--- CHECK IF PARENT HAS BEEN INVITED
	<cfquery name="qry_parent_check" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM ParentInvites
	WHERE ContactID=#session.UserID#
	AND (Status LIKE '%Pending%' OR Status LIKE '%Activation%')
	</cfquery> --->
	
	<cfquery name="qry_pending_invitations" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Invitations
	WHERE Invitations.InvitationFrom=#session.UserID#
	AND InvitationStatus LIKE '%Pending%'
	</cfquery>
	
	
	<cfquery name="qry_successful_referrals" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Contacts
	WHERE ReferralCode LIKE '%#session.User_ScreenName#%'
	ORDER BY #session.referrals_sortby# #session.referrals_sortorder#
	</cfquery>
	
	
	
	<!--- SET THE invitations_endrow VALUE --->
	<cfif session.invitations_MaxRows NEQ 'ALL'>
	
		<cfif qry_pending_invitations.RecordCount GT (session.invitations_StartRow+session.invitations_MaxRows)-1>
			<cfset invitations_endrow = session.invitations_StartRow+session.invitations_MaxRows-1>
		<cfelse>
			<cfset invitations_endrow = qry_pending_invitations.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset invitations_endrow = qry_pending_invitations.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.invitations_Startrow GT session.invitations_Maxrows>
		<cfset prev = session.invitations_Startrow - session.invitations_Maxrows>
	
	<cfelse>
		<cfset prev = session.invitations_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif invitations_endrow LT qry_pending_invitations.RecordCount>
		<cfset next = (invitations_endrow+1)>
	
	<cfelse>
		<cfset next = session.invitations_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.invitations_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(qry_pending_invitations.RecordCount / session.invitations_Maxrows)>
		<cfset invitationsNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset invitationsNumberCount=1>
		
	</cfif>
		
	
	<cfset total_referrals = (qry_pending_invitations.recordcount + qry_successful_referrals.recordcount)>
	
	
	<!--- SET THE SUCCESS PERCENTAGE --->
	<cftry>
		<cfset success_percent = (qry_successful_referrals.RecordCount / total_referrals * 100)>	
	<cfcatch>
		<cfset success_percent = 0>	
	</cfcatch>
	</cftry>
	
	 
	<span style="color:###TRIM(AllSettings.DkTextColor)#;">Total Invitations: <strong>#total_referrals#</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Successful Invitations: <strong>#qry_successful_referrals.RecordCount#</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Success Rate: <strong>#DecimalFormat(success_percent)#%</strong></span><br><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"><br>
	
	
	
	
	
	
	<!--- <cfif qry_parent_check.recordcount GT 0 AND qry_parent_check.Status EQ 'Activated'>
	
	<cfelse>
		<cfinclude template="dsp_invite_parents.cfm">
	</cfif> --->
	<cfif session.userID EQ 1>
	
	<br>
	<table align="center" cellpadding="10" cellspacing="0" style="border:dashed 1px ###TRIM(AllSettings.DkTextColor)#;">
	<tr>
	<td style="color:##000000;"><strong>Easily import and invite your contacts from the following online services...</strong>
	<hr width="100%" size="1" color="##000000">
	
	<a href="#request.webroot#/contacts/import/import.php" target="InviteContacts" onclick="fdbackwindow=window.open ('','InviteContacts','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=730,height=500,top=10,left=10')"><img src="#request.imageroot#/contacts/invite_contacts.gif" width="518" height="50" alt="Invite your contacts from Hotmail, Yahoo, AOL, GMail, MSN" border="0"></a></td>
	</tr>
	
	</table><br><br>
	
	</cfif>
	
	<table width="100%" cellpadding="0" cellspacing="1" border="0">
	
	<tr bgcolor="###AllSettings.DkBoxColour#" height="25">
	<td colspan="3">
	
	
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;"><strong>my PENDING INVITATIONS</strong></td>
		<td align="right">
		
			
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td style="font-size:11px;color:white;"><strong>#qry_pending_invitations.RecordCount#</strong> pending invitations. <cfif qry_pending_invitations.RecordCount>&nbsp; Displaying <strong>#session.invitations_StartRow#</strong> - <strong>#Invitations_Endrow#</strong></cfif></td>
			<td align="right" style="font-size:11px;color:white;"><cfif qry_pending_invitations.RecordCount>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&invitations_MaxRows=10&invitations_StartRow=1" style="color:white;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&invitations_MaxRows=20&invitations_StartRow=1" style="color:white;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&invitations_MaxRows=50&invitations_StartRow=1" style="color:white;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&invitations_MaxRows=ALL&invitations_StartRow=1" style="color:white;">ALL</a></cfif>&nbsp;&nbsp;</td>
			</tr>
			
			</table>	
		
		
		</td>
		</tr>
		
		</table>
	
	
	
	</td>
	</tr>
	
	
	<tr bgcolor="##e2e2e2" height="18">
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&invitations_sortby=DateLastSent&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#" style="color:###TRIM(AllSettings.DkTextColor)#;">Date Sent </a></td>
	<td align="left"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&invitations_sortby=InvitationToEmail&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#" style="color:###TRIM(AllSettings.DkTextColor)#;padding-left:10px;">Email Address</a></td>
	<td></td>
	</tr>
	
	<tr>
	<td width="80" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="4" border="0"></td>
	<td width="100%" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="4" border="0"></td>
	<td width="140" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="4" border="0"></td>
	</tr>
	
	
	<cfloop query="qry_pending_invitations" startrow="#session.Invitations_StartRow#" endrow="#Invitations_endrow#">
	
	<tr>
	<td align="center" valign="top">#DateFormat(qry_pending_invitations.DateLastSent)#</td>
	<td align="left" valign="top"><a href="mailto:#TRIM(qry_pending_invitations.InvitationToEmail)#" style="color:###TRIM(AllSettings.BoxColour)#;">#TRIM(qry_pending_invitations.InvitationToEmail)#</a></td>
	<td align="center" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=docs&documentID=53&type=resend&InvitationID=#qry_pending_invitations.InvitationID#"><img src="#request.imageroot#/resend_button.gif" alt="Resend this invitation" border="0"></a> <a href="javascript:confirmInvitationDelete('#request.webroot#/contacts/act_delete_invite.cfm?InvitationID=#qry_pending_invitations.InvitationID#')"><img src="#request.imageroot#/delete_button.gif" alt="Delete this invitation" border="0"></a></td>
	</tr>
		
	<tr>
	<td colspan="3" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	
	<tr>
	<td colspan="3" style="font-size:11px;">
	<cfif session.Invitations_Startrow GT session.Invitations_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Invitations_Startrow=#prev#">Prev Page</a> | </cfif><cfif Invitations_endrow LT qry_pending_invitations.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Invitations_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Invitations_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#InvitationsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Invitations_Maxrows*NumberCount-session.Invitations_Maxrows+1)><cfif thisStartRow EQ session.Invitations_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Invitations_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Invitations_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ InvitationsNumberCount> - </cfif></cfloop></cfif></td>
	</tr>
	
	</table><br><br>
	
	
	
	
	
	<cfif qry_successful_referrals.recordcount>
	
	
		<!--- SET THE referrals_endrow VALUE --->
		<cfif session.referrals_MaxRows NEQ 'ALL'>
		
			<cfif qry_successful_referrals.RecordCount GT (session.referrals_StartRow+session.referrals_MaxRows)-1>
				<cfset referrals_endrow = session.referrals_StartRow+session.referrals_MaxRows-1>
			<cfelse>
				<cfset referrals_endrow = qry_successful_referrals.RecordCount>
			</cfif>
		
		<cfelse>
			<cfset referrals_endrow = qry_successful_referrals.RecordCount>
		
		</cfif>
		
		
		
		<!--- SET THE PREV VALUE --->
		<cfif session.referrals_Startrow GT session.referrals_Maxrows>
			<cfset prev = session.referrals_Startrow-session.referrals_Maxrows>
		
		<cfelse>
			<cfset prev = session.referrals_StartRow>
		
		</cfif>
		
		
		
		<!--- SET THE NEXT VALUE --->
		<cfif referrals_endrow LT qry_successful_referrals.RecordCount>
			<cfset next = (referrals_endrow+1)>
		
		<cfelse>
			<cfset next = session.referrals_StartRow>
		
		</cfif>
		
		
		
		<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
		<cfif session.referrals_MaxRows NEQ 'ALL'>
		
			<cfset NumberCount=(qry_successful_referrals.RecordCount/session.referrals_Maxrows)>
			<cfset referralsNumberCount=Ceiling(NumberCount)>
		
		<cfelse>
		
			<cfset referralsNumberCount=1>
			
		</cfif>
		
		
		
		
		
		<table width="100%" cellpadding="0" cellspacing="1" border="0">
		
		<tr bgcolor="###AllSettings.DkBoxColour#" height="25">
		<td colspan="4">
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;"><strong>my SUCCESSFUL INVITATIONS</strong></td>
			<td align="right">
			
				
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
				
				<tr>
				<td style="font-size:11px;color:white;"><strong>#qry_successful_referrals.RecordCount#</strong> successful Referrals. <cfif qry_successful_referrals.RecordCount>&nbsp; Displaying <strong>#session.Referrals_StartRow#</strong> - <strong>#Referrals_Endrow#</strong></cfif></td>
				<td align="right" style="font-size:11px;color:white;"><cfif qry_successful_referrals.RecordCount>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Referrals_MaxRows=10&Referrals_StartRow=1" style="color:white;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Referrals_MaxRows=20&Referrals_StartRow=1" style="color:white;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Referrals_MaxRows=50&Referrals_StartRow=1" style="color:white;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Referrals_MaxRows=ALL&Referrals_StartRow=1" style="color:white;">ALL</a></cfif>&nbsp;&nbsp;</td>
				</tr>
				
				</table>	
			
			
			</td>
			</tr>
			
			</table>
		
		
		
		</td>
		</tr>
		
		<tr bgcolor="##e2e2e2" height="18">
		<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&referrals_sortby=DateLastSent&referrals_sortorder=<cfif session.referrals_sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#" style="color:###TRIM(AllSettings.DkTextColor)#;">Date Joined</a></td>
		<td align="left"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&invitations_sortby=FirstName&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#" style="color:###TRIM(AllSettings.DkTextColor)#;padding-left:10px;">Name</a></td>
		<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&invitations_sortby=ScreenName&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#" style="color:###TRIM(AllSettings.DkTextColor)#;">Screen Name</a></td>
		<td style="color:###TRIM(AllSettings.DkTextColor)#;" align="center">Activity Bonus</td>
		</tr>
		
		<tr>
		<td width="80" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="80" height="4" border="0"></td>
		<td width="100%" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="50" height="4" border="0"></td>
		<td width="140" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="4" border="0"></td>
		<td width="150" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="150" height="4" border="0"></td>
		</tr>
		
		
		<cfloop query="qry_successful_referrals" startrow="#session.Referrals_StartRow#" endrow="#Referrals_endrow#">
		
		<cfset this_contactID = qry_successful_referrals.ContactID>
		
		<!--- LOOK FOR INVITATION RECORD --->
		<cfquery name="qry_invitation_details" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Invitations
		WHERE InvitationFrom=#session.UserID#
		AND InvitationTo=#this_contactID#
		</cfquery>
		
		<cfif qry_invitation_details.RecordCount>
			<cfset royalties_earned = qry_invitation_details.Royalties_Earned>
		<cfelse>
			<cfset royalties_earned = 0>
		</cfif>
		
		<tr>
		<td align="center" valign="top">#DateFormat(qry_successful_referrals.DateJoined)#</td>
		<td align="left" style="padding-left:10px;" valign="top">#TRIM(qry_successful_referrals.FirstName)# #TRIM(qry_successful_referrals.LastName)#<br>
		<span style="font-size:10px;"><a href="mailto:#TRIM(qry_successful_referrals.EmailAddress)#" style="color:###TRIM(AllSettings.BoxColour)#;">#TRIM(qry_successful_referrals.EmailAddress)#</a></span></td>
		<td align="center" style="padding-left:10px;" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_ContactID#" title="View Profile">#TRIM(qry_successful_referrals.ScreenName)#</a></td>
		<td align="center" valign="top">I've earned: <strong>#royalties_earned#  pts</strong><br>
		<span style="font-size:10px;">(Maximum possible: 3000pts)</span>
		</td>
		</tr>
			
		<tr>
		<td colspan="4" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="4" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
		</tr>
		
		</cfloop>
	
	
		<tr>
		<td colspan="4" style="font-size:11px;">
		<cfif session.Referrals_Startrow GT session.Referrals_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Referrals_Startrow=#prev#">Prev Page</a> | </cfif><cfif Referrals_endrow LT qry_successful_referrals.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Referrals_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Referrals_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#ReferralsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Referrals_Maxrows*NumberCount-session.Referrals_Maxrows+1)><cfif thisStartRow EQ session.Referrals_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&documentID=#documentID#&Referrals_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Referrals_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ ReferralsNumberCount> - </cfif></cfloop></cfif></td>
		</tr>
		
		</table>
	
	
	</cfif>
	
</cfif>


</cfoutput>