<cfset session.User_SchoolID = schoolID>
<cfset session.User_SchoolName = SchoolName>
<cflocation url="#request.webroot#/index.cfm?fuseaction=school_dashboard">