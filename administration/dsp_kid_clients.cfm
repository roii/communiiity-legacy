<cfoutput>

<cfinclude template="../templates/styles.cfm">

<cfquery name="Clients" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT * 
FROM contacts, KidClientLinks
WHERE contacts.contactid = Kidclientlinks.clientid
AND kidclientlinks.kidid = #attributes.kidsid#
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td><b>Name</b></td>
<td><b>Email</b></td>
<td><b>Date Joined</b></td>
</tr>

<tr>
<td colspan="6"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<cfloop query="Clients">	

<tr>
<td>#FirstName# #LastName#</td>
<td><a href="mailto:#EmailAddress#">#EmailAddress#</a></td>
<td>#dateformat(DateJoined,"dd/mmm/yyyy")#</td>
</tr>

</cfloop>

</table>
	
<hr width="100%" size="1" color="e2e2e2">




</cfoutput>