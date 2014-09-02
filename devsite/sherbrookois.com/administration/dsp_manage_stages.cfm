<cfoutput>

<cfquery name="IdeaSettings" datasource="#dsn#" username="#request.username#" password="#request.password#">
SELECT *
FROM IdeaFunl_Settings
</cfquery>


<table border="0" cellpadding="0" cellspacing="2" width="100%">

<tr>
<td width="100%" style="font-size:12px;color:###TRIM(AllSettings.DkTextColor)#" height="20"><strong>MANAGE IDEAfunL Stages</strong></td>
<td align="right" width="30"></td>
</tr>

<tr>
<td colspan="2" bgcolor="###TRIM(AllSettings.BoxColour)#" height="2"><img src="#request.imageroot#/transparent_spc.gif" width="1" height="2" border="0"></td>
</tr>

</table>


<br>
<table cellpadding="0" cellspacing="0" border="0">

<form method="post" action="#request.webroot#/administration/act_idea_stages.cfm">

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Pending (Required "Yes" Votes)</td>
<td><input type="text" class="whitefield" name="Required_Pending" style="width:120px;" align="absmiddle" value="#IdeaSettings.Required_Pending#"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Pending (Total Votes)</td>
<td><input type="text" class="whitefield" name="Total_Pending" style="width:120px;" align="absmiddle" value="#IdeaSettings.Total_Pending#"></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Stage 1 (Required "Yes" Votes)</td>
<td><input type="text" class="whitefield" name="Required_Stage_1" style="width:120px;" align="absmiddle" value="#IdeaSettings.Required_Stage_1#"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Stage 1 (Total Votes)</td>
<td><input type="text" class="whitefield" name="Total_Stage_1" style="width:120px;" align="absmiddle" value="#IdeaSettings.Total_Stage_1#"></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Stage 2 (Required "Yes" Votes)</td>
<td><input type="text" class="whitefield" name="Required_Stage_2" style="width:120px;" align="absmiddle" value="#IdeaSettings.Required_Stage_2#"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Stage 2 (Total Votes)</td>
<td><input type="text" class="whitefield" name="Total_Stage_2" style="width:120px;" align="absmiddle" value="#IdeaSettings.Total_Stage_2#"></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Stage 3 (Required "Yes" Votes)</td>
<td><input type="text" class="whitefield" name="Required_Stage_3" style="width:120px;" align="absmiddle" value="#IdeaSettings.Required_Stage_3#"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">Stage 3 (Total Votes)</td>
<td><input type="text" class="whitefield" name="Total_Stage_3" style="width:120px;" align="absmiddle" value="#IdeaSettings.Total_Stage_3#"></td>
</tr>

<tr>
<td colspan="2"><hr width="100%" size="1" color="e2e2e2"></td>
</tr>

<tr>
<td style="color:###TRIM(AllSettings.DkTextColor)#;font-size:11px;" width="200">&nbsp;</td>
<td><input type="submit" class="whitefield" value="UPDATE NOW" style="width:120px;"></td>
</tr>

</form>

</table><br>



</cfoutput>