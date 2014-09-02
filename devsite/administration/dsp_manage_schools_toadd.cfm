<cfoutput>

<cfquery name="AllSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT SchoolName
FROM Schools
WHERE Schools.SchoolStatus LIKE '%Active%'
ORDER BY SchoolName
</cfquery>


<cfinclude template="qry_all_schools_toadd.cfm">

	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE Schools to-add</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"></td>
</tr>

</table>




<table width="100%" cellpadding="0" cellspacing="0" border="0">


<tr>
<td colspan="2">
	
	<select class="whitefield">
	<cfloop query="AllSchools">
	<option>#TRIM(AllSchools.SchoolName)#
	</cfloop>
	</select><br><br>
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><strong>Name</strong></td>
	<td align="center"><strong>Phone</strong></td>
	<td><strong>Address</strong></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<cfloop query="AllSchoolsToAdd">
	
	<cfset this_schoolname = AllSchoolsToAdd.School_Other>

	<cfquery name="CountryStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT name
	FROM Countries
	WHERE CountryID=#AllSchoolsToAdd.CountryID#
	</cfquery>
	
			
	<tr>
	<td valign="top"><a href="#request.webroot#/administration/dsp_school_toadd_popup.cfm?SchoolName=#AllSchoolsToAdd.School_Other#&ThisCountryID=#AllSchoolsToAdd.CountryID#&ContactID=#AllSchoolsToAdd.ContactID#&city=#AllSchoolsToAdd.City#&Phone=#AllSchoolsToAdd.School_Other_Phone#" target="editSchool" onclick="fdbackwindow=window.open ('','editSchool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#TRIM(this_schoolname)#</a></td>
	<td align="center" valign="top">#TRIM(AllSchoolsToAdd.School_Other_Phone)#</td>
	<td valign="top"><cfif TRIM(AllSchoolsToAdd.School_Other_Address) NEQ ''>#TRIM(AllSchoolsToAdd.School_Other_Address)#<br></cfif>
	#TRIM(AllSchoolsToAdd.City)#<br>
	#TRIM(CountryStuff.Name)#</td>
	</tr>
	
	<tr>
	<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="3" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>

	
	<br>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><b>Total: #AllSchoolsToAdd.recordcount#</b></td>
	</tr>
	
	</table>
	
	

</td>
</tr>

</table>


</cfoutput>