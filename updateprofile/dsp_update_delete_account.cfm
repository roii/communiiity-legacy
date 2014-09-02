<cfif IsDefined("SESSION.usertype") and SESSION.usertype eq 'Administrator'>

    <cfset adminIDArr = ListToArray(SESSION.userid, "999")>
    <cfset adminID = adminIDArr[1]> 
	<cfquery name="deleteAdminUserAcct" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE Administrator
		SET deleteAcct = 1
		WHERE AdministratorID = #adminID#
	</cfquery>

<cfelse>

	<cfquery name="deleteUserAcct" datasource="#dsn#" username="#request.username#" password="#request.password#">
		UPDATE Contacts
		SET deleteAcct = 1,
		    ContactStatus = 'InActive'
		WHERE ContactID = #SESSION.userid#  
	</cfquery>

</cfif> 

<cfoutput>

<cfset structclear(session)>

<cfset session.UserIsAuthenticated = 'no'>
<cfset session.ProgrammeSearchMode = 'basic'>
<cfset session.MemberSearchMode = 'basic'>
<cfset session.UserType = 'public'>
<cfset session.User_ContactTypeID = 0>
<cfset session.UserID = 0>
<cfset session.User_FirstName = ''>
<cfset session.User_LastName = ''>
<cfset session.User_Email = ''>
<cfset session.AdministratorID = 0>


<cflocation url="#request.webroot#/index.cfm?killcookies=yes">


</cfoutput>