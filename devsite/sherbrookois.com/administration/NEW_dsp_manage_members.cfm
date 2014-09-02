<cfoutput>

<cfparam name="session.kids_sortby" default="ContactID">
	<cfif IsDefined("kids_sortby")>
		<cfset session.kids_sortby = kids_sortby>
	</cfif>

<cfparam name="session.sortorder" default="DESC">
	<cfif IsDefined("sortorder")>
		<cfset session.sortorder = sortorder>
	</cfif>

<cfparam name="deletedmode" default="hide">


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
	
	
<cfquery name="AllContactTypes" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactTypeID, ContactType
FROM contacttypes
ORDER BY DisplayOrder
</cfquery>	
	
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(session.AllSettings_DkTextColor)#" height="20"><strong>MANAGE MEMBERS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(session.AllSettings_BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
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
	<td style="color:###TRIM(session.AllSettings_DkTextColor)#;" valign="middle">Search: <select name="search_field" class="whitefield" align="absmiddle">
	<option value="FirstName"<cfif session.search_field EQ 'FirstName'> selected</cfif>>First Name
	<option value="Surname"<cfif session.search_field EQ 'Surname'> selected</cfif>>Surname
	<option value="Email"<cfif session.search_field EQ 'Email'> selected</cfif>>Email
	<option value="City"<cfif session.search_field EQ 'City'> selected</cfif>>City
	<option value="Country"<cfif session.search_field EQ 'Country'> selected</cfif>>Country
	</select> for <input type="text" class="whitefield" name="search_keywords" style="width:120px;" align="absmiddle" value="#TRIM(session.search_keywords)#"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input type="image" src="#request.imageroot#/button_search.gif" align="absmiddle"></td>
	</tr>
	</form>
	
	</table>


</td>
</tr>

</table><br>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
Deleted: <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&deletedmode=show" style="color:###TRIM(session.AllSettings_BoxColour)#;">show</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&deletedmode=hide" style="color:###TRIM(session.AllSettings_BoxColour)#;">hide</a></td>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=20&members_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=50&members_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=100&members_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&members_maxrows=ALL&members_StartRow=1" style="color:###TRIM(session.AllSettings_BoxColour)#;">ALL</a></td>
</tr>

<tr>
<td colspan="2">

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=lastname&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Last</strong></a> <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=firstname&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>First</strong></a> Name</td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=screenname&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Screen Name</strong></a></td>
	<td width="50" style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=dateofbirth&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Age</strong></a></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=DateJoined&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Date Joined</strong></a></td>
	<td style="font-size:11px;"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&kids_sortby=Countries.Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Country</strong></a></td>
	<td align="right"> </td>
	</tr>
	
	<tr>
	<td colspan="7"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<cfloop query="allkids" startrow="#session.members_StartRow#" endrow="#members_endrow#">
	
	<cfset this_contactID = allkids.contactid>
	
	<cfif IsNumeric("#allkids.RegionID#")>
	
		<cfquery name="regionstuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT Region
		FROM Region
		WHERE RegionID=#allkids.RegionID#
		</cfquery>
	
	</cfif>
	
	<cfif AllKids.contacttypeID NEQ ''>
	
		<cfquery name="Typestuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT ContactType
		FROM contacttypes
		WHERE contacttypeID=#AllKids.contacttypeID#
		</cfquery>
	
	</cfif>
	
	
	<!--- LOOK FOR INVITATION --->
	<cfquery name="CheckInvitation" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Contacts.FirstName, Contacts.LastName, Contacts.ScreenName
	FROM Invitations, Contacts
	WHERE Invitations.InvitationTo=#this_contactID#
	AND Invitations.InvitationFrom=Contacts.ContactID
	</cfquery>
	
		
	<tr>
	<td style="font-size:11px;" valign="top"><cfif CheckInvitation.RecordCount><img src="#request.imageroot#/icon_guyunspecified.gif" title="REFERRED BY:#chr(10)#Name: #TRIM(CheckInvitation.FirstName)# #TRIM(CheckInvitation.LastName)##chr(10)#Screen Name: #TRIM(CheckInvitation.ScreenName)#"></cfif></td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top">#allkids.LastName#, #allkids.FirstName#<cfif allkids.ContactStatus EQ 'pending'><span style="color:black;"> PENDING</span></cfif><br>
	<a href="mailto:#TRIM(allkids.EmailAddress)#" style="color:###TRIM(session.AllSettings_BoxColour)#;">#TRIM(allkids.EmailAddress)#</a></td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top">#allkids.ScreenName#</td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top"><cfif dateofbirth NEQ ''>#DateDiff('yyyy', allkids.dateofbirth, localDateTime)#yrs<cfelse>&ndash;</cfif></td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top" nowrap>#DateFormat(allkids.DateJoined, "dd/mm/yy")#</td>
	<td<cfif allkids.ContactStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> style="font-size:11px;" valign="top">#TRIM(allkids.Name)#</td>
	<td align="right"><a href="#request.webroot#/admin/dsp_kid_edit.cfm?contactID=#contactID#" target="editContact" onclick="fdbackwindow=window.open ('','editContact','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Kid" border="0"></a>&nbsp;<a href="javascript:confirmContactDelete('#request.webroot#/admin/act_delete_contact.cfm?contactID=#this_contactID#&caller=kids')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Kid" border="0"></a>&nbsp;<a href="javascript:confirmCompleteDelete('#request.webroot#/admin/act_delete_contact.cfm?contactID=#this_contactID#&caller=kids&completedelete=true')" title="Completely delete this kid from DB">D</a>&nbsp;<a href="javascript:confirmReverse('#request.webroot#/administration/act_reverse.cfm?type=member&contactID=#this_contactID#');" title="Reverse this entry">R</a></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="7" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
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