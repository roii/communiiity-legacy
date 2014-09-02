<cfoutput>
<table width="100%" cellpadding="0" cellspacing="0" border="0">

<form name="StatsForm" action="#request.webroot#/index.cfm" method="post">
<input type="hidden" name="fuseaction" value="community" />
<input type="hidden" name="fusesubaction" value="docs" />
<input type="hidden" name="documentID" value="116" />
<tr>
<td style="font-size:11px;">Display: <select name="statsmode" class="whitefield" style="font-size:11px;">
<optgroup label="TOP 100 USERS">
<option value="User_Points_Earned"<cfif statsmode EQ 'User_Points_Earned'> selected</cfif>>Points - Total Points Earned</option>
<option value="User_Points_Average"<cfif statsmode EQ 'User_Points_Average'> selected</cfif>>Points - Average Points Earned Per Month</option>
<option value="User_Ideas_submitted"<cfif statsmode EQ 'User_Ideas_submitted'> selected</cfif>>Ideas - Total Ideas Submitted</option>
<option value="User_Ideas_winner"<cfif statsmode EQ 'User_Ideas_winner'> selected</cfif>>Ideas - Total Winning Ideas</option>
<option value="User_Ideas_points"<cfif statsmode EQ 'User_Ideas_points'> selected</cfif>>Ideas - Points Earned from Ideas</option>
<!--- <option>--------------------------------</option>
<option value="User_Goals"> - Goals</option>
<option>--------------------------------</option>
<option value="User_Contacts"> - Contacts</option>
<option>--------------------------------</option>
<option value="User_Business"> - Business</option> --->
</optgroup>

<optgroup label="GENERAL STATISTICS">
<option value="User_Countries"<cfif statsmode EQ 'User_Countries'> selected</cfif>>User Countries
</select> &nbsp; Graph: <input type="checkbox" class="whitefield" style="border:0px;" name="ShowGraph" value="1"<cfif IsDefined("ShowGraph") AND showGraph EQ 1> checked </cfif>> &nbsp; <input type="submit" value="Display" class="whitefield" /></td>
</tr>
</form>

<tr>
<td>
<cfif statsmode EQ 'User_Points_Earned'>
	<cfinclude template="dsp_topuser_points_earned.cfm">
 <cfelseif statsmode EQ 'User_Points_Average'>
	<cfinclude template="dsp_topuser_points_average.cfm"> 
 <cfelseif statsmode EQ 'user_ideas_submitted'>
	<cfinclude template="dsp_topuser_ideas_submitted.cfm">
 <cfelseif statsmode EQ 'user_ideas_winner'>
	<cfinclude template="dsp_topuser_ideas_winner.cfm">
 <cfelseif statsmode EQ 'user_ideas_points'>
	<cfinclude template="dsp_topuser_ideas_points.cfm">
<cfelseif statsmode EQ 'user_goals'>
	<cfinclude template="dsp_topuser_goals.cfm">
<cfelseif statsmode EQ 'user_contacts'>
	<cfinclude template="dsp_topuser_contacts.cfm">
<cfelseif statsmode EQ 'user_business'>
	<cfinclude template="dsp_topuser_business.cfm">
<cfelseif statsmode EQ 'User_Countries'>
	<cfinclude template="dsp_user_countries.cfm">
</cfif>
</td>
</tr>

</table><BR><BR />
</cfoutput>