<!--- 

	DJP - 07Oct11 - removed empty cfquery that was causing an error in production.
	
 --->



<!--- CHECK AVAILABILITY OF LOGIN_NAME --->
<cfquery name="CheckUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE ScreenName LIKE '%#TRIM(form.ScreenName)#%'
</cfquery>

<cfif CheckUser.RecordCount>
	<script type="text/javascript">
	alert("The Screen Name you entered is already in use. Please select another Screen Name.");
	history.back(-1);
	</script>
	<cfabort>	
</cfif>

<!--- <cfset birthday= '1' & ' ' & '#form.DOB_Month#' & ' ' & '#DOB_Year#'> --->

<!--- DETERMINE CONTACT TYPE FROM AGE --->
<!--- <cfset age = datediff('yyyy', birthday, localDateTime)> --->

<!--- <cfif age GTE 20>
	<cfset contactTypeID=2>
<cfelse>
	<cfset contactTypeID=1>
</cfif> --->

<cfset contactTypeID = 2>



<cftransaction action="BEGIN" isolation="READ_COMMITTED">

<cftry>

	<!--- UPDATE CONTACT INFO --->
	<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
	UPDATE Contacts
	SET ContactTypeID=#contactTypeID#,
	ContactStatus='Active',
	ParentConfirmed=0,
	FirstName='#TRIM(form.FirstName)#',
	LastName='#TRIM(form.LastName)#',
	CountryID=#form.countryID#,
	ScreenName='#TRIM(form.ScreenName)#',
	Password='#TRIM(form.Password)#',
	<!--- DateOfBirth=#CreateODBCDate(Birthday)#, --->
	
	<!--- <cfif IsDefined("form.ParentEmail")>
		ParentsName='#TRIM(form.ParentName)#',
		ParentsEmail='#TRIM(form.ParentEmail)#',
	</cfif> --->
	
	Address1='',
	AcceptTerms='#form.AcceptTerms#',
	DateVerified=#createODBCDateTime(localdatetime)#
	WHERE ContactID=#form.ContactID#
	</cfquery>
	
	<cftransaction action="commit" />

<cfcatch>

	<cftransaction action="rollback" />
	
</cfcatch>

</cftry>

</cftransaction>

<!--- ADD ROLE --->

