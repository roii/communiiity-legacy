<!--- GET ALL TEACHERS AND ADMINISTRATORS --->
<cfquery name="AllTeachers" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT ContactID, FirstName, Lastname, EmailAddress
FROM Contacts
WHERE SchoolID=#SchoolID#
AND ContactTypeID IN (5,6)
ORDER BY FirstName
</cfquery>

<cfif IsNumeric("#SchoolStuff.PrimaryContact#") AND SchoolStuff.PrimaryContact NEQ 0>

	<cfquery name="PrimaryContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, Lastname, EmailAddress
	FROM Contacts
	WHERE ContactID=#SchoolStuff.PrimaryContact#
	</cfquery>

</cfif>


<cfquery name="CountryStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Name
FROM Countries
WHERE CountryID=#SchoolStuff.CountryID#
</cfquery>

<cfquery name="RegionStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT Region
FROM Region
WHERE RegionID=#SchoolStuff.RegionID#
</cfquery>


<cfoutput>


<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Name:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(SchoolStuff.SchoolName)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Phone:</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(SchoolStuff.Phone)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Website URL</strong></td>
<td style="font-size:11px;color:##444444;"><a href="#TRIM(SchoolStuff.Website)#" target="_Blank">#TRIM(SchoolStuff.Website)#</a></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Address</strong></td>
<td style="font-size:11px;color:##444444;" valign="top"><cfif TRIM(SchoolStuff.Address1) NEQ ''>#TRIM(SchoolStuff.Address1)#<br></cfif>
<cfif TRIM(SchoolStuff.Address2) NEQ ''>#TRIM(SchoolStuff.Address2)#</cfif></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" valign="top" width="110"><strong>City/Town</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(SchoolStuff.City)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
<td colspan="2"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Country</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(CountryStuff.Name)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
<td colspan="2"></td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>Region</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(RegionStuff.Region)#</td>
</tr>


<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>No. of Students</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(SchoolStuff.NumberStudents)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>No. of Staff</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(SchoolStuff.NumberStaff)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110"><strong>No. of Computers</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(SchoolStuff.NumberComputers)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Primary Contact</strong></td>
<td valign="top" style="font-size:11px;color:##444444;"><cfif IsNumeric("#SchoolStuff.PrimaryContact#") AND SchoolStuff.PrimaryContact NEQ 0>#TRIM(PrimaryContactStuff.FirstName)# #TRIM(PrimaryContactStuff.LastName)#<br>
<a href="mailto:#TRIM(PrimaryContactStuff.EmailAddress)#">#TRIM(PrimaryContactStuff.EmailAddress)#</a><cfelse>Un-assigned</cfif></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Logo</strong></td>
<td style="font-size:11px;color:##444444;"><cfif fileExists("#request.fileroot#\images\schools\#TRIM(SchoolStuff.LogoFile)#")><img src="#request.imageroot#/schools/#TRIM(SchoolStuff.LogoFile)#" border="0"></cfif></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td style="font-size:11px;color:##444444;" width="110" valign="top"><strong>Notes</strong></td>
<td style="font-size:11px;color:##444444;">#TRIM(SchoolStuff.Notes)#</td>
</tr>

<tr>
<td width="10"><img src="#request.imageroot#/transparent_spc.gif" width="10" height="1" border="0"></td>
<td colspan="2"><hr width="100%" size="1" color="silver"></td>
</tr>


</table><br><br>


</cfoutput>