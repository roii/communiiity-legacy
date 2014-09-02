<cfoutput>

<cfset inviteList = "9999999999">

<cfloop from="1" to="#form.TotalContacts#" index="loopcount">

	<cfif IsDefined("form.UseContact_#loopcount#")>
	
		<cfset this_name = Evaluate("ContactName_" & loopcount)>
		<cfset this_email = Evaluate("ContactEmail_" & loopcount)>
		<cfset this_mobile = Evaluate("ContactPhone_" & loopcount)>
		
		<cfif IsDefined("Categories_#loopcount#")>
			<cfset this_categories = Evaluate("Categories_" & loopcount)>
		<cfelse>
			<cfset this_categories = "">
		</cfif>
		
		<!--- CHECK IF EMAIL ADDRESS ALREADY ENTERED --->
		<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID, ContactStatus
		FROM Contacts
		WHERE EmailAddress LIKE '%#TRIM(this_email)#%'
		AND ContactStatus<>'Deleted'
		</cfquery>
	
		
		<cfif CheckUserEmail.RecordCount>
		
			<!--- CHECK IF LINK ALREADY EXISTS, IF NO MAKE THE LINK --->
			<cfquery name="CheckLink" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT KidClientLinkID
			FROM KidClientLinks
			WHERE KidID=#session.UserID#
			AND ClientID=#CheckUserEmail.ContactID#
			</cfquery>			
			
			
			<cfif CheckLink.RecordCount>
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
				AllowEdit,
				Categories)
				
				VALUES(
				#newLinkid#,
				#session.UserID#,
				#CheckUserEmail.ContactID#,
				0,
				'#this_categories#')
				</cfquery>
				
				</cftransaction>				
			
			</cfif>		
		
		<cfelse>
		
			<cfif ListLen(this_name,  ",") GT 1>					
				<cfset loopcount=0>					
				<cfloop list="#this_name#" index="loopitem" delimiters=",">
					<cfset loopcount=(loopcount+1)>						
					<cfif loopcount EQ 1>
						<cfset LastName = TRIM(loopitem)>
					<cfelseif loopcount EQ 2>
						<cfset FirstName = TRIM(loopitem)>
					</cfif>					
				</cfloop>					
			<cfelse>
				<cfset FirstName = this_name>
				<cfset LastName = "">
			</cfif>
		
	
			<cftransaction action="BEGIN">
	
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
			'#TRIM(FirstName)#',
			'#TRIM(LastName)#',
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
			AllowEdit,
			Categories)
			
			VALUES(
			#newLinkid#,
			#session.UserID#,
			#newid#,
			1,
			'#this_Categories#')
			</cfquery>
			
			</cftransaction>	
			
			<cfset inviteList = inviteList & ",#newid#">
			
			<!--- CHECK IF MEMBER HAS ALREADY BEEN REWARDED FOR ADDING THIS CONTACT --->
			<cfquery name="CheckRewarded" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT TransactionID
			FROM Contact_Transactions
			WHERE ContactID=#session.userID#
			AND Transaction_Description LIKE '%<BR>Contact: #TRIM(FirstName)# #TRIM(LastName)#%'
			</cfquery>
					
			<cfif CheckRewarded.RecordCount>
			<cfelse>			
	
				<cfset ExtraDescription = "<BR>Contact: #TRIM(FirstName)# #TRIM(LastName)#">
		
				<!--- PROCESS LOGIN REWARDS --->
				<cfset this_activity = 21>
				<cfset this_contactID = session.UserID>
				<cfset this_RelatedID = newid>
				<cfset this_relatedDescription = "AddNewContact">
		
				<cfinclude template="../../templates/act_activity_reward_payment.cfm">
				
			</cfif>
					
		</cfif>
	
	</cfif>
	
</cfloop>


<cfif InviteList NEQ '9999999999'>

	<script type="text/javascript">
	alert("You have successfully imported your contacts!\nPlease select and invite your contacts to join my3P on the next page.");
	window.opener.document.location = "#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=45&InviteMode=Contacts&inviteList=#inviteList#";
	self.close();
	</script>

<cfelse>
	
	<script type="text/javascript">
	alert("You have successfully imported your contacts but all\nof them have already been invited to join my3P.com!.");
	window.opener.document.location = "#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=44";
	self.close();
	</script>
	
</cfif>


</cfoutput>