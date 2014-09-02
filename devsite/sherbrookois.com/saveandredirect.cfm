<!--- CREATE VERIFICATION CODE ---> 
				<cfset verificationcode = "">	
				<cfset numoptions = "0123456789">	
				<cfloop index="loopcount" from="1" to="9">
					<cfset randomnumber = randrange(1,10)>
					<cfset verificationcode = (verificationcode & mid(numoptions,randomnumber,1))>
				</cfloop> 
			 
			 <cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
					SELECT ContactID
					FROM Contacts
					WHERE EmailAddress = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(FORM.email))#">
					AND ContactStatus <> 'Deleted'
					AND ContactTypeID IN (1,2,4,6,7)
			 </cfquery>  
					
			 <cfif checkuseremail.recordcount>  
			         <cfquery name="getPasswords" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT *
						FROM Contacts
						WHERE EmailAddress ='#TRIM(FORM.email)#'
				     </cfquery>
					 
		             <cfquery name="Passwords" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT *
						FROM Contacts
						WHERE (LoginName ='#trim(FORM.email)#' OR EmailAddress ='#TRIM(FORM.email)#' OR ScreenName='#trim(FORM.ScreenName)#' OR MobilePhone='#trim(FORM.email)#')
						AND Password = '#trim(getPasswords.password)#'
						AND ContactStatus='Active'
				     </cfquery>	
					 
					    <!--- User has been authenticated --->
						<cfset session.UserID = Passwords.ContactID>
						<cfset Session.UserIsAuthenticated = "Yes">
						<cfset Session.UserType = TRIM(Passwords.ContactType)>
						<cfset Session.User_ContactTypeID = TRIM(Passwords.ContactTypeID)>
						<cfset session.User_FirstName = TRIM(Passwords.FirstName)>
						<cfset session.User_LastName = TRIM(Passwords.LastName)>
						<cfset session.User_FullName = TRIM(Passwords.FirstName) & ' ' & TRIM(Passwords.LastName)>
						<cfset session.pictureUrl = TRIM(FORM.pictureUrl)>
						<cfset session.User_Email = TRIM(Passwords.EmailAddress)>
						<cfset session.User_CountryID = TRIM(Passwords.CountryID)>
						<cfset session.User_ScreenName = TRIM(Passwords.ScreenName)>
						<cfset session.User_SchoolID = passwords.SchoolID>
						<cfset session.User_Mobile = passwords.MobilePhone>
						 
						 <!---SET ROLES PERMISSIONS --->
						<cfif TRIM(passwords.Roles) NEQ ''>
						
							<cfloop list="#passwords.Roles#" index="thisRole" delimiters=",">
							
								 <!---SET USER PERMISSIONS --->
								<cfquery name="Userpermissions" datasource="#dsn#" username="#request.username#" password="#request.password#">
								SELECT *
								FROM RolePermissions
								WHERE RoleID=#thisRole#
								</cfquery>			
							
								<cfloop query="Userpermissions">
									<cfif Userpermissions.AllowView EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_view" = 1>
									</cfif>
									<cfif Userpermissions.AllowAdd EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_add" = 1>
									</cfif>
									<cfif Userpermissions.AllowEdit EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_edit" = 1>
									</cfif>
									<cfif Userpermissions.AllowDelete EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_delete" = 1>
									</cfif>
								</cfloop>		
							
							</cfloop>
							
						</cfif>
					 
					<cflocation url="/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92" addtoken="no">
			 <cfelse>   
					 <cftransaction action="BEGIN"> 
						<!--- GENERATE NEW CONTACT ID --->
						<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
							SELECT ContactID
							FROM contacts
							ORDER BY ContactID DESC
						</cfquery>
						
						<cfif lastid.recordcount>
							<cfset newid = (lastid.contactid + 1)>
						<cfelse>
							<cfset newid = 1>
						</cfif>
						<cfparam name="form.AcceptTerms" default="0" />  
						<cfset password = #FORM.password#>
						<cfset ScreenName1 = #FORM.firstName# & ' ' & #FORM.lastName#> 
						 
						<!--- INSERT CONTACT INFO---> 
						<cfquery name="AddContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
							INSERT INTO Contacts(
							ContactID,
							ContactTypeID,
							ContactStatus,
							DateJoined,
							EmailAddress,
							MobilePhone,
							CountryID,
							OrganisationID,
							ParentConfirmed,
							RegionID,
							DistrictID,
							SuburbID,
							EmailConfirmed,
							ProfilePermission1,
							ProfilePermission2,
							ProfilePermission3,
							ProfilePermission4,
							ProfilePermission5,
							receiveEmail,
							SchoolID,
							Charity,
							PromoID,
							VerificationCode,
							AcceptTerms,
							password,
							ScreenName,
							FirstName,
							LastName,
							linkedinprofilepic,
							linkedinuser 
							)
							VALUES(
							<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#newid#">,
							1,
							'Active', 
							<cfqueryparam cfsqltype="cf_sql_timestamp" value="#CreateODBCDateTime(localDateTime)#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(FORM.email))#">,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							0,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#verificationcode#">,
							<cfqueryparam cfsqltype="CF_SQL_BIT" value="1">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.password#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ScreenName1#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.firstName#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.lastName#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#FORM.pictureUrl#">,
							1 
							)
						</cfquery> 
					 </cftransaction>
					  
					 
					 <cfquery name="Passwords" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT *
						FROM Contacts
						WHERE (LoginName ='#trim(FORM.email)#' OR EmailAddress ='#TRIM(FORM.email)#')
						AND Password = '#trim(FORM.password)#'
						AND ContactStatus='Active'
				     </cfquery>	
					 
					   <!---  User has been authenticated --->
						<cfset session.UserID = Passwords.ContactID>
						<cfset Session.UserIsAuthenticated = "Yes">
						<cfset Session.UserType = TRIM(Passwords.ContactType)>
						<cfset Session.User_ContactTypeID = TRIM(Passwords.ContactTypeID)>
						<cfset session.User_FirstName = TRIM(Passwords.FirstName)>
						<cfset session.User_LastName = TRIM(Passwords.LastName)>
						<cfset session.User_FullName = TRIM(Passwords.FirstName) & ' ' & TRIM(Passwords.LastName)>
						<cfset session.pictureUrl = TRIM(FORM.pictureUrl)>
						<cfset session.User_Email = TRIM(Passwords.EmailAddress)>
						<cfset session.User_CountryID = TRIM(Passwords.CountryID)>
						<cfset session.User_ScreenName = TRIM(Passwords.ScreenName)>
						<cfset session.User_SchoolID = passwords.SchoolID>
						<cfset session.User_Mobile = passwords.MobilePhone>
						 
						 <!---SET ROLES PERMISSIONS  ---->
						<cfif TRIM(passwords.Roles) NEQ ''>
						
							<cfloop list="#passwords.Roles#" index="thisRole" delimiters=",">
							
								<!---- SET USER PERMISSIONS ---->
								<cfquery name="Userpermissions" datasource="#dsn#" username="#request.username#" password="#request.password#">
								SELECT *
								FROM RolePermissions
								WHERE RoleID=#thisRole#
								</cfquery>			
							
								<cfloop query="Userpermissions">
									<cfif Userpermissions.AllowView EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_view" = 1>
									</cfif>
									<cfif Userpermissions.AllowAdd EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_add" = 1>
									</cfif>
									<cfif Userpermissions.AllowEdit EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_edit" = 1>
									</cfif>
									<cfif Userpermissions.AllowDelete EQ 1>
										<cfset "session.Permission#Userpermissions.PermissionID#_delete" = 1>
									</cfif>
								</cfloop>		
							
							</cfloop>
							
						</cfif>
					 
					<cflocation url="/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92" addtoken="no">		  
			 </cfif>