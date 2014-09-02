
<!--- GET ALL CATEGORIES --->
<cfquery name="AllGoalCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GoalCatID, CategoryName
FROM GoalCats
WHERE Deleted=0
ORDER BY DisplayOrder
</cfquery>


 <cfoutput>
 
<script>
function ChangeTickbox(AddGoal) {
if (document.AddGoal.Frequency_Daily.checked) {
	document.AddGoal.SendEmails[0].checked = true;
	document.AddGoal.Frequency.selectedIndex=0;
	}
else {
	document.AddGoal.Frequency_Daily.checked = false;
	}
	
}


function ChangeSelect(AddGoal) {
if (document.AddGoal.Frequency.selectedIndex == 0) {
	document.AddGoal.Frequency_Daily.checked = true;
	}
else {
	document.AddGoal.Frequency_Daily.checked = false;
	}
	
}



function validateAddGoal(AddGoal) {

if (AddGoal.GoalCatID.selectedIndex == "0") {
	alert("You must select a category.");
	AddGoal.GoalCatID.focus();
	return;
	}
	 
else if (AddGoal.GoalTitle.value == "") {
	alert("Please enter your goal title first.");
	AddGoal.GoalTitle.focus();
	return;
	} 
	 
else if (AddGoal.goaldetails.value == "") {
	alert("Please enter your goals details.");
	AddGoal.Goaldetails.focus();
	return;
	} 
	

else {
	AddGoal.submit(); //submit form
	}
	
}
</script>
			
	<cfif IsDefined("NoGoals")>
	<strong>A goal is something you want. What is your first goal? Use this form to add it now!...</strong><br><br>
	</cfif>
	
	
	<table cellSpacing="1" cellPadding="0" bgColor="##b4b4b4" border="0" width="100%">

	<tr>
	<td>
	
	
		<table cellSpacing="0" cellPadding="10" bgColor="white" border="0" width="100%">
		
		<tr>
		<td>
		
		
			<table width="100%" cellpadding="0" cellspacing="0" border="0">
			
			<tr>
			<td width="140" height="1"><img src="#request.imageroot#/transparent_spc.gif" width="140" height="1"  border="0"></td>
			<td></td>
			</tr>
			
			<form name="AddGoal" action="#request.webroot#/goals/act_add_goal.cfm" method="post" onsubmit="javascript:validateAddGoal(AddGoal); return false;">
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Category</td>
			<td><select name="GoalCatID" class="whitefield" style="width:250px;">
			<option value="0">Choose a category
			<cfloop query="AllGoalCats">
			<option value="#AllGoalCats.GoalCatID#">#TRIM(AllGoalCats.CategoryName)#
			</cfloop>
			</select></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">What is this goal?</td>
			<td><input type="text" name="GoalTitle" class="whitefield" style="width:250px;"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Goal details<br><br>
			<em>The result of<br>
			achieving this goal</em></td>
			<td><textarea rows="5" style="width:250px;font-family:Arial;font-size:11px;" name="goaldetails">So that ...</textarea></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>

			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">By When (dd/mm/yyyy)</td>
			<td><select class="whitefield" name="ByWhen_Day">
			<cfloop from="1" to="31" index="day">
			<option value="#day#">#day#
			</cfloop></select> <select class="whitefield" name="ByWhen_Month">
			<cfloop from="1" to="12" index="month">
			<option value="#month#">#MonthAsString(month)#
			</cfloop></select> <select class="whitefield" name="ByWhen_year">
			<cfloop from="#DateFormat(localDateTime, "yyyy")#" to="#DateFormat(DateAdd('yyyy', 30, localDateTime), "yyyy")#" index="year">
			<option value="#year#">#year#
			</cfloop></select></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>

			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">% Done Now</td>
			<td><select name="percentDone" class="whitefield">
			<cfloop from="1" to="100" index="loopcount">
			<option value="#loopcount#">#loopcount#%
			</cfloop></select></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>		

			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Email Reminders</td>
			<td><input type="radio" style="border:0px;" class="whitefield" name="SendEmails" value="1" checked> Yes &nbsp; <input style="border:0px;" type="radio" class="whitefield" name="SendEmails" value="0"> No</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##ffffff"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Frequency</td>
			<td><input type="checkbox" name="Frequency_Daily" class="whitefield" onclick="javascript:ChangeTickbox(AddGoal);" value="1" checked> Daily &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>or</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; every <select name="Frequency" class="whitefield" style="width:50px;" onclick="javascript:ChangeSelect(AddGoal);">
			<cfloop from="1" to="100" index="loopcount">
			<option value="#loopcount#">#loopcount#
			</cfloop>
			</select> days</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/add_button.gif" title="ADD NOW!"></td>
			</tr>
			</form>
			
			</table>
			
		</td>
		</tr>
		
		</table>
	
	</td>
	</tr>
	
	</table>
<iframe width=120 height=148 name="gToday:normal:agenda.js" id="gToday:normal:agenda.js" src="#request.webroot#/goals/ipopeng.htm" scrolling="no" frameborder="0" style="visibility:visible; z-index:999; position:absolute; left:-500px; top:0px;">
</iframe>

</cfoutput>