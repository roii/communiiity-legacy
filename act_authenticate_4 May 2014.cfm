<!--- SET DEFAULT PERMISSIONS --->
<cfquery name="AllPermissions" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT PermissionID
FROM Permissions
ORDER BY PermissionID
</cfquery>

<cfloop query="Allpermissions">
	<cfparam name="session.Permission#Allpermissions.PermissionID#_view" default="0">
	<cfparam name="session.Permission#Allpermissions.PermissionID#_add" default="0">
	<cfparam name="session.Permission#Allpermissions.PermissionID#_edit" default="0">
	<cfparam name="session.Permission#Allpermissions.PermissionID#_delete" default="0">
</cfloop>

<!--- CHECK IF THE LOGIN HAS BEEN SUBMITED AND TAKE NECESSARY ACTIONS TO AUTHENTICATE AND AUTHORISE --->
<cfif IsDefined("form.LoginName") AND IsDefined("form.Password") AND TRIM(form.Password) NEQ ''>

	<cfquery name="Passwords" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT *
	FROM Contacts
	WHERE (LoginName ='#trim(LoginName)#' OR EmailAddress ='#TRIM(LoginName)#' OR ScreenName='#trim(LoginName)#' OR MobilePhone='#trim(LoginName)#')
	AND Password = '#trim(password)#'
	AND ContactStatus='Active'
	</cfquery>
	
	<cfif Passwords.RecordCount>
		
		<cfif Passwords.ContactStatus NEQ 'active'>
			
			<cfoutput>
			<script type="text/javascript">
			alert("Sorry #passwords.FirstName#, your account is currently de-activated. Please contact #TRIM(AllSettings.SiteName)#.");
			</script>
			</cfoutput>
		
		<cfelse>
		
			<!--- User has been authenticated --->
			<cfset session.UserID = Passwords.ContactID>
			<cfset Session.UserIsAuthenticated = "Yes">
			<cfset Session.UserType = TRIM(Passwords.ContactType)>
			<cfset Session.User_ContactTypeID = TRIM(Passwords.ContactTypeID)>
			<cfset session.User_FirstName = TRIM(Passwords.FirstName)>
			<cfset session.User_LastName = TRIM(Passwords.LastName)>
			<cfset session.User_Email = TRIM(Passwords.EmailAddress)>
			<cfset session.User_CountryID = TRIM(Passwords.CountryID)>
			<cfset session.User_ScreenName = TRIM(Passwords.ScreenName)>
			<cfset session.User_SchoolID = passwords.SchoolID>
			<cfset session.User_Mobile = passwords.MobilePhone>
			 
			<!--- SET ROLES PERMISSIONS --->
			<cfif TRIM(passwords.Roles) NEQ ''>
			
				<cfloop list="#passwords.Roles#" index="thisRole" delimiters=",">
				
					<!--- SET USER PERMISSIONS --->
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
						
			<cfinclude template="act_user_points_balance.cfm">
						
			<!--- CAPTURE LOGIN IP ADDRESS --->
			<cfinclude template="act_login_ip.cfm">			
			
			<cfset userlist = "1,2,4">
			
			<!--- IF THEY ARE A MEMBER --->
			<cfif ListContains(userlist, session.User_ContactTypeID, ",")>
			
				<!--- CHECK IF FIRST LOGIN IN 24hrs --->
				<cfif IsDate("#Passwords.LastLogin#")>
				
					<cfif DateDiff('h', passwords.LastLogin, localDateTime) GT 24>
					
						<!--- UPDATE LOGIN DATE --->
						<cfquery name="UpdateLogin" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Contacts
						SET LastLogin=#CreateODBCDateTime(localDateTime)#
						WHERE ContactID=#Passwords.ContactID#
						</cfquery>						
						
						<!--- PROCESS LOGIN REWARDS --->
						<cfset this_activity = 1>
						<cfset this_contactID = passwords.contactID>
						<cfset this_relatedDescription = "Login">
						<cfset this_relatedID = "0">
												
						<cfinclude template="templates/act_activity_reward_payment.cfm">						
										
						<cfoutput>
									
							<script type="text/javascript">
							<!---alert("For your first login today you just earned #this_points# point<cfif this_points GT 1>s</cfif>!");--->
							self.location="#request.webroot#/index.cfm?fuseaction=Projects";
							</script>
											
						</cfoutput>					
					
					<cfelse>				
						
						<!--- UPDATE LOGIN DATE --->
						<cfquery name="UpdateLogin" datasource="#dsn#" username="#request.username#" password="#request.password#">
						UPDATE Contacts
						SET LastLogin=#CreateODBCDateTime(localDateTime)#
						WHERE ContactID=#Passwords.ContactID#
						</cfquery>
					
						<cflocation url="#request.webroot#/index.cfm?fuseaction=Projects" addtoken="no">
						
					</cfif>					
				
				<cfelse>
										
					<!--- UPDATE LOGIN DATE --->
					<cfquery name="UpdateLogin" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE Contacts
					SET LastLogin=#CreateODBCDateTime(localDateTime)#
					WHERE ContactID=#Passwords.ContactID#
					</cfquery>				
					
					<!--- PROCESS LOGIN REWARDS --->
					<cfset this_activity = 1>
					<cfset this_contactID = passwords.contactID>
					<cfset this_relatedDescription = "Login">
					<cfset this_relatedID = "0">
					
					<cfinclude template="templates/act_activity_reward_payment.cfm">					
									
					<cfoutput>					
						<script type="text/javascript">
						<!---alert("For your first login today you just earned #this_points# point<cfif this_points GT 1>s</cfif>!");--->
						self.location="#request.webroot#/index.cfm?fuseaction=Projects";
						</script>						
					</cfoutput>					
				
				</cfif>				
			
			<!--- IF THEY ARE A SCHOOL STAFF --->
			<cfelseif session.User_ContactTypeID EQ 6>
						
				<!--- GET SCHOOL NAME --->
				<cfquery name="SchoolStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT SchoolName
				FROM Schools
				WHERE SchoolID=#Passwords.SchoolID#
				</cfquery>
				
				<cfset session.User_SchoolID = passwords.SchoolID>
				<cfset session.User_SchoolName = TRIM(SchoolStuff.SchoolName)>
				
				<!--- UPDATE LOGIN DATE --->
				<cfquery name="UpdateLogin" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Contacts
				SET LastLogin=#CreateODBCDateTime(localDateTime)#
				WHERE ContactID=#Passwords.ContactID#
				</cfquery>
			
				<cflocation url="#request.webroot#/index.cfm?fuseaction=school_dashboard">				
				
			<!--- IF THEY ARE A PARTNER STAFF --->
			<cfelseif session.User_ContactTypeID EQ 7>
			
				<!--- GET SCHOOL NAME --->
				<cfquery name="PartnerStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
				SELECT OrganisationID, Organisation_Name
				FROM Organisations
				WHERE OrganisationID=#Passwords.OrganisationID#
				</cfquery>
				
				<cfset session.User_OrganisationID = PartnerStuff.OrganisationID>
				<cfset session.User_Organisation_Name = TRIM(PartnerStuff.Organisation_Name)>
				
				<!--- UPDATE LOGIN DATE --->
				<cfquery name="UpdateLogin" datasource="#dsn#" username="#request.username#" password="#request.password#">
				UPDATE Contacts
				SET LastLogin=#CreateODBCDateTime(localDateTime)#
				WHERE ContactID=#Passwords.ContactID#
				</cfquery>
							
				<cflocation url="#request.webroot#/index.cfm?fuseaction=partner_dash">		
							
			</cfif>
			
		</cfif>
		
	<!--- NOT A MEMBER --->
	<cfelse>			
		
		<!--- CHECK IF SITE ADMINISTRATOR --->		
		<cfquery name="AdminPasswords" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT *
		FROM Administrator
		WHERE EmailAddress = '#trim(LoginName)#'
		AND password = '#trim(password)#'
		</cfquery>	
	
		<cfif AdminPasswords.RecordCount>
			
			<!--- User has been authenticated --->
			<cfset Session.UserIsAuthenticated = "Yes">
			<cfset Session.UserType = "Administrator">
			<cfset Session.User_ScreenName = "SiteAdmin">
			<cfset Session.User_ContactTypeID = 99999>
			<cfset session.AdministratorID = AdminPasswords.AdministratorID>
			<cfset session.UserID = "999#AdminPasswords.AdministratorID#">
			<cfset session.User_FirstName = AdminPasswords.FirstName>
			<cfset session.User_LastName = AdminPasswords.LastName>
			<cfset session.User_Email = AdminPasswords.EmailAddress>
			<cfset session.User_CountryID = 0>
			<cfset session.User_SchoolID = 0>
			<cfset session.User_Mobile = "">
			
			<cfset user_points = 0>			

			<cfloop query="Allpermissions">
				<cfset "session.Permission#Allpermissions.PermissionID#_view" = 1>
			</cfloop>				
				
			<cflocation url="#request.webroot#/index.cfm?fuseaction=Projects" addtoken="no">
			
		<cfelse>		
		
			<script type="text/javascript">
			alert("Sorry, your login was unsuccessful.");
			history.back(-1);
			</script>
					
		</cfif>		
	
	</cfif>	
	
</cfif>