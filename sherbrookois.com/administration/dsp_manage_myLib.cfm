<cfoutput>
<cfparam name="shoppers_sortby" default="bizideaID">
<cfparam name="sortorder" default="DESC">
<script language="JavaScript">
	<!--
	function confirmAdministratorDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Item form myLibrary?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfinclude template="qry_myLib.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE LIBRARY</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="2" height="15"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="15" border="0"></td>
</tr>

</table>




<table width="100%" cellpadding="0" cellspacing="0" border="0">

<tr>
<td class="small">
<a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=add_myLib" style="color:red; text-decoration:none;">
<strong>ADD A New Item to myLibrary</strong></a>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="1" cellspacing="1" border="0">
	
	<tr>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=title&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=title&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Title</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=libtype&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=libtype&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Type</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=ages&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=ages&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Ages</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=author_fn&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=author_ln&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Author FN</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=author_ln&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=author_ln&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Author LN</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=Media_type&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=media_type&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Media Type</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=copies&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=copies&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Copies</a></span></td>
	<td><span class="normal"><cfif #sortorder# EQ 'ASC'><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=display&sortorder=DESC" style="color:blue;text-decoration:underline;"><cfelse><a href="#request.webroot#/index.cfm?fuseaction=#fuseaction#&fusesubaction=#fusesubaction#&sortby=display&sortorder=ASC" style="color:blue;text-decoration:underline;"></cfif>Display</a></span></td>
	<td></td>
	</tr>
	
	<tr>
	<td><span class="normal"><b>Title</b></span></td>
	<td><span class="normal"><b>Type</b></span></td>
	<td><span class="normal"><b>Ages</b></span></td>
	<td><span class="normal"><b>Author First Name</b></span></td>
	<td><span class="normal"><b>Author Last Name</b></span></td>
	<td><span class="normal"><b>Media Type</b></span></td>
	<td><span class="normal"><b>Copies</b></span></td>
	<td><span class="normal"><b>Display</b></span></td>
	<td></td>
	</tr>
	
	<cfloop query="allmyLib">
	<tr>
	<td><span class="normal">#title#</span></td>
	<td><span class="normal">#libtype#</span></td>
	<td><span class="normal">#ages#</span></td>	
	<td><span class="normal">#author_fn#</span></td>
	<td><span class="normal">#author_ln#</span></td>
	<td><span class="normal">#media_type#</span></td>
	<td><span class="normal">#copies#</span></td>
	<td><span class="normal"><cfif display EQ '1'>Y<cfelse>N</cfif></span></td>
	<td align="right"><a href="#request.webroot#/index.cfm?fuseaction=administration&fusesubaction=edit_myLib&myLibID=#myLibid#" style="color:red; text-decoration:none;">
	<img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Item" border="0"></a>&nbsp;
	<a href="javascript:confirmAdministratorDelete('#request.webroot#/administration/act_remove_myLib.cfm?myLibid=#myLibid#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Item" border="0"></a></td>
	</tr>
	</cfloop>
	
	</table>
	
<hr width="100%" size="1" color="e2e2e2">

</td>
</tr>

</table>


</cfoutput>