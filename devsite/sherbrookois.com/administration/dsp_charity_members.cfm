<cfoutput>

<cfquery name="AllMembers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, LastName, EMailAddress
FROM Contacts
WHERE Charity=#OrganisationID#
ORDER BY FirstName
</cfquery> 


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:12px;" colspan="2"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool&ExportList=#ValueList(AllMembers.contactID)#" target="mymainwindow">Email All Members</a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>



<cfloop query="AllMembers">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;"><strong>#TRIM(AllMembers.FirstName)# #TRIM(AllMembers.LastName)#</strong></td>
<td style="font-size:11px;color:##444444;"><a href="mailto:#TRIM(AllMembers.emailaddress)#">#TRIM(AllMembers.emailaddress)#</a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

</cfloop>


</table>
<div align="center"><input type="button" onclick="javascript:window.close();" value="CLOSE WINDOW >>" class="whitefield"></div><br>


</cfoutput>