<cfoutput>

<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM ContactCats
ORDER BY DisplayOrder
</cfquery>

<script language="JavaScript">
<!--
function confirmContactDelete(aURL) {
    if(confirm('Are you sure you want to delete this Contact?')) {
      location.href = aURL;
    }
}
//-->
<!--
function ActionSelectChange(Contact) {
var selectBox = document.getElementById("Action_"+Contact);

	if (selectBox.options[selectBox.selectedIndex].value == "Invite") {
		var sendstring = "#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=53&this_contactID="+Contact;
		self.location = sendstring;
		
	}
	else if (selectBox.options[selectBox.selectedIndex].value == "Resend") {
		var sendstring = "#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=53&type=resend&InvitationID="+Contact;
		self.location = sendstring;	
		
	}
	else if (selectBox.options[selectBox.selectedIndex].value == "Edit") {
		var sendstring = "#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=44&EditContact=1&contactID="+Contact;
		self.location = sendstring;
	}	
	else if (selectBox.options[selectBox.selectedIndex].value == "Delete") {
		var sendstring = "#request.webroot#/contacts/act_delete_contact.cfm?contactID="+Contact;
		
		if(confirm("Are you sure you want to remove this contact?")) {
		self.location = sendstring;
		}
	}
	else {
	alert("Please select a valid action.");	
	}	
}	 
//-->

<!--
function ActionInviteChange(Invitation) {
var selectBox = document.getElementById("Invite_"+Invitation);

	if (selectBox.options[selectBox.selectedIndex].value == "Resend") {
		var sendstring = "#request.webroot#/index.cfm?fuseaction=contacts&fusesubaction=docs&documentID=53&type=resend&InvitationID="+Invitation;
		self.location = sendstring;	
		
	}
	else if (selectBox.options[selectBox.selectedIndex].value == "Delete") {
		var sendstring = "#request.webroot#/contacts/act_delete_invite.cfm?InvitationID="+Invitation;
		
		if(confirm("Are you sure you want to remove this invitation?")) {
		self.location = sendstring;
		}
	}
	else {
	alert("Please select a valid action.");	
	}	
}	 
//-->
</script>

<table cellpadding="0" cellspacing="0" border="0">

<tr>
<td style="color:##444444;padding-right:10px;"><strong>Import and invite your contacts from...</strong></td>
<td>
	<a href="#request.webroot#/contacts/import/import.php?spimport=Hotmail" target="InviteContacts" onclick="fdbackwindow=window.open ('','InviteContacts','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=730,height=500,top=10,left=10')">
		<img src="#request.imageroot#/contacts/hotmail.gif" border="0">
	</a>
	<a href="#request.webroot#/contacts/import/import.php?spimport=Yahoo" target="InviteContacts" onclick="fdbackwindow=window.open ('','InviteContacts','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=730,height=500,top=10,left=10')">
		<img src="#request.imageroot#/contacts/yahoo.gif" border="0">
	</a>
	<a href="#request.webroot#/contacts/import/import.php?spimport=AOL" target="InviteContacts" onclick="fdbackwindow=window.open ('','InviteContacts','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=730,height=500,top=10,left=10')">
		<img src="#request.imageroot#/contacts/aol.gif" border="0">
	</a>
	<a href="#request.webroot#/contacts/import/import.php?spimport=MSN" target="InviteContacts" onclick="fdbackwindow=window.open ('','InviteContacts','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=730,height=500,top=10,left=10')">
		<img src="#request.imageroot#/contacts/msn.gif" border="0">
	</a>
	<a href="#request.webroot#/contacts/import/import.php?spimport=GMail" target="InviteContacts" onclick="fdbackwindow=window.open ('','InviteContacts','toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=1,resizable=1,width=730,height=500,top=10,left=10')">
		<img src="#request.imageroot#/contacts/gmail.gif" border="0">
	</a>
	<!---	<img src="#request.imageroot#/contacts/invite_contacts_sml.gif" width="369" height="27" alt="Hotmail, Yahoo, Gmail, AOL, MSN" border="0" align="absmiddle">
	
	</a> --->
</td>
</tr>

</table>

<img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"><br>


<table width="100%" cellpadding="6" cellspacing="0" style="border:solid 1px ##b4b4b4;">

