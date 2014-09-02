<cfoutput>

<cfparam name="session.Partners_sortby" default="Organisations.Organisation_Name">
	<cfif IsDefined("Partners_sortby")>
		<cfset session.Partners_sortby = Partners_sortby>
	</cfif>

<cfparam name="session.sortorder" default="ASC">
	<cfif IsDefined("sortorder")>
		<cfset session.sortorder = sortorder>
	</cfif>


<cflock Type="exclusive" scope="session" timeout="10">
	<cfparam name="session.Partners_StartRow" default="1">
</cflock>

	<cfif isdefined("Partners_StartRow")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Partners_StartRow = Partners_StartRow>
		</cflock>
	</cfif>
	
	
<cflock Type="exclusive" scope="session" timeout="10">	
	<cfparam name="session.Partners_MaxRows" default="50">
</cflock>

	<cfif isdefined("Partners_MaxRows")>	
		<cflock Type="exclusive" scope="session" timeout="10">
			<cfset session.Partners_MaxRows = Partners_MaxRows>
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
	function confirmPartnerDelete(aURL) {
	    if(confirm('Are you sure you want to delete this partner?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>
	
	
<cfinclude template="qry_all_Partners.cfm">




<!--- SET THE Partners_endrow VALUE --->
	<cfif session.Partners_MaxRows NEQ 'ALL'>
	
		<cfif allPartners.RecordCount GT (session.Partners_StartRow+session.Partners_MaxRows)-1>
			<cfset Partners_endrow = session.Partners_StartRow+session.Partners_MaxRows-1>
		<cfelse>
			<cfset Partners_endrow = allPartners.RecordCount>
		</cfif>
	
	<cfelse>
		<cfset Partners_endrow = allPartners.RecordCount>
	
	</cfif>
	
	
	
	<!--- SET THE PREV VALUE --->
	<cfif session.Partners_Startrow GT session.Partners_Maxrows>
		<cfset prev = session.Partners_Startrow-session.Partners_Maxrows>
	
	<cfelse>
		<cfset prev = session.Partners_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE NEXT VALUE --->
	<cfif Partners_endrow LT allPartners.RecordCount>
		<cfset next = (Partners_endrow+1)>
	
	<cfelse>
		<cfset next = session.Partners_StartRow>
	
	</cfif>
	
	
	
	<!--- SET THE LOOP COUNT FOR THE PAGE SKIP NUMBERS AT THE BOTTOM --->
	<cfif session.Partners_MaxRows NEQ 'ALL'>
	
		<cfset NumberCount=(allPartners.RecordCount/session.Partners_Maxrows)>
		<cfset PartnersNumberCount=Ceiling(NumberCount)>
	
	<cfelse>
	
		<cfset PartnersNumberCount=1>
		
	</cfif>
	
	
	
	
	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE PARTNERS</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5" border="0"><br>
<a href="#request.webroot#/administration/dsp_add_partner.cfm" target="AddPartner" onclick="fdbackwindow=window.open ('','AddPartner','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=600,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A PARTNER &raquo;</strong></a><br>
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
	<input type="hidden" name="Partners_StartRow" value="1">
	
	<tr>
	<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="middle">Search: <select name="search_field" class="whitefield" align="absmiddle">
	<option value="Name"<cfif session.search_field EQ 'Name'> selected</cfif>>Name
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
<td align="right">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;::: View - <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Partners_maxrows=20&Partners_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">20</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Partners_maxrows=50&Partners_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">50</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Partners_maxrows=100&Partners_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">100</a> | <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Partners_maxrows=ALL&Partners_StartRow=1" style="color:###TRIM(AllSettings.BoxColour)#;">ALL</a></td>
</tr>

<tr>
<td>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Partners_sortby=Organisations.Organisation_Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Name</strong></a></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Partners_sortby=Organisations.City&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>City</strong></a></td>
	<td><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&Partners_sortby=Countries.Name&sortorder=<cfif session.sortorder EQ 'ASC'>DESC<cfelse>ASC</cfif>"><strong>Country</strong></a></td>
	<td><strong>Primary Contact</strong></td>
	<td align="center"><strong>Active Points</strong></td>
	<td align="Center"><strong>Status</strong></td>
	<td align="right"> </td>
	</tr>
	
	<tr>
	<td colspan="7"><hr width="100%" size="1" color="e2e2e2"></td>
	</tr>
	<cfset AllTotalActivePoints = 0>
	
	<cfloop query="allPartners" startrow="#session.Partners_StartRow#" endrow="#Partners_endrow#">
	
	<cfif allPartners.PrimaryContactID NEQ ''>
	
	<!--- GET PRIMARY CONTACT DETAILS --->
	<cfquery name="PrimaryContactStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT FirstName, Lastname, EmailAddress
	FROM Contacts
	WHERE ContactID=#allPartners.PrimaryContactID#
	AND ContactStatus = 'Active'
	</cfquery>
	
	</cfif>
	
	
	<!--- GET ACTIVE POINTS --->
	<cfquery name="PointsCheck" datasource="#dsn#" username="#request.username#" password="#request.password#" maxrows="1">
	SELECT SUM(PointsRemaining) AS TotalActivePoints
	FROM SponsorPoints
	WHERE SponsorID=#allPartners.OrganisationID#
	</cfquery>
	
	<tr>
	<td><a href="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#allPartners.OrganisationID#&updatemode=viewprofile" target="editCharity" onclick="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')">#TRIM(allPartners.Organisation_Name)#</a></td>
	<td>#TRIM(allPartners.City)#</td>
	<td>#TRIM(allPartners.Name)#</td>
	<td><cfif allPartners.PrimaryContactID NEQ ''><a href="mailto:#TRIM(PrimaryContactStuff.EmailAddress)#">#TRIM(PrimaryContactStuff.FirstName)# #TRIM(PrimaryContactStuff.LastName)#</a><cfelse>&ndash;</cfif></td>
	<td align="center"><cftry><cfif PointsCheck.RecordCount><cfset AllTotalActivePoints = AllTotalActivePoints + PointsCheck.TotalActivePoints>#PointsCheck.TotalActivePoints#<cfelse>0</cfif><cfcatch></cfcatch></cftry></td>		
	<td align="Center">#TRIM(allPartners.organisation_status)#</td>
	<td align="right"><a href="#request.webroot#/administration/dsp_edit_partner_popup.cfm?OrganisationID=#allPartners.OrganisationID#&updatemode=updatedetails" target="editCharity" onclick="fdbackwindow=window.open ('','editCharity','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=600,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Partner" border="0"></a>&nbsp;<a href="javascript:confirmPartnerDelete('#request.webroot#/admin/act_delete_charity.cfm?OrganisationID=#allPartners.OrganisationID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Partner" border="0"></a></td>
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
	
	
	<tr>
	<td colspan="7" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5"><b>Total: #AllPartners.recordcount#</b></td>
	<td align="center"><strong>#AllTotalActivePoints#</strong></td>		
	<td align="right"></td>
	</tr>
	
	</table>

	
	
	
	<hr width="100%" size="1" color="e2e2e2">
	
	<div align="right"><cfif session.Partners_Startrow GT session.Partners_Maxrows>&lt; <a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Partners_Startrow=#prev#">Prev Page</a> | </cfif><cfif Partners_endrow LT allPartners.RecordCount><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Partners_Startrow=#next#">Next Page</a> &gt;</cfif><cfif session.Partners_MaxRows NEQ 'ALL'> ::: <cfloop from="1" to="#PartnersNumberCount#" index="NumberCount"><cfset thisStartRow=(session.Partners_Maxrows*NumberCount-session.Partners_Maxrows+1)><cfif thisStartRow EQ session.Partners_StartRow><span style="text-decoration:none;"><cfelse><a href="#request.webroot#/index.cfm?Fuseaction=#Fuseaction#&Fusesubaction=#Fusesubaction#&Partners_Startrow=#thisStartRow#"></cfif>#NumberCount#<cfif thisStartRow EQ session.Partners_StartRow></span><cfelse></a></cfif><cfif NumberCount NEQ PartnersNumberCount> - </cfif></cfloop></cfif>&nbsp;&nbsp;&nbsp;</div>


</td>
</tr>

</table>


</cfoutput>