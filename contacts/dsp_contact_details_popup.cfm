<cfoutput>

<!--- CHECK IF LINKED TO THIS USER --->
<cfset ContactID_List = "">	

<cfquery name="AllLinks" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ClientID, AllowEdit, Categories
FROM KidClientLinks
WHERE KidClientLinks.KidID=#session.UserID#
</cfquery>

<cfif AllLinks.RecordCount>
	<cfset ContactID_List = ListAppend(ContactID_List, valueList(AllLinks.ClientID, ","), ",")>
</cfif>	

<cfquery name="All_Referrals" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ContactStatus, DateJoined, DateVerified
FROM Contacts
WHERE ReferralCode LIKE '%#session.User_ScreenName#%'
AND ReferralCode <> ''
</cfquery>

<cfif All_Referrals.RecordCount>
	<cfset ContactID_List = ListAppend(ContactID_List, valueList(All_Referrals.ContactID, ","), ",")>
</cfif>

<cfquery name="All_Invites" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT InvitationID, InvitationToEmail, InvitationTo, InvitationStatus, Royalties_Earned, DateFirstSent, DateLastSent, DateResponded, InvitationFrom, InvitationTo_FirstName, InvitationTo_LastName
FROM Invitations
WHERE InvitationFrom = #session.UserID#
</cfquery>

<cfif All_Invites.RecordCount>
	<cfset ContactID_List = ListAppend(ContactID_List, valueList(All_Invites.InvitationTo, ","), ",")>
</cfif>

	
<cfif IsDefined("URL.ContactID") AND ListFind(ContactID_List, URL.ContactID, ",")>	
	
	<cfquery name="ContactDetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
	SELECT Contacts.ContactID, Contacts.LastName, Contacts.FirstName, Contacts.Title, Contacts.HomePhone, Contacts.MobilePhone, Contacts.EmailAddress, Contacts.ContactTypeID, Contacts.LoginName, Contacts.Password, Organisations.Organisation_Name, Organisations.CompanyCode, Organisations.WorkPhone, Organisations.EmailAddress, Organisations.OrganisationID, Organisations.Fax, Organisations.Address1, Organisations.Address2, Organisations.Address3, Organisations.City, Organisations.State, Organisations.ZipCode, Organisations.CountryID, Organisations.WebsiteURL, Organisations.Notes, ContactTypes.ContactType
	FROM Contacts, Organisations, ContactTypes
	WHERE Contacts.ContactID=#ContactID#
	AND Contacts.OrganisationID=Organisations.OrganisationID
	AND Contacts.ContactTypeID=ContactTypes.ContactTypeID
	</cfquery>
	
<cfelse>
	
	<script type="text/javascript">
	alert("You do not have permission to view that persons details.");
	window.close();
	</script>
	<cfabort>

</cfif>

<cfset OrganisationID=contactDetails.OrganisationID>	

<html>
<head>
<cfinclude template="../templates/styles.cfm">
</head>

<body marginheight="0" marginwidth="0" leftmargin="0" topmargin="0" bgcolor="white">
<div align="center">
<br>

<table border="0" cellpadding="0" cellspacing="0" width="95%">

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td width="90%">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td class="PageTitle"><cfif IsDefined("URL.ContactID")>People Profile<cfelse>Organisation Profile</cfif></td>
	<td width="150" align="right" class="maincopy"><a href="javascript:window.close();" class="textlinks">Close Window</a> | <a href="javascript:window.print();" class="textlinks">Print page</a></td>
	</tr>
	
	</table>
	
</td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td bgcolor="black" width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td>Printed:<b> #dateformat(localDateTime, "mmm d, yyyy")#</b></td>
	<td align="center" class="maincopy"></td>
	<td align="right"><!--- <cfif IsDefined("URL.ContactID")>Category:<b> #TRIM(ContactDetails.CatName)#</b></cfif> ---></td>
	</tr>
	
	</table>

</td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td width="90%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td width="90%">


	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td class="maincopy"><br>

<cfif IsDefined("URL.ContactID")>
									
									
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td style="font-size:14px;font-family:Trebuchet MS, Arial, Verdana, Helvetica;"><strong>Contact Details</strong></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="18" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="2" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
		</tr>
		
		</table>


		<table border="0" cellpadding="0" cellspacing="0">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Contact Name:&nbsp;&nbsp;</td>
		<td><strong>#TRIM(ContactDetails.FirstName)# #TRIM(ContactDetails.LastName)#</strong></td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Phone:&nbsp;&nbsp;</td>
		<td>#TRIM(ContactDetails.HomePhone)#</td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;"></td>
		<td></td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Mobile:&nbsp;&nbsp;</td>
		<td>#TRIM(ContactDetails.MobilePhone)#</td>
		</tr>
		
		<tr>
		<td align="right"></td>
		<td></td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Email:&nbsp;&nbsp;</td>
		<td><a href="mailto:#TRIM(ContactDetails.EmailAddress)#">#TRIM(ContactDetails.EmailAddress)#</a></td>
		</tr>
		
		</table><br>
		
		
		
</cfif>		
	

