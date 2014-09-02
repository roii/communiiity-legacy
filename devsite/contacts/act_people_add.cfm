<cfloop from="1" to="#form.NumberToAdd#" index="loopcount">

	<cfif IsDefined("form.FirstName_#loopcount#") AND Evaluate("FirstName_" & loopcount) NEQ '' AND Evaluate("EmailAddress_" & loopcount) NEQ ''>
	
		<cfset this_name = Evaluate("FirstName_" & loopcount)>
		<cfset this_email = Evaluate("EmailAddress_" & loopcount)>
		<cfset this_mobile = Evaluate("MobilePhone_" & loopcount)>
		
		<!--- CHECK IF EMAIL ADDRESS ALREADY ENTERED --->
		<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID, ContactStatus, ContactTypeID
		FROM Contacts
		WHERE EmailAddress LIKE '%#TRIM(this_email)#%'
		AND ContactStatus<>'Deleted'
		</cfquery>	
		
		<cfif CheckUserEmail.RecordCount>
		
			<!--- CHECK IF LINK ALREADY EXISTS, IF NO MAKE THE LINK --->
			<cfquery name="CheckLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT KidClientLinkID, AllowEdit
			FROM KidClientLinks
			WHERE KidID=#session.UserID#
			AND ClientID=#CheckUserEmail.ContactID#
			</cfquery>			
			
			<cfif CheckLink.RecordCount>
			
				<!--- IF ACTIVE MEMBER CHECK IF CORRECT LINK TYPE IF NOT UPDATE --->
				<cfif CheckUserEmail.ContactStatus EQ 'Active' AND CheckLink.AllowEdit EQ 1>
				
					<cfquery name="CheckLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
					UPDATE KidClientLinks					
					SET AllowEdit=0 
					WHERE KidClientLinkID=#CheckLink.KidClientLinkID#
					</cfquery>					
				
				</cfif>
			
			<cfelse>			
			
				<cftransaction action="BEGIN">
				
				<cfquery name="LastLinkID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
				SELECT KidClientLinkID
				FROM KidClientLinks
				ORDER BY KidClientLinkID DESC
				</cfquery>
				
				<cfif LastLinkID.recordcount>
					<cfset newLinkid = (LastLinkID.KidClientLinkID + 1)>
				<cfelse>
					<cfset newLinkid = 1>
				</cfif>				
				
				<!--- INSERT LINK INFO --->			
				<cfquery name="AddLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
				INSERT INTO KidClientLinks(
				KidClientLinkID,
				KidID,
				ClientID,
				AllowEdit)
				
				VALUES(
				#newLinkid#,
				#session.UserID#,
				#CheckUserEmail.ContactID#,
				0)
				</cfquery>
				
				</cftransaction>				
			
			</cfif>		
		
		<cfelse>
				
	
			<cftransaction action="BEGIN" isolation="READ_COMMITTED">
	
			<!--- INSERT CONTACT INFO --->
			<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT ContactID
			FROM Contacts
			ORDER BY ContactID DESC
			</cfquery>
			
			<cfif lastid.recordcount>
				<cfset newid = (lastID.ContactID + 1)>
			<cfelse>
				<cfset newid = 1>
			</cfif>		
			
			<cfquery name="AddContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO Contacts(
			ContactID,
			ContactTypeID,
			ContactStatus,
			OrganisationID,
			FirstName,
			LastName,
			EmailAddress,
			Categories,
			Title,
			Address1,
			Address2,
			Address3,
			City,
			RegionID,
			DistrictID,
			SuburbID,
			CountryID,
			WorkPhone,
			MobilePhone,
			HomePhone,
			HomeFax	
			)
		
			VALUES(
			#newid#, 
			3,
			'Pending',
			0,
			'#TRIM(this_name)#',
			'',
			'#TRIM(this_email)#',
			'',
			'',
			'',
			'',
			'',
			'',
			0,
			0,
			0,
			0,
			'',
			'#this_Mobile#',
			'',
			''	
			)
			</cfquery>
			
			
			<cfquery name="LastLinkID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
			SELECT KidClientLinkID
			FROM KidClientLinks
			ORDER BY KidClientLinkID DESC
			</cfquery>
			
			<cfif LastLinkID.recordcount>
				<cfset newLinkid = (LastLinkID.KidClientLinkID + 1)>
			<cfelse>
				<cfset newLinkid = 1>
			</cfif>
						
			<!--- INSERT LINK INFO --->			
			<cfquery name="AddLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO KidClientLinks(
			KidClientLinkID,
			KidID,
			ClientID,
			AllowEdit)
			
			VALUES(
			#newLinkid#,
			#session.UserID#,
			#newid#,
			1)
			</cfquery>
			
			</cftransaction>	
			
			<cfset ExtraDescription = "<BR>Contact: #TRIM(this_name)#">
		
			<!--- PROCESS LOGIN REWARDS --->
			<cfset this_activity = 21>
			<cfset this_contactID = session.UserID>
			<cfset this_RelatedID = newid>
			<cfset this_relatedDescription = "AddNewContact">
		
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
			<!--- CHECK IF SEND INVITE --->
			<cfif isDefined("form.SendInvite_" & loopcount)>			
				<cfinclude template="act_send_multi_invite.cfm">			
			</cfif>
					
		</cfif>
	
	</cfif>
	
</cfloop>
	
<cfoutput>

<script type="text/javascript">
alert("You have successfully added and invited your friends!");
self.location = "#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=44";
</script>
<cfabort>

</cfoutput>