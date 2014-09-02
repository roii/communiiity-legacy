<cfparam name="fusesubaction" default="index">
<cfparam name="attributes.fusesubaction" default="index">



<cfparam name="session.SearchField" default="Name">
<cfif IsDefined("SearchField")>
	<cfset session.SearchField = SearchField>
</cfif>


<cfparam name="session.contact_keywords" default="">
<cfif IsDefined("contact_keywords")>
	<cfset session.contact_keywords = contact_keywords>
</cfif>


<cfparam name="session.PeopleSearchFilter" default="ALL">
<cfif IsDefined("PeopleSearchFilter")>
	<cfset session.PeopleSearchFilter = PeopleSearchFilter>
</cfif>


<cfparam name="session.OrgCatID" default="ALL">
<cfif IsDefined("OrgCatID")>
	<cfset session.OrgCatID = OrgCatID>
</cfif>



<cfparam name="session.people_sortby" default="LastName">
<cfif isdefined("people_sortby")>	
	<cfset session.people_sortby = people_sortby>
</cfif>



<cfparam name="session.orgs_sortby" default="Organisation_Name">
<cfif isdefined("orgs_sortby")>	
	<cfset session.orgs_sortby = orgs_sortby>
</cfif>


<cfparam name="session.sortorder" default="ASC">
<cfif isdefined("sortorder")>	
	<cfset session.sortorder = sortorder>
</cfif>



<cfparam name="session.invitations_sortby" default="ScreenName">
<cfif isdefined("invitations_sortby")>	
	<cfset session.invitations_sortby = invitations_sortby>
</cfif>

<cfparam name="session.referrals_sortby" default="DateJoined">
<cfif isdefined("referrals_sortby")>	
	<cfset session.referrals_sortby = referrals_sortby>
</cfif>


<cfparam name="session.referrals_sortorder" default="ASC">
<cfif isdefined("sortorder")>	
	<cfset session.referrals_sortorder = referrals_sortorder>
</cfif>



<cfparam name="session.Contacts_StartRow" default="1">
<cfif isdefined("Contacts_StartRow")>	
	<cfset session.Contacts_StartRow = Contacts_StartRow>
</cfif>
	
	
<cfparam name="session.Contacts_MaxRows" default="50">
<cfif isdefined("Contacts_MaxRows")>	
	<cfset session.Contacts_MaxRows = Contacts_MaxRows>
</cfif>


<cfparam name="session.invitations_StartRow" default="1">
<cfif isdefined("invitations_StartRow")>	
	<cfset session.invitations_StartRow = invitations_StartRow>
</cfif>
	
	
<cfparam name="session.invitations_MaxRows" default="50">
<cfif isdefined("invitations_MaxRows")>	
	<cfset session.invitations_MaxRows = invitations_MaxRows>
</cfif>
	
	
<cfparam name="session.Invitations_Status" default="ALL">
<cfif isdefined("Invitations_Status")>	
	<cfset session.Invitations_Status = Invitations_Status>
</cfif>



<cfparam name="session.referrals_StartRow" default="1">
<cfif isdefined("referrals_StartRow")>	
	<cfset session.referrals_StartRow = referrals_StartRow>
</cfif>
	
	
<cfparam name="session.referrals_MaxRows" default="50">
<cfif isdefined("referrals_MaxRows")>	
	<cfset session.referrals_MaxRows = referrals_MaxRows>
</cfif>