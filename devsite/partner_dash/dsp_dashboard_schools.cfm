<cfoutput>

<!--- ALL SCHOOLS --->

<cfquery name="TotalActiveSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT count(SchoolID) as TotalSchools
FROM Schools
WHERE SchoolStatus <> 'deleted'
</cfquery>

<cfquery name="AllSchools2" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID
FROM Schools
WHERE SchoolStatus <> 'deleted'
GROUP BY SchoolID
</cfquery>

<cfset schoolswithstudents = 0>

<cfloop query="AllSchools2">
<cfset this_schoolID=AllSchools2.SchoolID>

<cfquery name="FindStudents" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE SchoolID=#this_schoolID#
AND ContactTypeID IN (1,2)
</cfquery>

<cfif FindStudents.RecordCount>
<cfset schoolswithstudents = (schoolswithstudents + 1)>
</cfif>
</cfloop>


<!--- GET ALL SCHOOL CONTACTS --->
<cfquery name="AllSchoolContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Count(ContactID) AS totalSchoolContacts
FROM Contacts
WHERE (ContactStatus LIKE '%Active%' OR ContactStatus LIKE '%Pending%')
AND ContactTypeID = 6
</cfquery>

<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Schools</strong></td>
	<td align="right" valign="bottom"><!--- <img src="#request.imageroot#/SiteIcons/schools_sml.jpg" alt="Schools" border="0"> ---></td>
	</tr>
	
	</table>


</td>
</tr>

<tr>
<td height="3" colspan="3" bgcolor="###TRIM(AllSettings.BoxColour)#"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="3" border="0"></td>
</tr>

<tr>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
<td><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"><br>



	<table width="100%" cellpadding="0" cellspacing="0" border="0" align="center">
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Number of Schools:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#TotalActiveSchools.TotalSchools#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Schools with registered members:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#schoolswithstudents#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Staff Registered:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllSchoolContacts.totalSchoolContacts#</td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td style="color:Black;font-size:11px;padding-left:5px;">Total points earned for schools:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#INT(AllEarned.TotalEarned/10)#</td>
	</tr>	
	
	<tr>
	<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>	
	
	</table>


</td>
<td width="1" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td height="1" colspan="3" bgcolor="##b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

</table>


</cfoutput>