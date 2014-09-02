<cfoutput>

<script language="JavaScript">
	<!--
	function confirmTeacherDelete(aURL) {
	    if(confirm('Are you sure you want to delete this teacher?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>


<!--- GET ALL TEACHERS AND ADMINISTRATORS --->
<cfquery name="AllTeachers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, Lastname, EmailAddress, Password
FROM Contacts
WHERE SchoolID=#SchoolID#
AND ContactTypeID IN (5,6)
ORDER BY FirstName
</cfquery>


<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:12px;"><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?SchoolID=#SchoolID#&updatemode=addstaff" style="color:###TRIM(AllSettings.BoxColour)#;"><strong>ADD A TEACHER</strong></a></td>
<td style="font-size:12px;" colspan="2" align="right"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=emailtool&ExportList=#ValueList(AllTeachers.contactID)#" target="mymainwindow">Email All Teachers</a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="3" style="font-size:12px;"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>



<cfloop query="AllTeachers">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;"><strong>#TRIM(AllTeachers.FirstName)# #TRIM(AllTeachers.LastName)#</strong></td>
<td style="font-size:11px;color:##444444;"><a href="mailto:#TRIM(AllTeachers.emailaddress)#">#TRIM(AllTeachers.emailaddress)#</a><br>#TRIM(AllTeachers.Password)#</td>
<td width="40" align="right"><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?SchoolID=#SchoolID#&updatemode=editstaff&contactID=#AllTeachers.ContactID#"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Teacher" border="0"></a>&nbsp;<a href="javascript:confirmTeacherDelete('#request.webroot#/administration/act_delete_teacher.cfm?SchoolID=#SchoolID#&contactID=#AllTeachers.ContactID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Teacher" border="0"></a></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="3"><hr width="100%" size="1" color="silver"></td>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
</tr>

</cfloop>


</table><br><br>


</cfoutput>