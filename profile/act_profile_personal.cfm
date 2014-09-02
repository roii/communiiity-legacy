<cfoutput>

<cfset this_contactID=session.userID>

<cfif IsDefined("form.ScreenName")>

	<!--- CHECK AVAILABILITY OF SCREEN NAME --->
	
	<cfquery name="CheckScreenName" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ScreenName
	FROM Contacts
	WHERE ScreenName='#TRIM(form.ScreenName)#'
	</cfquery>
	
	<cfif CheckScreenName.RecordCount>
	
		<script>
		alert("The Screen Name you chose is already in use.Please try another option.");
		history.back();
		</script>
		<cfabort>
		
	</cfif>


	
	
<cfelse>
	<!--- CHECK IF THEY HAVE ALREADY BEEN REWARDED FOR ADDING REGION,DISTRICT,SUBURB TO PROFILE --->
	<cfquery name="ScreenNameCheck" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT TransactionID
	FROM contact_transactions
	WHERE Transaction_Description LIKE '%Screen Name%'
	AND ContactID=#session.UserID#
	</cfquery>
	
	<cfif ScreenNameCheck.RecordCount EQ 0>
	
	
		<!--- PROCESS SCREEN NAME REWARDS --->
		<cfset this_activity = 23>
		<cfset this_contactID = session.UserID>	
		<cfset this_relatedDescription = "UpdateProfile-ScreenName">
		<cfset this_relatedID = "#session.UserID#">	
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	</cfif>
	
</cfif>


<cfif form.currentEmail NEQ form.EmailAddress>

	<!--- CHECK AVAILABILITY OF EMAIL ADDRESS --->
	
	<cfquery name="CheckUser" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE EmailAddress='#TRIM(form.EmailAddress)#'
	</cfquery>
	
	<cfif CheckUser.RecordCount>
	
		<script>
		alert("The Email Address you entered is already in use. Please try another Email Address.");
		history.back();
		</script>
		<cfabort>
		
	</cfif>


</cfif>



<cfif form.DistrictID NEQ 0>

	<cfquery name="GetDistrict" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT District
	FROM District
	WHERE DistrictID=#form.DistrictID#
	</cfquery>
	
	<cfset insert_city = GetDistrict.District>

<cfelse>

	<cfset insert_city = form.city>

</cfif>





<cftransaction action="BEGIN">

<!--- UPDATE CONTACT INFO --->
<cfif isdefined("form.receiveEmail")>
  <cfset form.receiveEmail = 1>
<cfelse>
  <cfset form.receiveEmail = 0>
</cfif> 

<cfquery name="UpdateContact" datasource="#dsn#" username="#request.username#" password="#request.password#">
UPDATE Contacts
SET FirstName='#TRIM(form.FirstName)#',
LastName='#TRIM(form.LastName)#',

<cfif IsDefined("form.ScreenName")>
	ScreenName='#TRIM(form.ScreenName)#',
</cfif>

<cfif IsDefined("form.gender")>
	Gender='#TRIM(form.gender)#',
</cfif>

City='#TRIM(insert_city)#',
CountryID=#form.countryID#,
RegionID=#form.regionid#,
DistrictID=#form.districtid#,
SuburbID=#form.suburbid#,
EmailAddress='#TRIM(form.EmailAddress)#',
Password='#TRIM(form.Profile_Password)#',

<cfif IsDefined("form.ParentName")>
	ParentsName='#TRIM(form.ParentName)#',
</cfif>

<cfif IsDefined("form.ParentEmail")>
	ParentsEmail='#TRIM(form.ParentEmail)#',
</cfif>

receiveEmail=#TRIM(form.receiveEmail)#,

<cfif IsDefined("form.SchoolID")>
	SchoolID=#form.SchoolID#,
<cfelse>
	SchoolID=0,
</cfif>

<cfif IsDefined("form.School_Other")>
	School_Other='#form.School_Other#',
<cfelse>
	School_Other='',
</cfif>

<cfif IsDefined("form.School_Other_Phone")>
	School_Other_Phone='#form.School_Other_Phone#',
<cfelse>
	School_Other_Phone='',
</cfif>

<cfif IsDefined("form.School_Other_Address")>
	School_Other_Address='#form.School_Other_Address#',
<cfelse>
	School_Other_Address='',
</cfif>

Charity=#form.Charity#,
mobilePhone='#form.MobilePhone#'

WHERE ContactID=#session.userID#
</cfquery>


</cftransaction>


<!--- CHECK IF THEY HAVE ALREADY BEEN REWARDED FOR ADDING REGION,DISTRICT,SUBURB TO PROFILE --->
<cfquery name="LocationCheck" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TransactionID
FROM contact_transactions
WHERE Transaction_Description LIKE '%location details%'
AND ContactID=#session.UserID#
</cfquery>