<tr>
<td>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">	
	<form method="post" action="#request.webroot#/index.cfm">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="documentID" value="#documentID#">
	<input type="hidden" name="displayresults" value="1">
	<input type="hidden" name="contacts_StartRow" value="1">
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="middle">Search: <select name="SearchField" class="whitefield" align="absmiddle">
	<option value="FirstName"<cfif session.SearchField EQ 'FirstName'> selected</cfif>>First Name
	<option value="LastName"<cfif session.SearchField EQ 'LastName'> selected</cfif>>Last Name
	<option value="ScreenName"<cfif session.SearchField EQ 'ScreenName'> selected</cfif>>Screen Name
	<option value="City"<cfif session.SearchField EQ 'City'> selected</cfif>>City
	</select> for <input type="text" class="whitefield" name="contact_keywords" style="width:120px;" align="absmiddle" value="#TRIM(session.contact_keywords)#"> &nbsp;&nbsp;Filter by: <select name="PeopleSearchFilter" class="whitefield">
	<option value="ALL"<cfif session.PeopleSearchFilter EQ 'ALL'> selected</cfif>>All Contacts
	<option value="Members"<cfif session.PeopleSearchFilter EQ 'Members'> selected</cfif>>Members
	<option value="NonMember"<cfif session.PeopleSearchFilter EQ 'NonMember'> selected</cfif>>Non-members
	<option value="Success"<cfif session.PeopleSearchFilter EQ 'Success'> selected</cfif>>Successful invites
	<option value="Pending"<cfif session.PeopleSearchFilter EQ 'Pending'> selected</cfif>>Pending invites
	</select> &nbsp; <input type="image" src="#request.imageroot#/button_search.gif" align="absmiddle"></td>
	</tr>
	</form>	
	</table>
	
	<!--- INCLUDE SEARCH QUERIES --->
	<cfinclude template="qry_people_search.cfm">
	
	<!--- INCLUDE THE ICON KEY AND ADD CONTACTS FORM --->
	<cfinclude template="dsp_people_search_summary.cfm">
	
	
	<cfif IsDefined("ContactResults")>	
			
		<!--- SET THE contacts_endrow VALUE --->
		<cfif session.contacts_MaxRows NEQ 'ALL'>
			<cfif ContactResults.RecordCount GT (session.contacts_StartRow+session.contacts_MaxRows)-1>
				<cfset contacts_endrow = session.contacts_StartRow+session.contacts_MaxRows-1>
			<cfelse>
				<cfset contacts_endrow = ContactResults.RecordCount>
			</cfif>
		<cfelse>
			<cfset contacts_endrow = ContactResults.RecordCount>
		</cfif>
		
		<!--- SET THE PREV VALUE --->
		<cfif session.contacts_Startrow GT session.contacts_Maxrows>
			<cfset prev = session.contacts_Startrow-session.contacts_Maxrows>
		<cfelse>
			<cfset prev = session.contacts_StartRow>
		</cfif>
		
		<!--- SET THE NEXT VALUE --->
		<cfif contacts_endrow LT ContactResults.RecordCount>
			<cfset next = (contacts_endrow+1)>
		<cfelse>
			<cfset next = session.contacts_StartRow>
		</cfif>
		
		<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
		<cfif session.contacts_MaxRows NEQ 'ALL'>
			<cfset NumberCount=(ContactResults.RecordCount/session.contacts_Maxrows)>
			<cfset contactsNumberCount=Ceiling(NumberCount)>
		<cfelse>
			<cfset contactsNumberCount=1>	
		</cfif>
		
	</cfif>	
		
	
	<cfif IsDefined("ContactResults") AND ContactResults.RecordCount OR IsDefined("PendingResults") AND PendingResults.RecordCount>
		
			
		<cfif session.PeopleSearchFilter DOES NOT CONTAIN 'Pending'>				
			<cfinclude template="dsp_people_search_contacts.cfm">			
		</cfif>		
		
		<cfif (session.PeopleSearchFilter CONTAINS 'Pending' OR session.PeopleSearchFilter CONTAINS 'ALL') AND (PendingResults.RecordCount)>	
			<cfinclude template="dsp_people_search_invites.cfm">		
		</cfif>
	
	</cfif>
	
</td>
</tr>

</table>

</cfoutput>