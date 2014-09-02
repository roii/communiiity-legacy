<cfoutput>

<cfparam name="sortOrder" default="desc">


<!--- GET ALL CATEGORIES --->
<cfquery name="AllGoalCats" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT GoalCatID, CategoryName, DisplayOrder, ImageFile
FROM GoalCats
WHERE Deleted=0
ORDER BY DisplayOrder
</cfquery>


<script language="JavaScript">
<!--
function confirmCatDelete(aURL) {
    if(confirm('Are you sure you want to delete this Category?')) {
      location.href = aURL;
    }
  }
//-->
</script>

	
<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE GOAL CATEGORIES</strong></td>
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
<td><a href="#request.webroot#/administration/dsp_add_goalcat.cfm" target="AddPrize" onclick="fdbackwindow=window.open ('','AddPrize','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=550,top=10,left=10')" style="color:###TRIM(AllSettings.BoxColour)#; text-decoration:none;"><strong>ADD A GOAL CATEGORY &raquo;</strong></a>

	<hr width="100%" size="1" color="e2e2e2">

	<table border="0" cellpadding="0" cellspacing="0" width="100%">
	
	<tr>
	<td width="90"></td>
	<td style="padding-left:10px;"><b>Name</b></td>
	<td><b>Order</b></td>
	<td><b>Active</b></td>
	<td></td>
	</tr>
	
	<tr>
	<td colspan="5" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" height="8"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="8" border="0"></td>
	</tr>
	
	<cfloop query="AllGoalCats">
	
	<cfset this_catID = AllGoalCats.GoalCatID>
	
	<cfquery name="AllGoalKids" datasource="#dsn#" username="#request.username#" password="#request.password#">
	SELECT KidsID
	FROM Goals, GoalKidsLink
	WHERE Goals.GoalCatID=#this_catID#
	AND Goals.GoalID=GoalKidsLink.GoalID
	GROUP BY KidsID
	</cfquery>
	
	<tr>
	<td width="90">
		
		<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
			
		<tr>
		<td align="center" valign="center">			
		<cfif fileExists("#request.fileroot#\images\goals\#TRIM(AllGoalCats.ImageFile)#")>
			<img src="#request.imageroot#/goals/#TRIM(AllGoalCats.ImageFile)#" border="0" width="80" height="60">
		<cfelse>
			<img src="#request.imageroot#/transparent_spc.gif" width="80" height="60" border="0">
		</cfif>
		</td>
		</tr>
		
		</table>
	
	
	
	</td>
	<td valign="top" style="padding-left:10px;">#TRIM(AllGoalCats.CategoryName)#</td>
	<td valign="top">#AllGoalCats.DisplayOrder#</td>
	<td valign="top"><cfif AllGoalKids.RecordCount><a href="#request.webroot#/administration/dsp_goal_kids.cfm?GoalCatID=#this_catID#" target="GoalKids" ONCLICK="fdbackwindow=window.open ('','GoalKids','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=600,top=10,left=10')">#AllGoalKids.RecordCount#</a><cfelse>0</cfif></td>
	<td align="right" valign="top"><a href="#request.webroot#/administration/dsp_edit_goalcat.cfm?goalcatID=#AllGoalCats.goalcatID#" target="EditPrize" onclick="fdbackwindow=window.open ('','EditPrize','toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=1,resizable=1,width=550,height=500,top=10,left=10')"><img src="images/but_edit_icon.gif" width="10" height="10" alt="Edit Goal Category" border="0"></a> <a href="javascript:confirmCatDelete('#request.webroot#/administration/act_delete_goalcat.cfm?goalcatID=#AllGoalCats.goalcatID#');"><img src="images/but_delete_icon.gif" width="10" height="10" alt="Delete Goal Category" border="0"></a></td>
	</tr>
	
	<tr>
	<td colspan="5" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" height="1" bgcolor="e2e2e2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
	</tr>
	
	<tr>
	<td colspan="5" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
	</tr>
	
	</cfloop>	
	
	
	</table>


</td>
</tr>

</table>

</cfoutput>