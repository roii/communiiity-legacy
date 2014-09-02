<cfoutput>

<cfquery name="AllCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM OrgCats
ORDER BY DisplayOrder
</cfquery>

<table width="100%" cellpadding="6" cellspacing="0" style="border:solid 1px ##b4b4b4;">

<tr>
<td>

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<form method="post" action="#request.webroot#/index.cfm">
	<input type="hidden" name="fuseaction" value="#fuseaction#">
	<input type="hidden" name="fusesubaction" value="#fusesubaction#">
	<input type="hidden" name="documentID" value="#documentID#">
	<input type="hidden" name="displayresults" value="1">
	<input type="hidden" name="contacts_StartRow" value="1">
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="middle">Search: <select name="SearchField" class="whitefield" align="absmiddle">
	<option value="Organisation"<cfif session.SearchField EQ 'Organisation'> selected</cfif>>Organisation Name
	<option value="City"<cfif session.SearchField EQ 'City'> selected</cfif>>City
	<option value="Country"<cfif session.SearchField EQ 'Country'> selected</cfif>>Country
	</select> for <input type="text" class="whitefield" name="contact_keywords" style="width:120px;" align="absmiddle" value="#TRIM(session.contact_keywords)#"> <input type="image" src="#request.imageroot#/button_search.gif" align="absmiddle"></td>
	<td align="right" style="color:###TRIM(AllSettings.DkTextColor)#;" valign="middle"><select name="OrgCatID" class="whitefield">
	<option value="ALL"<cfif session.OrgCatID EQ 'ALL'> selected</cfif>>ALL Categories
	<cfloop query="AllCats">
	<option value="#AllCats.OrgCatID#"<cfif session.OrgCatID EQ AllCats.OrgCatID> selected</cfif>>#TRIM(AllCats.CatName)#
	</cfloop>
	</select></td>
	</tr>
	</form>
	
	</table>


</td>
</tr>

