
<html>
<head>
<title>Manage Suggestion Category</title>
<link rel="stylesheet" type="text/css" href="CSS/small.css">


<script language="javascript">
	  <!--
	function confirmAdministratorDelete(aURL) {
	    if(confirm('Are you sure you want to archive this suggestion category?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>

</head>

<body>
<cfoutput>
	<cfparam name="sortOrder" default="desc">
	<cfinclude template="qry_manageSugCategory.cfm">
	
	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<tr>
		<td class="small">
			<a href="dsp_addSugCategory.cfm?Add=1" style="color:red; text-decoration:none;">
			<strong>Add a suggestion Category</strong></a>
		
			<hr width="100%" size="1" color="e2e2e2">

			<table border="0" cellpadding="1" cellspacing="1" width="100%">
		
			<!--- display allow sorting column --->
			
			<tr>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSugCategory.cfm?sortby=date&sortorder=desc"><cfelse><a href="dsp_manageSugCategory.cfm?sortby=date&sortorder=asc"></cfif>Date</a></span></td>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSugCategory.cfm?sortby=priority&sortorder=desc"><cfelse><a href="dsp_manageSugCategory.cfm?sortby=priority&sortorder=asc"></cfif>VoteEnd</a></span></td>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSugCategory.cfm?sortby=Name&sortorder=desc"><cfelse><a href="dsp_manageSugCategory.cfm?sortby=Name&sortorder=asc"></cfif>Category</a></span></td>
				<td><span class="normal"></span></td>
				<td><span class="normal"></span></td>
			</tr>
		
			<tr>
				<td><span class="normal"><b>Date Created</b></span></td>
				<td><span class="normal"><b>Priority</b></span></td>
				<td><span class="normal"><b>Name</b></span></td>
				<td><span class="normal"><b>Description</b></span></td>
				<td><span class="normal"></span></td>
			</tr>
			<cfloop query="sugCategory">
			<tr>
				<td><span class="normal">#date#</span></td>
				<td><span class="normal">#priority#</span></td>
				<td><span class="normal">#Name#</span></td>
				<td><span class="normal">#Description#</span></td>
				<td align="right"><a href="dsp_SugCategoryEdit.cfm?categoryID=#categoryID#" style="color:red; text-decoration:none;">
				<img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Suggestion" border="0"></a>&nbsp;
				<a href="javascript:confirmAdministratorDelete('act_removeSugCategory.cfm?categoryID=#categoryID#')">
				<img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Suggestion" border="0"></a>
				</td>
			</tr>
			</cfloop>	
		
		
			</table>
			<hr width="100%" size="1" color="e2e2e2">
		</td>
	</tr>
</table>
	
</cfoutput>
</body>
</html>