<cfquery name="CreateContactRole" datasource="#dsn#" username="#request.username#" password="#request.password#">
INSERT INTO ContactRoles(ContactID,RoleID)
VALUES(#form.ContactID#, 4)
</cfquery>

 <cfquery name="NewMemberStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
 SELECT *
 FROM Contacts
 WHERE ContactID=#form.ContactID#
 </cfquery>
 
<!--- LOG THEM IN --->
<cfset session.UserID = NewMemberStuff.ContactID>
<cfset Session.UserType = TRIM(NewMemberStuff.ContactType)>
<cfset Session.User_ContactTypeID = TRIM(NewMemberStuff.ContactTypeID)>
<cfset session.User_FirstName = TRIM(NewMemberStuff.FirstName)>
<cfset session.User_LastName = TRIM(NewMemberStuff.LastName)>
<cfset session.User_Email = TRIM(NewMemberStuff.EmailAddress)>
<cfset session.User_CountryID = TRIM(NewMemberStuff.CountryID)>
<cfset session.User_ScreenName = TRIM(form.ScreenName)>
<cfset session.User_SchoolID = NewMemberStuff.SchoolID>
<cfset session.User_Mobile = NewMemberStuff.MobilePhone>
 <cfset Session.UserIsAuthenticated = "Yes">
 
 <cfset newmemberID = form.ContactID>
<cfinclude template="../act_user_points_balance.cfm">	

<!--- CHECK FOR PROMO CODE IN DATE --->

<!--- Removed for simplicity --->
<!--- 
<cfif form.PromoCode NEQ ''>
	
	<cfquery name="CheckPromoCode" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT PromoID, Points, ExpireDate, SponsorID, PromoName
	FROM PromoCodes
	WHERE PromoCode LIKE '#TRIM(PromoCode)#'
	</cfquery>	
	
	<!--- IF THE CODE MATCHES --->
	<cfif CheckPromoCode.recordcount>
	
		<cfset this_description = "Special Promotion Code Rewards - #TRIM(CheckPromoCode.PromoName)#">

		<!--- CHECK IF THEY HAVE THIS ALREADY --->
		<cfquery name="CheckReward" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT TransactionID
		FROM contact_transactions
		WHERE Related_description LIKE '%RegisterPromoCode%'
		AND ContactID=#form.contactID#
		</cfquery>
		
		<cfif CheckReward.RecordCount>		
		<cfelse>		
		
			<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Contacts
			SET PromoID=#CheckPromoCode.PromoID#
			WHERE ContactID=#form.ContactID#
			</cfquery>
		
			<!--- LOOK FOR SPONSOR --->
			<cfquery name="SponsorCheck" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT SponsorPointsID, SponsorID, PointsRemaining
			FROM SponsorPoints
			WHERE PointsRemaining > 0
			AND SponsorID=#CheckPromoCode.SponsorID#
			ORDER BY DatePurchased
			</cfquery>
			
			<cfif SponsorCheck.RecordCount>			
				
				<!--- DOES THE SPONSOR HAVE ENOUGH POINTS LEFT FOR THIS ACTION --->
				<cfif SponsorCheck.PointsRemaining GTE CheckPromoCode.Points>					
				
					<cftransaction action="BEGIN" isolation="READ_COMMITTED">		
										
					<!--- INSERT THE TRANSACTION --->						
						<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
						INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_description, RoyaltyPaid, PointsType)
						VALUES(#form.ContactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #CheckPromoCode.Points#, '#TRIM(this_description)#', 'Points', #SponsorCheck.SponsorID#, #form.ContactID#, 'RegisterPromoCode', 0, 'Earned')
						</cfquery>
				
					<cftransaction action="commit" />
					</cftransaction>
					
					<!--- REMOVE POINTS FROM SPONSORS TABLE --->
					<cfquery name="UpdateSponsorPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE SponsorPoints
					SET PointsRemaining=#int(SponsorCheck.PointsRemaining - CheckPromoCode.Points)#
					WHERE SponsorPointsID=#SponsorCheck.SponsorPointsID#
					</cfquery>					
					
				<cfelse>
				
					<cftransaction action="BEGIN" isolation="READ_COMMITTED">					
					
					<!--- INSERT THE TRANSACTION --->						
						<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
						INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_description, RoyaltyPaid, PointsType)
						VALUES(#form.ContactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #CheckPromoCode.Points#, '#TRIM(this_description)#', 'Points', #SponsorCheck.SponsorID#, #form.ContactID#, 'RegisterPromoCode', 0, 'Earned')
						</cfquery>
										
					<cftransaction action="COMMIT" />
					</cftransaction>
					
					<!--- REMOVE POINTS FROM SPONSORS TABLE --->
					<cfquery name="UpdateSponsorPoints" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE SponsorPoints
					SET PointsRemaining=0
					WHERE SponsorPointsID=#SponsorCheck.SponsorPointsID#
					</cfquery>					
					
				</cfif>			
				
			<cfelse>
						
				<!--- LOOK FOR DEFAULT SPONSOR --->
				<cfquery name="DefaultCheck" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
				SELECT OrganisationID
				FROM Organisations
				WHERE DefaultSponsor=1
				</cfquery>
				
				<cftransaction action="BEGIN" isolation="READ_COMMITTED">				
				
				<!--- INSERT THE TRANSACTION --->
				<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Transaction_SponsorID, Related_Identifier, Related_description, RoyaltyPaid, PointsType)
				VALUES(#form.ContactID#, #CreateODBCDateTime(localDateTime)#, 'Credit', #CheckPromoCode.Points#, '#TRIM(this_description)#', 'Points', #DefaultCheck.OrganisationID#, #form.ContactID#, 'RegisterPromoCode', 0, 'Earned')
				</cfquery>
				
				<cftransaction action="COMMIT" />
				</cftransaction>
			
			</cfif>
			
		</cfif>
		
	</cfif>

</cfif>
 --->

<!--- REWARD NEW MEMBER --->
<!--- removed for simplicity --->
<!--- 
<cfset this_activity = 22>
<cfset this_contactID = form.contactid>
<cfset this_relatedDescription = "Register">
<cfset this_relatedID = "#form.contactid#">
<cfinclude template="../templates/act_activity_reward_payment.cfm">
 --->


<!--- SEND REGISTRATION ALERT TO MEMBER --->
<cfset ContactID = form.contactID>
<cfinclude template="../alerts/act_alert_02_registration.cfm">

<!--- CHECK IF UNDER 16 AND SEND MAIL TO GUARDIAN --->

<!---removed for simplicity --->
 <!--- 
<cfif age LTE 16 AND IsDefined("form.ParentEmail") AND form.ParentEmail NEQ ''>

	<!--- SEND REGISTRATION ALERT TO MEMBER --->
	<cfset ContactID = form.ContactID>
	<cfinclude template="../alerts/act_alert_03_parent.cfm">

</cfif>
 --->

<!--- CHECK FOR VALID REFERRAL CODE --->
<!---removed for simplicity --->
<!--- 
<cfif form.ReferralCode NEQ ''>

	<cfquery name="CheckReferralCode" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID, FirstName, LastName, EmailAddress
	FROM Contacts
	WHERE ScreenName = '#TRIM(form.ReferralCode)#'
	</cfquery>	
	
	<!--- IF REFERRAL CODE FOUND --->
	<cfif CheckReferralCode.RecordCount>	
	
		<!--- CHECK IF REFERRING MEMBER HAS ALREADY BEEN REWARDED --->
		<cfquery name="CheckRewarded" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT TransactionID
		FROM Contact_Transactions
		WHERE ContactID=#CheckReferralCode.ContactID#
		AND Related_Description LIKE '%SuccessfulInvitation%'
		AND Related_Identifier=#form.contactid#
		</cfquery>	
		
		<cfif CheckRewarded.RecordCount>
		<cfelse>
		
			<!--- SEND EMAIL TO REFERRING MEMBER --->
			<cfinclude template="dsp_activate_email_referrer.cfm">		
		
			<cfset ExtraDescription = "<BR>Contact: #TRIM(form.FirstName)# #TRIM(form.LastName)#">
		
			<!--- REWARD REFERRING MEMBER --->
			<cfset this_activity = 19>
			<cfset this_contactID = CheckReferralCode.ContactID>
			<cfset this_relatedDescription = "SuccessfulInvitation">
			<cfset this_relatedID = "#form.contactid#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
			<cfset ExtraDescription = "<BR>Contact: #TRIM(CheckReferralCode.FirstName)# #TRIM(CheckReferralCode.LastName)#">
		
			<!--- REWARD NEW MEMBER --->
			<cfset this_activity = 28>
			<cfset this_contactID = form.contactID>
			<cfset this_relatedDescription = "ActivateInvitation">
			<cfset this_relatedID = "#form.contactid#">
			<cfinclude template="../templates/act_activity_reward_payment.cfm">		
		
			<!--- INSERT REFERRAL CODE INTO CONTACT RECORD --->
			<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Contacts
			SET ReferralCode='#form.ReferralCode#'
			WHERE ContactID=#form.ContactID#
			</cfquery>
				
		</cfif>		
		
		<!--- CHECK FOR CURRENT LINK --->
		<cfquery name="CheckCurrentInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT InvitationID
		FROM Invitations
		WHERE InvitationToEmail LIKE '%#TRIM(NewMemberStuff.EmailAddress)#%'
		</cfquery>		
		
		<cfif CheckCurrentInvite.RecordCount>
			
			<!--- UPDATE INVITATION --->
			<cfquery name="GetInviteID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			UPDATE Invitations
			SET InvitationStatus='Successful',
			InvitationTo=#form.contactID#,
			DateResponded=#CreateODBCDateTime(localdatetime)#
			WHERE InvitationToEmail LIKE '%#TRIM(NewMemberStuff.EmailAddress)#%'
			</cfquery>
		
		<cfelse>
		
			<!--- INSERT INVITE LINK --->
			<cfquery name="LastInviteID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT InvitationID
			FROM Invitations
			ORDER BY InvitationID DESC
			</cfquery>
			
			<cfif LastInviteID.recordcount>
				<cfset newInviteid = (LastInviteID.InvitationID + 1)>
			<cfelse>
				<cfset newInviteid = 1>
			</cfif>			
			
			<cfquery name="AddInvite" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO Invitations(
			InvitationID,
			InvitationStatus,
			InvitationFrom,
			InvitationTo,
			InvitationToEmail,
			DateFirstSent,
			DateLastSent,
			DateResponded
			)
			VALUES(
			#newInviteid#, 
			'Successful',
			#CheckReferralCode.ContactID#,
			#form.contactID#,
			'#TRIM(NewMemberStuff.EmailAddress)#',
			#CreateODBCDateTime(localDateTime)#,
			#CreateODBCDateTime(localDateTime)#,
			#CreateODBCDateTime(localdatetime)#
			)
			</cfquery>		
		
		</cfif>
		
		
		<!--- CHECK FOR CURRENT CONTACT LINK --->
		<cfquery name="CheckCurrentContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT KidClientLinks.KidClientLinkID, KidClientLinks.ClientID
		FROM KidClientLinks, Contacts
		WHERE KidClientLinks.KidID = #CheckReferralCode.ContactID#
		AND KidClientLinks.ClientID=Contacts.ContactID
		AND Contacts.EmailAddress LIKE '%#TRIM(NewMemberStuff.EmailAddress)#%'
		</cfquery>
		
		<cfif CheckCurrentContact.RecordCount>
		
			<!--- UPDATE LINK --->
			<cfquery name="UpdateToNewContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE KidClientLinks
			SET ClientID=#TRIM(form.ContactID)#,
			AllowEdit=0
			WHERE KidClientLinkID=#CheckCurrentContact.KidClientLinkID#
			</cfquery>
		
			<!--- MAKE SURE ORIGINAL "CLIENT" RECORD NOT ACCESSIBLE --->
			<cfquery name="DeleteClient" datasource="#dsn#" username="#request.username#" password="#request.password#">
			UPDATE Contacts
			SET ContactStatus='Deleted',
			ContactTypeID=3
			WHERE ContactID=#CheckCurrentContact.ClientID#
			</cfquery>
		
		</cfif>		
		
	</cfif>

</cfif> --->

<!--- <cfset this_age=DateDiff('yyyy', Birthday, localDateTime)> --->

<cfquery name="CountryDetails" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Name
FROM Countries
WHERE CountryID=#NewMemberStuff.CountryID#
</cfquery>

<!--- <cfset message = "my3P SIGN-UP#chr(10)##TRIM(NewMemberStuff.FirstName)# #TRIM(NewMemberStuff.lastName)# - #this_age#yrs#chr(10)##TRIM(CountryDetails.Name)#"> --->
<cfset message = "my3P SIGN-UP#chr(10)##TRIM(NewMemberStuff.FirstName)# #TRIM(NewMemberStuff.lastName)# #chr(10)##TRIM(CountryDetails.Name)#">

 

<!--- SEND TEXT TO ROY --->

<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false">
<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
<cfhttpparam type="FORMFIELD" name="text" value="#message#">
<cfhttpparam type="FORMFIELD" name="to" value="6421319911">
<cfhttpparam type="FORMFIELD" name="from" value="6421319911">
</cfhttp>



<cflocation url="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92">