<cfif LocationCheck.RecordCount EQ 0>

	<cfif IsDefined("form.CountryID") AND form.countryID EQ 137>
		
		<!--- CHECK IF THEY HAVE ENTERED NEW VALUES --->
		<cfif IsDefined("form.RegionID") AND (form.current_regionID NEQ form.RegionID) 
		OR IsDefined("form.DistrictID") AND (form.current_DistrictID NEQ form.DistrictID)
		OR IsDefined("form.SuburbID") AND (form.current_SuburbID NEQ form.SuburbID)>
	
		
			<!--- PROCESS SCREEN NAME REWARDS --->
			<cfset this_activity = 24>
			<cfset this_contactID = session.UserID>		
			<cfset this_relatedDescription = "UpdateProfile-location">
			<cfset this_relatedID = "#session.UserID#">	
			<cfinclude template="../templates/act_activity_reward_payment.cfm">

		</cfif>
		

	<cfelse>
	
		<cfif form.current_City NEQ form.City>
		
			<!--- PROCESS LOCATION REWARDS --->
			<cfset this_activity = 24>
			<cfset this_contactID = session.UserID>
			<cfset this_relatedDescription = "UpdateProfile-City">
			<cfset this_relatedID = "#session.UserID#">	
			<cfinclude template="../templates/act_activity_reward_payment.cfm">
			
		
		</cfif>	
	
	</cfif>

</cfif>



<!--- CHECK IF THEY HAVE ALREADY BEEN REWARDED FOR ADDING SCHOOL TO PROFILE --->
<cfquery name="SchoolCheck" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TransactionID
FROM contact_transactions
WHERE (Transaction_Description LIKE '%Entered school%' OR Transaction_Description LIKE '%Add school%')
AND ContactID=#session.UserID#
</cfquery>

<cfif SchoolCheck.RecordCount EQ 0>

	<cfif IsDefined("form.SchoolID") AND form.current_SchoolID NEQ form.SchoolID>
		
		<!--- PROCESS SCHOOL REWARDS --->
		<cfset this_activity = 25>
		<cfset this_contactID = session.UserID>
		<cfset this_relatedDescription = "UpdateProfile-School">
		<cfset this_relatedID = "#session.UserID#">	
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	<cfelseif IsDefined("form.Current_School_Other") AND form.Current_School_Other NEQ form.School_Other>
		
		<!--- PROCESS SCHOOL REWARDS --->
		<cfset this_activity = 25>
		<cfset this_contactID = session.UserID>	
		<cfset this_relatedDescription = "UpdateProfile-School">
		<cfset this_relatedID = "#session.UserID#">		
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
		
		
	</cfif>

</cfif>


<!--- CHECK IF THEY HAVE ALREADY BEEN REWARDED FOR ADDING MOBILE NUMBER TO PROFILE --->
<cfquery name="mobileCheck" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TransactionID
FROM contact_transactions
WHERE (Transaction_Description LIKE '%Entered Mobile%' OR Transaction_Description LIKE '%Add mobile%')
AND ContactID=#session.UserID#
</cfquery>

<cfif mobileCheck.RecordCount EQ 0>

	<cfif IsDefined("form.MobilePhone") AND form.currentMobilePhone NEQ form.MobilePhone>
		
		<!--- PROCESS REWARDS --->
		<cftransaction action="BEGIN">	
	
		<!--- INSERT THE TRANSACTION --->
			
			<cfquery name="AddTransaction" datasource="#dsn#" username="#request.username#" password="#request.password#">
			INSERT INTO contact_transactions(ContactID, Transaction_Date, Transaction_Type, Transaction_Amount, Transaction_Description, Transaction_Account, Related_Identifier, Related_description, Transaction_SponsorID, RoyaltyPaid, PointsType)
			VALUES(#session.userID#, #CreateODBCDateTime(localDateTime)#, 'Credit', 50, 'Entered Mobile', 'Points', 0, 'PrintBizCards', 0, 0, 'Earned')
			</cfquery>
		
		</cftransaction>
	
	</cfif>

</cfif>

<!--- CHECK IF THEY HAVE ALREADY BEEN REWARDED FOR ADDING CHARITY TO PROFILE --->
<cfquery name="CharityCheck" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT TransactionID
FROM contact_transactions
WHERE (Transaction_Description LIKE '%Entered Charity%' OR Transaction_Description LIKE '%Add Charity%')
AND ContactID=#session.UserID#
</cfquery>

<cfif CharityCheck.RecordCount EQ 0>

	<cfif IsDefined("form.Charity") AND form.current_Charity NEQ form.Charity>
		
		<!--- PROCESS SCHOOL REWARDS --->
		<cfset this_activity = 26>
		<cfset this_contactID = session.UserID>
		<cfset this_relatedDescription = "UpdateProfile-Charity">
		<cfset this_relatedID = "#session.UserID#">	
		<cfinclude template="../templates/act_activity_reward_payment.cfm">
	
	</cfif>	



</cfif>


<script>
alert("Your profile has been updated");
self.location="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentID=41";
</script>


</cfoutput>

