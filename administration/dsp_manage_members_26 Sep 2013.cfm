<cfoutput>

<cfparam name="session.kids_sortby" default="DateJoined">
	<cfif IsDefined("kids_sortby")>
		<cfset session.kids_sortby = kids_sortby>
	</cfif>

<cfparam name="session.sortorder" default="DESC">
	<cfif IsDefined("sortorder")>
		<cfset session.sortorder = sortorder>
	</cfif>

<cfparam name="session.ShowPending" default="No">
	<cfif IsDefined("ShowPending")>
		<cfset session.ShowPending = ShowPending>
	</cfif>

<cfparam name="session.ShowEverything" default="No">

	<cfif IsDefined("form.displayresults")>
		<cfif IsDefined("form.ShowEverything")>
			<cfset session.ShowEverything = 1>
		<cfelse>
			<cfset session.ShowEverything = 0>
		</cfif>
	</cfif>


<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Members_StartRow" default="1">
</cflock>

	<cfif isdefined("Members_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Members_StartRow = Members_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Members_MaxRows" default="50">
</cflock>

	<cfif isdefined("Members_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Members_MaxRows = Members_MaxRows>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.search_field" default="Firstname">
</cflock>

	<cfif isdefined("search_field")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.search_field = search_field>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.search_keywords" default="">
</cflock>

	<cfif isdefined("search_keywords")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.search_keywords = search_keywords>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.search_contacttypeID" default="ALL">
</cflock>

	<cfif isdefined("search_contacttypeID")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.search_contacttypeID = search_contacttypeID>
		</cflock>
	</cfif>


<script language="JavaScript">
	<!--
	function confirmContactDelete(aURL) {
	    if(confirm('Are you sure you want to delete this kid?')) {
	      location.href = aURL;
	    }
	  }
	function confirmCompleteDelete(aURL) {
	    if(confirm('This will completely delete this kid from the database!\nPress OK to proceed.')) {
	      location.href = aURL;
	    }
	  }
	function confirmReverse(aURL) {
	    if(confirm('Are you sure you want to reverse this membership.')) {
	    window.open (aURL,'reverse','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=400,top=10,left=10');
	    }
	  }
	//-->
</script>
	
	
<cfinclude template="qry_all_members.cfm">




<!--- SET THE members_endrow VALUE --->
	<cfif session.members_MaxRows NEQ 'ALL'>
	
		<cfif allkids.RecordCount GT (session.members_StartRow+session.members_MaxRows)-1>
			<cfset members_endrow = session.members_StartRow+session.members_MaxRows-1>
		<cfelse>
			<cfset members_endrow = allkids.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset members_endrow = allkids.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.members_Startrow GT session.members_Maxrows>
		<cfset prev = session.members_Startrow-session.members_Maxrows>	
	<cfelse>
		<cfset prev = session.members_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif members_endrow LT allkids.RecordCount>
		<cfset next = (members_endrow+1)>	
	<cfelse>
		<cfset next = session.members_StartRow>	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.members_MaxRows NEQ 'ALL'>	
		<cfset NumberCount=(allkids.RecordCount/session.members_Maxrows)>
		<cfset membersNumberCount=Ceiling(NumberCount)>	
	<cfelse>	
		<cfset membersNumberCount=1>		
	</cfif>
	
	
<cfquery name="AllContactTypes" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
SELECT ContactTypeID, ContactType
FROM contacttypes
ORDER BY DisplayOrder
</cfquery>	
	
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE MEMBERS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>


<table width="100%" cellpadding="6" cellspacing="0" style="border:solid 1px ##b4b4b4;">

<tr>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form method="post" action="#request.webroot#/index.cfm">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="displayresults" value="1">
	<input type="hidden" name="Members_StartRow" value="1">
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="middle">Search: <select name="search_field" class="whitefield" align="absmiddle">
	<option value="ScreenName"<cfif session.search_field EQ 'ScreenName'> selected</cfif>>ScreenName
	<option value="FirstName"<cfif session.search_field EQ 'FirstName'> selected</cfif>>First Name
	<option value="Surname"<cfif session.search_field EQ 'Surname'> selected</cfif>>Surname
	<option value="Email"<cfif session.search_field EQ 'Email'> selected</cfif>>Email
	<option value="Mobile"<cfif session.search_field EQ 'Mobile'> selected</cfif>>Mobile
	<option value="City"<cfif session.search_field EQ 'City'> selected</cfif>>City
	</select> for <input type="text" class="whitefield" name="search_keywords" style="width:150px;" align="absmiddle" value="#TRIM(session.search_keywords)#"> &nbsp;&nbsp; <input type="checkbox" name="ShowEverything" value="1"<cfif session.showEverything EQ 1> checked</cfif>> Super Search &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="image" src="#request.imageroot#/button_search.gif" align="absmiddle"></td>
	</tr>
	</form>
	
	</table>


</td>
</tr>

</table><br>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
Pending: <cfif session.ShowPending EQ 'no'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ShowPending=Yes" style="color:###TRIM(AllSettings.BoxColour)#;">show</a><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&ShowPending=No" style="color:###TRIM(AllSettings.BoxColour)#;">hide</a></cfif></td>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=20&members_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=50&members_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=100&members_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=ALL&members_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
</tr>

<tr>
<td colspan="2">

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=lastname&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Last</strong></a> <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=firstname&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>First</strong></a> Name</td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=screenname&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Screen Name</strong></a></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=mobilephone&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Mobile</strong></a></td>
	<td width="50" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=dateofbirth&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Age</strong></a></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=DateJoined&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Date</strong></a></td>
	<td style="font-size:11px;"><strong>Last Login</strong></td>
	<td style="font-size:11px;"><strong>Country</strong></td>
	<td align="right"> </td>
	</tr>
	
	<tr>
	<td colspan="9"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<cfloop query="allkids" startrow="#session.members_StartRow#" endrow="#members_endrow#">
	
	<cfset this_contactID = allkids.contactid>
	<cfset this_referralcode = allkids.referralcode>
	<cfset this_status = allkids.ContactStatus>
	<cfset this_joined = allkids.DateJoined>
	<cfset this_verified = allkids.DateVerified>
	<cfset this_email = allkids.EmailAddress>
	
	<cfif IsNumeric("#AllKids.CountryID#")>
		
		<cfquery name="CountryStuff" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
		SELECT Name
		FROM Countries
		WHERE CountryID=#AllKids.CountryID#
		</cfquery>
		
		<cfif CountryStuff.RecordCount>
			<cfset this_country = CountryStuff.Name>
		<cfelse>
			<cfset this_country = "N/A">		
		</cfif>
	<cfelse>
		<cfset this_country = "N/A">	
	</cfif>
	
	
	<!--- ACTIVE MEMBERS - CHECK FOR REFERRAL USING REFERRALCODE VALUE IN CONTACTS TABLE --->
	<cfquery name="CheckInvitation" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
	SELECT Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName
	FROM Contacts
	WHERE ScreenName='#TRIM(this_referralcode)#'
	</cfquery>	
	
	<!--- CHECK FOR LAST LOGIN --->
	<cfquery name="CheckLogin" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ" maxrows="1">
	SELECT TraceIP, TraceDate
	FROM ContactTrace
	WHERE ContactID=#TRIM(this_contactID)#
	ORDER BY TraceDate DESC
	</cfquery>
	
	<cfif CheckInvitation.recordcount>
	
		<cfset this_Invited=1>
		<cfset this_referrer = "REFERRED BY:#chr(10)#Name: #TRIM(CheckInvitation.FirstName)# #TRIM(CheckInvitation.LastName)##chr(10)#Screen Name: #TRIM(CheckInvitation.ScreenName)#">
		<cfset this_referrerSearch = TRIM(CheckInvitation.ScreenName)>
		
	<cfelse>
		
		<!--- <!--- PENDING MEMBERS - CHECK FOR REFERRAL USING EMAILADDRESS VALUE IN INVITES TABLE --->
		<cfquery name="CheckInvitation2" datasource="#dsn#" username="mykidsbizcomi" password="u+67eNfJ">
		SELECT Invitations.InvitationID, Contacts.ContactID, Contacts.FirstName, Contacts.LastName, Contacts.ScreenName
		FROM Invitations, Contacts
		WHERE Invitations.InvitationToEmail LIKE '%#this_email#%'
		AND Invitations.InvitationToEmail <> ''
		AND Invitations.InvitationFrom=Contacts.ContactID
		</cfquery>
		
		<cfif CheckInvitation2.recordcount>
	
			<cfset this_Invited=1>
			<cfset this_referrer = "REFERRED BY:#chr(10)#Name: #TRIM(CheckInvitation2.FirstName)# #TRIM(CheckInvitation2.LastName)##chr(10)#Screen Name: #TRIM(CheckInvitation2.ScreenName)#">
			<cfset this_referrerSearch = TRIM(CheckInvitation2.ScreenName)>
			
		<cfelse> --->
			<cfset this_Invited=0>
		<!--- </cfif> --->
	
		
		
		
		
		
		
	</cfif>
		
	<tr>
	<td style="font-size:11px;" valign="top"><cfif this_Invited EQ 1><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&search_keywords=#this_ReferrerSearch#&search_field=ScreenName"><img src="#request.imageroot#/icon_guyunspecified.gif" title="#this_referrer#" border="0"></a></cfif></td>
	<td style="font-size:11px;" valign="top"><a href="#request.webroot#/index.cfm?fuseaction=memberprofile&contact=#this_contactID#">#allkids.LastName#, #allkids.FirstName#</a><cfif TRIM(this_status) EQ 'pending'><span style="color:black;"> PENDING</span> &nbsp; <a href="#request.webroot#/administration/dsp_resend_email_confirmation.cfm?contactID=#contactID#" target="Resend" onclick="fdbackwindow=window.open ('','Resend','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')">RE-SEND</a></cfif><br>
	<a href="mailto:#TRIM(this_email)#" style="color:###TRIM(AllSettings.BoxColour)#;">#TRIM(this_email)#</a></td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top">#allkids.ScreenName#</td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top">#allkids.MobilePhone#</td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top"><cfif dateofbirth NEQ ''>#DateDiff('yyyy', allkids.dateofbirth, localDateTime)#yrs<cfelse>&ndash;</cfif></td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top" nowrap>#DateFormat(this_joined, "dd/mm/yy")# #TimeFormat(this_joined, "HH:MM")#<br>
	#DateFormat(this_Verified, "dd/mm/yy")# #TimeFormat(this_Verified, "HH:MM")#</td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top" nowrap><a href="#request.webroot#/administration/dsp_member_trace.cfm?contactID=#this_contactID#" target="_Blank"><cfif CheckLogin.RecordCount>#DateFormat(CheckLogin.TraceDate, "dd/mm/yy")# #TimeFormat(CheckLogin.TraceDate, "HH:MM")#<br>
	#CheckLogin.TraceIP#<cfelse>Never Logged In!</cfif></a></td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top">#TRIM(this_country)#</td>
	<td align="right"><a href="#request.webroot#/admin/dsp_kid_edit.cfm?contactID=#contactID#" target="editContact" onclick="fdbackwindow=window.open ('','editContact','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Kid" border="0"></a>&nbsp;<a href="javascript:confirmContactDelete('#request.webroot#/admin/act_delete_contact.cfm?contactID=#this_contactID#&caller=kids')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Kid" border="0"></a>&nbsp;<a href="javascript:confirmReverse('#request.webroot#/administration/act_reverse.cfm?type=member&contactID=#this_contactID#');" title="Reverse this entry">R</a>&nbsp;<a href="#request.webroot#/index.cfm?fuseaction=profile&fusesubaction=docs&documentid=92&this_contact=#this_contactID#" title="View Dashboard">D</a></td>
	</tr>
	
	<tr>
	<td colspan="9" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="9" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="9" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
		
	</cfloop>
	
	</table>



	<cfset confirmrate = Totalkidsconfirmed.recordcount / TotalKids.recordcount * 100>
	
	<br>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><b>Total: #TotalKids.recordcount#</b></td>
	<td><b>Total Confirmed: #Totalkidsconfirmed.recordcount#</b></td>	
	<td><b>Confirm Rate: #decimalformat(confirmrate)#%</b></td>
	</tr>
	
	</table>
	
	
	<hr width="100%" size="1" color="e2e2e2">
	
	<div align="right"><cfif session.members_Startrow GT session.members_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_Startrow=#prev#">Prev Page</a> | </cfif><cfif members_endrow LT allkids.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.members_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#membersNumberCount#" index="NumberCount"><cfset thisStartRow=(session.members_Maxrows*NumberCount-session.members_Maxrows+1)><cfif thisStartRow EQ session.members_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.members_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ membersNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>


</td>
</tr>

</table>


</cfoutput>