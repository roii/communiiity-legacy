<cfoutput>

<script language="JavaScript">
	<!--
	function confirmFulfilmentDelete(aURL) {
	    if(confirm('Are you sure you want to delete this fulfilment house?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>

<cfparam name="houses_sortby" default="businessname">
<cfparam name="sortorder" default="ASC">

	
<cfinclude template="qry_all_fulfilment_houses.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="section_subheader" width="100%">#TRIM(SectionDetails.Title)#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a><cfif #sectionDetails.Admin# EQ 1>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&sectionType=documenthandling')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Section" border="0"></a></cfif></cfif></td>
</tr>


<tr>
<td class="section_header" width="100%">Manage Fulfilment Houses</td>
<td align="right" width="30"> </td>
</tr>


</table><br>




<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small"><a href="#request.webroot#/admin/dsp_fulfilmenthouse_add.cfm" target="addAdmin" ONCLICK="fdbackwindow=window.open ('','addAdmin','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=600,height=360,top=10,left=10')" style="color:red; text-decoration:none;"><strong>ADD A FULFILMENT HOUSE »</strong></a>

<hr width="100%" size="1" color="e2e2e2">
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&houses_sortby=businessname&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&houses_sortby=businessname&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Business Name</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&houses_sortby=EmailAddress&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&houses_sortby=EmailAddress&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Email Address</a></span></td>
	<td align="right"><span class="normal">&nbsp;</span></td>
	</tr>
	
	<tr>
	<td colspan="3"><hr width="100%" size="1" color="e2e2e2" noshade></td>
	</tr>
	
	<cfloop query="allhouses">	
	
	<tr>
	<td><span class="normal">#businessname#</span></td>
	<td><span class="normal">#EmailAddress#</span></td>		
	<td align="right"><a href="#request.webroot#/admin/dsp_fulfilmenthouse_edit.cfm?fulfilmenthouseID=#fulfilmenthouseID#" target="edithouse" ONCLICK="fdbackwindow=window.open ('','edithouse','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Kid" border="0"></a>&nbsp;<a 
	href="javascript:confirmFulfilmentDelete('#request.webroot#/admin/act_fulfilmenthouse_delete.cfm?fulfilmenthouseID=#fulfilmenthouseID#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Kid" border="0"></a></td>
	</tr>
	
	</cfloop>
	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table>


</cfoutput>