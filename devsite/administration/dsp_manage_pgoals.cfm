<cfoutput>

<script language="JavaScript">
	<!--
	function confirmGoalDelete(aURL) {
	    if(confirm('Are you sure you want to delete this Goal?')) {
	      location.href = aURL;
	    }
	  }
	//-->
	</script>
	
<cfinclude template="qry_pgoals.cfm">

<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE PUBLIC GOALS</strong></td>
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
<a href="#request.webroot#/admin/dsp_add_pGoal.cfm" target="addGoal" onclick="fdbackwindow=window.open ('','addGoal','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=280,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A PUBLIC GOAL &raquo;</strong></a>

<hr width="100%" size="1" color="e2e2e2">
	

	
	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td style="padding-right:10px;"><b>Goal Title</b></td>
	<td style="padding-right:10px;"><b>Goal Details</b></td>
	<td style="padding-right:10px;"><b>Goal Type</b></td>
	<td align="right"> </td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<cfloop query="allgoals">
	
	<tr>
	<td style="padding-right:10px;">#Goaltitle#</td>
	<td style="padding-right:10px;">#goaldetails#</td>
	<td style="padding-right:10px;">#goaltype#</td>	
	<td align="right"><a href="#request.webroot#/admin/dsp_edit_pgoal.cfm?goalID=#goalid#" target="EditGoal" onclick="fdbackwindow=window.open ('','EditGoal','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=0,width=700,height=320,top=10,left=10')"><img src="#request.imageroot#/but_edit_icon.gif" width="10" height="10" alt="Edit Goal" border="0"></a>&nbsp;<a href="javascript:confirmGoalDelete('#request.webroot#/administration/act_remove_goal.cfm?goalid=#goalid#')"><img src="#request.imageroot#/but_delete_icon.gif" width="10" height="10" alt="Delete Goal" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="4" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	</cfloop>
	
	</table>
	

</td>
</tr>

</table>


</cfoutput>