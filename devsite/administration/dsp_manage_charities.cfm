<cfoutput>

<cfparam name="session.Charities_sortby" default="Organisations.Organisation_Name">
	<cfif IsDefined("Charities_sortby")>
		<cfset session.Charities_sortby = Charities_sortby>
	</cfif>

<cfparam name="session.sortorder" default="ASC">
	<cfif IsDefined("sortorder")>
		<cfset session.sortorder = sortorder>
	</cfif>


<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Charities_StartRow" default="1">
</cflock>

	<cfif isdefined("Charities_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Charities_StartRow = Charities_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Charities_MaxRows" default="50">
</cflock>

	<cfif isdefined("Charities_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Charities_MaxRows = Charities_MaxRows>
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
	function confirmCharityDelete(aURL) {
	    if(confirm('#charitydelalert#?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>
	
	
<cfinclude template="qry_all_charities.cfm">




<!--- SET THE Charities_endrow VALUE --->
	<cfif session.Charities_MaxRows NEQ 'ALL'>
	
		<cfif allCharities.RecordCount GT (session.Charities_StartRow+session.Charities_MaxRows)-1>
			<cfset Charities_endrow = session.Charities_StartRow+session.Charities_MaxRows-1>
		<cfelse>
			<cfset Charities_endrow = allCharities.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset Charities_endrow = allCharities.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.Charities_Startrow GT session.Charities_Maxrows>
		<cfset prev = session.Charities_Startrow-session.Charities_Maxrows>
	
	<cfelse>
		<cfset prev = session.Charities_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif Charities_endrow LT allCharities.RecordCount>
		<cfset next = (Charities_endrow+1)>
	
	<cfelse>
		<cfset next = session.Charities_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.Charities_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(allCharities.RecordCount/session.Charities_Maxrows)>
		<cfset CharitiesNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset CharitiesNumberCount=1>
		
	</cfif>
	
	
	
	
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>#manchar#</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
<a href="#request.webroot#/administration/dsp_add_charity.cfm" target="AddCharity" onclick="fdbackwindow=window.open ('','AddCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=600,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>#addacharity# &raquo;</strong></a><br>
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
	<input type="hidden" name="Charities_StartRow" value="1">
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="middle">#search#: <select name="search_field" class="whitefield" align="absmiddle">
	<option value="Name"<cfif session.search_field EQ 'Name'> selected</cfif>>#name#
	<option value="City"<cfif session.search_field EQ 'City'> selected</cfif>>#City#
	<option value="State"<cfif session.search_field EQ 'State'> selected</cfif>>#State#
	<option value="Country"<cfif session.search_field EQ 'Country'> selected</cfif>>#CountryText#
	<option value="Notes"<cfif session.search_field EQ 'Notes'> selected</cfif>>#Notes#
	</select> #for# <input type="text" class="whitefield" name="search_keywords" style="width:120px;" align="absmiddle" value="#TRIM(session.search_keywords)#"> 
	<input type="image" src="#request.imageroot#/button_search.gif" align="absmiddle"></td>
	</tr>
	</form>
	
	</table>


</td>
</tr>

</table><br>



<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: #View# - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Charities_maxrows=20&Charities_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Charities_maxrows=50&Charities_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Charities_maxrows=100&Charities_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Charities_maxrows=ALL&Charities_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">#ALL#</a></td>
</tr>

<tr>
<td>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<cfif session.Charities_sortby CONTAINS 'TotalMembers'>
	
	<tr>
	<td colspan="7" bgcolor="###TRIM(AllSettings.BoxColour)#" height="20" style="color:white;">&nbsp;<strong>#charitieswithmem#</strong></td>
	</tr>
	
	</cfif>
	
	<tr>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=Organisations.Organisation_Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#name#</strong></a></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=Organisations.City&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#City#</strong></a></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=Countries.Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#CountryText#</strong></a></td>
	<td><strong>#primarycontact#</strong></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=TotalMembers&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#Members#</strong></a></td>
	<td align="right"> </td>
	</tr>
	
	<tr>
	<td colspan="6"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<cfloop query="allCharities" startrow="#session.Charities_StartRow#" endrow="#Charities_endrow#">
	
	<cfquery name="AllKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT ContactID
	FROM Contacts
	WHERE Charity=#allCharities.OrganisationID#
	AND ContactTypeID IN (1,2,5,6)
	GROUP BY ContactID
	ORDER BY ContactID
	</cfquery>
	
	
	<!--- GET PRIMARY CONTACT DETAILS --->
	<cfquery name="PrimaryContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, Lastname, EmailAddress
	FROM Contacts
	WHERE ContactID=#allCharities.PrimaryContactID#
	AND ContactStatus = 'Active'
	</cfquery>
	
		
	<tr>
	<td><a href="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#allCharities.OrganisationID#&updatemode=viewprofile" target="editCharity" onclick="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#TRIM(allCharities.Organisation_Name)#</a></td>
	<td>#TRIM(allCharities.City)#</td>
	<td>#TRIM(allCharities.Name)#</td>
	<td><a href="mailto:#TRIM(PrimaryContactStuff.EmailAddress)#">#TRIM(PrimaryContactStuff.FirstName)# #TRIM(PrimaryContactStuff.LastName)#</a></td>
	<td align="center"><cfif session.Charities_sortby CONTAINS 'TotalMembers'><a href="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#allCharities.OrganisationID#&updatemode=members" target="editCharity" ONCLICK="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#allCharities.TotalMembers#</a><cfelse><cfif AllKids.RecordCount><a href="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#allCharities.OrganisationID#&updatemode=members" target="editCharity" ONCLICK="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#AllKids.RecordCount#</a><cfelse>0</cfif></cfif></td>		
	<td align="right"><a href="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#allCharities.OrganisationID#&updatemode=updatedetails" target="editCharity" onclick="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Charity" border="0"></a>&nbsp;<a href="javascript:confirmCharityDelete('#request.webroot#/admin/act_delete_charity.cfm?OrganisationID=#allCharities.OrganisationID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Charity" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>

	
	
	
	<cfif session.Charities_sortby CONTAINS 'TotalMembers'>
	
	
	<cfquery name="NoMemberCharities" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisations.*, Countries.Name
	FROM Organisations, Countries
	WHERE Organisations.Charity=1
	AND Organisations.Organisation_Status LIKE '%Active%'
	AND Organisations.CountryID=Countries.CountryID
	AND Organisations.OrganisationID NOT IN (#ValueList(AllCharities.OrganisationID)#)
	
	<cfif session.search_keywords NEQ ''>
		
		<cfif session.search_field EQ 'Name'>
			AND Organisations.Organisation_Name LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'City'>
			AND Organisations.City LIKE '%#session.search_keywords#%'
		<cfelseif session.search_field EQ 'State'>
			AND Organisations.State LIKE '%#session.search_keywords#%'		
		<cfelseif session.search_field EQ 'Country'>
			AND Countries.Name LIKE '%#session.search_keywords#%'	
		<cfelseif session.search_field EQ 'Notes'>
			AND Organisations.Notes LIKE '%#session.search_keywords#%'
		</cfif>
		
	</cfif>
		
		
	ORDER BY Organisation_Name
	</cfquery>
	
	<br><br>
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	>
	
	<tr>
	<td colspan="7" bgcolor="###TRIM(AllSettings.BoxColour)#" height="20" style="color:white;">&nbsp;<strong>#charitieswithoutmem#</strong></td>
	</tr>
	
	
	
	<tr>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=Organisations.Organisation_Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#name#</strong></a></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=Organisations.City&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#city#</strong></a></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=Countries.Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#CountryText#</strong></a></td>
	<td><strong>#primarycontact#</strong></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Charities_sortby=TotalMembers&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>#Members#</strong></a></td>
	<td align="right"> </td>
	</tr>
	
	<tr>
	<td colspan="6"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	
	
	<cfloop query="NoMemberCharities" startrow="#session.Charities_StartRow#" endrow="#Charities_endrow#">
	
	
	<!--- GET PRIMARY CONTACT DETAILS --->
	<cfquery name="PrimaryContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, Lastname, EmailAddress
	FROM Contacts
	WHERE ContactID=#NoMemberCharities.PrimaryContactID#
	AND ContactStatus = 'Active'
	</cfquery>
	
		
	<tr>
	<td><a href="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#NoMemberCharities.OrganisationID#&updatemode=viewprofile" target="editCharity" onclick="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#TRIM(NoMemberCharities.Organisation_Name)#</a></td>
	<td>#TRIM(NoMemberCharities.City)#</td>
	<td>#TRIM(NoMemberCharities.Name)#</td>
	<td><a href="mailto:#TRIM(PrimaryContactStuff.EmailAddress)#">#TRIM(PrimaryContactStuff.FirstName)# #TRIM(PrimaryContactStuff.LastName)#</a></td>
	<td align="center">0</td>		
	<td align="right"><a href="#request.webroot#/administration/dsp_edit_charity_popup.cfm?OrganisationID=#NoMemberCharities.OrganisationID#&updatemode=updatedetails" target="editCharity" onclick="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Charity" border="0"></a>&nbsp;<a href="javascript:confirmCharityDelete('#request.webroot#/admin/act_delete_charity.cfm?OrganisationID=#NoMemberCharities.OrganisationID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Charity" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1" bgcolor="##e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="6" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	
	</cfif>
	
	<br>
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><b>#totaltxt#: #AllCharities.recordcount#</b></td>
	</tr>
	
	</table>
	
	
	<hr width="100%" size="1" color="e2e2e2">
	
	<div align="right"><cfif session.Charities_Startrow GT session.Charities_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Charities_Startrow=#prev#">Prev Page</a> | </cfif><cfif Charities_endrow LT allCharities.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Charities_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Charities_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#CharitiesNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Charities_Maxrows*NumberCount-session.Charities_Maxrows+1)><cfif thisStartRow EQ session.Charities_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Charities_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Charities_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ CharitiesNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>


</td>
</tr>

</table>


</cfoutput>