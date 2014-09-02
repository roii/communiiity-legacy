<html>
<head>
<title>Admin manage Suggestion</title>
<link rel="stylesheet" type="text/css" href="CSS/small.css">

<script language="javascript">
	var ie4 = false; 
	if(document.all) { ie4 = true; }
	
	function getObject(id) { 
		if (ie4) { 
			return document.all[id]; 
		} else { 
			return document.getElementById(id); 
		}
	 }
	 
	function toggle(divIdDisplay,divIdHide) {
		var display = getObject(divIdDisplay);
		var hide = getObject(divIdHide);
		display.style.display = 'block';
		hide.style.display ='none';
	  }
	  
	  <!--
	function confirmAdministratorDelete(aURL) {
	    if(confirm('Are you sure you want to archive this Suggestion?')) {
	      location.href = aURL;
	    }
	  }
	//-->
</script>

</head>
<body>
<cfoutput>
<cfparam name="sortOrder" default="desc">

<cfinclude template="qry_manageSug.cfm">

<table width="100%" cellpadding="0" cellspacing="0" border="0">

	<tr>
		<td class="small">
		<a href="dsp_manageSugCategory.cfm" style="color:red; text-decoration:none;">
		<strong>Manage Suggestion Category</strong></a>
		
		<hr width="100%" size="1" color="e2e2e2">

		<table border="0" cellpadding="1" cellspacing="1" width="100%">
		
			<!--- display allow sorting column --->
			
			<tr>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSug.cfm?sortby=date&sortorder=desc"><cfelse><a href="dsp_manageSug.cfm?sortby=date&sortorder=asc"></cfif>Date</a></span></td>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSug.cfm?sortby=voteCloseDate&sortorder=desc"><cfelse><a href="dsp_manageSug.cfm?sortby=voteCloseDate&sortorder=asc"></cfif>VoteEnd</a></span></td>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSug.cfm?sortby=Name&sortorder=desc"><cfelse><a href="dsp_manageSug.cfm?sortby=Name&sortorder=asc"></cfif>Category</a></span></td>
				<td><span class="normal"></span></td>
				<td><span class="normal"></span></td>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSug.cfm?sortby=Authorise&sortorder=desc"><cfelse><a href="dsp_manageSug.cfm?sortby=Authorise&sortorder=asc"></cfif>Authorise</a></span></td>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSug.cfm?sortby=Rated&sortorder=desc"><cfelse><a href="dsp_manageSug.cfm?sortby=Rated&sortorder=asc"></cfif>Rated</a></span></td>
				<td><span class="normal"><cfif #sortOrder# EQ 'asc'><a href="dsp_manageSug.cfm?sortby=voteReceived&sortorder=desc"><cfelse><a href="dsp_manageSug.cfm?sortby=voteReceived&sortorder=asc"></cfif>Vote Received</a></span></td>
				<td><span class="normal"></span></td>
			</tr>
		
			<tr>
				<td><span class="normal"><b>Date</b></span></td>
				<td><span class="normal"><b>VoteEnd</b></span></td>
				<td><span class="normal"><b>Category</b></span></td>
				<td><span class="normal"><b>Suggestion</b></span></td>
				<td><span class="normal"><b>Email</b></span></td>
				<td><span class="normal"><b>Authorise</b></span></td>
				<td><span class="normal"><b>Rated</b></span></td>
				<td><span class="normal"><b>VoteReceived</b></span></td>
				<td><span class="normal"></span></td>	
			</tr>
			<cfloop query="selAllSuggestion">
			<tr>
				<td><span class="normal">#date#</span></td>
				<td><span class="normal">#voteCloseDate#</span></td>
				<td><span class="normal">#name#</span></td>
				<td><span class="normal">
						<cfif len(suggestion) GT 50>
							<div id="d1#sugID#">
							#mid(suggestion,1,50)# 
							<a title="show" href="javascript: void(0);" onClick="toggle('d2#sugID#', 'd1#sugID#');">[+]</a>
							</div>
							<div id="d2#sugID#">
								#suggestion#
								<a title="hide" href="javascript: void(0);" onClick="toggle('d1#sugID#', 'd2#sugID#');">[-]</a>
							</div>
							<script language="javascript">toggle('d1#sugID#', 'd2#sugID#');</script>
						<cfelse>
							#suggestion#
						</cfif>
					</span>			
				</td>
				<td>
					<cfif len(trim(email)) GT 4>
						<div id="e1#SugID#">
							#mid(trim(email),1,4)#
							<a title="show" href="javascript: void(0);" onClick="toggle('e2#sugID#', 'e1#sugID#');">[+]</a>
						</div>
						<div id="e2#SugID#">
							#Trim(email)#
							<a title="show" href="javascript: void(0);" onClick="toggle('e1#sugID#', 'e2#sugID#');">[-]</a>
						</div>
						<script language="javascript">toggle('e1#sugID#', 'e2#sugID#');</script>
					</cfif>
				</td>
				<td align="center"><span class="normal"><cfif #authorise# Contains('no')>N<cfelse>Y</cfif></span></td>
				<td align="center"><span class="normal">#rated#</span></td>
				<td align="center"><span class="normal">#voteReceived#</span></td>
				<td align="right"><a href="dsp_SugEdit.cfm?sugID=#sugID#" style="color:red; text-decoration:none;">
				<img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Suggestion" border="0"></a>&nbsp;
				<a href="javascript:confirmAdministratorDelete('act_RemoveSug.cfm?sugID=#sugID#')">
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