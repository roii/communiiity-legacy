<cfoutput>

<cfparam name="session.schools_sortby" default="SchoolName">
	<cfif IsDefined("schools_sortby")>
		<cfset session.schools_sortby = schools_sortby>
	</cfif>

<cfparam name="session.sortorder" default="ASC">
	<cfif IsDefined("sortorder")>
		<cfset session.sortorder = sortorder>
	</cfif>

<cfparam name="deletedmode" default="hide">


<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Schools_StartRow" default="1">
</cflock>

	<cfif isdefined("Schools_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Schools_StartRow = Schools_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Schools_MaxRows" default="50">
</cflock>

	<cfif isdefined("Schools_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Schools_MaxRows = Schools_MaxRows>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.search_field" default="Name">
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


<script language="JavaScript">
	<!--
	function confirmSchoolDelete(aURL) {
	    if(confirm('Are you sure you want to delete this school?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>
	
	
<cfinclude template="qry_all_schools.cfm">




<!--- SET THE Schools_endrow VALUE --->
	<cfif session.Schools_MaxRows NEQ 'ALL'>
	
		<cfif allschools.RecordCount GT (session.Schools_StartRow+session.Schools_MaxRows)-1>
			<cfset Schools_endrow = session.Schools_StartRow+session.Schools_MaxRows-1>
		<cfelse>
			<cfset Schools_endrow = allschools.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset Schools_endrow = allschools.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.Schools_Startrow GT session.Schools_Maxrows>
		<cfset prev = session.Schools_Startrow-session.Schools_Maxrows>
	
	<cfelse>
		<cfset prev = session.Schools_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif Schools_endrow LT allschools.RecordCount>
		<cfset next = (Schools_endrow+1)>
	
	<cfelse>
		<cfset next = session.Schools_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.Schools_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(allschools.RecordCount/session.Schools_Maxrows)>
		<cfset SchoolsNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset SchoolsNumberCount=1>
		
	</cfif>
	
	
	
	
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE Schools</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
<a href="#request.webroot#/administration/dsp_add_school.cfm" target="AddSchool" onclick="fdbackwindow=window.open ('','AddSchool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=600,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A SCHOOL &raquo;</strong></a><br>
<img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
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
	<input type="hidden" name="Schools_StartRow" value="1">
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="middle">Search: <select name="search_field" class="whitefield" align="absmiddle">
	<option value="SchoolName"<cfif session.search_field EQ 'SchoolName'> selected</cfif>>Name
	<option value="City"<cfif session.search_field EQ 'City'> selected</cfif>>City
	<option value="State"<cfif session.search_field EQ 'State'> selected</cfif>>State
	<option value="Country"<cfif session.search_field EQ 'Country'> selected</cfif>>Country
	<option value="Notes"<cfif session.search_field EQ 'Notes'> selected</cfif>>Notes
	</select> for <input type="text" class="whitefield" name="search_keywords" style="width:120px;" align="absmiddle" value="#TRIM(session.search_keywords)#"> <input type="image" src="#request.imageroot#/button_search.gif" align="absmiddle"></td>
	</tr>
	</form>
	
	</table>


</td>
</tr>

</table><br>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
Deleted: <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&deletedmode=show" style="color:###TRIM(AllSettings.BoxColour)#;">show</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&deletedmode=hide" style="color:###TRIM(AllSettings.BoxColour)#;">hide</a></td>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Schools_maxrows=20&Schools_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Schools_maxrows=50&Schools_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Schools_maxrows=100&Schools_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Schools_maxrows=ALL&Schools_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
</tr>

<tr>
<td colspan="2">

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<cfif session.schools_sortby CONTAINS 'TotalMembers'>
	
	<tr>
	<td colspan="7" bgcolor="###TRIM(AllSettings.BoxColour)#" height="20" style="color:white;">&nbsp;<strong>SCHOOLS WITH MEMBERS</strong></td>
	</tr>
	
	</cfif>
	
	
	<tr>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=schools.SchoolName&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>">Name</a></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=schools.City&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>City</strong></a></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=Countries.Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Country</strong></a></td>
	<td align="center"><strong>Primary Contact</strong></td>
	<td align="center"><strong>Students</strong></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=TotalMembers&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Members</strong></a></td>
	<td align="right"> </td>
	</tr>
	
	<tr>
	<td colspan="7"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<cfloop query="allschools" startrow="#session.Schools_StartRow#" endrow="#Schools_endrow#">

	<cfset this_PrimaryContact = allschools.PrimaryContact>
	
	<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE SchoolID=#allschools.SchoolID#
	AND ContactTypeID=1
	GROUP BY ContactID
	ORDER BY ContactID
	</cfquery>
	
	
	<cfif IsNumeric("#this_PrimaryContact#") AND this_PrimaryContact NEQ 0>
	
		<!--- GET PRIMARY CONTACT DETAILS --->
		<cfquery name="PrimaryContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
		SELECT FirstName, Lastname, EmailAddress
		FROM Contacts
		WHERE ContactID=#this_PrimaryContact#
		</cfquery>
	
	</cfif>
		
	<tr>
	<td<cfif allschools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif>><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?SchoolID=#allschools.SchoolID#&updatemode=viewprofile" target="editSchool" onclick="fdbackwindow=window.open ('','editSchool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#TRIM(allschools.SchoolName)#</a></td>
	<td<cfif allschools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center">#TRIM(allschools.City)#</td>
	<td<cfif allschools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center">#TRIM(allschools.Name)#</td>
	<td<cfif allschools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center"><cfif IsNumeric("#this_PrimaryContact#") AND this_PrimaryContact NEQ 0><cfif TRIM(PrimaryContactStuff.EmailAddress) NEQ ''><a href="mailto:#TRIM(PrimaryContactStuff.EmailAddress)#"></cfif>#TRIM(PrimaryContactStuff.FirstName)# #TRIM(PrimaryContactStuff.LastName)#</a><cfelse>&ndash;</cfif></td>
	<td<cfif allschools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center">#TRIM(allschools.NumberStudents)#</td>
	<td align="center"<cfif allschools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif>><cfif session.schools_sortby CONTAINS 'TotalMembers'><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#allschools.SchoolID#&updatemode=students" target="editschool" ONCLICK="fdbackwindow=window.open ('','editschool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#allschools.TotalMembers#</a><cfelse><cfif AllKids.RecordCount><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?schoolID=#allschools.SchoolID#&updatemode=students" target="editschool" ONCLICK="fdbackwindow=window.open ('','editschool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#AllKids.RecordCount#</a><cfelse>0</cfif></cfif></td>		
	<td align="right"><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?SchoolID=#allschools.SchoolID#&updatemode=updatedetails" target="editSchool" onclick="fdbackwindow=window.open ('','editSchool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit School" border="0"></a>&nbsp;<a href="javascript:confirmSchoolDelete('#request.webroot#/administration/act_delete_school.cfm?SchoolID=#allschools.SchoolID#&caller=schools')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete School" border="0"></a><a href="#request.webroot#/administration/act_swap_school.cfm?schoolID=#AllSchools.SchoolID#&schoolname=#TRIM(allschools.SchoolName)#">L</a></td>
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
	
	
	<cfif session.schools_sortby CONTAINS 'TotalMembers'>
	
		<cfquery name="NoMemberSchools" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Schools.SchoolID, Schools.SchoolName, Schools.Phone, Schools.Website, Schools.City, Schools.State, Schools.RegionID, Schools.NumberStudents, Schools.NumberStaff, Schools.NumberComputers, Schools.ContactFirstName, Schools.ContactLastName, Schools.ContactEmail, Schools.SchoolStatus, Schools.PrimaryContact, Countries.Name
	FROM Schools, Countries
	WHERE Schools.SchoolID NOT IN (#valueList(AllSchools.SchoolID)#) 
	AND Schools.CountryID=Countries.CountryID
	
	
	
	<cfif session.search_keywords NEQ ''>
		
		<cfif session.search_field EQ 'Name'>
			AND Schools.SchoolName LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'City'>
			AND Schools.City LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'State'>
			AND Schools.State LIKE '%#session.search_keywords#%'		
		<cfelseif session.search_field EQ 'Country'>
			AND Countries.Name LIKE '%#session.search_keywords#%'	
		<cfelseif session.search_field EQ 'Notes'>
			AND Schools.Notes LIKE '%#session.search_keywords#%'
		</cfif>
		
	</cfif>
		
		
	GROUP BY Schools.SchoolID, Schools.SchoolName, Schools.Phone, Schools.Website, Schools.City, Schools.State, Schools.RegionID, Schools.NumberStudents, Schools.NumberStaff, Schools.NumberComputers, Schools.ContactFirstName, Schools.ContactLastName, Schools.ContactEmail, Schools.SchoolStatus, Schools.PrimaryContact, Countries.Name
	ORDER BY Schools.SchoolName
	</cfquery>
	
		<br><br>
		
		<table width="100%" cellpadding="0" cellspacing="0" border="0">
		
		<tr>
		<td colspan="7" bgcolor="###TRIM(AllSettings.BoxColour)#" height="20" style="color:white;">&nbsp;<strong>SCHOOLS WITHOUT MEMBERS</strong></td>
		</tr>
		
		
		<tr>
		<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=schools.SchoolName&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>">Name</a></td>
		<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=schools.City&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>City</strong></a></td>
		<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=Countries.Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Country</strong></a></td>
		<td align="center"><strong>Primary Contact</strong></td>
		<td align="center"><strong>Students</strong></td>
		<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&schools_sortby=TotalMembers&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Members</strong></a></td>
		<td align="right"> </td>
		</tr>
		
		<tr>
		<td colspan="7"><hr width="100%" size="1" color="e2e2e2"></td>
		</tr>
		
		
		
		
		<cfloop query="NoMemberSchools" startrow="#session.Schools_StartRow#" endrow="#Schools_endrow#">
	
		<cfset this_PrimaryContact = NoMemberSchools.PrimaryContact>
		
				
		<cfif IsNumeric("#this_PrimaryContact#") AND this_PrimaryContact NEQ 0>
		
			<!--- GET PRIMARY CONTACT DETAILS --->
			<cfquery name="PrimaryContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
			SELECT FirstName, Lastname, EmailAddress
			FROM Contacts
			WHERE ContactID=#this_PrimaryContact#
			</cfquery>
		
		</cfif>
			
		<tr>
		<td<cfif NoMemberSchools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif>><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?SchoolID=#NoMemberSchools.SchoolID#&updatemode=viewprofile" target="editSchool" onclick="fdbackwindow=window.open ('','editSchool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#TRIM(NoMemberSchools.SchoolName)#</a></td>
		<td<cfif NoMemberSchools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center">#TRIM(NoMemberSchools.City)#</td>
		<td<cfif NoMemberSchools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center">#TRIM(NoMemberSchools.Name)#</td>
		<td<cfif NoMemberSchools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center"><cfif IsNumeric("#this_PrimaryContact#") AND this_PrimaryContact NEQ 0><cfif TRIM(PrimaryContactStuff.EmailAddress) NEQ ''><a href="mailto:#TRIM(PrimaryContactStuff.EmailAddress)#"></cfif>#TRIM(PrimaryContactStuff.FirstName)# #TRIM(PrimaryContactStuff.LastName)#</a><cfelse>&ndash;</cfif></td>
		<td<cfif NoMemberSchools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif> align="center">#TRIM(NoMemberSchools.NumberStudents)#</td>
		<td align="center"<cfif NoMemberSchools.SchoolStatus EQ 'deleted'> style="text-decoration: line-through;"</cfif>>0</td>		
		<td align="right"><a href="#request.webroot#/administration/dsp_edit_school_popup.cfm?SchoolID=#NoMemberSchools.SchoolID#&updatemode=updatedetails" target="editSchool" onclick="fdbackwindow=window.open ('','editSchool','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit School" border="0"></a>&nbsp;<a href="javascript:confirmSchoolDelete('#request.webroot#/administration/act_delete_school.cfm?SchoolID=#NoMemberSchools.SchoolID#&caller=schools')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete School" border="0"></a><a href="#request.webroot#/administration/act_swap_school.cfm?schoolID=#NoMemberSchools.SchoolID#&schoolname=#TRIM(NoMemberSchools.SchoolName)#">L</a></td>
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

	</cfif>
	
	<br>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><b>Total: #Totalschools.recordcount#</b></td>
	</tr>
	
	</table>
	
	
	<hr width="100%" size="1" color="e2e2e2">
	
	<div align="right"><cfif session.Schools_Startrow GT session.Schools_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Schools_Startrow=#prev#">Prev Page</a> | </cfif><cfif Schools_endrow LT allschools.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Schools_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Schools_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#SchoolsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Schools_Maxrows*NumberCount-session.Schools_Maxrows+1)><cfif thisStartRow EQ session.Schools_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Schools_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Schools_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ SchoolsNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>


</td>
</tr>

</table>


</cfoutput>