<cfoutput>

<cfquery name="CurrentGoalsDetail" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT * 
FROM Goals, GoalKidsLink 
WHERE goals.goalID=GoalKidsLink.goalID 
AND goals.goalid = #attributes.goalid#
</cfquery>

<!--- GET ALL CATEGORIES --->
<cfquery name="AllGoalCats" datasource="#dsn#" username="mykidsbiznew" password="u+67eNfJ">
SELECT GoalCatID, CategoryName
FROM GoalCats
WHERE Deleted=0
ORDER BY DisplayOrder
</cfquery>


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




function validate(AddGoal) {
var GoalTypeID = document.forms["AddGoal"].GoalTypeID.options[document.forms["AddGoal"].GoalTypeID.selectedIndex].value;


if (AddGoal.GoalTitle.value == "") {
	alert("Please enter your goal title first.");
	AddGoal.GoalTitle.focus();
	return;
	} 
	 
else if (AddGoal.goaldetails.value == "") {
	alert("Please enter your goals details first.");
	AddGoal.Goaldetails.focus();
	return;
	} 
	
else if (GoalTypeID == "0") {
	alert("You must select the goal type.");
	return;
	}
	 
else {
	AddGoal.submit(); //submit form
	}
	
}
</script>
			

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
			
			<cfform name="AddGoal" action="#request.webroot#/goals/act_edit_goal.cfm" method="post">
			
			<input type="hidden" name="GoalID" value="#attributes.goalid#">
			<input type="hidden" name="DefaultGoal" value="#CurrentGoalsDetail.DefaultGoal#">
			
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Category</td>
			<td><select name="GoalCatID" class="whitefield" style="width:250px;">
			<cfloop query="AllGoalCats">
			<option value="#AllGoalCats.GoalCatID#"<cfif AllGoalCats.GoalCatID EQ CurrentGoalsDetail.GoalCatID> selected</cfif>>#TRIM(AllGoalCats.CategoryName)#
			</cfloop>
			</select></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Status</td>
			<td><input style="border:0px;" type="radio" class="whitefield" name="archived" value="0"<cfif CurrentGoalsDetail.archived CONTAINS 0> checked</cfif>> Current &nbsp; <input type="radio" style="border:0px;" class="whitefield" name="archived" value="1"<cfif CurrentGoalsDetail.archived CONTAINS 1> checked</cfif>> Complete</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">What is this goal?</td>
			<td><cfinput type="text" required="Yes" message="Please enter your goal title first" name="GoalTitle" class="whitefield" style="width:250px;" value="#TRIM(CurrentGoalsDetail.GoalTitle)#"></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;" valign="top">Goal details<br><br>
			<em>The result of<br>
			achieving this goal</em></td>
			<td><textarea rows="5" style="width:250px;font-family:Arial;font-size:11px;" name="goaldetails">#TRIM(CurrentGoalsDetail.goaldetails)#</textarea></td>
			</tr>

			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">By When (dd/mm/yyyy)</td>
			<td><select class="whitefield" name="ByWhen_Day">
			<cfloop from="1" to="31" index="day">
			<option value="#day#"<cfif DateFormat(CurrentGoalsDetail.bywhen, "d") EQ day> selected</cfif>>#day#
			</cfloop></select> <select class="whitefield" name="ByWhen_Month">
			<cfloop from="1" to="12" index="month">
			<option value="#month#"<cfif DateFormat(CurrentGoalsDetail.bywhen, "m") EQ month> selected</cfif>>#MonthAsString(month)#
			</cfloop></select> <select class="whitefield" name="ByWhen_year">
			<cfloop from="2004" to="#DateFormat(DateAdd('yyyy', 30, localDateTime), "yyyy")#" index="year">
			<option value="#year#"<cfif DateFormat(CurrentGoalsDetail.bywhen, "yyyy") EQ year> selected</cfif>>#year#
			</cfloop></select></td>
			</tr>

			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>

			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">% Done Now</td>
			<td><select name="percentDone" class="whitefield">
			<cfloop from="1" to="100" index="loopcount">
			<option value="#loopcount#"<cfif CurrentGoalsDetail.percentDone EQ loopcount> selected</cfif>>#loopcount#%
			</cfloop></select></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>		

			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Email Reminders</td>
			<td><input type="radio" style="border:0px;" class="whitefield" name="SendEmails" value="1"<cfif CurrentGoalsDetail.SendEmails CONTAINS 1> checked</cfif>> Yes &nbsp; <input style="border:0px;" type="radio" class="whitefield" name="SendEmails" value="0"<cfif CurrentGoalsDetail.SendEmails CONTAINS 0> checked</cfif>> No</td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="5"  border="0"></td>
			</tr>
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Frequency</td>
			<td><input type="checkbox" name="Frequency_Daily" class="whitefield" onclick="javascript:ChangeTickbox(AddGoal);" value="1"<cfif CurrentGoalsDetail.Frequency EQ 1> checked</cfif>> Daily &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <strong>or</strong> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; every <select name="Frequency" class="whitefield" style="width:50px;" onclick="javascript:ChangeSelect(AddGoal);">
			<cfloop from="1" to="100" index="loopcount">
			<option value="#loopcount#"<cfif CurrentGoalsDetail.Frequency EQ loopcount> selected</cfif>>#loopcount#
			</cfloop>
			</select> days</td>
			</tr>
			
			<tr>
			<td colspan="2" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8"  border="0"></td>
			</tr>	
			
			<tr>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;">Last Sent:</td>
			<td style="color:###TRIM(AllSettings.DkTextColor)#;"><cfif IsDate("#CurrentGoalsDetail.LastSent#")>#DateFormat(CurrentGoalsDetail.LastSent, "d-mmm-yyyy")#<cfelse>&ndash;</cfif></td>
			</tr>
			
			<tr>
			<td colspan="2" height="5"><hr width="100%" size="1" color="##b4b4b4"></td>
			</tr>		
			
			<tr>
			<td> </td>
			<td><input type="image" src="#request.imageroot#/update_button.gif" title="ADD NOW!"></td>
			</tr>
			</cfform>
			
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