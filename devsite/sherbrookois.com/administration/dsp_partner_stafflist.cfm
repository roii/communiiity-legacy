<cfoutput>

<script language="JavaScript">
	<!--
	function confirmStaffDelete(aURL) {
	    if(confirm('Are you sure you want to delete this staff member?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>


<!--- GET ALL STAFF --->
<cfquery name="AllStaff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, Lastname, EmailAddress
FROM Contacts
WHERE OrganisationID=#OrganisationID#
AND ContactStatus = 'Active'
ORDER BY FirstName
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:12px;"><a href="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=addstaff" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>ADD A STAFF MEMBER</strong></a></td>
<td style="font-size:12px;" colspan="2" align="right"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool&ExportList=#ValueList(AllStaff.contactID)#" target="mymainwindow">Email All Staff</a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="3" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>



<cfloop query="AllStaff">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;"><strong>#TRIM(AllStaff.FirstName)# #TRIM(AllStaff.LastName)#</strong></td>
<td style="font-size:11px;color:##444444;"><a href="mailto:#TRIM(AllStaff.emailaddress)#">#TRIM(AllStaff.emailaddress)#</a></td>
<td width="40" align="right"><a href="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#OrganisationID#&updatemode=editstaff&contactID=#AllStaff.ContactID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Staff Member" border="0"></a>&nbsp;<a href="javascript:confirmStaffDelete('#request.webroot#/administration/act_delete_partner_staff.cfm?OrganisationID=#OrganisationID#&contactID=#AllStaff.ContactID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Staff Member" border="0"></a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="3"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

</cfloop>


</table>

<div align="center"><input type="button" onclick="javascript:window.close();" value="CLOSE WINDOW >>" class="whitefield"></div><br>

</cfoutput>