<cfoutput>

<cfparam name="shoppers_sortby" default="ContactID">
<cfparam name="sortorder" default="DESC">
<cfparam name="deletedmode" default="hide">


<script language="JavaScript">
	<!--
	function confirmContactDelete(aURL) {
	    if(confirm('Are you sure you want to delete this shopper?')) {
	      location.href = aURL;
	    }
	  }
	function confirmCompleteDelete(aURL) {
	    if(confirm('This will completely delete this shopper from the database!\nPress OK to proceed.')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>
	
<cfinclude template="qry_all_shoppers.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td class="section_subheader" width="100%">#TRIM(SectionDetails.Title)#</td>
<td align="right" width="30"><cfif (#session.UserIsAuthenticated# EQ 'yes') AND (#session.UserType# EQ 'Administrator')><a href="#request.webroot#/admin/dsp_section_edit.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#" target="editSection" ONCLICK="fdbackwindow=window.open ('','editSection','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=450,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit This Page" border="0"></a><cfif #sectionDetails.Admin# EQ 1>&nbsp;<a href="javascript:confirmSectionDelete('#request.webroot#/admin/act_section_delete.cfm?sectionID=#sectiondetails.sectionID#&fuseaction=#fuseaction#&sectionType=documenthandling')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete This Section" border="0"></a></cfif></cfif></td>
</tr>


<tr>
<td class="section_header" width="100%">Manage Grownups</td>
<td align="right" width="30"> </td>
</tr>


</table><br>




<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
Deleted: <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&deletedmode=show" style="color:blue;text-decoration:underline;font-size:10px;">show</a> | <a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&deletedmode=hide" style="color:blue;text-decoration:underline;font-size:10px;">hide</a>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=firstname,lastname&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=lastname,firstname&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Name</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=EmailAddress&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=EmailAddress&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Email Address</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=DateJoined&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=DateJoined&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Date Joined</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=City&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&shoppers_sortby=City&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>City</a></span></td>	
	<td align="right"><span class="normal">&nbsp;</span></td>
	</tr>
	
	<tr>
	<td colspan="5"><hr width="100%" size="1" color="e2e2e2" noshade></td>
	</tr>
	
	<cfloop query="AllShoppers">
	<tr>
	<td><span class="normal"><cfif #AllShoppers.ContactStatus# EQ 'deleted'><strike></cfif>#LastName#, #FirstName#<cfif #AllShoppers.ContactStatus# EQ 'deleted'></strike><cfelseif #AllShoppers.ContactStatus# EQ 'pending'><span style="color:red;"> (pending)</span></cfif></span></td>
	<td><span class="normal"><cfif #AllShoppers.ContactStatus# EQ 'deleted'><strike></cfif>#EmailAddress#<cfif #AllShoppers.ContactStatus# EQ 'deleted'></strike></cfif></span></td>
	<td><span class="normal"><cfif #AllShoppers.ContactStatus# EQ 'deleted'><strike></cfif>#DateFormat(DateJoined, "d-mmm-yyyy")#<cfif #AllShoppers.ContactStatus# EQ 'deleted'></strike></cfif></span></td>
	<td><span class="normal"><cfif #AllShoppers.ContactStatus# EQ 'deleted'><strike></cfif>#City#<cfif #AllShoppers.ContactStatus# EQ 'deleted'></strike></cfif></span></td>	
	<td align="right"><a href="#request.webroot#/admin/dsp_shopper_edit.cfm?contactID=#contactID#" target="editContact" ONCLICK="fdbackwindow=window.open ('','editContact','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=700,height=450,top=10,left=10')" style="color:red; text-decoration:none;"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Shopper" border="0"></a>
	&nbsp;<a href="javascript:confirmContactDelete('#request.webroot#/admin/act_delete_contact.cfm?contactID=#contactID#&caller=shopper')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Shopper" border="0"></a>
	&nbsp;<a href="javascript:confirmCompleteDelete('#request.webroot#/admin/act_delete_contact.cfm?contactID=#contactID#&caller=shopper&completedelete=true')" title="Completely delete this shopper from DB">D</a></td>
	</tr>
	
	</cfloop>
		</table>
<hr width="100%" size="1" color="e2e2e2">

	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	<tr><td>
	<b>Total: #TotalShoppers.recordcount#</b>
	</td>
	<td>
	<b>Total Confirmed: #TotalShoppersconfirmed.recordcount#</b>
	</td>
	<cfset confirmrate = TotalShoppersconfirmed.recordcount / TotalShoppers.recordcount * 100>
	<td>
	<b>Confirm Rate: #decimalformat(confirmrate)#%</b>
	</td>
	</tr>
	</table>

</td>
</tr>

</table>


</cfoutput>