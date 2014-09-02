<cfoutput>

<!--- GET THE ALERT DETAILS 

{invitee_firstname} {member_firstname} {sitename} {siteurl} {sitelogo}

--->

<cfquery name="AlertStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT AlertSubject, AlertDetails, AlertFormat
FROM EmailAlerts
WHERE AlertID=4
</cfquery>


<!--- REPLACE {siteurl} --->
<cfset NewAlertSubject = Replace(AlertStuff.AlertSubject,  '{siteurl}',  '#request.webroot#',  "ALL")>
<cfset NewAlertDetails = Replace(AlertStuff.AlertDetails,  '{siteurl}',  '#request.webroot#',  "ALL")>

<!--- REPLACE {sitename} --->
<cfset NewAlertSubject = Replace(NewAlertSubject,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>
<cfset NewAlertDetails = Replace(NewAlertDetails,  '{sitename}',  '#TRIM(AllSettings.SiteName)#',  "ALL")>

<!--- REPLACE {sitelogo} --->
<cfset NewAlertSubject = Replace(NewAlertSubject,  '{sitelogo}',  '' ,  "ALL")>
<cfset NewAlertDetails = Replace(NewAlertDetails,  '{sitelogo}',  '' ,  "ALL")>	


<!--- REPLACE {member_firstname} --->
<cfset NewAlertSubject = Replace(NewAlertSubject,  '{member_firstname}',  '#form.YourName#' ,  "ALL")>
<cfset NewAlertDetails = Replace(NewAlertDetails,  '{member_firstname}',  '#form.YourName#' ,  "ALL")>


<cfif IsDefined("form.FriendName")>
	
	<cfif ListLen(form.FriendName,  " ") GT 1>
		
		<cfset loopcount=0>
		
		<cfloop list="#form.FriendName#" index="loopitem" delimiters=" ">
			<cfset loopcount=(loopcount+1)>
			
			<cfif loopcount EQ 1>
				<cfset FirstName = loopitem>
			<cfelseif loopcount EQ 2>
				<cfset LastName = loopitem>
			</cfif>
		
		</cfloop>
		
	<cfelse>
		<cfset FirstName = form.FriendName>
		<cfset LastName = "">
	</cfif> 

<cfelse>
	<cfset FirstName = "">
	<cfset LastName = "">
</cfif>


<!--- REPLACE {invitee_firstname} --->
<cfset NewAlertSubject = Replace(NewAlertSubject,  '{invitee_firstname}',  '#FirstName#' ,  "ALL")>
<cfset NewAlertDetails = Replace(NewAlertDetails,  '{invitee_firstname}',  '#FirstName#' ,  "ALL")>	


<cfquery name="CheckUserEmail" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE EmailAddress='#TRIM(form.FriendEmail)#'
AND EmailAddress <> ''
</cfquery>


<cfif CheckUserEmail.RecordCount>

	<script>
	alert("Your friend has already joined #TRIM(AllSettings.SiteName)#!");
	history.back();
	</script>
	
	<cfabort>

</cfif>




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
Categories)

VALUES(
#newid#, 
3,
'Pending',
0,
'#TRIM(FirstName)#',
'#TRIM(LastName)#',
'#TRIM(form.FriendEmail)#',
'1,'
)
</cfquery>



<cfset fromemail="theTeam@my3p.com">

<cfset NewAlertDetails = Replace(NewAlertDetails,  '<BR>',  '#chr(13)#' ,  "ALL")>
	<cfset NewAlertDetails = Replace(NewAlertDetails,  '{activationurl}',  '#request.webroot#/contacts/act_activate_invitation.cfm?NewMemberCode=AUNPOO#newid#TTBQWEDX' ,  "ALL")>

</cfoutput>

<cfmail server="#application.emailserver#" to="#TRIM(form.FriendEmail)#" from="#fromemail#" subject="#NewAlertSubject#">#TRIM(NewAlertDetails)#</cfmail>


<cfoutput>

<script>
alert("You have successfully told your friend about #TRIM(AllSettings.SiteName)#!");
self.location="#request.webroot#";
</script>


</cfoutput>
