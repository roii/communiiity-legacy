 <cfoutput>
<script language="javascript">
function validate(AddGoal) {
var st_index= document.forms["AddGoal"].ShortTermGoal.selectedIndex;
var mt_index= document.forms["AddGoal"].MediumTermGoal.selectedIndex;
var lt_index= document.forms["AddGoal"].LongTermGoal.selectedIndex;


if (st_index != 0 && AddGoal.ST_bywhen.value == "") {
	alert("Please enter the date you expect to achieve this short term goal.");
	AddGoal.ST_bywhen.focus();
	return;
	} 
if (mt_index != 0 && AddGoal.MT_bywhen.value == "") {
	alert("Please enter the date you expect to achieve this medium term goal.");
	AddGoal.MT_bywhen.focus();
	return;
	} 
if (lt_index != 0 && AddGoal.LT_bywhen.value == "") {
	alert("Please enter the date you expect to achieve this long term goal.");
	AddGoal.LT_bywhen.focus();
	return;
	} 
	 

AddGoal.submit(); //submit form
	
}
</script>
 
	<table cellSpacing="0" cellPadding="0" bgColor="a0d8e0" border="0">

	<tr>
	<td style="color:white;" width="230"><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"><strong>ADD A NEW GOAL</strong><img src="#request.imageroot#/transparent_spc.gif" width="12" height="1"  border="0"></td>
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
			
			<cfform name="AddGoal" action="#request.webroot#/kidzbiz/act_add_publicgoal.cfm" method="post">

			<tr>
			<td style="color:404040;">Short Term Goal</td>
			<td><select name="ShortTermGoal" class="whitefield" style="width:350px; border-color:a0d8e0;">
			<option value="">Select a short term goal</option>
			<cfloop query="AllGoals">
			<cfif #AllGoals.GoalTypeID# EQ 1>
			<option value="#TRIM(AllGoals.GoalID)#">#TRIM(AllGoals.GoalTitle)#
			</cfif>
			</cfloop></select>
			</tr>

			<tr>
			<td style="color:404040;">By When</td>
			<td><cfinput type="text" name="ST_bywhen" required="No" class="whitefield" validate="eurodate" message="You didn't enter the correct date format" style="width:200px; border-color:a0d8e0;">(dd/mm/yyyy)</td>
			</td>
			</tr>
			
			<tr>
			<td style="color:404040;">Medium Term Goal</td>
			<td><select name="MediumTermGoal" class="whitefield" style="width:350px; border-color:a0d8e0;">
			<option value="">Select a medium term goal</option>
			<cfloop query="AllGoals">
			<cfif #AllGoals.GoalTypeID# EQ 2>
			<option value="#TRIM(AllGoals.GoalID)#">#TRIM(AllGoals.GoalTitle)#
			</cfif>
			</cfloop></select></td>
			</tr>

			<tr>
			<td style="color:404040;">By When</td>
			<td><cfinput type="text" name="MT_bywhen" required="No" class="whitefield" validate="eurodate" message="You didn't enter the correct date format" style="width:200px; border-color:a0d8e0;">(dd/mm/yyyy)</td>
			</td>
			</tr>
		
			<tr>
			<td style="color:404040;">Long Term Goal</td>
			<td><select name="LongTermGoal" class="whitefield" style="width:350px; border-color:a0d8e0;">
			<option value="">Select a long term goal</option>
			<cfloop query="AllGoals">
			<cfif #AllGoals.GoalTypeID# EQ 3>
			<option value="#TRIM(AllGoals.GoalID)#">#TRIM(AllGoals.GoalTitle)#
			</cfif>
			</cfloop></select></td>
			</tr>
			
			<tr>
			<td style="color:404040;">By When</td>
			<td><cfinput type="text" name="LT_bywhen" required="No" class="whitefield" validate="eurodate" message="You didn't enter the correct date format" style="width:200px; border-color:a0d8e0;">(dd/mm/yyyy)</td>
			</td>
			</tr>

			<tr>
			<td colspan="2" style="color:404040;" height="5"><hr width="100%" size="1" color="a0d8e0"></td>
			</tr>			
			
			<tr>
			<td style="color:404040;"> </td>
			<td><input type="submit" class="whitefield" style="border-color:a0d8e0;" onclick="validate(AddGoal); return false;" value="ADD NOW!"></td>
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