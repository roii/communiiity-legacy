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