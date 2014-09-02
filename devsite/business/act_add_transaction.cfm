<cfif IsDefined("form.FirstName") AND FirstName NEQ 'Name...' AND FirstName NEQ '' AND form.EmailAddress NEQ '' AND form.EmailAddress NEQ 'Email...'>
	
	<cfset this_name = form.FirstName>
	<cfset this_email = form.EmailAddress>
	<cfset this_mobile = form.MobilePhone>
	
	
	<!--- CHECK IF EMAIL ADDRESS ALREADY ENTERED --->
	<cfquery name="CheckUserEmail" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
	SELECT ContactID, ContactStatus
	FROM Contacts
	WHERE EmailAddress LIKE '%#TRIM(this_email)#%'
	AND ContactStatus<>'Deleted'
	</cfquery>

	
	<cfif CheckUserEmail.RecordCount>
		
		<cfset this_client = CheckUserEmail.ContactID>
	
		<!--- CHECK IF LINK ALREADY EXISTS, IF NO MAKE THE LINK --->
		<cfquery name="CheckLink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		SELECT KidClientLinkID, AllowEdit
		FROM KidClientLinks
		WHERE KidID=#session.UserID#
		AND ClientID=#CheckUserEmail.ContactID#
		</cfquery>			
		
		
		<cfif CheckLink.RecordCount>
		
			<!--- IF ACTIVE MEMBER CHECK IF CORRECT LINK TYPE IF NOT UPDATE --->
			<cfif CheckUserEmail.ContactStatus EQ 'Active' AND CheckLink.AllowEdit EQ 1>
			
				<cfquery name="CheckLink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
				UPDATE KidClientLinks					
				SET AllowEdit=0 
				WHERE KidClientLinkID=#CheckLink.KidClientLinkID#
				</cfquery>					
			
			</cfif>
		
		<cfelse>			
		
			<cftransaction action="BEGIN">
			
			<cfquery name="LastLinkID" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
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
			<cfquery name="AddLink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
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
		<cfquery name="LastID" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
		SELECT ContactID
		FROM Contacts
		ORDER BY ContactID DESC
		</cfquery>
		
		<cfif lastid.recordcount>
			<cfset newid = (lastID.ContactID + 1)>
		<cfelse>
			<cfset newid = 1>
		</cfif>		
		
		<cfset this_client = newid>
		
		<cfquery name="AddContact" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
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
		#this_client#, 
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
		
		
		<cfquery name="LastLinkID" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
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
		<cfquery name="AddLink" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
		INSERT INTO KidClientLinks(
		KidClientLinkID,
		KidID,
		ClientID,
		AllowEdit)
		
		VALUES(
		#newLinkid#,
		#session.UserID#,
		#this_client#,
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
	
				
	</cfif>

<cfelseif IsDefined("form.clientid") AND form.clientid NEQ 0 AND form.clientid NEQ ''>

	<cfset this_client = form.clientid>

<cfelse>

<script type="text/javascript">
alert("Please add a client.");
history.back(-1);
</script>
<cfabort>

</cfif>



<cfif IsDate("#form.tranDate#")>
	<cfset tranDate = CreateDate(mid(form.tranDate,7,4), mid(form.tranDate,4,2), mid(form.tranDate,1,2))>
	<cfset tranDate = DateFormat(tranDate,"mm/dd/yyyy")>
</cfif>


<cfquery name="ClientStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT Contacts.FirstName, Contacts.LastName, Organisations.Organisation_Name
FROM Contacts, Organisations
WHERE Contacts.ContactID=#this_Client#
AND Contacts.OrganisationID=Organisations.OrganisationID
</cfquery>


<!--- SET THE ALLOCATED TIME IN MINUTES --->
<cfif form.Time_Hour GT 0>
	<cfset hourMinutes = (form.Time_Hour*60)>
	<cfset insert_Time = (hourMinutes+form.Time_Minutes)>
<cfelse>
	<cfset insert_Time = form.Time_Minutes>
</cfif>


<cfquery name="AddTran" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
INSERT INTO bizTransaction(
description,

<cfif IsDate("#form.tranDate#")>
	tranDate,
</cfif>

income1_amount,
income1_details,
income2_amount,
income2_details,
income3_amount,
income3_details,
income4_amount,
income4_details,
income5_amount,
income5_details,
expense1_amount,
expense1_details,
expense2_amount,
expense2_details,
expense3_amount,
expense3_details,
expense4_amount,
expense4_details,
expense5_amount,
expense5_details,
hours,
bizkidslinkid,
clientid,
clientName,
JobNumber,
ExcludeBenchmark
)		

VALUES(
'#trim(form.description)#',

<cfif IsDate("#form.tranDate#")>
	'#tranDate#',
</cfif>

<cfif IsNumeric("#val(REReplace(form.income1_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.income1_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.income1_details#',

<cfif IsNumeric("#val(REReplace(form.income2_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.income2_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.income2_details#',

<cfif IsNumeric("#val(REReplace(form.income3_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.income3_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.income3_details#',

<cfif IsNumeric("#val(REReplace(form.income4_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.income4_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.income4_details#',

<cfif IsNumeric("#val(REReplace(form.income5_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.income5_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.income5_details#',

<cfif IsNumeric("#val(REReplace(form.expense1_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.expense1_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.expense1_details#',

<cfif IsNumeric("#val(REReplace(form.expense2_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.expense2_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.expense2_details#',

<cfif IsNumeric("#val(REReplace(form.expense3_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.expense3_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.expense3_details#',

<cfif IsNumeric("#val(REReplace(form.expense4_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.expense4_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.expense4_details#',

<cfif IsNumeric("#val(REReplace(form.expense5_amount,"[^0-9.]","","ALL"))#")>
	#val(REReplace(form.expense5_amount,"[^0-9.]","","ALL"))#,
<cfelse>
	0,
</cfif>
'#form.expense5_details#',


<cfif IsNumeric("#insert_Time#")>
	#insert_Time#,
<cfelse>
	0,
</cfif>

#form.bizkidslinkid#,
#this_client#,
'#ClientStuff.FirstName# #ClientStuff.LastName# (#ClientStuff.Organisation_Name#)',
'#form.JobNumber#',
0
)
</cfquery>


<cfquery name="LastID" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ" maxrows="1">
SELECT transactionID
FROM bizTransaction
WHERE bizkidslinkid=#form.bizkidslinkid#
ORDER BY transactionID DESC
</cfquery>


<cfquery name="TransactionCount" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT distinct clientid 
FROM biztransaction bt,bizkidslink bz 
WHERE bt.bizkidslinkid = bz.bizkidslinkid
AND kidsID=#session.UserID# and clientid <> 0
</cfquery>


<cfquery name="BizStuff" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT bizidea.Biz_Idea 
FROM bizKidsLink, Business, bizidea
WHERE bizKidsLink.bizkidslinkid=#bizkidslinkid#
AND bizKidsLink.bizID=Business.bizID
AND Business.bizideaID=bizidea.bizideaID
</cfquery>


<cfset ExtraDescription = "<BR>Business: #TRIM(BizStuff.biz_idea)#">


<!--- PROCESS REWARDS --->
<cfset this_activity = 9>
<cfset this_contactID = session.UserID>
<cfset this_relatedDescription = "BusinessTransaction">
<cfset this_relatedID = "#LastID.TransactionID#">

						
<cfinclude template="../templates/act_activity_reward_payment.cfm">


<cflocation url="#request.webroot#/index.cfm?fuseaction=business&fusesubaction=docs&documentid=47&BizMode=edit&bizkidslinkID=#form.bizkidslinkid#">