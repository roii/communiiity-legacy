
 <cfoutput>
<cfinclude template="qry_pgoals.cfm">
		


	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>EDIT GOAL</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
	</tr>
	</table>
	
	<table cellSpacing="1" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td>
	
		<table cellSpacing="0" cellPadding="10" bgColor="e3f4f6" border="0">
		
		<tr>
		<td>
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<cfform name="AddGoal" action="#request.webroot#/administration/act_edit_goal.cfm" method="post">
			<input type="hidden" name="goalid" value="#attributes.goalid#">
			<tr>
			<td style="color:404040;">Goal Type</td>
			<td>
			<select name="GoalTypeID" class="whitefield" size="1">
			<option value="0">
			<cfloop query="GoalType">
			  <cfif CurrentGoalsDetail.GoalTypeID EQ goaltype.GoalTypeID>
			    <option value="#goaltype.GoalTypeID#" selected>#goaltype.GoalType#
			  <cfelse>
			    <option value="#goaltype.GoalTypeID#">#goaltype.GoalType#
			  </cfif>
			</cfloop>
			</select>
			</td>
			</tr>
						
			<tr>
			<td style="color:404040;">Goal Title</td>
			<td>
			  <cfinput type="text" required="Yes" message="Please enter your goal title first" name="GoalTitle" value="#CurrentGoalsDetail.goaltitle#" class="whitefield" style="width:250px; border-color:a0d8e0;">
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Goal details
			<br>(The result of achieving this goal)</td>
			<td>
			  <textarea rows="5" cols="30" name="goaldetails">#CurrentGoalsDetail.goaldetails#</textarea>
			</td>
			</tr>

			<tr>
			<td style="color:404040;">Display Order</td>
			<td>
			  <cfinput type="text" message="Please enter the display order" required="yes" name="goalorder" size="3" value="#CurrentGoalsDetail.GoalOrder#">
			</td>
			</tr>
		
			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
			<tr>
			<td style="color:404040;"> </td>
			<td><input type="submit" class="whitefield" style="border-color:a0d8e0;" value="SAVE NOW!"></td>
			</tr>
			</cfform>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>

</cfoutput>