</table>



	
	<cfquery name="OrgResults" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT Organisations.OrganisationID, Organisations.Organisation_Name, Organisations.CompanyCode, Organisations.WorkPhone, Organisations.EmailAddress, Organisations.City, Organisations.WebsiteURL, Countries.Name, OrgCats.CatName
	FROM KidOrgLinks, Organisations, Countries, OrgCats
	WHERE KidOrgLinks.ContactID=#session.UserID#
	AND KidOrgLinks.OrganisationID=Organisations.OrganisationID
	AND Organisations.CountryID=Countries.CountryID
	AND Organisations.OrgCatID=OrgCats.OrgCatID
	
	<cfif session.contact_keywords NEQ ''>
		
		<cfif session.searchfield EQ 'Organisation'>
			AND Organisations.Organisation_name LIKE '%#session.contact_keywords#%'
		<cfelseif session.searchfield EQ 'City'>
			AND Organisations.City LIKE '%#session.contact_keywords#%'		
		<cfelseif session.searchfield EQ 'Country'>
			AND Countries.Name LIKE '%#session.contact_keywords#%'
		</cfif>
		
	</cfif>
	
	<cfif session.OrgCatID NEQ 'ALL'>
		AND Organisations.OrgCatID = #session.OrgCatID#
	</cfif>
	
	ORDER BY #session.orgs_sortby# #session.sortorder#
	</cfquery>
	
	
	
	
	<!--- SET THE contacts_endrow VALUE --->
	<cfif session.contacts_MaxRows NEQ 'ALL'>
	
		<cfif OrgResults.RecordCount GT (session.contacts_StartRow+session.contacts_MaxRows)-1>
			<cfset contacts_endrow = session.contacts_StartRow+session.contacts_MaxRows-1>
		<cfelse>
			<cfset contacts_endrow = OrgResults.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset contacts_endrow = OrgResults.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.contacts_Startrow GT session.contacts_Maxrows>
		<cfset prev = session.contacts_Startrow-session.contacts_Maxrows>
	
	<cfelse>
		<cfset prev = session.contacts_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif contacts_endrow LT OrgResults.RecordCount>
		<cfset next = (contacts_endrow+1)>
	
	<cfelse>
		<cfset next = session.contacts_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.contacts_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(OrgResults.RecordCount/session.contacts_Maxrows)>
		<cfset contactsNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset contactsNumberCount=1>
		
	</cfif>
	<br>
		
	<table width="100%" cellpadding="0" cellspacing="1" border="0">
	
	<tr>
	<td colspan="5" style="color:###TRIM(AllSettings.DkTextColor)#;">Your search retreived <strong>#OrgResults.recordcount# records</strong></td>
	<td colspan="3" align="right"><cfif OrgResults.RecordCount>::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=10&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">10</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=20&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=50&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_maxrows=ALL&contacts_StartRow=1&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></cfif></td>
	</tr>
	
	
	<cfif OrgResults.RecordCount>
	
	<tr>
	<td colspan="8" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
	</tr>
	
	<tr bgcolor="###TRIM(AllSettings.DkBoxColour)#" height="25">
	<td style="padding-left:10px;" colspan="2"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orgs_sortby=organisations.Organisation_Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">Name </a></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orgs_sortby=organisations.Organisation_name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">Code</a></td>
	<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center">Phone</td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orgs_sortby=organisations.city&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">City</a></td>
	<td align="center"><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&orgs_sortby=countries.name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>&documentID=#documentID#&displayresults=1" style="color:###TRIM(AllSettings.DkBoxTextColour)#;">Country</a></td>
	<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;" align="center">Category</td>
	<td style="padding-left:10px;"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<cfloop query="OrgResults" startrow="#session.contacts_StartRow#" endrow="#contacts_endrow#">
	
	<tr>
	<td style="padding-left:10px;" valign="top"><a href="#request.webroot#/contacts/dsp_contact_details_popup.cfm?organisationID=#OrgResults.organisationID#" target="ContactDetails" onclick="fdbackwindow=window.open ('','ContactDetails','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=800,height=650,top=10,left=10')">#TRIM(OrgResults.Organisation_Name)#</a></td>
	<td align="right" valign="top" width="50" style="padding-right:5px;"><cfif TRIM(OrgResults.EmailAddress) NEQ ''><a href="mailto:#TRIM(OrgResults.EmailAddress)#" style="text-decoration:none;color:###TRIM(AllSettings.BoxColour)#" title="#TRIM(OrgResults.EmailAddress)#">[email]</a><cfelse>&ndash;</cfif></td>
	<td valign="top" align="center"><cfif TRIM(OrgResults.CompanyCode) NEQ 'self'>#TRIM(OrgResults.CompanyCode)#<cfelse>&ndash;</cfif></td>
	<td align="center" valign="top"><cfif TRIM(OrgResults.WorkPhone) NEQ ''>#TRIM(OrgResults.WorkPhone)#<cfelse>&ndash;</cfif></td>
	<td valign="top" align="center"><cfif TRIM(OrgResults.City) NEQ ''>#TRIM(OrgResults.City)#<cfelse>&ndash;</cfif></td>
	<td valign="top" align="center"><cfif TRIM(OrgResults.Name) NEQ ''>#TRIM(OrgResults.Name)#<cfelse>&ndash;</cfif></td>
	<td valign="top" align="center"><cfif TRIM(OrgResults.CatName) NEQ ''>#TRIM(OrgResults.CatName)#<cfelse>&ndash;</cfif></td>
	<td style="padding-left:10px;" valign="top"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="8" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	<tr>
	<td colspan="8" align="right"><cfif session.contacts_Startrow GT session.contacts_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_Startrow=#prev#" style="color:###TRIM(AllSettings.BoxColour)#;">Prev Page</a> | </cfif><cfif contacts_endrow LT OrgResults.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_Startrow=#next#" style="color:###TRIM(AllSettings.BoxColour)#;">Next Page</a> &gt;</cfif><cfif session.contacts_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#contactsNumberCount#" index="NumberCount"><cfset thisStartRow=(session.contacts_Maxrows*NumberCount-session.contacts_Maxrows+1)><cfif thisStartRow EQ session.contacts_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&contacts_Startrow=#thisStartRow#" style="color:###TRIM(AllSettings.BoxColour)#;"></cfif><cfif session.contacts_StartRow EQ NumberCount><strong></cfif>#NumberCount#<cfif session.contacts_StartRow EQ NumberCount></strong></cfif><cfif thisStartRow EQ session.contacts_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ contactsNumberCount> - </cfif></cfloop></cfif></td>
	</tr>
	</cfif>
	
	</table>
	
	
	


</cfoutput>