<!---
This is the file that LinkedIn will call back to with the token. Make sure you update the path in the cfc to match your filename.
---> 		
<cfif structKeyExists(url, "oauth_token") and structKeyExists(url, "oauth_verifier")> 
		<cfset session.linkedin.oauth_verifier = url.oauth_verifier /> 
		
		<cfinvoke component="linkedIn" method="getAccessTokenInDetails" authToken="#url.oauth_token#" authVerifier="#url.oauth_verifier#" returnvariable="s" />
	
		LinkedIn Account verified. <!---<a href="getConnections.cfm">Click here to get your connections</a>--->
		 
		 <cftry>
		     <cfinvoke component="LinkedIn" method="getProfiles" authToken="#s.linkedInToken#" authTokenSecret="#s.linkedInTokenSecret#" identifier="~" returnvariable="results" /> 
			 <!---<cfset accountNum = #results.person.XmlAttributes.first-name.#>--->
		     <cfset idArray = xmlSearch(results,'/person/id')>
		     <cfset id = #idArray[1].XmlText#>
			 
			 <cfset firstNameArray = xmlSearch(results,'/person/first-name')>
		     <cfset firstName = #firstNameArray[1].XmlText#>
			 
			 <cfset lastNameArray = xmlSearch(results,'/person/last-name')>
		     <cfset lastName = #lastNameArray[1].XmlText#>
			 
			 <cfset headlineArray = xmlSearch(results,'/person/headline')>
		     <cfset headline = #headlineArray[1].XmlText#>
			 
			 <cfset publicProfileUrlArray = xmlSearch(results,'/person/public-profile-url')>
		     <cfset publicProfileUrl = #publicProfileUrlArray[1].XmlText#>
			 
			 <cfset emailArray = xmlSearch(results,'/person/email-address')>
		     <cfset email      = #emailArray[1].XmlText#>
			 
			  <cfset dateNow = now()>
			  <cfset dateNow = Replace(dateNow,"{ts '", '')>
			  <cfset dateNow = Replace(dateNow,"'}", '')>
			  
			  <cfset dataArr = ListToArray(dateNow, " ")>
			  
			  <cfset dateArr = ListToArray(dataArr[1], "-")>
			  <cfset timeArr = ListToArray(dataArr[2], ":")> 
			  
			  <cfset localDateTime = CreateDateTime (dateArr[1], dateArr[2], dateArr[3], timeArr[1], timeArr[2], timeArr[3])> 
			 
			 <cfset data = #id# & ',' & #firstName# & ',' & #lastName# & ',' & #headline# & ',' & #publicProfileUrl# & ',' & #email#>
			 <cfset ScreenName = #firstName# & ' ' & #lastName#> 
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
					WHERE EmailAddress = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(email))#">
					AND ContactStatus <> 'Deleted'
					AND ContactTypeID IN (1,2,4,6,7)
			 </cfquery>   
					
			 <cfif checkuseremail.recordcount> 
			         <cfquery name="getPasswords" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT *
						FROM Contacts
						WHERE EmailAddress ='#TRIM(email)#'
				     </cfquery>
					 
		             <cfquery name="Passwords" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT *
						FROM Contacts
						WHERE (LoginName ='#trim(email)#' OR EmailAddress ='#TRIM(email)#' OR ScreenName='#trim(ScreenName)#' OR MobilePhone='#trim(email)#')
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
					 
					 <script language="javascript">
						   window.opener.location.href = "/index.cfm";
						   window.close();
					 </script>
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
						<cfset password = "fhrfh778">
						
						<!--- INSERT CONTACT INFO --->
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
							LastName 
							)
							VALUES(
							<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#newid#">,
							1,
							'Active', 
							#CreateODBCDateTime(localDateTime)#,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(email))#">,
							'',
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
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#password#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#ScreenName#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#firstName#">,
							<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#lastName#"> 
							)
						</cfquery> 
					 </cftransaction>
					 
					 <cfquery name="Passwords" datasource="#dsn#" username="#request.username#" password="#request.password#">
						SELECT *
						FROM Contacts
						WHERE (LoginName ='#trim(email)#' OR EmailAddress ='#TRIM(email)#' OR ScreenName='#trim(ScreenName)#' OR MobilePhone='#trim(email)#')
						AND Password = '#trim(password)#'
						AND ContactStatus='Active'
				     </cfquery>	
					 
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
					 
					 <script language="javascript">
						   window.opener.location.href = "/index.cfm";
						   window.close();
					 </script>		  
			 </cfif> 
			   
			 
			 <!---<cfset strEncodedString = URLEncodedFormat(data)> 
			 
			 <script language="javascript">
			      window.opener.location.href = "/displaydata.cfm?cid=<cfoutput>#strEncodedString#</cfoutput>";
				  window.close();
			 </script>--->			 
			  
			<cfcatch type="Any">
				 <cfoutput>
				     #cfcatch.Message#
				 </cfoutput>
			</cfcatch>
		 </cftry> 
		   
<cfelse>
	This page cannot be invoked directly.
</cfif>
 