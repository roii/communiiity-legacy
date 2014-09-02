<cfset ContactID_List = "0">	

<cfquery name="AllLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ClientID, AllowEdit, Categories
FROM KidClientLinks
WHERE KidClientLinks.KidID=#session.UserID#
</cfquery>

<cfif AllLinks.RecordCount>
	<cfset ContactID_List = ContactID_List & valueList(AllLinks.ClientID, ",")>
</cfif>	

<cfquery name="All_Referrals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ContactStatus, DateJoined, DateVerified
FROM Contacts
WHERE ReferralCode LIKE '%#session.User_ScreenName#%'
AND ReferralCode <> ''
</cfquery>

<cfif All_Referrals.RecordCount>
	<cfset ContactID_List = ContactID_List & valueList(All_Referrals.ContactID, ",")>
</cfif>

<cfquery name="All_Invites" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT InvitationID, InvitationToEmail, InvitationTo, InvitationStatus, Royalties_Earned, DateFirstSent, DateLastSent, DateResponded, InvitationFrom, InvitationTo_FirstName, InvitationTo_LastName
FROM Invitations
WHERE InvitationFrom = #session.UserID#
</cfquery>

<cfset ContactID_List = ContactID_List & "999999999">	

<cfif session.PeopleSearchFilter CONTAINS 'ALL' OR session.PeopleSearchFilter CONTAINS 'Pending'>
	
	<cfquery name="PendingResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT InvitationID, InvitationToEmail, InvitationTo, InvitationStatus, Royalties_Earned, DateFirstSent, DateLastSent, DateResponded, InvitationFrom, InvitationTo_FirstName, InvitationTo_LastName
	FROM Invitations
	WHERE InvitationFrom = #session.UserID#
	AND InvitationStatus LIKE '%Pending%'
	</cfquery>

</cfif>	

<cfif session.PeopleSearchFilter DOES NOT CONTAIN 'Pending'>
	
		
	<cfquery name="ContactResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, FirstName, LastName, Address1, Address2, Address3, City, CountryID, EmailAddress, LoginName, Password, WorkPhone, HomePhone, MobilePhone, City, ScreenName, ReferralCode
	FROM Contacts
	WHERE (ContactID IN (#ContactID_List#)
	
	<cfif All_Invites.RecordCount AND All_Invites.RecordCount>
		OR <cfloop query="All_Invites"><cfif TRIM(All_Invites.InvitationToEmail) NEQ ''>(EmailAddress LIKE '#All_Invites.InvitationToEmail#')<cfif All_Invites.CurrentRow NEQ All_Invites.RecordCount> OR</cfif></cfif></cfloop>
	</cfif>	
	)
	
	<cfif session.contact_keywords NEQ ''>
		
		<cfif session.searchfield EQ 'FirstName'>
			AND FirstName LIKE '%#session.contact_keywords#%'
		<cfelseif session.searchfield EQ 'LastName'>
			AND LastName LIKE '%#session.contact_keywords#%'
		<cfelseif session.searchfield EQ 'ScreenName'>
			AND ScreenName LIKE '%#session.contact_keywords#%'
		<cfelseif session.searchfield EQ 'City'>
			AND City LIKE '%#session.contact_keywords#%'
		</cfif>
		
	</cfif>
	
	<cfif session.PeopleSearchFilter CONTAINS 'Members'>
		AND ContactTypeID IN (1,2,4,6,7)
	<cfelseif session.PeopleSearchFilter CONTAINS 'NonMember'>
		AND ContactTypeID IN (3)
	<cfelseif session.PeopleSearchFilter CONTAINS 'Success'>
		AND ContactStatus = 'Active'
		AND ReferralCode LIKE '%#session.User_ScreenName#%'
	</cfif>
	
	ORDER BY Firstname, LastName
	</cfquery>
	
</cfif>