<cfoutput>


<cfquery name="TotalSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolID, CountryID
FROM Schools
WHERE SchoolStatus LIKE '%Active%'
</cfquery>


<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, ParentsEmail
FROM Contacts
WHERE SchoolID=#session.User_SchoolID#
AND ContactTypeID=1
</cfquery>

<cfif AllKids.RecordCount>
	<cfset AllSchoolKids = valueList(AllKids.ContactID)>
<cfelse>
	<cfset AllSchoolKids = "99999999999">
</cfif>

<cfquery name="AllKidParents" dbtype="query">
SELECT ContactID
FROM AllKids
WHERE ParentsEmail <> ''
</cfquery>

<cfif AllKids.RecordCount>
	<!--- GENERATE THE PERCENT OF TOTAL STUDENTS ENROLLED IN my3p --->
	<cfset percentoftotal = (AllKids.RecordCount/SchoolStuff.NumberStudents) * 100>
<cfelse>
	<cfset percentoftotal = 0>
</cfif>
	
<cfquery name="AllContacts" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Contacts.ContactID, Contacts.Categories
FROM Contacts, KidClientLinks
WHERE KidClientLinks.KidID IN (#AllSchoolKids#)
AND KidClientLinks.ClientID=Contacts.ContactID
AND Contacts.ContactStatus <> 'Deleted'
</cfquery>


<cfquery name="AllClients" dbtype="query">
SELECT ContactID
FROM AllContacts
WHERE Categories LIKE '4' 
OR Categories LIKE '%,4' 
OR Categories LIKE '4,%' 
OR Categories LIKE '%,4,%'
</cfquery>



<!--- GET ALL TEACHERS AND ADMINISTRATORS --->
<cfquery name="AllTeachers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID
FROM Contacts
WHERE SchoolID=#session.User_SchoolID#
AND ContactTypeID IN (5,6)
</cfquery>

<cfif AllTeachers.RecordCount>
	<cfset AllSchoolTeachers = valueList(AllTeachers.ContactID)>
<cfelse>
	<cfset AllSchoolTeachers = "999999999">
</cfif>


<cfset schoolcountrylist = ''>

<!--- GENERATE COUNTRIES --->
<cfloop query="totalSchools">

	<cfif ListFind(schoolcountrylist, totalSchools.CountryID, ",")>
	<cfelse>
		<cfset schoolcountrylist = "#schoolcountrylist#,#totalSchools.CountryID#">
	</cfif>

</cfloop>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="center" height="20" colspan="3">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="font-size:14px;font-family:ArialBlack;color:###TRIM(AllSettings.BoxColour)#;" valign="bottom"><strong>Community</strong></td>
	<td align="right" valign="bottom"><img src="#request.imageroot#/SiteIcons/Community_sml.jpg" alt="Community" border="0"></td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Students:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllKids.RecordCount#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">% of total students:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#decimalFormat(percentoftotal)# %</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Parents:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllKidParents.recordcount#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Teachers:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllTeachers.recordcount#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Contacts:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllContacts.RecordCount#</td>
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
	<td style="color:Black;font-size:11px;padding-left:5px;">Clients:</td>
	<td style="color:Black;font-size:11px;padding-right:5px;" align="center" width="100">#AllClients.RecordCount#</td>
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
	<td style="color:909090;font-size:11px;padding-left:5px;">Total Schools:</td>
	<td style="color:909090;font-size:11px;padding-right:5px;" align="center" width="100">#TotalSchools.recordcount#</td>
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
	<td style="color:909090;font-size:11px;padding-left:5px;">School Countries:</td>
	<td style="color:909090;font-size:11px;padding-right:5px;" align="center" width="100">#Listlen(schoolcountrylist, ",")#</td>
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