<!--- CHECK AVAILABILITY OF EMAIL ADDRESS --->
<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE EmailAddress = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(form.EmailAddress))#">
	AND ContactStatus <> 'Deleted'
	AND ContactTypeID IN (1,2,4,6,7)
</cfquery>

<cfif checkuseremail.recordcount>

	<cfoutput>
	<script type="text/javascript">
		alert("We already have a member with the email address you specified.\nPlease use the \"Forgot your Password\" function to retreive your\n login details, or contact #trim(AllSettings.SiteName)# for further help.");
		history.back();
	</script>
	</cfoutput>
	<cfabort>
	
</cfif>

<!--- <<<<<<< .mine --->
<!--- Removed Mobile Phone requirement from Registration page. DJP 13Sep11 --->
<!--- <cfif TRIM(form.MobilePhone) NEQ ''>
=======
<cfif trim(form.mobilephone) NEQ "">
>>>>>>> .r110
	
	<!--- IF FIRST NUMBER A ZERO STRIP IT OFF --->
	<cfif mid(trim(form.mobilephone), 1, 1) EQ 0>
		<cfset this_mobile = mid(trim(form.mobilephone), 2, len(form.mobilephone))>
	<cfelse>
		<cfset this_mobile = trim(form.mobilephone)>
	</cfif>	
	<!--- CHECK AVAILABILITY OF MOBILE --->
	<cfquery name="CheckUserMobile" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID
		FROM Contacts
		WHERE MobilePhone LIKE '%#trim(this_mobile)#%'
		AND ContactStatus <> 'Deleted'
		AND ContactTypeID IN (1,2,4,6,7)
	</cfquery>	
	<cfif checkusermobile.recordcount>
	
		<cfoutput>
		<script type="text/javascript">
			alert("We already have a member with the mobile phone number you specified.\nPlease use the \"Forgot your Password\" function to retreive your\n login details, or contact #trim(AllSettings.SiteName)# for further help.");
			history.back();
		</script>
		</cfoutput>
		<cfabort>
		
	</cfif>
</cfif> --->

<!--- CREATE VERIFICATION CODE --->
<cfset verificationcode = "">	
<cfset numoptions = "0123456789">	
<cfloop index="loopcount" from="1" to="9">
	<cfset randomnumber = randrange(1,10)>
	<cfset verificationcode = (verificationcode & mid(numoptions,randomnumber,1))>
</cfloop>

<!--- For testing only ---> <!--- <cfset verificationcode = "012345678"> --->

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
		AcceptTerms
		)
		VALUES(
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#newid#">,
		1,
		'pending', 
		#CreateODBCDateTime(localDateTime)#,
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(form.EmailAddress))#">,
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
		<cfqueryparam cfsqltype="CF_SQL_BIT" value="#form.AcceptTerms#">
		)
	</cfquery>


</cftransaction>


<!--- SEND REGISTRATION ALERT TO MEMBER --->
<cfset contactid = newid>
<cfinclude template="../alerts/act_alert_01_registration.cfm">

<!--- <<<<<<< .mine --->
<!--- Deleted for simplicity
<cfif form.mobilephone NEQ ''>
=======
<cfif trim(form.mobilephone) NEQ "">
>>>>>>> .r110
	
	<!--- LOG MESSAGE --->
	<cfquery name="LastID" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
		SELECT TxtLogID
		FROM TxtLog
		ORDER BY TxtLogID DESC
	</cfquery>
	
	<cfif lastid.recordcount>
		<cfset newid = (lastid.txtlogid + 1)>
	<cfelse>
		<cfset newid = 1>
	</cfif>	
	
	<!--- ADD TAG LINE TO MESSAGE --->
	<cfset tagged_msg = "Go to my3p.com and enter this code to complete your registration.#chr(10)#----#chr(10)#Code: #verificationcode##chr(10)#----#chr(10)#">
		
	<!--- LOG TXT --->
	<cfquery name="LogTxtMessage" datasource="#dsn#" username="#request.username#" password="#request.password#">
		INSERT INTO TxtLog
		(
		TxtLogID, ContactID, TxtDateTime, TxtTo, TxtFrom, TxtMsg
		)
		VALUES
		(
		<cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#newid#">, 
		9999999, 
		#CreateODBCDateTime(localdatetime)#, 
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(form.MobilePhone))#">, 
		'6421319911', 
		<cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#trim(htmleditformat(tagged_msg))#">
		)
	</cfquery>
	
	<cfhttp url="http://api.clickatell.com/http/sendmsg" method="POST" resolveurl="false">
		<cfhttpparam type="FORMFIELD" name="api_id" value="2122389">
		<cfhttpparam type="FORMFIELD" name="user" value="3pventures">
		<cfhttpparam type="FORMFIELD" name="password" value="cc1339***">
		<cfhttpparam type="FORMFIELD" name="text" value="#trim(htmleditformat(tagged_msg))#">
		<cfhttpparam type="FORMFIELD" name="to" value="#trim(htmleditformat(form.MobilePhone))#">
		<cfhttpparam type="FORMFIELD" name="from" value="6421319911">
	</cfhttp>
	
</cfif> --->

<cflocation url="#request.webroot#/index.cfm?fuseaction=join&fusesubaction=step1complete&contactID=#ContactID#">