<cfif ContactDetails.OrganisationID NEQ 0>

   <cfif IsDefined("ContactDetails.OrganisationID") and #ContactDetails.OrganisationID# neq ''>
		<cfquery name="AllCompanyContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID, LastName, FirstName, Title, MobilePhone, EmailAddress, HomePhone
		FROM Contacts
		WHERE OrganisationID=#ContactDetails.OrganisationID#
		AND ContactStatus <> 'Deleted'
		</cfquery>
   <cfelse>
        <cfquery name="AllCompanyContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactID, LastName, FirstName, Title, MobilePhone, EmailAddress, HomePhone
		FROM Contacts
		WHERE OrganisationID=0
		AND ContactStatus <> 'Deleted'
		</cfquery>		
   </cfif>		
		
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td style="font-size:14px;font-family:Trebuchet MS, Arial, Verdana, Helvetica;"><strong>Organisation Details</strong></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="18" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="2" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
		</tr>
		
		</table>
	
	
		<table border="0" cellpadding="0" cellspacing="0">
	
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Name:&nbsp;&nbsp;</td>
		<td class="objectcopyblack"><strong>#TRIM(ContactDetails.Organisation_Name)#</strong></td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;"></td>
		<td class="objectcopyblack"></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Address Line 1:&nbsp;&nbsp;</td>
		<td class="objectcopyblack">#TRIM(ContactDetails.Address1)#</td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Town/City:&nbsp;&nbsp;</td>
		<td class="objectcopyblack">#TRIM(ContactDetails.City)#</td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Address Line 2:&nbsp;&nbsp;</td>
		<td class="objectcopyblack">#TRIM(ContactDetails.Address2)#</td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">State / ZipCode:&nbsp;&nbsp;</td>
		<td class="objectcopyblack">#TRIM(ContactDetails.State)# #TRIM(ContactDetails.ZipCode)#</td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Address Line 3:&nbsp;&nbsp;</td>
		<td class="objectcopyblack">#TRIM(ContactDetails.Address3)#</td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Country:&nbsp;&nbsp;</td>
		<td class="objectcopyblack"><cfif IsNumeric("#ContactDetails.CountryID#")>
		<cfquery name="countrydetails" datasource="#dsn#" maxrows="1" username="#request.username#" password="#request.password#">
		SELECT Name
		FROM Countries
		WHERE CountryID=#ContactDetails.CountryID#
		</cfquery><cfif countryDetails.recordcount>#TRIM(countrydetails.Name)#</cfif></cfif></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Phone:&nbsp;&nbsp;</td>
		<td class="objectcopyblack">#TRIM(ContactDetails.WorkPhone)#</td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Website:&nbsp;&nbsp;</td>
		<td class="objectcopyblack"><a href="#TRIM(ContactDetails.WebsiteURL)#" target="_blank">#TRIM(ContactDetails.WebsiteURL)#</a></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Fax:&nbsp;&nbsp;</td>
		<td class="objectcopyblack">#TRIM(ContactDetails.Fax)#</td>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;">Email:&nbsp;&nbsp;</td>
		<td class="objectcopyblack"><a href="mailto:#TRIM(ContactDetails.EmailAddress)#">#TRIM(ContactDetails.EmailAddress)#</a></td>
		</tr>
		
		</table>
	
	
		<table border="0" cellpadding="0" cellspacing="0">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="8" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" style="color:###TRIM(AllSettings.TextColour)#;" valign="top">Notes:&nbsp;&nbsp;</td>
		<td class="objectcopyblack" colspan="3" valign="top">#TRIM(ContactDetails.Notes)#</td>
		</tr>
		
		</table><br>
	
	
			
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
		
		<tr>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="110" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="90" height="4" border="0"></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="120" height="4" border="0"></td>
		</tr>
		
		<tr>
		<td style="font-size:14px;font-family:Trebuchet MS, Arial, Verdana, Helvetica;"><strong>Organisation Contacts</strong></td>
		<td></td>
		<td></td>
		<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="18" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="5" bgcolor="silver"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
		</tr>
		
		<tr>
		<td align="right" class="objectcopysmall" colspan="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="10" border="0"></td>
		</tr>
		
		<tr>
		<td align="left" style="color:###TRIM(AllSettings.TextColour)#;">Contact Name:&nbsp;</td>
		<td style="color:###TRIM(AllSettings.TextColour)#;">Title/Position:&nbsp;</td>
		<td style="color:###TRIM(AllSettings.TextColour)#;">Phone:&nbsp;</td>
		<td style="color:###TRIM(AllSettings.TextColour)#;">Mobile:&nbsp;</td>
		<td style="color:###TRIM(AllSettings.TextColour)#;">Email:&nbsp;</td>
		</tr>
		
		
		<cfloop query="AllCompanyContacts">	
		
		<tr>
		<td><a href="#request.webroot#/contacts/dsp_contact_details_popup.cfm?contactID=#AllCompanyContacts.ContactID#" style="color:###TRIM(AllSettings.BoxColour)#;">#TRIM(AllCompanyContacts.FirstName)# #TRIM(AllCompanyContacts.LastName)#</a></td>
		<td><cfif TRIM(AllCompanyContacts.Title) NEQ ''>#TRIM(AllCompanyContacts.Title)#<cfelse><span style="color:Gray;">-</span></cfif></td>
		<td><cfif TRIM(AllCompanyContacts.HomePhone) NEQ ''>#TRIM(AllCompanyContacts.HomePhone)#<cfelse><span style="color:Gray;">-</span></cfif></td>
		<td><cfif TRIM(AllCompanyContacts.MobilePhone) NEQ ''>#TRIM(AllCompanyContacts.MobilePhone)#<cfelse><span style="color:Gray;">-</span></cfif></td>
		<td><cfif TRIM(AllCompanyContacts.EmailAddress) NEQ ''><a href="mailto:#TRIM(AllCompanyContacts.EmailAddress)#" class="textlinks">#TRIM(AllCompanyContacts.EmailAddress)#</a><cfelse><span style="color:Gray;">-</span></cfif></td>
		</tr>
		
		</cfloop>
		
		</table>
	
	
</cfif>

	
	</td>
	</tr>
	
	</table>


</td>
</tr>

</table><br>





<table border="0" cellpadding="0" cellspacing="0" width="95%">

<tr>
<td bgcolor="d3d3d3" width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td bgcolor="d3d3d3" width="50%"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>
</div>
</body>

</html>

</cfoutput>