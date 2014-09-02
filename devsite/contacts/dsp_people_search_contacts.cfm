<cfoutput>
<br>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td colspan="2" style="color:###TRIM(AllSettings.DkTextColor)#;"><strong>myCONTACTS</strong> (#ContactResults.recordcount#)</td>
<td colspan="2" align="right"><cfif IsDefined("ContactResults") AND ContactResults.RecordCount>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=10&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=20&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=50&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=ALL&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></cfif></td>
</tr>

<tr>
<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="4" height="1" bgcolor="###TRIM(AllSettings.DkTextColor)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="4" height="12"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="12" border="0"></td>
</tr>

<tr>
<td></td>
<td style="color:###TRIM(AllSettings.DkTextColor)#;padding-left:5px;">Name <span style="font-size:11px;">(ScreenName)</span></td>
<td style="color:###TRIM(AllSettings.DkTextColor)#;padding-left:5px;">Email / Mobile Phone</td>
<td></td>
</tr>

<tr>
<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr bgcolor="##b4b4b4">
<td height="1" width="20"><img src="#request.imageroot#/transparent_spc.gif" width="20" height="1" border="0"></td>
<td height="1" width="140"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1" border="0"></td>
<td height="1" width="100%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td height="1" width="140"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1" border="0"></td>
</tr>
	
<tr>
<td colspan="4" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>
	
<cfloop query="ContactResults" startrow="#session.contacts_StartRow#" endrow="#contacts_endrow#">

<cfset this_contactID=ContactResults.ContactID>
<cfset this_emailaddress = TRIM(ContactResults.EmailAddress)>

<cfset thiscontact_edit="0">
<cfset thiscontact_invite="0">

<!--- CHECK IF MEMBER --->
<cfquery name="CheckMember" dbtype="query">
SELECT AllowEdit, Categories
FROM AllLinks
WHERE ClientID=#this_contactID#	
</cfquery>

<cfif CheckMember.RecordCount>
	<cfset thiscontact_edit=CheckMember.AllowEdit>
	<cfset thiscategories="#CheckMember.Categories#">
<cfelse>
	<cfset thiscategories="0">	
</cfif>

<!--- CHECK IF REFERRED --->
<cfquery name="CheckReferral" dbtype="query">
SELECT ContactID
FROM All_Referrals
WHERE ContactID=#this_contactID#	
</cfquery>

<cfif CheckReferral.RecordCount>
	<cfset thiscontact_edit="0">
</cfif>			


<cfif IsDefined("All_Invites") AND All_Invites.RecordCount AND this_emailaddress NEQ ''>

	<!--- CHECK IF SUCCESSFULLY INVITED --->
	<cfquery name="CheckInvite" dbtype="query">
	SELECT InvitationID, InvitationStatus, Royalties_Earned, DateFirstSent, DateLastSent, InvitationToEmail, InvitationFrom, InvitationTo, InvitationTo_FirstName, InvitationTo_LastName
	FROM All_Invites
	WHERE InvitationToEmail = '#this_emailaddress#'
	AND InvitationToEmail <> ''
	AND InvitationStatus LIKE '%Successful%'
	</cfquery>	
	
	<cfif CheckInvite.RecordCount>
	
		<cfset thiscontact_invite="1">
		<cfset this_inviteid = CheckInvite.InvitationID>
		<cfset this_invitefirstsent = CheckInvite.DateFirstSent>
		<cfset this_invitelastsent = CheckInvite.DateLastSent>
		
		
		<!--- GET ALL POINTS EARNED BY INVITEE DURING RANGE --->
		<cfquery name="qry_all_transactions" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT SUM(Transaction_Amount) AS TotalEarned
		FROM contact_transactions
		WHERE ContactID=#this_contactID#
		AND Transaction_Type LIKE '%Credit%'
		AND Transaction_Account LIKE '%Points%'
		</cfquery>
		
		<!--- CALCULATE ONE TENTH --->
		<cfif IsNumeric("#qry_all_transactions.TotalEarned#") AND qry_all_transactions.TotalEarned NEQ 0>
			<cfset total_amount_percentage = Round(qry_all_transactions.TotalEarned \ 10)>	
		<cfelse>
			<cfset total_amount_percentage = 0>
		</cfif>	

	<cfelse>	
					
		<cfset thiscontact_invite="0">
		<cfset this_inviteid = "">
		<cfset this_invitefirstsent = "">
		<cfset this_invitelastsent = "">	
					
	</cfif>				
	
<cfelse>
					
	<cfset thiscontact_invite="0">
	<cfset this_inviteid = "">
	<cfset this_invitefirstsent = "">
	<cfset this_invitelastsent = "">	
				
</cfif>
	

<cfif IsNumeric("#ContactResults.CountryID#")>
	
	<cfquery name="CountryStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Name
	FROM Countries
	WHERE CountryID=#ContactResults.CountryID#
	</cfquery>
	
	<cfif CountryStuff.RecordCount>
		<cfset this_country = CountryStuff.Name>
	<cfelse>
		<cfset this_country = "">		
	</cfif>
	
<cfelse>

	<cfset this_country = "">
	
</cfif>

<tr>
<td align="center"><input type="checkbox" name="SelectContact" value="1" style="border:0px;"></td>
<td style="padding-left:5px;">	

	<table width="100%" cellpadding="1" cellspacing="0" border="0">
	
	<tr>
	<td width="30"><a href="#request.webroot#/contacts/dsp_contact_details_popup.cfm?contactID=#this_contactID#" target="ContactDetails" onclick="fdbackwindow=window.open ('','ContactDetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')"><cfif thiscontact_edit EQ 'Yes'><img src="#request.imageroot#/icons/people_grey_sml.gif" width="24" height="20" alt="Non-member - View Details" border="0" align="absmiddle"><cfelse><img src="#request.imageroot#/icons/people_sml.gif" width="24" height="20" alt="Member - View Profile" border="0" align="absmiddle"></cfif></a></td>
	<td><a href="#request.webroot#/contacts/dsp_contact_details_popup.cfm?contactID=#this_contactID#" target="ContactDetails" onclick="fdbackwindow=window.open ('','ContactDetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')">#TRIM(ContactResults.FirstName)# #TRIM(ContactResults.LastName)#</a><cfif TRIM(ContactResults.ScreenName) NEQ ''><br><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&member=#TRIM(ContactResults.ScreenName)#" title="View Profile" style="color:###TRIM(AllSettings.BoxColour)#;">(#TRIM(ContactResults.ScreenName)#)</a></cfif></td>
	</tr>
	
	</table>	

 </td>
<td style="padding-left:5px;">[e] <cfif TRIM(this_emailaddress) NEQ ''><a href="mailto:#TRIM(this_emailaddress)#" style="text-decoration:none;color:###TRIM(AllSettings.BoxColour)#" title="#TRIM(this_emailaddress)#">#MID(this_emailaddress, 1, 25)#</a><cfelse><span style="font-size:11px;"><cfif thiscontact_edit EQ 'Yes'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&EditContact=1&contactID=#this_ContactID#">Add email address</a><cfelse>No email address found</cfif></span></cfif><br>
[m] <cfif TRIM(ContactResults.MobilePhone) NEQ ''><a href="javascript:contactSMS(#TRIM(ContactResults.MobilePhone)#);" style="text-decoration:none;color:###TRIM(AllSettings.BoxColour)#" title="#TRIM(ContactResults.MobilePhone)#">#TRIM(ContactResults.MobilePhone)#</a><cfelse><span style="font-size:11px;"><cfif thiscontact_edit EQ 'Yes'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&documentID=#documentID#&EditContact=1&contactID=#this_ContactID#">Add mobile phone number</a><cfelse>No mobile phone found</cfif></span></cfif></td>
<td align="right" style="color:###TRIM(AllSettings.DkTextColor)#;"><cfif thiscontact_invite EQ 1><span style="color:###TRIM(AllSettings.BoxColour)#;"><cfif IsNumeric("#total_amount_percentage#") AND total_amount_percentage NEQ 0><strong>#total_amount_percentage#pts</strong><cfelse>0pts</cfif></span> earned so far<br>for inviting #TRIM(ContactResults.FirstName)#</cfif>

<cfif thiscontact_edit EQ 'Yes'>

	<select name="Action_#this_ContactID#" id="Action_#this_ContactID#" class="whitefield" onchange="javascript:ActionSelectChange(#this_ContactID#);">
	<option value="0">-- Select Action --
	<option value="Invite">- Invite to Join
	<option value="Edit">- Edit Contact
	<option value="Delete">- Remove Contact
	</select>
	
</cfif>
</td>
</tr>

<tr>
<td colspan="4" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td colspan="4" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</cfloop>

<tr>
<td colspan="4" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
</tr>
	
<tr>
<td colspan="4" align="right"><cfif session.contacts_Startrow GT session.contacts_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_Startrow=#prev#&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#;">Prev Page</a> | </cfif><cfif contacts_endrow LT ContactResults.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_Startrow=#next#&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#;">Next Page</a> &gt;</cfif><cfif session.contacts_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#contactsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.contacts_Maxrows*NumberCount-session.contacts_Maxrows+1)><cfif thisStartRow EQ session.contacts_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_Startrow=#thisStartRow#&documentID=#documentID#" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><cfif session.contacts_StartRow EQ NumberCount><strong></cfif>#NumberCount#<cfif session.contacts_StartRow EQ NumberCount></strong></cfif><cfif thisStartRow EQ session.contacts_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ contactsNumberCount> - </cfif></cfloop></cfif></td>
</tr>

<tr>
<td colspan="4" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

</table>

</cfoutput>