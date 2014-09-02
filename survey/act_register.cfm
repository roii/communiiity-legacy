
<!--- CHECK FOR CURRENT ENTRY --->
<cfquery name="CheckCurrent" datasource="#dsn#" maxrows="1">
SELECT UserID
FROM NewQuestionairre_Responders
WHERE Email='#form.Email#'
</cfquery>


<cfif CheckCurrent.RecordCount>

	<cfset session.Questionairre_UserID=CheckCurrent.UserID>

	<!--- UPDATE DETAILS --->
	<cfquery name="updateUser" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	UPDATE NewQuestionairre_Responders
	SET Title='#form.Title#',
	FirstName='#form.FirstName#',
	Surname='#form.Surname#',
	Email='#form.Email#',
	RoleID=#form.RoleID#,
	BusinessTitle='#form.BusinessTitle#',
	Organisation='#form.Organisation#',
	OrganisationTypeID=#form.OrgTypeID#,
	HealthcareProvider=#form.HealthcareProvider#,
	OKToContact=#form.OKToContact#,
	RecordLastUpdated=#CreateODBCDateTime(localDateTime)#
	WHERE UserID=#CheckCurrent.UserID#
	</cfquery>
	
	

<cfelse>

	<!--- GENERATE NEW ID --->
	<cfquery name="LastID" datasource="#dsn#" maxrows="1">
	SELECT UserID
	FROM NewQuestionairre_Responders
	ORDER BY UserID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastID.UserID + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>
	
	
	<cfset session.Questionairre_UserID=newid>
	
	
	<!--- INSERT DOC INFO --->
	<cfquery name="AddUser" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	INSERT INTO NewQuestionairre_Responders(
	UserID,
	Title,
	FirstName,
	Surname,
	Email,
	RoleID,
	BusinessTitle,
	Organisation,
	OrganisationTypeID,
	HealthcareProvider,
	OKToContact,
	RecordLastUpdated
	)
	VALUES(
	#newid#,
	'#form.Title#',
	'#form.FirstName#',
	'#form.Surname#',
	'#form.Email#',
	#form.RoleID#,
	'#form.BusinessTitle#',
	'#form.Organisation#',
	#form.OrgTypeID#,
	#form.HealthcareProvider#,
	#form.OKToContact#,
	#CreateODBCDateTime(localDateTime)#
	)
	</cfquery>



</cfif>




<cflocation url="#request.webroot#/index.cfm?fuseaction=survey">