
<cfoutput>


<table width="100%" cellpadding="0" cellspacing="1" border="0">

<tr>
<td colspan="3" align="right" style="font-size:11px;padding-bottom:2px;"><a href="javascript:document.GoalForm.submit();">Print format</a></td>
</tr>

<tr bgcolor="###TRIM(AllSettings.DkBoxColour)#" height="25">
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:10px;" colspan="2"><strong>My Goals Are...</strong></td>
<td style="color:###TRIM(AllSettings.DkBoxTextColour)#;padding-left:5px;padding-right:5px;" align="center" nowrap><strong>Print</strong></td>
</tr>

<tr>
<td colspan="3" height="6"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="6" border="0"></td>
</tr>


<form name="GoalForm" action="#request.webroot#/goals/act_print_format.cfm" method="post">
<input type="hidden" name="fuseaction" value="#fuseaction#">
<input type="hidden" name="fusesubaction" value="#fusesubaction#">
<input type="hidden" name="documentID" value="#documentID#">


<cfloop query="CurrentPrivateGoals">

<cfquery name="CatStuff" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT CategoryName, ImageFile
FROM GoalCats
WHERE GoalCatID=#CurrentPrivateGoals.GoalCatID#
</cfquery>

<tr>
<td valign="top" width="90">

	<table width="90" height="70" cellpadding="5" cellspacing="0" style="border:1px solid ##b4b4b4;">
			
	<tr>
	<td align="center" valign="center">			
	<cfif fileExists("#request.fileroot#\images\goals\#TRIM(CatStuff.ImageFile)#")>
		<img src="#request.imageroot#/goals/#TRIM(CatStuff.ImageFile)#" width="80" height="60" border="0" alt="#TRIM(CatStuff.CategoryName)#">
	<cfelse>
		<img src="#request.imageroot#/transparent_spc.gif" width="80" height="60" border="0" alt="#TRIM(CatStuff.CategoryName)#">
	</cfif>
	</td>
	</tr>
	
	</table>

</td>
<td valign="top" style="padding-left:10px;">


	<table width="100%" cellpadding="0" cellspacing="0" border="0">
	
	<tr>
	<td valign="top" width="100%"><strong><span style="color:###TRIM(AllSettings.DkTextColor)#;">#TRIM(CurrentPrivateGoals.GoalTitle)#</span></strong><br>
	#TRIM(CurrentPrivateGoals.Goaldetails)#<br>
	<cfset this_percentDone = CurrentPrivateGoals.PercentDone>
	<cfinclude template="dsp_percent_bar.cfm"></td>
	<td valign="top" width="120">By When: #Dateformat(CurrentPrivateGoals.bywhen,"d-mmm-yy")#<br>
	Updated: #Dateformat(CurrentPrivateGoals.lastModified,"d-mmm-yy")#<br>
	<img src="#request.imageroot#/transparent_spc.gif" width="120" height="1" border="0"><br>
	<a href="#request.webroot#/goals/act_archive_goal.cfm?goalid=#CurrentPrivateGoals.goalid#" title="Archive this goal" style="font-size:11px;color:###TRIM(AllSettings.BoxColour)#;">DONE</a> | <a href="index.cfm?fuseaction=goals&fusesubaction=article&documentid=38&articleID=3&goalid=#CurrentPrivateGoals.goalID#" title="Edit this goal" style="color:###TRIM(AllSettings.BoxColour)#;font-size:11px;">EDIT</a> | 
<a href="#request.webroot#/goals/act_remove_goal.cfm?goalid=#CurrentPrivateGoals.goalid#" title="Delete this goal" onclick="return confirm('Are you sure you want to delete this goal?')" style="color:###TRIM(AllSettings.BoxColour)#;font-size:11px;">DELETE</a>
	</td>
	</tr>
	
	
	</table>


</td>
<td valign="top" align="center"><input type="checkbox" name="GoalID" class="whitefield" value="#CurrentPrivateGoals.GoalID#" checked></td>
</tr>

<tr>
<td colspan="3" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

<tr>
<td colspan="3" height="1" bgcolor="b4b4b4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="1" border="0"></td>
</tr>

<tr>
<td colspan="3" height="4"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="4" border="0"></td>
</tr>

</cfloop>


<tr>
<td colspan="3" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

<tr>
<td colspan="3" align="right" style="font-size:11px;"><a href="javascript:document.GoalForm.submit();">Print format</a><br>
You will need to disable any pop-up blockers</td>
</tr>

</form>


</table>

	


</cfoutput>